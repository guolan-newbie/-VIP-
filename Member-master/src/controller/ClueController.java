package controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.ClueDAO;
import dao.CommunicationDAO;
import entity.Admin;
import entity.Clue;
import entity.Communication;
import tools.DateFormatUtils;
import tools.RandomNumberUtils;
import tools.Result;
import tools.VerifyIdentity;
import tools.clueNum;

@Controller
@RequestMapping(value = "/clue", method = RequestMethod.POST)
public class ClueController {
	@Autowired
	ClueDAO clueDAO;
	@Autowired
	CommunicationDAO communicationDAO;

	/**
	 * 添加线索用户
	 *
	 * @param request
	 * @param session
	 * @param clue
	 *            Clue 线索用户
	 * @param date
	 *            String 字符串类型时间
	 * @return Result 统一的返回结果
	 * 
	 */
	@ResponseBody
	@RequestMapping("/add.action")
	public Result add(HttpSession session, Clue clue) {
		Admin admin = VerifyIdentity.verifyAdmin(session);
		if (admin == null) {
			return Result.build(201, "你不是管理员！");
		}
		clue.setAdmin(admin);
		clueDAO.add(clue);
		return Result.ok();
	}

	/**
	 * 添加沟通信息
	 *
	 * @param session
	 * @param communication
	 *            Communication 沟通信息
	 * @return Result 统一的返回结果
	 * 
	 */
	@ResponseBody
	@RequestMapping("/addCommunication.action")
	public Result addCommunication(HttpSession session, Communication communication) {
		Admin admin = VerifyIdentity.verifyAdmin(session);
		if (admin != null) {
			communication.setAid(admin.getId());
			communicationDAO.add(communication);
			return Result.ok();
		}
		return Result.build(201, "你不是管理员！");
	}

	/**
	 * 校验线索用户资料是否齐全
	 *
	 * @param id
	 *            Integer 线索用户ID
	 * @return Result 统一的返回结果
	 * 
	 */
	@ResponseBody
	@RequestMapping("/checkAttr.action")
	public Result checkAttr(Integer id) {
		return checkCule(clueDAO.getClueById(id));
	}

	/**
	 * 校验用户资料
	 *
	 * @param clue
	 *            Clue 线索用户
	 * @return Result 统一的返回结果
	 * 
	 */
	private Result checkCule(Clue clue) {
		if (StringUtils.isBlank(clue.getRealName())) {
			return Result.build(304, "真实姓名为空！");
		}
		if (StringUtils.isBlank(clue.getSchool())) {
			return Result.build(304, "学校为空！");
		}
		if (StringUtils.isBlank(clue.getDiploma())) {
			return Result.build(304, "学历为空！");
		}
		if (StringUtils.isBlank(clue.getPhone())) {
			return Result.build(304, "手机号为空！");
		}
		if (null == clue.getGraduateDate()) {
			return Result.build(304, "毕业时间为空！");
		}
		if (!(clue.getSex().equals("男") || clue.getSex().equals("女"))) {
			return Result.build(304, "性别不能为不详！");
		}
		return Result.ok();
	}

	/**
	 * 校验QQ号是否重复
	 *
	 * @param qq
	 * @return 返回false重复，true通过
	 * 
	 */
	@ResponseBody
	@RequestMapping("/checkQq.action")
	public boolean checkQq(String qq) {
		return clueDAO.checkQq(qq);
	}

	/**
	 * 设置或取消重点
	 *
	 * @param id
	 *            Integer 线索用户ID
	 * @return Result 统一的返回结果
	 * 
	 */
	@ResponseBody
	@RequestMapping("/emphasis.action")
	public Result emphasis(Integer id) {
		Clue clue = clueDAO.getClueById(id);
		if (clue.getFlag() == 3 || clue.getFlag() == 0) {
			if (clue.getFlag() == 3) {
				clue.setFlag(0);
			} else {
				clue.setFlag(3);
			}
			clueDAO.update(clue);
			return Result.ok();
		}
		return Result.build(999, "非法操作！");
	}

	/**
	 * 删除线索用户及沟通信息
	 *
	 * @param id
	 *            Integer 线索用户ID
	 * @return Result 统一的返回对象
	 * 
	 */
	@ResponseBody
	@RequestMapping("/deleteById.action")
	public Result delete(Integer id) {
		clueDAO.delete(id);
		return Result.ok();
	}

	/**
	 * 删除线索用户的沟通信息
	 *
	 * @param id
	 *            Integer 沟通信息的ID
	 * @return Result 统一的返回对象
	 * 
	 */
	@ResponseBody
	@RequestMapping("/deleteClueCommunication.action")
	public Result deleteCommunicationById(Integer id) {
		clueDAO.deleteCommunicationById(id);
		return Result.ok();
	}

	/**
	 * 下载线索用户的xls文档
	 *
	 * @param request
	 * @return Result 统一的返回对象
	 * 
	 */
	@RequestMapping("/download.action")
	@ResponseBody
	public Result download(HttpServletRequest request) {
		String fileName = RandomNumberUtils.getLongRandomNumber();
		String path = request.getServletContext().getRealPath("//") + fileName + ".xls";
		String title = "线索用户表";
		List<Clue> list = clueDAO.getClue();
		String[] headers = { "序号", "用户名", "真实姓名", "性别", "毕业学校", "追踪开始时间", "追踪结束时间", "毕业时间", "手机号码", "体验编号", "助教",
				"学生" };
		try {
			clueDAO.print(list, headers, path, title);
			return Result.ok(fileName + ".xls");
		} catch (IOException e) {
			e.printStackTrace();
			return Result.build(999, "服务器发生异常！");
		}
	}

	/**
	 * 结束线索用户的跟踪
	 *
	 * @param id
	 *            Integer 线索用户的ID
	 * @return Result 统一的返回对象
	 * 
	 */
	@RequestMapping("/finishClue.action")
	@ResponseBody
	public Result finishClue(Integer id) {
		Clue clue = clueDAO.getClueById(id);
		clue.setBtime(new Date());
		clue.setFlag(2);
		clueDAO.update(clue);
		return Result.ok();
	}

	/**
	 * 分页获取跟踪者
	 *
	 * @param type
	 *            Integer 用户类型
	 * @param aid
	 *            Integer 小助手ID
	 * @param qq
	 *            String QQ号码
	 * @param page
	 *            Integer 页码
	 * @param rows
	 *            Integer 每页行数
	 * @return Result 统一的返回对象
	 * 
	 */
	@ResponseBody
	@RequestMapping("/getClues.action")
	public Result getClues(Integer type, Integer aid, @RequestParam(defaultValue = "") String qq,
			@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer rows) {
		Result result = null;
		if (!StringUtils.isBlank(qq)) {
			// 当是QQ查询的时候
			result = clueDAO.getClues(0, 0, "%" + qq + "%", page, rows);
		} else {
			// 是管理员id查询的时候
			result = clueDAO.getClues(type, aid, null, page, rows);
		}
		return result;
	}

	/**
	 * 获取线索用户的沟通信息
	 *
	 * @param cid
	 *            Integer 线索用户的ID
	 * @return Result 统一的返回对象
	 * 
	 */
	@ResponseBody
	@RequestMapping("/getCommunication.action")
	public Result getCommunication(Integer cid) {
		return Result.ok(clueDAO.getCommunication(cid));
	}

	/**
	 * 根据ID获取线索用户
	 *
	 * @param id
	 *            Integer 线索用户ID
	 * @return Result 统一的返回对象
	 * 
	 */
	@ResponseBody
	@RequestMapping("/getClueById.action")
	public Result getClueById(Integer id) {
		return Result.ok(clueDAO.getClueById(id));
	}

	/*
	 * 功能:添加新的体验者时自动生成序号 作者: 日期：
	 */
	@ResponseBody
	@RequestMapping("/getNum.action")
	public String getNum(HttpServletRequest request, HttpSession session) {
		String num = clueDAO.getNum();
		System.out.println(num + "======================");
		num = clueNum.getNum(num);
		return num;
	}

	/**
	 * 线索用户加入体验
	 *
	 * @param clue
	 *            Clue 线索用户对象
	 * @return Result 统一的返回结果
	 * 
	 */
	@ResponseBody
	@RequestMapping("/joinExperience.action")
	public Result joinExperience(Clue clue) {
		clue = clueDAO.getClueById(clue.getId());
		Result checkCule = checkCule(clue);
		if (checkCule.getStatus() != 100) {
			return checkCule;
		}
		if (clue.getFlag() == 1) {
			return Result.build(999, "非法操作!");
		}
		clueDAO.joinExperience(clue);
		return Result.ok();
	}

	/**
	 * 修改线索用户信息
	 *
	 * @param clue
	 *            Clue 线索用户对象
	 * @param gdate
	 *            String 毕业时间
	 * @return Result 统一的返回结果
	 * 
	 */
	@ResponseBody
	@RequestMapping("/modify.action")
	public Result modify(Clue clue, String gdate) {
		Clue oldclue = clueDAO.getClueById(clue.getId());
		if (!StringUtils.isBlank(gdate)) {
			Date gtime = DateFormatUtils.dateParse(gdate);
			if (null == gtime) {
				return Result.build(999, "毕业时间不合法！");
			}
			oldclue.setGraduateDate(gtime);
		} else {
			oldclue.setGraduateDate(null);
		}
		if (!StringUtils.isBlank(clue.getRealName())) {
			oldclue.setRealName(clue.getRealName());
		} else {
			oldclue.setRealName(null);
		}
		if (!StringUtils.isBlank(clue.getSchool())) {
			oldclue.setSchool(clue.getSchool());
		} else {
			oldclue.setSchool(null);
		}
		if (!StringUtils.isBlank(clue.getDiploma())) {
			oldclue.setDiploma(clue.getDiploma());
		} else {
			oldclue.setDiploma(null);
		}
		if (!StringUtils.isBlank(clue.getPhone())) {
			oldclue.setPhone(clue.getPhone());
		} else {
			oldclue.setPhone(null);
		}
		oldclue.setBtime(clue.getBtime());
		oldclue.setSex(clue.getSex());
		oldclue.setType(clue.isType());
		clueDAO.update(oldclue);
		return Result.ok();
	}

	/**
	 * 重置线索用户的状态
	 *
	 * @param id
	 *            Integer 线索用户的ID
	 * @return Result 统一的返回结果
	 * 
	 */
	@ResponseBody
	@RequestMapping("/reset.action")
	public Result reset(Integer id) {
		Clue clue = clueDAO.getClueById(id);
		if (clue.getFlag() == 1) {
			return Result.build(999, "非法操作！");
		}
		clue.setFlag(0);
		clue.setEtime(null);
		clueDAO.update(clue);
		return Result.ok();
	}

	/**
	 * 获取小助手
	 *
	 * @return Result 统一的返回结果
	 * 
	 */
	@ResponseBody
	@RequestMapping("/getAssistants.action")
	public Result getAssistants() {
		return Result.ok(clueDAO.getAssistants());
	}

	/**
	 * 设置体验者的小助手
	 *
	 * @param clue
	 *            Clue 线索用户
	 * @return Result 统一的返回结果
	 * 
	 */
	@ResponseBody
	@RequestMapping("/setAssistant.action")
	public Result setAssistant(Clue clue) {
		Clue oldclue = clueDAO.getClueById(clue.getId());
		oldclue.setAdmin(clue.getAdmin());
		clueDAO.update(oldclue);
		return Result.ok();
	}
}
