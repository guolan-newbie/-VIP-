package controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.CommunicationDAO;
import dao.ExperienceDAO;
import dao.MemberDAO;
import dao.UserDAO;
import dto.ExperienceDTO;
import entity.Admin;
import entity.Clue;
import entity.Communication;
import entity.Experience;
import entity.Member;
import entity.User;
import tools.MD5SaltUtils;
import tools.NavigationBar;
import tools.RandomNumberUtils;
import tools.Result;
import tools.experienceNum;

@Controller
@RequestMapping("/experience")
public class ExperienceController {
	private static Logger logger = Logger.getLogger(ExperienceController.class);
	@Resource
	CommunicationDAO communicationDAO;
	@Resource
	ExperienceDAO experienceDAO;
	@Resource
	UserDAO userDAO;
	@Resource
	MemberDAO MemberDAO;

	/*
	 * 功能:添加体验者 作者:刘娈莎 日期2016-5-24
	 * 
	 * 修改:当添加的体验者，默认小助手就是添加者 作者:张晓敏 日期:2016-10-26
	 */
	@ResponseBody
	@RequestMapping("/add.action")
	public String add(HttpServletRequest request, HttpSession session, Experience experience) {
		// System.out.println(experience);
		String salt = MD5SaltUtils.randomCreateSalt();
		experience.setPassword(MD5SaltUtils.encode(experience.getPassword(), salt));
		experience.setSalt(salt);
		experience.setBegintime(new Date());
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin == null) {
			return "0";
		} else {
			experience.setAid(admin.getId());
		}
		experienceDAO.add(experience);
		return "1";
	}

	/*
	 * 功能:添加沟通信息 作者:刘娈莎 日期2016-5-27
	 */
	@ResponseBody
	@RequestMapping("/addCommunication.action")
	public String addCommunication(HttpServletRequest request, HttpSession session, Communication communication) {
		System.out.println(communication);
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			communication.setAid(admin.getId());
			System.out.println(communication);
			communicationDAO.add(communication);
			return "1";
		}
		return null;
	}

	/*
	 * 功能:检验用户名是否存在 作者:刘娈莎 日期2016-5-23
	 */
	@ResponseBody
	@RequestMapping("/checkExists.action")
	public int checkExists(HttpServletRequest request, HttpSession session, String num) {
		if (experienceDAO.checkExists(num) > 0) {
			return 1;
		}
		return 0;
	}

	/*
	 * 功能:删除体验者 作者:刘娈莎 日期2016-6-6
	 */
	@ResponseBody
	@RequestMapping("/delete.action")
	public String delete(HttpServletRequest request, HttpSession session, Experience experience) {
		experienceDAO.delete(experience.getId());
		return null;
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
		String title = "体验用户表";
		List<Experience> list = experienceDAO.getExperiences();
		String[] headers = { "序号", "用户名", "真实姓名", "QQ", "类型", " 开始时间", "会员编号", "助教" };
		try {
			experienceDAO.print(list, headers, path, title);
			System.out.println("真实路劲" + path);
			return Result.ok(fileName + ".xls");
		} catch (IOException e) {
			e.printStackTrace();
			return Result.build(999, "服务器发生异常！");
		}
	}

	/*
	 * 功能:获取沟通信息 作者:刘娈莎 日期2016-5-27
	 */
	@ResponseBody
	@RequestMapping("/getCommunicationByEid.action")
	public List<Communication> getCommunicationByEid(HttpServletRequest request, HttpSession session, int eid) {
		List<Communication> list = communicationDAO.getCommunicationByEid(eid);
		// 设置时间格式
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (int i = 0; i < list.size(); i++) {
			Communication communication = list.get(i);
			communication.setFormatTime(df.format(communication.getTime()));
		}
		return list;
	}

	/*
	 * 功能:通过id获取体验者 作者:刘娈莎 日期2016-6-6
	 */
	@ResponseBody
	@RequestMapping("/getExperienceById.action")
	public Experience getExperienceById(HttpServletRequest request, HttpSession session, int id) {

		return experienceDAO.getExperienceById(id);
	}

	/*
	 * 功能:获取体验者，分页 作者:刘娈莎 日期2016-5-23
	 */
	@ResponseBody
	@RequestMapping("/getExperienceByPage.action")
	public String getExperienceByPage(HttpServletRequest request, HttpSession session, ExperienceDTO experienceDTO,
			int page2) {
		System.out.println(experienceDTO);
		int newpage;
		experienceDTO.getPage().setCurrentPage(page2);
		newpage = page2;
		List<Experience> list = experienceDAO.getExperienceByPage(experienceDTO);
		// 当删除某页最后一天记录时，要往前一页取值
		if (list.size() == 0) {
			newpage = page2 - 1;
			if (newpage == 0) {
				newpage = 1;
			}
			experienceDTO.getPage().setCurrentPage(newpage);
			list = experienceDAO.getExperienceByPage(experienceDTO);
		}

		// 设置时间格式
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		for (int i = 0; i < list.size(); i++) {
			Experience experience = list.get(i);
			experience.setFormatGraduateDate(df.format(experience.getGraduateDate()));
			experience.setFormatBegintime(df.format(experience.getBegintime()));
			if (experience.getEndtime() != null) {
				experience.setFormatEndtime(df.format(experience.getEndtime()));
			}
		}
		String url = request.getContextPath() + "/experience/getExperienceByPage.action";
		int btnCount = 5;
		int pageCount = experienceDTO.getPage().getTotalPage();
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		System.out.println(str);
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("navbar", str);
		// returnMap.put("totalCount", userDTO.getPage().getTotalCount());
		if (list.size() > 0) {
			returnMap.put("list", list);
		} else {
			returnMap.put("list", new ArrayList<>());
		}
		JSONObject json = new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();
	}

	@ResponseBody
	@RequestMapping("/getExperienceByPinyin")
	public Result getExperienceByPinyin(String pinyin) {
		return experienceDAO.getExperienceByPinyin(pinyin);
	}

	/*
	 * 功能:获取已经加入、退出、预科的体验者，分页 作者:陈家豪 日期2017-3-30
	 */
	@ResponseBody
	@RequestMapping("/getExperienceInByPage.action")
	public String getExperienceInByPage(HttpServletRequest request, HttpSession session, ExperienceDTO experienceDTO,
			int page2, int flag) {
		System.out.println(experienceDTO);
		int newpage;
		experienceDTO.getPage().setCurrentPage(page2);
		experienceDTO.setFlag(flag);
		newpage = page2;
		List<Experience> list = experienceDAO.getExperienceInByPage(experienceDTO);
		// 当删除某页最后一天记录时，要往前一页取值
		if (list.size() == 0) {
			newpage = page2 - 1;
			if (newpage == 0) {
				newpage = 1;
			}
			experienceDTO.getPage().setCurrentPage(newpage);
			list = experienceDAO.getExperienceInByPage(experienceDTO);
		}

		// 设置时间格式
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		for (int i = 0; i < list.size(); i++) {
			Experience experience = list.get(i);
			experience.setFormatGraduateDate(df.format(experience.getGraduateDate()));
			experience.setFormatBegintime(df.format(experience.getBegintime()));
			if (experience.getEndtime() != null) {
				experience.setFormatEndtime(df.format(experience.getEndtime()));
			}
		}
		String url = request.getContextPath() + "/experience/getExperienceInByPage.action";
		int btnCount = 5;
		int pageCount = experienceDTO.getPage().getTotalPage();
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		System.out.println(str);
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("navbar", str);
		// returnMap.put("totalCount", userDTO.getPage().getTotalCount());
		if (list.size() > 0) {
			returnMap.put("list", list);
		} else {
			returnMap.put("list", new ArrayList<>());
		}
		JSONObject json = new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();
	}

	/*
	 * 功能:获取正在体验的体验者，分页 作者:陈家豪 日期2017-3-30
	 */
	@ResponseBody
	@RequestMapping("/getExperienceIngByPage.action")
	public String getExperienceIngByPage(HttpServletRequest request, HttpSession session, ExperienceDTO experienceDTO,
			int page2) {
		System.out.println(experienceDTO);
		int newpage;
		experienceDTO.getPage().setCurrentPage(page2);
		newpage = page2;
		List<Experience> list = experienceDAO.getExperienceIngByPage(experienceDTO);
		// 当删除某页最后一天记录时，要往前一页取值
		if (list.size() == 0) {
			newpage = page2 - 1;
			if (newpage == 0) {
				newpage = 1;
			}
			experienceDTO.getPage().setCurrentPage(newpage);
			list = experienceDAO.getExperienceIngByPage(experienceDTO);
		}

		// 设置时间格式
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		for (int i = 0; i < list.size(); i++) {
			Experience experience = list.get(i);
			experience.setFormatGraduateDate(df.format(experience.getGraduateDate()));
			experience.setFormatBegintime(df.format(experience.getBegintime()));
			if (experience.getEndtime() != null) {
				experience.setFormatEndtime(df.format(experience.getEndtime()));
			}
		}
		String url = request.getContextPath() + "/experience/getExperienceIngByPage.action";
		int btnCount = 5;
		int pageCount = experienceDTO.getPage().getTotalPage();
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		System.out.println(str);
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("navbar", str);
		if (list.size() > 0) {
			returnMap.put("list", list);
		} else {
			returnMap.put("list", new ArrayList<>());
		}
		JSONObject json = new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();
	}

	@ResponseBody
	@RequestMapping("/getExperienceInfoById")
	public Result getExperienceInfoById(int eid) {
		return experienceDAO.getExperienceInfoById(eid);
	}

	@ResponseBody
	@RequestMapping("/getExperienceList")
	// ststus:0 全部 ,1已加入, 2预科计划 ,0+endtime is not null退出 ,endtime is null正在体验
	public Result getExperienceList(Integer status, @RequestParam(defaultValue = "") String qq,
			@RequestParam(defaultValue = "0") Integer aId, @RequestParam(defaultValue = "1") Integer page,
			@RequestParam(defaultValue = "10") Integer rows) {
		if (!"".equals(qq)) {
			qq = "%" + qq + "%";
		}
		Result result = experienceDAO.getExperienceList(status, qq, aId, page, rows);
		return result;
	}

	/*
	 * 功能:显示每月加入会员数量 作者:陈家豪 日期:2017-5-3
	 */
	@ResponseBody
	@RequestMapping("/getMemberByMonth")
	public Result getMemberByMonth(@RequestParam(defaultValue = "1") Integer page,
			@RequestParam(defaultValue = "10") Integer rows, Integer years, Integer month) {
		System.out.println(years+":"+month);
		Result result = experienceDAO.getMemberByMonth(page, rows, years, month);
		return result;
	}

	/*
	 * 功能:添加新的体验者时自动生成序号 作者: 日期：
	 */
	@ResponseBody
	@RequestMapping("/getNum.action")
	public String getNum(HttpServletRequest request, HttpSession session) {
		String num = experienceDAO.getNum();
		num = experienceNum.getNum(num);
		return num;
	}

	/*
	 * 功能:设置加入VIP 作者:刘娈莎 日期2016-5-26
	 * 
	 * 修改:体验会员加入VIP后 将体验用户表中的提交周报的字段设置成不需要提交，
	 * 交由member的判断周报来处理，体验用户加入vip要求使用会员账户而不是体验账户(这个暂时没有处理) 作者:张晓敏 日期:2016-09-26
	 * 
	 * 修改:体验会员加入vip后设置出生地，如果没有出生地则设置所在地 作者：张晓敏 日期：2016-10-26
	 */
	@ResponseBody
	@RequestMapping("/joinVIP.action")
	public Result joinVIP(HttpServletRequest request, HttpSession session, Experience experience) {
		System.out.println(experience);
		// 更新experience表
		experience = experienceDAO.getExperienceById(experience.getId());
		experience.setFlag(1);
		experience.setEndtime(new Date());
		experience.setSummaryflag(false);
		experienceDAO.update(experience);

		// 在user表中增加内容

		/*
		 * @author 林立富
		 * 
		 * @注释 修改了当user表记录为空时，userDAO.getLastOne()报空指针，避免加入第一个会员时报错
		 * 
		 * @date 2016年10月13日 下午43138
		 */
		User user = new User();
		if (userDAO.getLastOne() == null) {
			String tempName = "1";
			user.setName(tempName);
			user.setPwd(experience.getPassword());
			user.setSalt(experience.getSalt());
			user.setTime(new Date());
			userDAO.add(user);
			user = userDAO.getUserByName(tempName);
		} else {
			User lastuser = userDAO.getLastOne();
			int newUserCount = Integer.parseInt(lastuser.getName()) + 1;
			String newUserName = "" + newUserCount;
			user.setName(newUserName);
			user.setPwd(experience.getPassword());
			user.setSalt(experience.getSalt());
			user.setTime(new Date());
			userDAO.add(user);
			user = userDAO.getUserByName(newUserName);
		}

		// System.out.println(user);

		// 在member表中增加内容
		Member member = new Member();
		member.setUid(user.getId());
		member.setName(experience.getName());
		member.setSex(experience.getSex());
		member.setSchool(experience.getSchool());
		member.setCompany(experience.getCompany());
		member.setMobile(experience.getPhone());
		member.setStudent(experience.isStudent());
		member.setGraduateDate(experience.getGraduateDate());
		member.setTime(new Date());
		member.setProvid(Integer.parseInt(experience.getProvince()));
		member.setFlag(false);
		member.setAid(experience.getAid());
		member.setEid(experience.getId());
		member.setSummaryflag(true);
		if (experience.getSeat_provid() != 0) {
			member.setSeat_provid(experience.getSeat_provid());
		} else {
			member.setSeat_provid(Integer.parseInt(experience.getProvince()));
		}
		// System.out.println(member);
		MemberDAO.add(member);
		return Result.ok();
	}

	/*
	 * 功能:加入预科计划 作者:陈家豪 日期:2017-4-6
	 */
	@ResponseBody
	@RequestMapping("/joinPreVIP.action")
	public Result joinPreVIP(HttpServletRequest request, HttpSession session, Experience experience) {
		experience = experienceDAO.getExperienceById(experience.getId());
		experience.setFlag(2);
		experience.setEndtime(new Date());
		experience.setSummaryflag(false);
		experienceDAO.update(experience);
		return Result.ok();
	}

	/*
	 * 功能:设置退出体验 作者:刘娈莎 日期2016-5-26
	 * 
	 * 修改:当体验会员退出后，不需要提交周报了 作者:张晓敏 日期:2016-09-26
	 */
	@ResponseBody
	@RequestMapping("/leftVIP.action")
	public Result leftVIP(HttpServletRequest request, HttpSession session, Experience experience) {
		experience = experienceDAO.getExperienceById(experience.getId());
		experience.setFlag(0);
		experience.setEndtime(new Date());
		experience.setSummaryflag(false);
		experienceDAO.update(experience);
		return Result.ok();
	}

	/*
	 * 功能:修改体验者信息（不包括密码） 作者:刘娈莎 日期2016-6-6
	 */
	@ResponseBody
	@RequestMapping("/modify.action")
	public String modify(HttpServletRequest request, HttpSession session, Experience experience) {
		Experience oldExperience = experienceDAO.getExperienceById(experience.getId());
		oldExperience.setNum(experience.getNum());
		oldExperience.setSex(experience.getSex());
		oldExperience.setName(experience.getName());
		oldExperience.setSchool(experience.getSchool());
		oldExperience.setCompany(experience.getCompany());
		oldExperience.setPhone(experience.getPhone());
		oldExperience.setProvince(experience.getProvince());
		oldExperience.setStudent(experience.isStudent());
		oldExperience.setGraduateDate(experience.getGraduateDate());
		experienceDAO.update(oldExperience);
		return null;

	}

	/*
	 * 功能:重置是否加入的状态 作者:刘娈莎 日期2016-5-26
	 */
	@ResponseBody
	@RequestMapping("/resetVIPFlag.action")
	public Result resetVIPFlag(HttpServletRequest request, HttpSession session, Experience experience) {
		// 重置experience表内容
		experience = experienceDAO.getExperienceById(experience.getId());
		experience.setFlag(0);
		experience.setEndtime(null);
		experienceDAO.update(experience);
		// 删除user、member表内容 (user的delete方法直接删了两个表的内容)
		int uid = experienceDAO.getUidById(experience.getId());
		userDAO.deleteById(uid);
		return Result.ok();
	}

	/*
	 * 功能:重置小助手 作者:刘娈莎 日期2016-5-26
	 */
	@ResponseBody
	@RequestMapping("/resetExpAssistant.action")
	public String resetExpAssistant(HttpServletRequest request, HttpSession session, Experience experience) {
		experience = experienceDAO.getExperienceById(experience.getId());
		experience.setAid(0);
		experienceDAO.update(experience);
		return null;
	}

	/*
	 * 功能:设置小助手 作者:刘娈莎 日期2016-5-26
	 */
	@ResponseBody
	@RequestMapping("/setAssistant.action")
	public String setAssistant(HttpServletRequest request, HttpSession session, int id, int aid) {
		Experience experience = experienceDAO.getExperienceById(id);
		experience.setAid(aid);
		experienceDAO.update(experience);
		return null;
	}

	/*
	 * 功能:切换是否需要写周报的标记，summaryflag 作者:刘娈莎 日期2016-5-31
	 */
	@ResponseBody
	@RequestMapping("/toggleSummryflag.action")
	public String toggleSummryflag(HttpServletRequest request, HttpSession session, Experience experience) {
		experience = experienceDAO.getExperienceById(experience.getId());
		boolean newflag = true;
		if (experience.isSummaryflag()) {
			newflag = false;
		}
		experience.setSummaryflag(newflag);
		experienceDAO.update(experience);
		return null;
	}

}
