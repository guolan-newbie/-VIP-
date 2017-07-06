package controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zefer.html.doc.n;

import dao.AdminDAO;
import dao.ExperienceDAO;
import dao.MemberDAO;
import dao.SummaryDAO;
import dto.MemAndExpDTO;
import dto.SummaryDTO;
import entity.Admin;
import entity.Experience;
import entity.LookSummary;
import entity.MemAndExp;
import entity.Member;
import entity.Summary;
import entity.SummaryVisit;
import entity.User;
import pageinterceptor.PageParameter;
import tools.NavigationBar;
import tools.Paging;
import tools.Result;
import tools.SummaryTitle;

@Controller
@RequestMapping("/summary")
public class SummaryController {
	private static Logger logger = Logger.getLogger(SummaryController.class);
	@Resource
	AdminDAO adminDAO;
	@Resource
	MemberDAO memberDAO;
	@Resource
	SummaryDAO summaryDAO;
	@Resource
	ExperienceDAO experienceDAO;
	int sumpageSize = 9;

	@ResponseBody
	@RequestMapping("/savePageC.action")
	public String savePageC(HttpSession session, Summary summary) throws ParseException {
		List<Summary> list = summaryDAO.getgetSummaryAll(SummaryTitle.getTitle());
		if (list.size() == 0) {
			String preweek = SummaryTitle.getPreWeekTitleSec(SummaryTitle.getTitle());
			list = summaryDAO.getgetSummaryAll(preweek);
		}
		int pageCounts = Paging.pageCount(list.size(), sumpageSize);
		session.setAttribute("AllPageCounts", pageCounts);
		return "";
	}

	/*
	 * 功能:获取分页周报内容、分页导航条、记录总数（不从服务器跳转，返回一个json对象） 作者:刘娈莎 日期:2016-4-12
	 */
	// 因为dto中有一个叫page的变量，所以页码改成了page2
	@ResponseBody
	@RequestMapping("/getSummarysByPage1.action")
	public String getSummarysByPage1(HttpSession session, HttpServletRequest request, SummaryDTO summaryDTO, int page2)
			throws ParseException {
		System.out.println(summaryDTO);
		// 设置取数据的参数
		// ownerType设置,只有会员需要这个
		if (session.getAttribute("admin") == null) {
			String ownerType = summaryDTO.getOwnerType();
			if (!ownerType.equals("all") && ownerType != null) {
				if (session.getAttribute("myuser") != null) {
					User user = (User) session.getAttribute("myuser");
					summaryDTO.setId(user.getMember().getId());
					summaryDTO.setIdentityType("member");
				}
				if (session.getAttribute("experience") != null) {
					Experience experience = (Experience) session.getAttribute("experience");
					summaryDTO.setId(experience.getId());
					summaryDTO.setIdentityType("experience");
				}

			}

		}
		// weekType设置
		String weekType = summaryDTO.getWeekType();
		// String weekType="current";
		String title = summaryDTO.getTitle();
		String newTitle = "";
		if (weekType.equals("previous")) {
			if (title.equals("")) {
				newTitle = SummaryTitle.getPreWeekTitleSec(SummaryTitle.getWriteTitle());
				summaryDTO.setTitle(newTitle);
			} else {
				newTitle = SummaryTitle.getPreWeekTitleSec(title);
				summaryDTO.setTitle(newTitle);
			}
		}
		if (weekType.equals("current")) {
			newTitle = SummaryTitle.getWriteTitle();
			summaryDTO.setTitle(newTitle);
		}
		if (weekType.equals("next")) {
			if (title.equals("")) {
				newTitle = SummaryTitle.getNextWeekTitleSec(SummaryTitle.getWriteTitle());
				summaryDTO.setTitle(newTitle);
			} else {
				newTitle = SummaryTitle.getNextWeekTitleSec(title);
				summaryDTO.setTitle(newTitle);
			}

		}
		// 用于修改完周报title不变
		if (weekType.equals("now")) {
			newTitle = title;
			summaryDTO.setTitle(newTitle);
		}
		// checkType设置

		// 取数据部分
		int newpage;
		summaryDTO.getPage().setCurrentPage(page2);
		newpage = page2;

		List<LookSummary> list = summaryDAO.getSummarysByPage(summaryDTO);
		System.out.println(summaryDTO.getPage());

		// System.out.println(summaryDTO.getTitle());
		// 当删除某页最后一天记录时，要往前一页取值
		if (list.size() == 0) {
			newpage = page2 - 1;
			if (newpage == 0) {
				newpage = 1;
			}
			summaryDTO.getPage().setCurrentPage(newpage);
			list = summaryDAO.getSummarysByPage(summaryDTO);
		}

		String url = request.getContextPath() + "/summary/getSummarysByPage1.action";
		int btnCount = 5;
		int pageCount = summaryDTO.getPage().getTotalPage();
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		// System.out.println(str);
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("navbar", str);
		returnMap.put("totalCount", summaryDTO.getPage().getTotalCount());
		returnMap.put("list", list);
		returnMap.put("title", newTitle);
		String titleTip = "";
		if (!weekType.equals("all")) {
			titleTip = "当前周报时间：" + newTitle;
		}
		returnMap.put("titleTip", titleTip);
		JSONObject json = new JSONObject();
		json.put("returnMap", returnMap);

		// //用于查看后返回
		// //按理说
		// 直接在session一整个summaryDTO就可以了，但是在第一次访问页面的时候summaryDTO里面的值获取不到。单独的值可以获取的到
		// //所以只能用这种笨办法，一个一个的存了。
		// session.setAttribute("LASTTITLE", title);
		// session.setAttribute("CHECKTYPE", summaryDTO.getCheckType());
		// session.setAttribute("OWNERTYPE", summaryDTO.getOwnerType() );
		// session.setAttribute("WEEKTYPE", summaryDTO.getWeekType());
		// session.setAttribute("PAGE2", summaryDTO.getPage().getCurrentPage());
		return json.toString();
	}

	/**
	 * 
	 * <p>
	 * Title: getSummarysByPage1
	 * </p>
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @author xiaochaozi 日期： 2016年12月31日 功能：通过姓名查询周报
	 * @param session
	 * @param request
	 * @param summaryDTO
	 * @param page2
	 * @return
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping("/getSummarysByNameWithPage.action")
	public String getSummarysByNameWithPage(HttpSession session, HttpServletRequest request, SummaryDTO summaryDTO,
			int page2) throws ParseException {
		String ownerType = summaryDTO.getOwnerType();

		if (!ownerType.equals("所有人")) {
			System.out.println(summaryDTO);
			// 设置取数据的参数
			// ownerType设置,只有会员需要这个
			if (session.getAttribute("admin") == null) {
				if (!ownerType.equals("所有人") && ownerType != null) {
					if (session.getAttribute("myuser") != null) {
						User user = (User) session.getAttribute("myuser");
						summaryDTO.setId(user.getMember().getId());
						summaryDTO.setIdentityType("member");
					}
					if (session.getAttribute("experience") != null) {
						Experience experience = (Experience) session.getAttribute("experience");
						summaryDTO.setId(experience.getId());
						summaryDTO.setIdentityType("experience");
					}

				}

			}
			// weekType设置
			String weekType = summaryDTO.getWeekType();
			// String weekType="current";
			String title = summaryDTO.getTitle();
			String newTitle = "";
			if (weekType.equals("previous")) {
				if (title.equals("")) {
					newTitle = SummaryTitle.getPreWeekTitleSec(SummaryTitle.getWriteTitle());
					summaryDTO.setTitle(newTitle);
				} else {
					newTitle = SummaryTitle.getPreWeekTitleSec(title);
					summaryDTO.setTitle(newTitle);
				}
			}
			if (weekType.equals("current")) {
				newTitle = SummaryTitle.getWriteTitle();
				summaryDTO.setTitle(newTitle);
			}
			if (weekType.equals("next")) {
				if (title.equals("")) {
					newTitle = SummaryTitle.getNextWeekTitleSec(SummaryTitle.getWriteTitle());
					summaryDTO.setTitle(newTitle);
				} else {
					newTitle = SummaryTitle.getNextWeekTitleSec(title);
					summaryDTO.setTitle(newTitle);
				}

			}
			// 用于修改完周报title不变
			if (weekType.equals("now")) {
				newTitle = title;
				summaryDTO.setTitle(newTitle);
			}
			// checkType设置

			// 取数据部分
			int newpage;
			summaryDTO.getPage().setCurrentPage(page2);
			newpage = page2;

			List<LookSummary> list = summaryDAO.getSummarysByNameWithPage(summaryDTO);
			System.out.println(summaryDTO.getPage());

			// System.out.println(summaryDTO.getTitle());
			// 当删除某页最后一天记录时，要往前一页取值
			if (list.size() == 0) {
				newpage = page2 - 1;
				if (newpage == 0) {
					newpage = 1;
				}
				summaryDTO.getPage().setCurrentPage(newpage);
				list = summaryDAO.getSummarysByNameWithPage(summaryDTO);
			}

			String url = request.getContextPath() + "/summary/getSummarysByNameWithPage.action";
			int btnCount = 5;
			int pageCount = summaryDTO.getPage().getTotalPage();
			String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
			// System.out.println(str);
			HashMap<String, Object> returnMap = new HashMap<String, Object>();
			returnMap.put("navbar", str);
			returnMap.put("totalCount", summaryDTO.getPage().getTotalCount());
			returnMap.put("list", list);
			returnMap.put("title", newTitle);
			String titleTip = "";
			if (!weekType.equals("all")) {
				titleTip = "当前周报时间：" + newTitle;
			}
			returnMap.put("titleTip", titleTip);
			JSONObject json = new JSONObject();
			json.put("returnMap", returnMap);

			// //用于查看后返回
			// //按理说
			// 直接在session一整个summaryDTO就可以了，但是在第一次访问页面的时候summaryDTO里面的值获取不到。单独的值可以获取的到
			// //所以只能用这种笨办法，一个一个的存了。
			// session.setAttribute("LASTTITLE", title);
			// session.setAttribute("CHECKTYPE", summaryDTO.getCheckType());
			// session.setAttribute("OWNERTYPE", summaryDTO.getOwnerType() );
			// session.setAttribute("WEEKTYPE", summaryDTO.getWeekType());
			// session.setAttribute("PAGE2",
			// summaryDTO.getPage().getCurrentPage());
			return json.toString();

		} else {
			ownerType = ownerType.equals("所有人") ? "all" : "my";
			summaryDTO.setOwnerType(ownerType);

			System.out.println(summaryDTO);
			// 设置取数据的参数
			// ownerType设置,只有会员需要这个
			if (session.getAttribute("admin") == null) {
				if (!ownerType.equals("all") && ownerType != null) {
					if (session.getAttribute("myuser") != null) {
						User user = (User) session.getAttribute("myuser");
						summaryDTO.setId(user.getMember().getId());
						summaryDTO.setIdentityType("member");
					}
					if (session.getAttribute("experience") != null) {
						Experience experience = (Experience) session.getAttribute("experience");
						summaryDTO.setId(experience.getId());
						summaryDTO.setIdentityType("experience");
					}

				}

			}
			// weekType设置
			String weekType = summaryDTO.getWeekType();
			// String weekType="current";
			String title = summaryDTO.getTitle();
			String newTitle = "";
			if (weekType.equals("previous")) {
				if (title.equals("")) {
					newTitle = SummaryTitle.getPreWeekTitleSec(SummaryTitle.getWriteTitle());
					summaryDTO.setTitle(newTitle);
				} else {
					newTitle = SummaryTitle.getPreWeekTitleSec(title);
					summaryDTO.setTitle(newTitle);
				}
			}
			if (weekType.equals("current")) {
				newTitle = SummaryTitle.getWriteTitle();
				summaryDTO.setTitle(newTitle);
			}
			if (weekType.equals("next")) {
				if (title.equals("")) {
					newTitle = SummaryTitle.getNextWeekTitleSec(SummaryTitle.getWriteTitle());
					summaryDTO.setTitle(newTitle);
				} else {
					newTitle = SummaryTitle.getNextWeekTitleSec(title);
					summaryDTO.setTitle(newTitle);
				}

			}
			// 用于修改完周报title不变
			if (weekType.equals("now")) {
				newTitle = title;
				summaryDTO.setTitle(newTitle);
			}
			// checkType设置

			// 取数据部分
			int newpage;
			summaryDTO.getPage().setCurrentPage(page2);
			newpage = page2;

			List<LookSummary> list = summaryDAO.getSummarysByPage(summaryDTO);
			System.out.println(summaryDTO.getPage());

			// System.out.println(summaryDTO.getTitle());
			// 当删除某页最后一天记录时，要往前一页取值
			if (list.size() == 0) {
				newpage = page2 - 1;
				if (newpage == 0) {
					newpage = 1;
				}
				summaryDTO.getPage().setCurrentPage(newpage);
				list = summaryDAO.getSummarysByPage(summaryDTO);
			}

			String url = request.getContextPath() + "/summary/getSummarysByPage1.action";
			int btnCount = 5;
			int pageCount = summaryDTO.getPage().getTotalPage();
			String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
			// System.out.println(str);
			HashMap<String, Object> returnMap = new HashMap<String, Object>();
			returnMap.put("navbar", str);
			returnMap.put("totalCount", summaryDTO.getPage().getTotalCount());
			returnMap.put("list", list);
			returnMap.put("title", newTitle);
			String titleTip = "";
			if (!weekType.equals("all")) {
				titleTip = "当前周报时间：" + newTitle;
			}
			returnMap.put("titleTip", titleTip);
			JSONObject json = new JSONObject();
			json.put("returnMap", returnMap);

			// //用于查看后返回
			// //按理说
			// 直接在session一整个summaryDTO就可以了，但是在第一次访问页面的时候summaryDTO里面的值获取不到。单独的值可以获取的到
			// //所以只能用这种笨办法，一个一个的存了。
			// session.setAttribute("LASTTITLE", title);
			// session.setAttribute("CHECKTYPE", summaryDTO.getCheckType());
			// session.setAttribute("OWNERTYPE", summaryDTO.getOwnerType() );
			// session.setAttribute("WEEKTYPE", summaryDTO.getWeekType());
			// session.setAttribute("PAGE2",
			// summaryDTO.getPage().getCurrentPage());
			return json.toString();
		}
	}

	/*
	 * 作者:
	 * 
	 * 功能:通过判断标题是否重复确定是否可以写周报
	 * 
	 * 将title从本周的title修改为周报编写周期的title 刘娈莎 2016-04-03
	 * 
	 * 修改:增加一个内容，来判断用户用户的注册信息是否完整，防止空指针错误。 作者： 日期：
	 * 
	 * 
	 * 修改:将sid==null的判断条件改为sid.equals("0")，否则每次登陆都是修改周报 作者:左琪 日期:2016-4-19
	 * 
	 */
	@ResponseBody
	@RequestMapping("/checkIsRepeatByTit.action")
	public String checkIsRepeatByTit(HttpSession session, Summary summary) throws ParseException {
		if (session.getAttribute("myuser") != null) {
			User user = (User) session.getAttribute("myuser");
			summary.setMid(user.getMember().getId());
		} else if (session.getAttribute("experience") != null) {
			Experience experience = (Experience) session.getAttribute("experience");
			summary.setEid(experience.getId());
		}
		// String title=SummaryTitle.getTitle();
		String writeTitle = SummaryTitle.getWriteTitle();
		summary.setTitle(writeTitle);
		String sid = summaryDAO.checkIsRepeatByTit(summary);
		// 还没有写过，返回1，表示可以写
		if (sid.equals("0")) {
			return "1";
		}
		// 返回0，表示不可以写了，只能修改
		return "0";
	}

	/*
	 * 作者:
	 * 
	 * 功能:新增周报 新增功能： 判断session是否过期，未过期返回1，过期返回0 刘娈莎 2016-03-23
	 * 
	 * 修改： 将title从本周的title修改为周报编写周期的title 去掉了content这个变量， 刘娈莎 2016-04-03
	 * 
	 * 新增功能： 判断周报是否重复，防止用户提交时，多点几次按钮造成重复提交。重复返回2 刘娈莎 2016-04-05
	 * 
	 * 方法名统一将add.action改为addSummary.action 杨凯 2016-04-20
	 * 
	 * 
	 * 修改：增加体验者添加的功能 作者：刘娈莎 日期：2016-5-27
	 */
	@ResponseBody
	@RequestMapping("/addSummary.action")
	public String addSummary(HttpSession session, Summary summary) throws ParseException {
		// 判断session是否过期，未过期返回1，过期返回0
		if (session.getAttribute("myuser") != null) {
			// 判断是否重复，重复返回2
			if (checkIsRepeatByTit(session, summary) == "1") {
				User user = (User) session.getAttribute("myuser");
				summary.setTime(SummaryTitle.getTime());
				summary.setMid(user.getMember().getId());
				summary.setTitle(SummaryTitle.getWriteTitle());
				summary.setIscheck(0);
				summaryDAO.add(summary);
				// session.setAttribute("CONTENT",1);
				return "1";
			} else {
				return "2";
			}
		} else if (session.getAttribute("experience") != null) {

			// 判断是否重复，重复返回2
			if (checkIsRepeatByTit(session, summary) == "1") {
				Experience experience = (Experience) session.getAttribute("experience");
				summary.setTime(SummaryTitle.getTime());
				summary.setEid(experience.getId());
				summary.setTitle(SummaryTitle.getWriteTitle());
				summary.setIscheck(0);
				summaryDAO.add(summary);
				// session.setAttribute("CONTENT",1);
				return "1";
			} else {
				return "2";
			}
		}

		return "0";
	}

	/*
	 * 作者:
	 * 
	 * 功能:获取本周周报
	 * 
	 * 修改：添加体验者功能 作者：刘娈莎 日期：2016-05-27
	 * 
	 */
	@ResponseBody
	@RequestMapping("/getCurrentSummary.action")
	public Summary getCurrentSummary(HttpSession session, Summary summary) throws ParseException {
		if (session.getAttribute("myuser") != null) {
			User user = (User) session.getAttribute("myuser");
			int mid = user.getMember().getId();
			summary.setMid(mid);
		} else if (session.getAttribute("experience") != null) {
			Experience experience = (Experience) session.getAttribute("experience");
			summary.setEid(experience.getId());
		}
		summary.setTitle(SummaryTitle.getWriteTitle());
		return summaryDAO.getCurrentSummary(summary);

	}

	/*
	 * 作者:
	 * 
	 * 功能:修改周报 新增功能： 判断session是否过期，未过期返回1，过期返回0 刘娈莎 2016-03-24
	 * 
	 * 修改： 原本写的太过混乱，精简了代码 刘娈莎 2016-04-03
	 * 
	 * 方法名统一 将update.action改为updateSummary.action
	 * 
	 * 修改：添加体验者功能 作者：刘娈莎 日期：2016-5-27
	 */
	@ResponseBody
	@RequestMapping("/updateSummary.action")
	public String updateSummary(HttpSession session, Summary summary) {
		// System.out.println(summary);
		// 判断session是否过期，未过期返回1，过期返回0
		if (session.getAttribute("myuser") != null || session.getAttribute("experience") != null) {
			summaryDAO.updateSummary(summary);
			return "1";
		}

		return "0";

	}

	/*
	 * 作者:
	 * 
	 * 功能:通过getSummary(HttpSession, int)方法在session中存的数据来审核周报 作者：
	 * 
	 * 修改： 通过传上来的id来审核周报 刘娈莎 2016-04-16
	 * 
	 */
	@ResponseBody
	@RequestMapping("/approveSumarry.action")
	public String approveSumarry(HttpSession session, Summary summary) {
		summary.setIscheck(1);
		summaryDAO.approveSumarry(summary);
		return "";
	}

	/*
	 * 作者:
	 * 
	 * 功能:添加评论
	 * 
	 * 修改： 将sumname会员姓名改成会员id
	 * 
	 * 修改： 代码进行了精简 传上来的参数 改成了content和pid 去掉返回值 刘娈莎 2016-04-03
	 * 
	 * 修改： 添加返回值，用来标记session是否过期。 1为不过期，0为过期 刘娈莎 2016-04-03
	 * 
	 * 修改： 增加体验者功能 刘娈莎 2016-06-02
	 * 
	 * 
	 * 修改：管理员评论后显示的不是自己的姓名 袁超 2016-12-21
	 * 
	 */
	@ResponseBody
	@RequestMapping("/addComment.action")
	public String addComment(HttpSession session, String content, Summary comment) {
		String flag = "0";
		User user = (User) session.getAttribute("myuser");
		Admin admin = (Admin) session.getAttribute("admin");
		Experience experience = (Experience) session.getAttribute("experience");

		if (admin != null) {
			flag = "1";
			comment.setAdmin(admin);
		} else if (user != null) {
			flag = "1";
			comment.setMember(user.getMember());
		} else if (experience != null) {
			flag = "1";
			comment.setExperience(experience);
		} else {
			return flag;
		}
		comment.setContent(content);
		comment.setTime(SummaryTitle.getTime());
		summaryDAO.addComment(comment);
		return flag;
	}

	/*
	 * 作者:
	 * 
	 * 功能:添加评论
	 * 
	 * 修改： 将sumname会员姓名改成会员id
	 * 
	 * 修改： 增加体验者功能 作者：刘娈莎 日期：2016-02-06
	 * 
	 * 修改： 功能:添加谁看过我的周报 作者:张晓敏 日期：2016-08-06
	 * 
	 */
	@ResponseBody
	@RequestMapping("/getComments.action")
	public Summary getComments(HttpSession session, Summary summary) {
		List<Summary> comments = new ArrayList<Summary>();
		if (summaryDAO.getComment(summary.getId()) != null) {
			comments = summaryDAO.getComment(summary.getId()).getSummaries();
		}

		for (int i = 0; i < comments.size(); i++) {
			Summary s = comments.get(i);
			int mid = summaryDAO.getMemId(s.getId());
			if (mid != 0) {
				Member member = memberDAO.getMemById(mid);
				s.setMember(member);
			}
			int eid = summaryDAO.getEid(s);
			if (eid != 0) {
				Experience experience = experienceDAO.getExperienceById(eid);
				s.setExperience(experience);
			}
			int aid = summaryDAO.getAid(s);
			if (aid != 0) {
				Admin admin = adminDAO.getAmById(aid);
				s.setAdmin(admin);
			}

		}
		summary.setSummaries(comments);
		summary.setSummaryVisits(summaryDAO.getSummaryVisit(summary.getId()));
		return summary;

	}

	/*
	 * 功能:管理员删除周报对应评论 作者:傅新顺 日期:2016-4-11
	 *
	 *
	 * 修改： 去掉了返回值 刘娈莎 2016-4-16
	 */
	@ResponseBody
	@RequestMapping("/delComment.action")
	public String delComment(int id) {
		summaryDAO.delSum(id);
		return null;

	}

	@ResponseBody
	@RequestMapping("/isApprove.action")
	public int isApprove(HttpSession session) {
		Summary s = (Summary) session.getAttribute("getSum");
		int checkVal = summaryDAO.isApprove(s.getId());
		int data = 0;
		if (checkVal != 0) {
			data = checkVal;
		}
		return data;
	}

	/*
	 * 作者:
	 * 
	 * 功能:获取通过getSummary(HttpSession, int)方法在session中存的周报和评论 作者：
	 * 
	 * 修改： 改成和方法名一致，通过id获取周报 刘娈莎 2016-04-16
	 * 
	 * 修改： 增加体验者功能 刘娈莎 2016-06-02
	 * 
	 * 修改: 功能:添加浏览周报的记录 作者：张晓敏 日期:2016-08-06
	 */
	@ResponseBody
	@RequestMapping("/getSumById.action")
	public Summary getSumById(HttpSession session, Summary summary) {
		summary = summaryDAO.getSumById(summary.getId());
		if (summary.getMid() != 0) {
			Member member = memberDAO.getMemById(summary.getMid());
			summary.setMember(member);
			// System.out.println(member);
		}
		if (summary.getEid() != 0) {
			Experience experience = experienceDAO.getExperienceById(summary.getEid());
			summary.setExperience(experience);
			// System.out.println(experience);
		}
		// 当有人查看周报时添加查看记录
		if (summary != null) {
			int flag;
			String name;
			if (session.getAttribute("admin1") != null) {
				flag = 1;
				name = ((Admin) session.getAttribute("admin1")).getRealname();
			} else if (session.getAttribute("myuser") != null) {
				flag = 2;
				name = ((User) session.getAttribute("myuser")).getMember().getName();
			} else {
				flag = 3;
				name = ((Experience) session.getAttribute("experience")).getName();
			}
			SummaryVisit summaryVisit = new SummaryVisit();
			summaryVisit.setSid(summary.getId());
			summaryVisit.setFlag(flag);
			summaryVisit.setName(name);
			if (summaryDAO.checkSummaryVisit(summaryVisit) == 0) {
				summaryDAO.addSummaryVisit(summaryVisit);
				System.out.println(summaryVisit.toString());
			}
		}
		return summary;
	}

	@ResponseBody
	@RequestMapping("/getNewestComment.action")
	public Summary getNewestComment(HttpSession session) {
		Summary summary = (Summary) session.getAttribute("NEWEST");
		return summary;
	}

	@ResponseBody
	@RequestMapping("/getSummaryAll.action")
	public List<Summary> getSummaryAll(HttpSession session, Summary summary, int pages) throws ParseException {
		@SuppressWarnings("unchecked")
		List<Summary> prelist = (List<Summary>) session.getAttribute("PREWEEKLIST");
		@SuppressWarnings("unchecked")
		List<Summary> nextlist = (List<Summary>) session.getAttribute("NEXTWEEKLIST");
		@SuppressWarnings("unchecked")
		List<Summary> currentlist = (List<Summary>) session.getAttribute("CURRENTWEEKLIST");
		if (prelist != null) {
			return prelist;
		} else if (nextlist != null) {
			return nextlist;
		} else if (currentlist != null) {
			return currentlist;
		}
		if (pages <= 0) {
			pages = 1;
		}
		List<Summary> list = summaryDAO.getgetSummaryAll(SummaryTitle.getTitle());
		List<Summary> list2 = null;
		if (list.size() == 0) {
			String preweek = SummaryTitle.getPreWeekTitleSec(SummaryTitle.getTitle());
			list2 = summaryDAO.getgetSummaryAll(preweek);
		}
		int datasize = 0;
		if (list.size() > 0) {
			datasize = list.size();
		} else {
			datasize = list2.size();
		}
		int pageCounts = Paging.pageCount(datasize, sumpageSize);
		session.setAttribute("AllPageCounts", pageCounts);
		if (pages > pageCounts) {
			pages = pageCounts;
		}
		session.setAttribute("TITLEDATE", SummaryTitle.getTitle());
		Paging<Summary> paging = new Paging<>();
		if (list.size() > 0) {
			return paging.paging(list, sumpageSize, pages);
		} else {
			return paging.paging(list2, sumpageSize, pages);
		}

	}

	@ResponseBody
	@RequestMapping("/preparePageNumber.action")
	public int preparePageNumber(HttpSession session) throws ParseException {
		int pageSum = (int) session.getAttribute("AllPageCounts");
		return pageSum;
	}

	@ResponseBody
	@RequestMapping("/checkPreWeekIsValid.action")
	public int checkpreWeekIsValid(HttpSession session) throws ParseException {
		String validTitle = (String) session.getAttribute("TITLEDATE");
		List<Summary> list = summaryDAO.getSummaryByWeek(validTitle);
		String preOneWeek = SummaryTitle.getPreWeekTitleSec(validTitle);
		String preTwoWeek = SummaryTitle.getPreWeekTitleSec(preOneWeek);
		List<Summary> preTwoWeekList = summaryDAO.getSummaryByWeek(preTwoWeek);
		if (list.size() > 0) {
			return 1;
		} else if (preTwoWeekList.size() > 0) {
			session.setAttribute("PRETWOLIST", preTwoWeekList);
			session.setAttribute("PRETWOWeek", preTwoWeek);
			return 1;
		}
		return 0;

	}

	@ResponseBody
	@RequestMapping("/getSummaryByPreWeek.action")
	public List<Summary> getSummaryByPreWeek(HttpSession session, int pages) throws ParseException {
		if (pages <= 0) {
			pages = 1;
		}
		@SuppressWarnings("unchecked")
		List<Summary> preTWOlist = (List<Summary>) session.getAttribute("PRETWOLIST");
		String titleDate = (String) session.getAttribute("TITLEDATE");
		List<Summary> list = new ArrayList<Summary>();
		String preWeekDate2 = SummaryTitle.getPreWeekTitleSec(titleDate);
		session.setAttribute("TITLEDATE", preWeekDate2);
		list = summaryDAO.getSummaryByWeek(preWeekDate2);
		if (list.size() == 0) {
			String updateToCurrentWeek = SummaryTitle.getNextWeekTitleSec(preWeekDate2);
			session.setAttribute("TITLEDATE", updateToCurrentWeek);
			return list;
		} else {
			int datasize = list.size();
			if (datasize == 0) {
				return list;
			}
			int pageCounts = Paging.pageCount(datasize, sumpageSize);
			session.setAttribute("AllPageCounts", pageCounts);
			if (pages > pageCounts) {
				pages = pageCounts;
			}
			List<Summary> paginglist = new ArrayList<Summary>();

			if (preTWOlist != null) {
				String preTwoWeek = (String) session.getAttribute("PRETWOWeek");
				session.setAttribute("TITLEDATE", preTwoWeek);
				list = preTWOlist;
			}
			Paging<Summary> paging = new Paging<>();
			paginglist = paging.paging(list, sumpageSize, pages);
			session.setAttribute("PREWEEKLIST", paginglist);
			session.setAttribute("NEXTWEEKLIST", null);
			session.setAttribute("CURRENTWEEKLIST", null);
			return paginglist;
		}
	}

	@ResponseBody
	@RequestMapping("/getSummaryByCurrentWeek.action")
	public List<Summary> getSummaryByCurrentWeek(HttpSession session, Summary summary, int pages)
			throws ParseException {
		if (pages <= 0) {
			pages = 1;
		}
		List<Summary> list = summaryDAO.getgetSummaryAll(SummaryTitle.getTitle());
		List<Summary> list2 = null;
		if (list.size() == 0) {
			String preweek = SummaryTitle.getPreWeekTitleSec(SummaryTitle.getTitle());
			list2 = summaryDAO.getgetSummaryAll(preweek);
		}
		int datasize = 0;
		if (list.size() > 0) {
			datasize = list.size();
		} else {
			datasize = list2.size();
		}
		int pageCounts = Paging.pageCount(datasize, sumpageSize);
		session.setAttribute("AllPageCounts", pageCounts);
		if (pages > pageCounts) {
			pages = pageCounts;
		}
		session.setAttribute("TITLEDATE", SummaryTitle.getTitle());
		List<Summary> paginglist = new ArrayList<Summary>();
		Paging<Summary> paging = new Paging<>();
		if (list.size() > 0) {
			paginglist = paging.paging(list, sumpageSize, pages);
			session.setAttribute("PREWEEKLIST", null);
			session.setAttribute("NEXTWEEKLIST", null);
			session.setAttribute("CURRENTWEEKLIST", paginglist);
			return paginglist;
		} else {
			paginglist = paging.paging(list2, sumpageSize, pages);
			session.setAttribute("PREWEEKLIST", null);
			session.setAttribute("NEXTWEEKLIST", null);
			session.setAttribute("CURRENTWEEKLIST", paginglist);
			return paginglist;
		}
	}

	@ResponseBody
	@RequestMapping("/checkNextWeekIsValid.action")
	public int checkNextWeekIsValid(HttpSession session) throws ParseException {
		String validTitle = (String) session.getAttribute("TITLEDATE");
		List<Summary> list = summaryDAO.getSummaryByWeek(validTitle);
		String nextOneWeek = SummaryTitle.getNextWeekTitleSec(validTitle);
		String nextTwoWeek = SummaryTitle.getPreWeekTitleSec(nextOneWeek);
		List<Summary> nextTwoWeekList = summaryDAO.getSummaryByWeek(nextTwoWeek);
		if (list.size() > 0) {
			return 1;
		} else if (nextTwoWeekList.size() > 0) {
			session.setAttribute("NEXTTWOLIST", nextTwoWeekList);
			session.setAttribute("NEXTTWOWeek", nextTwoWeek);
			return 1;
		}
		return 0;

	}

	@ResponseBody
	@RequestMapping("/getSummaryByNextWeek.action")
	public List<Summary> getSummaryByNextWeek(HttpSession session, int pages) throws ParseException {
		if (pages <= 0) {
			pages = 1;
		}
		@SuppressWarnings("unchecked")
		List<Summary> nextTWOlist = (List<Summary>) session.getAttribute("NEXTTWOLIST");
		String titleDate = (String) session.getAttribute("TITLEDATE");
		List<Summary> list = new ArrayList<Summary>();
		String preWeekDate2 = SummaryTitle.getNextWeekTitleSec(titleDate);
		session.setAttribute("TITLEDATE", preWeekDate2);
		list = summaryDAO.getSummaryByWeek(preWeekDate2);
		if (list.size() == 0) {
			String updateToCurrentWeek = SummaryTitle.getPreWeekTitleSec(preWeekDate2);
			session.setAttribute("TITLEDATE", updateToCurrentWeek);
			return list;
		} else {
			int datasize = list.size();
			if (datasize == 0) {
				return list;
			}
			int pageCounts = Paging.pageCount(datasize, sumpageSize);
			session.setAttribute("AllPageCounts", pageCounts);
			if (pages > pageCounts) {
				pages = pageCounts;
			}
			List<Summary> paginglist = new ArrayList<Summary>();
			if (nextTWOlist != null) {
				String preTwoWeek = (String) session.getAttribute("NEXTTWOWeek");
				session.setAttribute("TITLEDATE", preTwoWeek);
				list = nextTWOlist;
			}
			Paging<Summary> paging = new Paging<>();
			paginglist = paging.paging(list, sumpageSize, pages);
			session.setAttribute("PREWEEKLIST", null);
			session.setAttribute("NEXTWEEKLIST", paginglist);
			session.setAttribute("CURRENTWEEKLIST", null);
			return paginglist;
		}
	}

	/*
	 * 作者:
	 * 
	 * 功能:获取周报 修改： 把传入的page参数去掉了 刘娈莎 2016-04-02
	 * 
	 * 修改： aid从string改成int类型 刘娈莎 2016-04-16 方法名统一：将get.action改为getSummary.action
	 * 杨凯 2016-04-20
	 */

	@ResponseBody
	@RequestMapping("/getSummary.action")
	public String getSummary(HttpSession session, int id) {
		Summary s = summaryDAO.getSumById(id);
		int mid = summaryDAO.getMemId(id);
		if (mid != 0) {
			Member member = memberDAO.getMemById(mid);
			s.setMember(member);
		}
		// 这是拿到的评论
		int isHavePid = summaryDAO.isChePid(id);
		if (isHavePid != 0) {
			List<Summary> comments = summaryDAO.getComment(id).getSummaries();
			for (int i = 0; i < comments.size(); i++) {
				Summary summary = comments.get(i);
				int mid3 = summaryDAO.getMemId(summary.getId());
				if (mid3 != 0) {
					Member member2 = memberDAO.getMemById(mid3);
					summary.setMember(member2);
				}
				int aid = summaryDAO.getAid(summary);
				if (aid != 0) {
					Admin admin2 = adminDAO.getAmById(aid);
					summary.setAdmin(admin2);
				}
			}
			s.setSummaries(comments);
		}
		session.setAttribute("getSum", s);
		String str = s.getMember().getId() + ":" + s.getIscheck();
		return str;
	}

	/*
	 * 作者:
	 * 
	 * 功能:获取周报内容content，如果已经审核则内容为空
	 * 
	 * 
	 * 修改： 简单的只检查是否已审核，已审核返回1，未审核返回0
	 * 
	 * 修改:增加判断体验者 作者：刘娈莎 日期：2016-5-27
	 * 
	 */
	@ResponseBody
	@RequestMapping("/isCheckSum.action")
	public int isCheckSum(HttpSession session, Summary summary) throws ParseException {
		if (session.getAttribute("myuser") != null) {
			User user = (User) session.getAttribute("myuser");
			int mid = user.getMember().getId();
			summary.setMid(mid);
		} else if (session.getAttribute("experience") != null) {
			Experience experience = (Experience) session.getAttribute("experience");
			summary.setEid(experience.getId());
		}
		summary.setTitle(SummaryTitle.getWriteTitle());
		return summaryDAO.getCurrentSummary(summary).getIscheck();

	}

	// ==============================分割线=============================

	/*
	 * 功能:管理员删除周报(连同评论)功能 作者:傅新顺 日期:2016-4-11
	 *
	 * 修改： 去掉了返回值,增加@ResponseBody 刘娈莎 2016-4-16
	 */
	@ResponseBody
	@RequestMapping("/delSummary.action")
	public String delSummary(int id) {
		summaryDAO.delSum(id);
		return null;
	}

	/*
	 * 功能:获取修改的title时间 作者:左琪 日期:2016-4-23
	 */
	@ResponseBody
	@RequestMapping("/modifyTitle.action")
	public String modifyTitle(HttpServletRequest request) throws ParseException {
		String title = request.getParameter("title");
		String weekType = request.getParameter("weekType");
		String newTitle = "";
		if (weekType.equals("pre")) {
			newTitle = SummaryTitle.getPreWeekTitleSec(title);
		} else {
			newTitle = SummaryTitle.getNextWeekTitleSec(title);
		}
		return newTitle;
	}

	/*
	 * 作者:左琪 功能:修改周报标题,暂时只有修改title 日期:2016-4-24
	 */
	@ResponseBody
	@RequestMapping("/update1Summary.action")
	public String update1Summary(HttpSession session, Summary summary) {
		summaryDAO.update1Summary(summary);
		return null;
	}

	/*
	 * 功能:获取周报相关的一些信息 作者:刘娈莎 日期:2016-6-5
	 */
	@ResponseBody
	@RequestMapping("/getSummaryInfoByPage.action")
	public String getSummaryInfoByPage(HttpSession session, HttpServletRequest request, MemAndExpDTO memAndExpDTO,
			int page2) {
		System.out.println(memAndExpDTO);
		int newpage;
		memAndExpDTO.getPage().setCurrentPage(page2);
		newpage = page2;
		List<MemAndExp> list = summaryDAO.getSummaryInfoByPage(memAndExpDTO);
		// 当删除某页最后一天记录时，要往前一页取值
		if (list.size() == 0) {
			newpage = page2 - 1;
			if (newpage == 0) {
				newpage = 1;
			}
			memAndExpDTO.getPage().setCurrentPage(newpage);
			list = summaryDAO.getSummaryInfoByPage(memAndExpDTO);
		}
		String url = request.getContextPath() + "/summary/getSummaryInfoByPage.action";
		int btnCount = 5;
		int pageCount = memAndExpDTO.getPage().getTotalPage();
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		// System.out.println(str);
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("navbar", str);
		returnMap.put("list", list);
		JSONObject json = new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();
	}

	@ResponseBody
	@RequestMapping("/getSumByMid.action")
	public String getSumByMid(HttpServletRequest request, HttpSession session, SummaryDTO summaryDTO, int page2,
			int cmid) throws ParseException {
		String weekType1 = summaryDTO.getWeekType();
		String title1 = summaryDTO.getTitle();
		String newTitle1 = "";
		if (weekType1.equals("previous")) {
			if (title1 == null) {
				newTitle1 = SummaryTitle.getPreWeekTitleSec(SummaryTitle.getWriteTitle());
				summaryDTO.setTitle(newTitle1);
			} else {
				newTitle1 = SummaryTitle.getPreWeekTitleSec(title1);
				summaryDTO.setTitle(newTitle1);
			}
		}
		if (weekType1.equals("current")) {
			newTitle1 = SummaryTitle.getWriteTitle();
			summaryDTO.setTitle(newTitle1);
		}
		if (weekType1.equals("next")) {
			if (title1.equals("")) {
				newTitle1 = SummaryTitle.getNextWeekTitleSec(SummaryTitle.getWriteTitle());
				summaryDTO.setTitle(newTitle1);
			} else {
				newTitle1 = SummaryTitle.getNextWeekTitleSec(title1);
				summaryDTO.setTitle(newTitle1);
			}

		}
		String cnum = memberDAO.getMemNum(cmid);
		summaryDTO.setCnum(cnum);
		// System.out.println(summaryDTO);
		int sumcount = summaryDAO.checkHaveSumByNum(cnum);
		if (sumcount != 0) {
			// 设置取数据的参数
			// ownerType设置,只有会员需要这个
			if (session.getAttribute("admin") == null) {
				String ownerType = summaryDTO.getOwnerType();
				if (!ownerType.equals("all") && ownerType != null) {
					if (session.getAttribute("myuser") != null) {
						User user = (User) session.getAttribute("myuser");
						summaryDTO.setId(user.getMember().getId());
						summaryDTO.setIdentityType("member");
					}
					if (session.getAttribute("experience") != null) {
						Experience experience = (Experience) session.getAttribute("experience");
						summaryDTO.setId(experience.getId());
						summaryDTO.setIdentityType("experience");
					}

				}

			}
			// weekType设置
			String weekType = summaryDTO.getWeekType();
			// String weekType="current";
			String title = summaryDTO.getTitle();
			String newTitle = "";
			if (weekType.equals("previous")) {
				if (title.equals("")) {
					newTitle = SummaryTitle.getPreWeekTitleSec(SummaryTitle.getWriteTitle());
					summaryDTO.setTitle(newTitle);
				} else {
					newTitle = SummaryTitle.getPreWeekTitleSec(title);
					summaryDTO.setTitle(newTitle);
				}
			}
			if (weekType.equals("current")) {
				newTitle = SummaryTitle.getWriteTitle();
				summaryDTO.setTitle(newTitle);
			}
			if (weekType.equals("next")) {
				if (title.equals("")) {
					newTitle = SummaryTitle.getNextWeekTitleSec(SummaryTitle.getWriteTitle());
					summaryDTO.setTitle(newTitle);
				} else {
					newTitle = SummaryTitle.getNextWeekTitleSec(title);
					summaryDTO.setTitle(newTitle);
				}

			}
			// 用于修改完周报title不变
			if (weekType.equals("now")) {
				newTitle = title;
				summaryDTO.setTitle(newTitle);
			}
			// checkType设置

			// 取数据部分
			int newpage;
			summaryDTO.getPage().setCurrentPage(page2);
			newpage = page2;

			List<LookSummary> list = summaryDAO.getSummarysByMid(summaryDTO);

			// System.out.println(summaryDTO.getTitle());
			// 当删除某页最后一天记录时，要往前一页取值
			if (list.size() == 0) {
				newpage = page2 - 1;
				if (newpage == 0) {
					newpage = 1;
				}
				summaryDTO.getPage().setCurrentPage(newpage);
				list = summaryDAO.getSummarysByMid(summaryDTO);
			}

			String url = request.getContextPath() + "/summary/getSumByMid.action";
			int btnCount = 5;
			int pageCount = summaryDTO.getPage().getTotalPage();
			Paging<LookSummary> p = new Paging<LookSummary>();
			String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
			// System.out.println(str);
			HashMap<String, Object> returnMap = new HashMap<String, Object>();
			returnMap.put("navbar", str);
			// returnMap.put("totalCount",
			// summaryDTO.getPage().getTotalCount());
			returnMap.put("totalCount", list.size());
			returnMap.put("list", list);
			returnMap.put("title", newTitle);
			String titleTip = "";
			if (!weekType.equals("all")) {
				titleTip = "当前周报时间：" + newTitle;
			}
			returnMap.put("titleTip", titleTip);
			JSONObject json = new JSONObject();
			json.put("returnMap", returnMap);
			return json.toString();

		} else {
			return "0";
		}

	}

	/*
	 * 作者:张晨旭 功能:有人评论后，修改summary表的remind字段 日期:2017-1-6
	 */
	@ResponseBody
	@RequestMapping("/remind.action")
	public String remind(HttpSession session, int pid) {
		if (session.getAttribute("MyLastSummary") != null) {
			int mylastpid = (int) session.getAttribute("MyLastSummary");
			if (mylastpid != pid) {
				summaryDAO.updateRemind(pid);
			} else {
				summaryDAO.deleteRemind(pid);
			}
		} else {
			summaryDAO.updateRemind(pid);
		}
		return null;
	}

	/*
	 * 作者:张晨旭 功能:登录后检查是否有为查看的评论 日期:2017-1-6
	 */
	@ResponseBody
	@RequestMapping("/checkRemind.action")
	public int checkRemind(HttpSession session) {
		try {
			int mylastpid = (int) session.getAttribute("MyLastSummary");
			return summaryDAO.getRemind(mylastpid);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	/*
	 * 作者:谢尚钢 功能:通过summary里的id得到评论 日期:2017-3-11
	 */
	@ResponseBody
	@RequestMapping("/getCommentById.action")
	public Summary getCommentById(HttpSession session, Summary summary) {
		return summaryDAO.getCommentById(summary.getId());
	}

	/*
	 * 作者:谢尚钢 功能:修改评论 日期:2017-3-11
	 */
	@ResponseBody
	@RequestMapping("/updateComment.action")
	public String updateComment(HttpSession session, Summary summary) {
		if (summaryDAO.updateComment(summary) > 0) {
			return "1";
		}
		return "0";
	}
	/*
	 * 作者:郭俊良
	 * 功能:改变周报架构
	 * 日期:2017-3-28
	 */	
	@RequestMapping("/getSummarys.action")
	@ResponseBody
	public Result getSummarys(SummaryDTO summaryDTO, @RequestParam(defaultValue = "1") Integer page,
			@RequestParam(defaultValue = "10") Integer rows, HttpSession session) {
		try {
			if (summaryDTO.getTitle() == null) {
				summaryDTO.setTitle(SummaryTitle.getWriteTitle());
			}
			// summaryDTO.setWeekType("all");
			// summaryDTO.setAssistant(20);
			if (summaryDTO.getOwnerType().equals("my")) {
				if (session.getAttribute("myuser") != null) {
					User user = (User) session.getAttribute("myuser");
					summaryDTO.setId(user.getMember().getId());
					summaryDTO.setIdentityType("member");
				} else if (session.getAttribute("experience") != null) {
					Experience experience = (Experience) session.getAttribute("experience");
					summaryDTO.setId(experience.getId());
					summaryDTO.setIdentityType("experience");
				}
			}
			if (summaryDTO.getOwnerType().equals("所有人")) {
				summaryDTO.setOwnerType("all");
			}
			System.out.println("summary:" + summaryDTO);
			return summaryDAO.getSummarys(summaryDTO, page, rows);
		} catch (Exception e) {
			return Result.build(101, e.getMessage());
		}
	}
	/*
	 * 功能:获取分页周报内容、分页导航条、记录总数（不从服务器跳转，返回一个json对象） 作者:杜炜 日期:2017-4-23
	 */
	@ResponseBody
	@RequestMapping("/getExperienceSummary.action")
	public Result getExperienceSummary(HttpServletRequest request,String name,  @RequestParam(defaultValue = "1") int  page, @RequestParam(defaultValue = "10") int  rows)
			{
		Result result= summaryDAO.getExperienceSummarys(name,page,rows);
		@SuppressWarnings("unchecked")
		List<LookSummary> list =(List<LookSummary>)result.getData();
		String url = request.getContextPath() + "/summary/getExperienceSummary.action";
		int btnCount = 5;
		String str = NavigationBar.classNavBar(url, btnCount, page, result.getCount());
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("navbar", str);
		returnMap.put("totalCount",result.getTotal());
		returnMap.put("list", list);
		JSONObject json = new JSONObject();
		json.put("returnMap", returnMap);

		return Result.ok(json.toString(),page,result.getCount());
	}

}
