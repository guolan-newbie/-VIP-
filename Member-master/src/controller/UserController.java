package controller;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zefer.html.doc.s;

import com.itextpdf.text.log.SysoLogger;

import dao.AccountLogDAO;
import dao.ExperienceDAO;
import dao.MemberDAO;
import dao.PeriodDAO;
import dao.PictureDAO;
import dao.SummaryDAO;
import dao.UserDAO;
import dao.UserInfoDAO;
import dao.VisitDAO;
import dto.UserDTO;
import entity.AccountLog;
import entity.Experience;
import entity.Member;
import entity.QueryType;
import entity.StatusCode;
import entity.Summary;
import entity.SystemInfo;
import entity.User;
import entity.UserInfo;
import entity.Visitor;
import tools.Authentication;
import tools.ContractPDF;
import tools.GeneratePDF;
import tools.HttpRequestDeviceUtils;
import tools.MD5SaltUtils;
import tools.NavigationBar;
import tools.Paging;
import tools.ReturnJson;
import tools.SummaryTitle;
import tools.VerifyIdentity;

@Controller
@RequestMapping("/user")
public class UserController {
	private static Logger logger = Logger.getLogger(UserController.class);
	@Resource
	PeriodDAO periodDAO;
	@Resource
	VisitDAO visitDAO;
	@Resource
	UserDAO userDAO;
	@Resource
	MemberDAO memberDAO;
	@Resource
	UserInfoDAO userInfoDAO;
	@Resource
	SummaryDAO summaryDAO;
	@Resource
	PictureDAO pictureDAO;
	@Resource
	ExperienceDAO experienceDAO;
	@Resource
	AccountLogDAO accountLogDAO;
	int pageSize = 10;
	int sumpageSize = 9;
	@Resource
	GeneratePDF generatePDF;

	/*
	 * 修改： 修改的内容：getuser.action改成getUser.action 作者：刘文启 最后修改:2016-04-19
	 */
	@RequestMapping("/getUser.action")
	@ResponseBody
	public List<User> getUser(HttpServletRequest request, int page, int type,
			@RequestParam(value = "no", defaultValue = "0") int no) throws IOException {
		QueryType queryType = new QueryType();
		queryType.setType(type);
		queryType.setNo(no);
		List<User> list = userDAO.getUser(queryType);

		int size = list.size();
		if (size == 0) {
			return list;
		}
		// 根据传入的页码,提取分页数据
		int pageCount = Paging.pageCount(size, pageSize);
		if (page > pageCount) {
			page = pageCount;
		}
		if (page <= 0) {
			page = 1;
		}
		Paging<User> paging = new Paging<>();
		return paging.paging(list, pageSize, page);
	}

	/*
	 * 本来是对上面getUser方法的改写，不敢确定是否有别的地方也调用这个方法，所以重新写一个 功能：获取分页用户信息，供费用管理页面使用
	 * 目的：统一分页逻辑 作者：刘娈莎 日期：2016-5-10
	 *
	 * 修改：增加判断list的长度，如果没有数据则返回一个空的arraylist
	 * 同时修改了sql语句，由全部内连接改为user和member内连接，其他表与他们左外连接。 作者：刘娈莎 日期：2016-5-19
	 */
	@RequestMapping("/getUserByPage.action")
	@ResponseBody
	public String getUserByPage(HttpSession session, HttpServletRequest request, UserDTO userDTO, int page2)
			throws IOException, ParseException {
//		System.out.println(userDTO);
		int newpage;
		userDTO.getPage().setCurrentPage(page2);
		newpage = page2;
		List<User> list = userDAO.getUserByPage(userDTO);
		// 当删除某页最后一天记录时，要往前一页取值
		if (list.size() == 0) {
			newpage = page2 - 1;
			if (newpage == 0) {
				newpage = 1;
			}
			userDTO.getPage().setCurrentPage(newpage);
			list = userDAO.getUserByPage(userDTO);
		}
		// 设置时间格式
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		for (int i = 0; i < list.size(); i++) {
			Member member = list.get(i).getMember();
			member.setFormatGraduateDate(df.format(member.getGraduateDate()));
		}
		ArrayList<Double> unpaid = new ArrayList<Double>();
		ArrayList<String> date = new ArrayList<String>();
		ArrayList<Integer> flags = new ArrayList<Integer>();
		long time = 0;
		List<AccountLog> accountLogs = accountLogDAO.getAccountLogByFlag();
		/*for (AccountLog accountLog : accountLogs) {
			System.out.println(accountLog);
		}*/
		DateFormat df2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (int i = 0; i < list.size(); i++) {
			for (int j = 0; j < accountLogs.size(); j++) {
				if (list.get(i).getMember().getId() == accountLogs.get(j).getMember().getId()) {
					accountLogs.get(j).setFormatDate(df2.format(accountLogs.get(j).getDate()));
					list.get(i).setAccountLog(accountLogs.get(j));
					break;
				}
			}
			if (list.get(i).getMember().isFlag()) {
				long l1 = new Date().getTime();
				long l2 = 0l;
				long l3 = 1000 * 60 * 60 * 24 * 30l;
				AccountLog accountLog = accountLogDAO.getAccountLogLastById(list.get(i).getMember().getId());
				if (accountLog != null) {
					l2 = accountLog.getDate().getTime();
				} else {
					l2 = list.get(i).getMember().getTime().getTime();
				}
				time = (l1 - l2) / l3;
				System.out.println(time + "sdfghdjksfghjdfsjdfghjksdf");
				flags.add((int) time);
				unpaid.add(periodDAO.getUnpaidByMid(list.get(i).getMember().getId()));
				date.add(new SimpleDateFormat("dd号").format(list.get(i).getMember().getTime()));
			}
		}
		String url = request.getContextPath() + "/user/getUserByPage.action";
		int btnCount = 5;
		int pageCount = userDTO.getPage().getTotalPage();
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		System.out.println(str);
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("navbar", str);
		// returnMap.put("totalCount", userDTO.getPage().getTotalCount());
		if (list.size() > 0) {
			returnMap.put("list", list);
			if (userDTO.getType() == 3) {
				returnMap.put("unpaid", unpaid);
				returnMap.put("date", date);
				returnMap.put("flags", flags);
				System.out.println(flags.toString());
			}
		} else {
			returnMap.put("list", new ArrayList<>());
		}
		JSONObject json = new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();
	}

	/*
	 * 作者:张中强 最后修改日期:2015-11-15 功能:计算指定范围用户的分页总页数。 type表示不同范围的用户。 type=0表示提取所有数据
	 * type=1表示提取指定id为指定no的数据 type=2表示提取所有需要审核的数据 type=3表示提取所有需要缴费的数据
	 * type=4表示提取所有已审核的用户 王冰冰20151203
	 */
	@RequestMapping("/getPageCount.action")
	@ResponseBody
	public String getPageCount(int type, @RequestParam(value = "no", defaultValue = "0") int no) {
		QueryType queryType = new QueryType();
		queryType.setType(type);
		queryType.setNo(no);
		List<User> list = userDAO.getUser(queryType);
		return String.valueOf(Paging.pageCount(list.size(), pageSize));
	}

	/*
	 * 作者:张中强 最后修改日期:2015-11-15 功能:查询指定范围内的会员 type表示不同范围的用户。 type=0表示提取所有数据
	 * type=1表示提取指定id为指定no的数据 type=2表示提取所有需要审核的数据 type=3表示提取所有需要缴费的数据
	 * type=4表示提取所有已审核的用户
	 */
	/*
	 * 功能:提供保存Excel文件
	 * 
	 * 修改：最后返回的路径有问题，将\\改为// 作者：刘娈莎 日期：2016-5-11
	 */
	//
	@RequestMapping("/download.action")
	@ResponseBody
	public String download(HttpServletResponse response, HttpServletRequest request, int type,
			@RequestParam(value = "no", defaultValue = "0") int no) throws IOException {
		// 这里是我修改的代码
		QueryType queryType = new QueryType();
		

		queryType.setType(type);
		queryType.setNo(no);
		
		List<User> list = userDAO.getUser(queryType);
		// 设置文件名称
		Calendar cal = Calendar.getInstance();
		String fileName = "";

		// 生成文件名的年部分
		int year = cal.get(Calendar.YEAR);
		fileName = fileName + year;

		// 生成文件名的月部分
		int month = cal.get(Calendar.MONTH);
		if (month < 10) {
			fileName = fileName + "0";
		}
		fileName = fileName + month;

		// 生成文件名的日部分
		int day = cal.get(Calendar.DAY_OF_MONTH);
		if (day < 10) {
			fileName = fileName + "0";
		}
		fileName = fileName + day;

		// 生成文件名的小时部分
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		if (hour < 10) {
			fileName = fileName + "0";
		}
		fileName = fileName + hour;

		// 生成文件名的分钟部分
		int minute = cal.get(Calendar.MINUTE);
		if (minute < 10) {
			fileName = fileName + "0";
		}
		fileName = fileName + minute;

		// 生成文件名的秒部分
		int second = cal.get(Calendar.SECOND);
		if (second < 10) {
			fileName = fileName + "0";
		}
		fileName = fileName + second;

		// 生成文件名的毫秒部分
		int millisecond = cal.get(Calendar.MILLISECOND);
		if (millisecond < 10) {
			fileName = fileName + "0";
		}
		if (millisecond < 100) {
			fileName = fileName + "0";
		}

		fileName = fileName + millisecond;

		String path = request.getServletContext().getRealPath("//") + fileName + ".xls";
		String contextpath = request.getServletContext().getContextPath() + "//" + fileName + ".xls";
		String title = "学生审核表";
		String[] headers = { "序号", "用户名", "真实姓名", "学校名称", "联系电话", "公司名称", "毕业时间", "在职", "特殊" };
		userDAO.print(list, headers, path, title);
		response.setContentType("application/force-download");
		return String.valueOf(contextpath);
	};

	/*
	 * 作者:张中强 作用:通过会员用户id,获取用户的协议相关信息 日期:2015-12-02
	 * 
	 * 修改：添加判断如果list长度为0则返回空 作者：刘娈莎 日期：2016-5-19
	 */
	@ResponseBody
	@RequestMapping("/getinfo.action")
	public UserInfo getinfo(int id) {
		UserInfo userInfo = new UserInfo();
		userInfo.setUid(id);
		List<UserInfo> list = userInfoDAO.get(userInfo);
		if (list.size() > 0) {
			return list.get(0);
		} else {
			return null;
		}

	}

	/*
	 * 功能：根据id，删除某用户 修改： 修改的内容：deleteuser.action改成deleteById.action 作者：刘文启
	 * 最后修改:2016-04-19
	 *
	 *
	 * 修改：去掉返回值 作者：刘娈莎 日期：2016-5-11
	 *
	 * 修改：把deletebyid的dao方法由直接删除user、member、userinfo表改为只删除user、member，
	 * 其他的数据再单独删除，修改了注册的逻辑后，其他的表可能为空。 增加删除period表信息的功能。 作者：刘娈莎 日期：2016-5-19
	 */
	@ResponseBody
	@RequestMapping("/deleteById.action")
	public String deleteById(int id) {
		userDAO.deleteById(id);
		userInfoDAO.deleteByUid(id);
		if (memberDAO.getByUid(id).size() > 0) {
			periodDAO.deleteByMid(memberDAO.getByUid(id).get(0).getId());
		}
		return null;
	}

	/*
	 * 修改： 修改内容：getpwd.action改成getPwd.action 作者：刘文启 最后修改:2016-04-19
	 */
	@ResponseBody
	@RequestMapping("/getPwd.action")
	public String getPwd(User user) throws Exception {
		String newpwd = MD5SaltUtils.randomCreatePwd();
		String salt = MD5SaltUtils.randomCreateSalt();
		user.setSalt(salt);
		user.setPwd(MD5SaltUtils.encode(newpwd, salt));
		userDAO.update(user);
		return newpwd;
	}

	/*
	 * 功能：退出，去掉session中的用户信息 作者：杨凯 日期：
	 *
	 * 修改：增加了体验者的退出 作者：刘娈莎 日期：2016-5-27
	 *
	 * 修改： 增加了更新访客信息的功能 作者：刘娈莎 日期：2016-07-12
	 * 
	 * 修改： 1.方法名由clearsession修改为clearSession，规范方法名 2.添加项目重构后必须返回值
	 * 3.具体的代码细节未做修改，有些麻烦，等到登录那块修改好了之后，再改这里。 作者：刘娈莎 日期：2016-11-29
	 */
	@RequestMapping(value = "/clearSession.action", method = RequestMethod.POST)
	public void clearSession(HttpSession session, HttpServletRequest request) {
		session.invalidate();
		/*ReturnJson returnJson = new ReturnJson();
		returnJson.setStatusCode(Authentication.checkAll(session));
		if (returnJson.getStatusCode().getErrNum() != 100) {
			return returnJson.returnJson();
		}

		ServletContext application = request.getServletContext();
		session.removeAttribute("admin");
		session.removeAttribute("myuser");
		session.removeAttribute("TURE");
		session.removeAttribute("experience");
		HashMap<String, Visitor> map = (HashMap<String, Visitor>) application.getAttribute("online");
		Set<String> ids = map.keySet();
		Iterator<String> it = ids.iterator();
		String id = "";
		while (it.hasNext()) {
			id = it.next();
		}
		Visitor visitor = map.get(id);
		if (visitor != null) {
			visitor.setLeftTime(new Date());
			visitDAO.update(visitor);
			map.remove(id);
		}
		return returnJson.returnJson();*/
	}

	@RequestMapping("/add.action")
	public String add(HttpSession session, HttpServletRequest request, User user) throws Exception {
		String salt = MD5SaltUtils.randomCreateSalt();
		user.setTime(new Date());
		user.setPwd(MD5SaltUtils.encode(user.getPwd(), salt));
		user.setSalt(salt);
		userDAO.add(user);
		int uid = user.getId();
		int count = pictureDAO.count(uid);
		int allcount = pictureDAO.allcount(uid);
		session.setAttribute("count", count);
		session.setAttribute("allcount", allcount);
		session.setAttribute("myuser", user);
		return "/member/info";
	}

	/*
	 * 作者: 功能:检测登录，并在session中存入一些必要的变量
	 * 
	 * 修改： 把跟周报有关的代码注释掉了，因为查看周报重新做了。 作者：刘娈莎 日期：2016-04-07
	 * 
	 * 修改： 增加一个验证程序，来验证只有注册了用户名和密码的用户。 作者：杨凯 日期：2016-05-06
	 * 
	 * 修改： 添加体验者登录 作者：刘娈莎 日期：2016-05-27
	 * 
	 * 修改： 改善一些逻辑，修复密码乱输可以登录的问题（代码好像被修改过，所以改动较大，不详细记录了） 增加了添加访客信息的功能 作者：刘娈莎
	 * 日期：2016-07-12
	 * 
	 * 修改：在user中加入了几个协议需要的变量 作者：刘娈莎 日期：2016-09-08
	 * 
	 * 修改 内容:登陆成功返回1，否则返回0 作者：张晓敏 日期：2016-10-15
	 */
	@ResponseBody
	@RequestMapping("/check.action")
	public String check(HttpSession session, User user, HttpServletRequest request) throws Exception {
		ServletContext application = request.getServletContext();
		// session.setMaxInactiveInterval(45);
		String path = "login";

		String num = user.getName();
		String password = user.getPwd();
		// 部分访客信息
		Visitor visitor = new Visitor();
		visitor.setVisitTime(new Date());
		visitor.setIp(request.getRemoteAddr());
		boolean flag = HttpRequestDeviceUtils.isMobileDevice(request);
		visitor.setAgent(flag);

		// 体验者登录
		String esalt = experienceDAO.getSaltByNum(num);
		Experience experience = new Experience();
		experience.setNum(num);
		experience.setPassword(MD5SaltUtils.encode(password, esalt));
		experience = experienceDAO.isValid(experience);
		if (experience != null) {
			// 项目重构需要
			session.setAttribute("EXPERIENCE", experience);
			session.setAttribute("experience", experience);
			session.setAttribute("TURE", experience);
			session.setAttribute("SYSTEMINFO", new SystemInfo(request));
			// 设置来访信息
			visitor.setIdentityType(0);
			visitor.setMeid(experience.getId());
			visitDAO.addvisit(visitor);
			visitor = visitDAO.getOne(visitor);
			HashMap<String, Visitor> map = (HashMap<String, Visitor>) application.getAttribute("online");
			map.put(session.getId(), visitor);
			session.setAttribute("Visitor", visitor);
			//在登录时储存体验者的最后一篇周报的id
			int pid=summaryDAO.getExpId(experience.getId());
			session.setAttribute("MyLastSummary", pid);
			path = "/experience/navbar";
			return "1";
		}

		// 不是体验者,继续处理会员登录
		// 以是否通过审核（member.flag）为标准，判断是否完成信息补全
		String salt = userDAO.getSalt(user);
		//将salt放入session  在判断初始密码是否是12345678时有用到
		session.setAttribute("salt", salt);	
		
		user.setPwd(MD5SaltUtils.encode(user.getPwd(), salt));
		if (userDAO.checkValid(user).size() != 0) {
			user = userDAO.checkValid(user).get(0);
			int root = user.getRoot();
			// session.setAttribute("Root", 0);
			List<User> memberlist = userDAO.getMemberInfo(user);
			// user表,member表两个表中有有能链接的数据
			
			if (memberlist.size() != 0) {
				user = memberlist.get(0);
				if (user.getMember().isFlag()) {
					session.setAttribute("Root", 1);
				}
				visitor.setIdentityType(1);
				visitor.setMeid(user.getMember().getId());
				System.out.println(visitor);
				visitDAO.addvisit(visitor);
				System.out.println(visitor);
				HashMap<String, Visitor> map = (HashMap<String, Visitor>) application.getAttribute("online");
				map.put(session.getId(), visitor);
				session.setAttribute("Visitor", visitor);
				List<User> alllist = userDAO.getValid(user);
				// user表,member表,userinfo三个表中有能链接的数据
				if (alllist.size() != 0) {
					user = alllist.get(0);
					if (user.getMember().isFlag()) {
						int mid = user.getMember().getId();
						session.setAttribute("Root", 1);
						user.setFirst(periodDAO.getFirst(mid));
						user.setMonthly(periodDAO.getMonthly(mid));
						user.setSum(periodDAO.getSum(mid));
						user.setAllMonth(periodDAO.getAllMonthByMid(mid) - 2);
						user.setLast(periodDAO.getLast(mid));
						user.setDelayMonth(periodDAO.getDelayMonthyByMid(mid));

					}
				}
			}
			user.setRoot(root);
			session.removeAttribute("myuserinfo");
			session.removeAttribute("myuser");
			session.setAttribute("myuser", user);
			// 项目重构需要
			session.removeAttribute("USER");
			session.setAttribute("USER", user);
			session.removeAttribute("ADMIN");
			//存会员最后一篇周报的id
			//try-catch解决，第一册注册会员空指针错误，否则无法登陆
			try {
				int pid=summaryDAO.getMId(user.getMember().getId());
				session.setAttribute("MyLastSummary", pid);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}

			// //把用户的id写入visitor表中 王冰冰2015-12-11
			int uid = user.getId();
			int count = pictureDAO.count(uid);
			session.setAttribute("conut", count);
			int allcount = pictureDAO.allcount(uid);
			session.setAttribute("allconut", allcount);
			//
			// session.setAttribute("myuser", user);
			session.setAttribute("SYSTEMINFO", new SystemInfo(request));
			// 会员登录时将用户保存在session中，用于页面判断是否首次登陆。
			session.setAttribute("TURE", user);
			// 会员登录时将session中管理的值删掉，防止交叉测试的时候，出现一些问题
			session.removeAttribute("admin");
			return "1";
		}
		return "0";
	}

	/*
	 * 修改：将checkold.action改为checkOldPwd.action。 统一名称
	 * 
	 * 杨凯 2016-04-20
	 */
	@ResponseBody
	@RequestMapping("/checkOldPwd.action")
	public String checkOldPwd(String name, String old) throws Exception {
		User user = new User();
		user.setName(name);
		String salt = userDAO.getSalt(user);
		user.setPwd(MD5SaltUtils.encode(old, salt));
		List<User> list = userDAO.getValid(user);
		if (list.size() > 0) {
			return "OK";
		} else {
			return "ERROR";
		}
	}

	/*
	 * 修改：将changepwd.action改为changePassword.action。 统一名称
	 * 
	 * 杨凯 2016-04-20
	 */
	@RequestMapping("/changePassword.action")
	public String changePassword(User user) throws Exception {
		String salt = userDAO.getSalt(user);
		user.setPwd(MD5SaltUtils.encode(user.getPwd(), salt));
		user.setSalt(salt);
		userDAO.update(user);
		return "/personal/navbar";
	}
	/*
	 * 新增：修改初始密码  修改成功后让其重新登录
	 * 高鑫 2017-06-19
	 */
	@RequestMapping("/changeInitPassword.action")
	public String changeInitPassword(User user,HttpSession session) throws Exception {
		String salt = userDAO.getSalt(user);
		user.setPwd(MD5SaltUtils.encode(user.getPwd(), salt));
		user.setSalt(salt);
		userDAO.update(user);
		session.setAttribute("TURE", null);
		session.removeAttribute("admin");
		session.removeAttribute("myuser");
		session.removeAttribute("experience");
		session.removeAttribute("modify");
		return "redirect:/user/login.jsp";
	}
	/*
	 * 
	 *新增: 检查初始化密码是否是12345678 如果是则强制修改
	 * 
	 * 高鑫 2017-06-19
	 */
	@RequestMapping("/checkInitPwd.action")
	@ResponseBody
	public int checkInitPassword(User user,HttpSession session) throws Exception
	{
		String salt =(String)session.getAttribute("salt");
		if(user.getPwd().equals(MD5SaltUtils.encode("12345678", salt)))
		{
			session.removeAttribute("salt");
			return 1;
		}
		return 0;
		
		
	}
	@RequestMapping("/checkExists.action")
	@ResponseBody
	public String checkExists(HttpServletResponse response, User user) throws IOException {
		List<User> list = userDAO.getExist(user);
		boolean flag = true;
		if (list.size() > 0)
			flag = false;

		JSONObject json = new JSONObject();
		json.put("valid", flag);// bootstrapvalidator后台验证的返回固定格式 flag可以是任意名
								// 但类型必须是boolean 通过true 失败false
		System.out.println(flag);
		return json.toString();
	}

	/*
	 * 作者:左琪 作用:编写或修改周报session过期后重新登录并保存 添加:周报评论session过期重新登录 最后修改:2016-05-10
	 *
	 * 修改：增加体验者功能 作者：刘娈莎 日期：2016-5-27
	 */

	@ResponseBody
	@RequestMapping("/layerLogin.action")
	public String layerLogin(HttpSession session, User user, Summary summary, HttpServletRequest request)
			throws Exception {
		// state=1则是编写周报 state=2为修改周报
		String state = request.getParameter("state");
		int id = Integer.parseInt(request.getParameter("id"));
		// 体验者登录
		String num = user.getName();
		String password = user.getPwd();
		String esalt = experienceDAO.getSaltByNum(num);
		Experience experience = new Experience();
		experience.setNum(num);
		experience.setPassword(MD5SaltUtils.encode(password, esalt));
		experience = experienceDAO.isValid(experience);
		if (experience != null) {
			// System.out.println(experience);
			session.setAttribute("experience", experience);
			session.setAttribute("TURE", experience);
			session.setAttribute("SYSTEMINFO", new SystemInfo(request));
			if (state.equals("1")) {
				summary.setEid(experience.getId());
				summary.setTime(SummaryTitle.getTime());
				summary.setTitle(SummaryTitle.getWriteTitle());
				summary.setIscheck(0);
				summaryDAO.add(summary);
			}
			if (state.equals("2")) {
				summary.setId(id);
				summaryDAO.updateSummary(summary);
			}
			return "1";
		}

		String salt = userDAO.getSalt(user);
		user.setPwd(MD5SaltUtils.encode(user.getPwd(), salt));
		List<User> list = userDAO.getValid(user);
		if (list.size() > 0) {
			user = list.get(0);
			// 把用户的id写入visitor表中 王冰冰20151211
			int uid = user.getId();
			int count = pictureDAO.count(uid);
			session.setAttribute("conut", count);
			int allcount = pictureDAO.allcount(uid);
			session.setAttribute("allconut", allcount);

			session.setAttribute("myuser", user);
			// session.setMaxInactiveInterval(5);

			// 会员登录时将session中管理的值删掉，防止交叉测试的时候，出现一些问题
			session.removeAttribute("admin");

			if (state.equals("1")) {
				summary.setMid(user.getMember().getId());
				summary.setTime(SummaryTitle.getTime());
				summary.setTitle(SummaryTitle.getWriteTitle());
				summary.setIscheck(0);
				summaryDAO.add(summary);
			}
			if (state.equals("2")) {
				summary.setId(id);
				summaryDAO.updateSummary(summary);
			}
			return "1";
		}
		return "0";
	}

	/*
	 * 作者:农大辉 作用:写一个方法在线显示PDF协议，动态生成PDF，服务器一共有三个basic文件：协议模板，
	 * 替换参数后的协议文档，及协议PDF文件
	 * inputHTMLFileName为HTML文件的所在路径，htmlPath为替换修改后的HTML文件的所在路径，
	 * pdfPath生成的pdf所在的文件 contextpath为pdf的所在文件目录，用于在线预览pdf文件 日期:2015-12-02
	 */
	@RequestMapping("/getPDF.action")
	@ResponseBody
	public String getPdf(HttpServletRequest request, HttpSession session, int id) throws Exception {
		String contextpath = null;
		String inputHTMLFileName = null;
		String htmlPath = null;
		String pdfPath = null;
		// 判断是学生的类型还是已经毕业的学生
		QueryType queryType = new QueryType();
		queryType.setType(1);
		queryType.setNo(id);
		User user = userDAO.getUser(queryType).get(0);
		inputHTMLFileName = request.getServletContext().getRealPath("") + "contract" + java.io.File.separator
					+ "html" + java.io.File.separator + "contractOfEverybody.html";
		UserInfo userInfo = new UserInfo();
		userInfo.setUid(user.getId());
		userInfo = userInfoDAO.get(userInfo).get(0);
		String fileName = "";
		// 产生随机数，文件的名字
		fileName = String.valueOf((int) (1000000000 + Math.random() * 999999999));
		htmlPath = request.getServletContext().getRealPath("") + "contract" + java.io.File.separator + "temp"
				+ java.io.File.separator + fileName + ".html";
		pdfPath = request.getServletContext().getRealPath("") + "contract" + java.io.File.separator + "temp"
				+ java.io.File.separator + fileName + ".pdf";
		// 获得修改后的路径htmlpath
		String lasthtmlPath = generatePDF.replaceKeyWords(user, inputHTMLFileName, htmlPath, pdfPath, userInfo);
		GeneratePDF converter = new GeneratePDF();
		// 用于把html文件转化为Pdf文件
		converter.generatePDF(lasthtmlPath, new File(pdfPath));
		contextpath = request.getContextPath() + "/contract" + "/temp/" + fileName + ".pdf";
		// 返回contextppath的地址，用于在线预览pdf
		return String.valueOf(contextpath);
	}

	/*
	 * 作者：左琪 作用：协议显示，判断是否是学生 日期：2016-05-18
	 * 
	 * 修改：将myuser改为myuserinfo 作者：刘娈莎 日期：2016-11-08
	 * 
	 * 修改：添加判断，如果分别设置不同情况下的user 作者：刘娈莎 日期：2016-11-22
	 * 
	 * 修改：添加判断分期信息，如果为旧分期，内容不变，如果是新分期，增加数据   作者：袁超 日期：2016-12-12
	 */
	@RequestMapping("/judge.action")
	@ResponseBody
	public String judge(HttpSession session ,Model model) throws Exception {
		User user = null;
		if (session.getAttribute("myuser") != null) {
			user = (User) session.getAttribute("myuser");
		}else if (session.getAttribute("myuserinfo") != null) {
			user = (User) session.getAttribute("myuserinfo");
		}
		//修改：管理员和学生使用同一个模板  作者：袁超     日期：2016-12-14
		session.setAttribute("myuser", user);
		
		Member member = user.getMember();
		//判断分期方式   旧分期正常返回0、1，新分期返回2，全费返回3,自定义返回4
		if(member.getPeriodStatus()==1)
		{
			session.setAttribute("status", "2");
		}else if(member.getPeriodStatus()==2){
			session.setAttribute("status", "3");
		}else if(member.getPeriodStatus()==3){
			session.setAttribute("status", "4");
		}else if(member.getPeriodStatus()==0)
		{
			// 判断是学生的类型还是已经毕业的学生
			boolean flag = member.getStudent();
			if (flag) {
				session.setAttribute("status", "1");
			} else {
				session.setAttribute("status", "0");
			}
		}else{
			return "ERROR";
		}
		return "OK";
	}
	// ==================================分割线===============================

	/*
	 * 作者:陈泽帆 作用:通过通配符替换WORD文件的变量，生成属于用户的协议文档，并返回一下下载窗口 日期:2015-12-23
	 * 
	 * 修改：去掉了要传的id参数。直接出session中获得。解决点击下载没有反应的问题。 作者：刘娈莎 日期：2015-4-2
	 * 
	 * 修改：发现不是只有会员有这个功能，管理员也有这个功能，改回传id的形式 作者：刘娈莎 日期：2015-5-11
	 */
	@RequestMapping("/dlWord.action")
	@ResponseBody
	public String dlWord(HttpServletRequest request, HttpSession session, int id) throws Exception {
		String contextpath = null;
		String inputDocFileName = null;
		String docPath = null;
		String pdfPath = null;
		// User user1=(User)session.getAttribute("myuser");
		// int id=user1.getId();
		// 判断是学生的类型还是已经毕业的学生
		QueryType queryType = new QueryType();
		queryType.setType(1);
		queryType.setNo(id);
		User user = userDAO.getUser(queryType).get(0);
		Member member = user.getMember();
		System.out.println(member.getName());
		boolean flag = member.getStudent();
		if (flag) {
			inputDocFileName = request.getServletContext().getRealPath("") + "contract" + java.io.File.separator + "doc"
					+ java.io.File.separator + "contractForStudent.doc";
		} else {
			inputDocFileName = request.getServletContext().getRealPath("") + "contract" + java.io.File.separator + "doc"
					+ java.io.File.separator + "contractForEmployee.doc";
		}
		UserInfo userInfo = new UserInfo();
		userInfo.setUid(user.getId());
		userInfo = userInfoDAO.get(userInfo).get(0);
		String fileName = "";
		// 产生随机数，文件的名字
		fileName = String.valueOf((int) (1000000000 + Math.random() * 999999999));
		docPath = request.getServletContext().getRealPath("") + "contract" + java.io.File.separator + "temp"
				+ java.io.File.separator + fileName + ".doc";
		// 处理一下费用信息
		int mid = member.getId();
		int sum = (int) periodDAO.getSum(mid);
		int first = (int) periodDAO.getFirst(mid);
		int monthly = (int) periodDAO.getMonthly(mid);
		// 对doc文档修改并保存文件
		ContractPDF cp = new ContractPDF();
		cp.testWrite(user, inputDocFileName, docPath, userInfo, sum, first, monthly);
		File file = new File(docPath);
		if (file.exists()) {
			contextpath = request.getContextPath() + "/contract" + "/temp/" + fileName + ".doc";
		}
		// 返回contextpath的地址，为用户提供下载文件
		return String.valueOf(contextpath);
	}

	

	/*
	 * 作者:左琪 作用:修改信用信息 日期:2016-05-17
	 */
	@ResponseBody
	@RequestMapping("/updateUserInfo.action")
	public String updateUserInfo(HttpSession session, UserInfo userInfo) {

		User user = (User) session.getAttribute("myuser");
		if (user != null) {
			userInfoDAO.update(userInfo);
			user.setUserInfo(userInfo);
			session.setAttribute("myuser", user);
			return "1";
		}
		return "0";
	}
	//=====================================规范代码区 以下为新标准 请不要将未规范的代码写在这之后========================================================
	/**
	 * 
	 * <p>
	 * Title: checkUserSession
	 * </p>
	 * <p>
	 * Description: 检测user或experience是否过期
	 * </p>
	 * 
	 * @author 刘娈莎 日期： 2016年11月29日
	 *
	 * @param session
	 * @return json String 统一的数据返回形式
	 */
	@ResponseBody
	@RequestMapping(value = "/checkUserSession.action", method = RequestMethod.POST)
	public String checkUserSession(HttpSession session) {
		return VerifyIdentity.verifyUser(session) != null ? "1" : "0";
	}
}
