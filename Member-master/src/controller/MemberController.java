
package controller;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.json.JSONObject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import dao.AccountLogDAO;
import dao.CommunicationDAO;
import dao.InterestDAO;
import dao.MemberDAO;
import dao.PeriodDAO;
import dao.PictureDAO;
import dao.UserDAO;
import dao.UserInfoDAO;
import dto.AccountLogDTO;
import dto.CostDTO;
import dto.InterestDTO;
import dto.PeriodDTO;
import dto.SchoolDTO;
import dto.UserDTO;
import entity.AccountLog;
import entity.Admin;
import entity.Communication;
import entity.FeeData;
import entity.Interest;
import entity.InterestDetail;
import entity.Member;
import entity.Period;
import entity.PeriodsResult;
import entity.Picture;
import entity.Province;
import entity.QueryType;
import entity.ResultType;
import entity.Summary;
import entity.User;
import entity.UserInfo;
import tools.DateFormatUtils;
import tools.MD5SaltUtils;
import tools.NavigationBar;
import tools.Paging;
import tools.RandomNumberUtils;
import tools.Result;
import tools.SummaryTitle;

@Controller
@RequestMapping("/member")
public class MemberController {
	private static Logger logger = Logger.getLogger(MemberController.class);
	@Resource
	MemberDAO memberDAO;
	@Resource
	UserDAO userDAO;
	@Resource
	PeriodDAO periodDAO;
	@Resource
	AccountLogDAO accountLogDAO;
	@Resource
	InterestDAO interestDAO;
	@Resource
	UserInfoDAO userInfoDAO;
	@Resource
	PictureDAO pictureDAO;
	@Resource
	CommunicationDAO communicationDAO;
	int sumpageSize = 9;

	/*
	 * 作用:获取会员的分期信息
	 * 
	 * 修改：从session获取user改为从前端传member的id过来 并将member信息一起传到前端去 作者：刘娈莎 日期：2016-5-11
	 */
	@RequestMapping("/getPeriod.action")
	@ResponseBody
	public ArrayList<Period> getPeriod(HttpServletRequest request, int id)
			throws ParserConfigurationException, SAXException, IOException, XPathExpressionException, ParseException {
		Member member = memberDAO.getMemById(id);
		// 开始计算分期信息
		// 1.加载xml中的初始化数据
		initData(request, member.isAbnormal());
		ArrayList<Period> periods = new ArrayList<Period>();
		// 2.第一期费用在职和在学都是一样的
		periods.add(new Period(member.getTime(), FeeData.firstamount, FeeData.firstamount));
		// 3.根据在学和在职进行分别的处理
		if (member.getStudent()) {
			// (1)首先计算从现在到毕业要交多少期
			Calendar c = Calendar.getInstance();
			c.setTime(member.getTime());
			c.add(Calendar.MONTH, 1);
			List<Date> list = getMonths(c.getTime(), member.getGraduateDate());
			for (int i = 0; i < list.size(); i++) {
				periods.add(new Period(list.get(i), FeeData.monthlyforstudent, FeeData.monthlyforstudent));
			}
			// (2)计算交完这些期以后，还剩余多少钱
			float restamount = FeeData.totalamount - FeeData.firstamount - FeeData.monthlyforstudent * list.size();
			// (3)计算毕业4个月之后的时间
			Date fromDate = list.get(list.size() - 1);
			c.setTime(fromDate);
			c.add(Calendar.MONTH, 4);
			fromDate = c.getTime();
			// 计算毕业后每月需要付费金额
			float amount = restamount / 8.0f;
			for (int i = 0; i < 8; i++) {
				periods.add(new Period(fromDate, amount, amount));
				c.add(Calendar.MONTH, 1);
				fromDate = c.getTime();
			}
		} else {
			// (1)计算第一期后剩余多少钱
			float restamount = FeeData.totalamount - FeeData.firstamount;
			// (2)计算需要多少期
			float nums = restamount / FeeData.monthlyforworker;
			Calendar c = Calendar.getInstance();
			c.setTime(member.getTime());
			c.add(Calendar.MONTH, 1);
			for (int i = 0; i < nums; i++) {
				periods.add(new Period(c.getTime(), FeeData.monthlyforworker, FeeData.monthlyforworker));
				c.add(Calendar.MONTH, 1);
			}
		}
		return periods;
	}

	/*
	 * 作者:秦珊 功能:根据会员id保存会员的分期信息
	 * 
	 * 修改：从session获取user改为从前端传member的id过来 作者：刘娈莎 日期：2016-5-11
	 */
	@ResponseBody
	@RequestMapping("/savePeriod.action")
	public String savePeriod(HttpServletRequest request, int id)
			throws XPathExpressionException, ParserConfigurationException, SAXException, IOException, ParseException {
		ArrayList<Period> list = getPeriod(request, id);
		Member member = memberDAO.getMemById(id);
		member.getUser().setId(member.getUid());
		/*int num = periodDAO.exists(member.getId());
		if (num > 0) {
			return "ERROR";
		}*/
		periodDAO.initInstalment(id);
		for (int i = 0; i < list.size(); i++) {
			Period period = list.get(i);
			period.setMember(member);
			periodDAO.add(period);
		}
		member.setFlag(true);
		member.setPeriodStatus(0);
		member.setRestAmount(periodDAO.getRestAmount(member.getId()));
		memberDAO.update(member);
		return "OK";
	}

	@ResponseBody
	@RequestMapping("/getCount.action")
	public int getCount() {
		return memberDAO.getCount();
	}

	/*
	 * 修改： 修改内容：getsex.action改成getSex.action 作者：刘文启 日期：2016-04-23
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "getSex.action", produces = "text/html; charset=utf-8")
	public String getSex() {
		ResultType resultType = memberDAO.getSex();
		StringBuilder strXML = new StringBuilder("");
		strXML.append(
				"<chart unescapeLinks='0' caption='男女比例' xAxisName='Month' yAxisName='Units' showNames='1' decimalPrecision='0' formatNumberScale='0' showBorder='1'>");
		strXML.append("<set label='男' value='");
		strXML.append(Integer.toString(resultType.getFirst()));
		strXML.append("'/> ");
		strXML.append("<set label='女' value='");
		strXML.append(Integer.toString(resultType.getSecond()));
		strXML.append("'/> ");
		strXML.append("</chart>");
		String xmlString = strXML.toString();
		try {
			URLEncoder.encode(xmlString, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return xmlString;
	}

	/*
	 * 作者:秦珊 作用:获取未审核的会员缴费信息
	 * 
	 * 修改：从session获取user改为从前端传member的id过来 返回其实不用写那么复杂，为了统一一下，就这么写了。 作者：刘娈莎
	 * 日期：2016-5-10
	 */
	@RequestMapping("/getLog.action")
	@ResponseBody
	public String getLog(HttpSession session, int id) {
		List<AccountLog> list = accountLogDAO.getAccountLogForCheck(id);
		// 设置时间格式
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		for (int i = 0; i < list.size(); i++) {
			AccountLog accountLog = list.get(i);
			accountLog.setFormatDate(df.format(accountLog.getDate()));
		}
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("list", list);
		JSONObject json = new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();
	}

	/*
	 * 作用:获取会员的分期信息
	 * 
	 * 修改：从session获取user改为从前端传member的id过来 并将member信息一起传到前端去 作者：刘娈莎 日期：2016-5-10
	 */
	@RequestMapping("/fetchPeriod.action")
	@ResponseBody
	public String fetchPeriod(HttpSession session, int id) {
		List<Period> list = periodDAO.getAll(id);
		// 设置时间格式
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		for (int i = 0; i < list.size(); i++) {
			Period period = list.get(i);
			period.setFormateDuetime(df.format(period.getDuetime()));
		}
		Member member = memberDAO.getMemById(id);
		member.setFormatTime(df.format(member.getTime()));
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("list", list);
		returnMap.put("member", member);
		JSONObject json = new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();
	}

	/*
	 * 功能：根据id审核一条缴费信息
	 * 
	 * 修改：从session获取user改为从前端传member的id过来 把member.setRestInterest改成只保留两位小数的形式
	 * 作者：刘娈莎 日期：2016-5-11
	 * 
	 * 修改:审核缴费需要验证upflag的值是否相同，防止多人同时操作同一条数据 作者:张晓敏 日期:2016-10-30
	 */
	@ResponseBody
	@RequestMapping("/checkLog.action")
	public String checkLog(HttpSession session, int accountlogID, int id, int upflag) {
		Member member = memberDAO.getMemById(id);
		if (member.getAlog() >= 1) {
			member.setAlog(member.getAlog() - 1);
		} else {
			member.setAlog(0);
		}

		AccountLog accountLog = accountLogDAO.getAccountLogById(accountlogID);
		if (accountLog == null) {
			return "1";
		}
		if (accountLog.getUpflag() != upflag) {
			return "2";
		}
		float money = accountLog.getAmount();
		List<Period> list = periodDAO.getAll(member.getId());
		float sum = 0f;
		boolean changed = false;
		int i = 0;
		for (i = 0; i < list.size(); i++) {
			Period period = list.get(i);
			Float f = interestDAO.getInterest(period);
			if (f != null) {
				sum += f;
			}
			if (period.getRestAmount() == 0) {
				interestDAO.getInterest(period);
				continue;
			}
			changed = true;
			Date d1 = period.getDuetime();
			Date d2 = accountLog.getDate();
			int flag = 0;
			int days = 0;
			if (d1.getTime() > d2.getTime()) {
				flag = 1;// 正向利息
				days = getBetweenDay(d2, d1);
			} else if (d1.getTime() < d2.getTime()) {
				flag = -1;// 负向利息
				days = getBetweenDay(d1, d2);
			}
			// 计算利息(按月息2%,每月30天计算利息)
			float rates = (float) (0.02 / 30.0f) * days * flag;

			float thisInterest = 0;
			float notYet = 0;
			float actuallyPayed = 0;
			if (money >= period.getRestAmount()) {
				// 可以还清
				actuallyPayed = period.getRestAmount();
				money = money - period.getRestAmount();
				notYet = 0;
				thisInterest = Float.valueOf(String.format("%.2f", rates * period.getRestAmount()));
			} else {
				// 不能还清
				actuallyPayed = money;
				notYet = period.getRestAmount() - money;
				// 修改剩余金额
				thisInterest = Float.valueOf(String.format("%.2f", rates * money));
				// 不能还清
				money = 0f;
			}
			sum += thisInterest;
			// 保存剩余金额
			period.setRestAmount(notYet);
			periodDAO.update(period);
			// 保存利息
			Interest interest = new Interest();
			interest.setAmount(thisInterest);
			interest.setPeriod(period);
			interest.setMoney(actuallyPayed);
			interest.setAccountLog(accountLog);
			interestDAO.add(interest);
			// 更新会员表中的利息余额

			// 退出循环的两种方式:
			// 1.所交的钱在各个分期中分配完毕
			// 2.循环了各期,费用没用完,继续用于扣除后面你的利息

			// System.out.println(money);
			if (money == 0) {
				break;
			}
		}
		// 更新利息余额
		if (changed) {
			// member.setRestInterest(sum);
			member.setRestInterest(Float.valueOf(String.format("%.2f", sum)));
			;
		}
		Admin admin=(Admin)session.getAttribute("admin");
		System.out.println("当前管理员的信息======"+admin);
		System.out.println("当前管理员的Id==="+admin.getId());
		System.out.println("当前管理员的Id==="+admin.getRealname());
		
		accountLog.setRid(admin.getId());
		System.out.println("设置缴费记录的Rid========"+accountLog.getRid());
		accountLog.setFlag(true);
		accountLog.setUpflag(accountLog.getUpflag()+1);
		accountLogDAO.updateFlag(accountLog);
		System.out.println("数据库中的Rid修改后的数据：------"+accountLog.getRid());
		double rest = periodDAO.getRestAmount(member.getId());
		member.setRestAmount(rest);
		if (rest == 0) {
			member.setFee(true);
		}
		member.getUser().setId(member.getUid());// 必须要重新设置一下user的id，否则更新之后的uid会为0
		memberDAO.update(member);
		return "0";
	}

	/*
	 * 功能：根据accountLog的id修改记录 作者:张晓敏 日期:2016-11-06
	 */
	@ResponseBody
	@RequestMapping(value = "/modifypay.action", method = RequestMethod.POST)
	public String modifypay(HttpSession session, HttpServletRequest request) throws ParseException, IOException {
		User user = (User) session.getAttribute("myuser");
		if (user == null) {
			return "202";
		}
		AccountLog accountLog = accountLogDAO.getAccountLogById(Integer.parseInt(request.getParameter("accountlogID")));
		if (accountLog != null) {
			if (accountLog.getUpflag() == Integer.parseInt(request.getParameter("upflag"))) {
				accountLog.setAmount(Float.parseFloat(request.getParameter("pay")));
				StringBuilder sBuilder = new StringBuilder(request.getParameter("date"));
				sBuilder.setCharAt(10, ' ');
				accountLog.setDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sBuilder.toString()));
				accountLog.setUpflag(accountLog.getUpflag() + 1);
				if (request.getParameter("fileflag").toString().equals("1")) {
					MultipartHttpServletRequest mulReq = (MultipartHttpServletRequest) request;
					MultipartFile file = mulReq.getFile("file");
					String[] string = file.getOriginalFilename().split("\\.");
					if (string[1].equals("png") || string[1].equals("gif") || string[1].equals("jpg")
							|| string[1].equals("jpeg")) {
						accountLog.setPhoto(file.getBytes());
						accountLog.setType(request.getParameter("type"));
						accountLog.setFileflag(1);
					}
				}
				accountLogDAO.updateAccountLog(accountLog);
				return "100";
			} else {
				return "302";
			}
		} else {
			return "301";
		}
	}

	/*
	 * 功能：根据id删除一条缴费信息
	 * 
	 * 修改：从session获取user改为从前端传member的id过来 作者：刘娈莎 日期：2016-5-10
	 * 
	 * 修改:删除缴费需要验证upflag的值是否相同，防止多人同时操作同一条数据 作者:张晓敏 日期:2016-10-30
	 */
	@ResponseBody
	@RequestMapping("/deleteLog.action")
	public String deleteLog(HttpSession session, int accountlogID, int id, int upflag) {
		Member member = memberDAO.getMemById(id);
		if (member.getAlog() >= 1) {
			member.setAlog(member.getAlog() - 1);
		} else {
			member.setAlog(0);
		}
		AccountLog accountLog = accountLogDAO.getAccountLogById(accountlogID);
		if (accountLog == null) {
			return "1";
		}
		if (accountLog.getUpflag() != upflag) {
			return "2";
		}
		accountLogDAO.deleteAcountLogById(accountlogID);
		member.getUser().setId(member.getUid());// 必须要重新设置一下user的id，否则更新之后的uid会为0
		memberDAO.update(member);
		return "0";
	}

	@RequestMapping("getAmountDetail.action")
	@ResponseBody
	public Map<String, Object> getAmountDetail(String starttime, String endtime, int type) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> maps = new ArrayList<Map<String, Object>>();
		Map<String, Object> mapDate = new HashMap<String, Object>();

		mapDate.put("type", type);
		mapDate.put("start", starttime);
		mapDate.put("end", endtime);

		List<Map<String, Object>> ids = accountLogDAO.getMidByAmount(mapDate);
		Iterator<Map<String, Object>> its = ids.iterator();
		int count = 0;
		while (its.hasNext()) {
			Map<String, Object> memberInfo = its.next();
			String mdate = null;
			int days = 0;
			if (memberInfo.get("date") != null) {
				mdate = memberInfo.get("date").toString();
			}
			Map<String, Object> mapParam = new HashMap<String, Object>();
			Map<String, Object> mapAmount = new HashMap<String, Object>();
			Map<String, Object> resultMap = new HashMap<String, Object>();
			mapParam.put("mid", memberInfo.get("id"));
			String restdate = null;

			mapParam.put("date", starttime);
			restdate = starttime.substring(0, 7) + "-31 23:59:59";
			mapAmount.put("start", starttime.substring(0, 10) + " 23:59:59");
			mapAmount.put("end", restdate);

			double restAmount = 0;
			double amount = 0;
			double sum = 0;
			// 获取当天缴费金额
			if (mdate != null) {
				mapParam.put("date", mdate + " 23:59:59");
				amount = accountLogDAO.getAmountByMid(mapParam);
			}

			mapAmount.put("mid", memberInfo.get("id"));

			if (mdate != null) {
				mapAmount.put("start", mdate + " 23:59:59");
			}
			// 获取当天到月末的缴费金额
			sum = accountLogDAO.getSumAmountByMid(mapAmount);
			mapParam.put("date", restdate);
			// 获取应交金额：restAmount(到当天为止的剩余应交金额-分配给之后分期的金额)+(amount+sum)缴费数（为当月的缴费数,即当天缴费数+当天之后的缴费数）
			restAmount = periodDAO.getRestAmountByMid(mapParam);
			double ramount = restAmount + amount + sum;
			if (ramount < 0.0) {
				ramount = 0;
			}
			resultMap.put("uname", memberInfo.get("uname"));
			resultMap.put("name", memberInfo.get("name"));
			resultMap.put("restAmount", ramount);
			resultMap.put("amount", amount);
			Object object = memberInfo.get("tday");
			int time = Integer.parseInt(object.toString().substring(8, 10));

			if (memberInfo.get("date") != null) {
				int day = Integer.parseInt(memberInfo.get("date").toString().substring(8, 10));
				days = time - day;
			}
			resultMap.put("time", time);
			resultMap.put("days", days);
			maps.add(resultMap);
		}
		result.put("Rows", maps);
		return result;
	}

	@RequestMapping("getDetail.action")
	@ResponseBody
	public Map<String, Object> getDetail(String date) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> maps = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> ids = accountLogDAO.getMemByAmount(date + " 23:59:59");
		Iterator<Map<String, Object>> its = ids.iterator();
		int count = 0;
		while (its.hasNext()) {
			Map<String, Object> memberInfo = its.next();
			Map<String, Object> mapParam = new HashMap<String, Object>();
			Map<String, Object> mapAmount = new HashMap<String, Object>();
			Map<String, Object> resultMap = new HashMap<String, Object>();
			mapParam.put("mid", memberInfo.get("id"));
			mapParam.put("date", date + " 23:59:59");
			double restAmount = 0;
			double amount = 0;
			double sum = 0;
			// 获取当天缴费金额
			amount = accountLogDAO.getAmountByMid(mapParam);
			String restdate = date.substring(0, 8) + "31 23:59:59";
			mapAmount.put("mid", memberInfo.get("id"));
			mapAmount.put("start", date + " 23:59:59");
			mapAmount.put("end", restdate);
			// 获取当天到月末的缴费金额
			sum = accountLogDAO.getSumAmountByMid(mapAmount);
			mapParam.put("date", restdate);
			// 获取应交金额：restAmount(到当天为止的剩余应交金额-分配给之后分期的金额)+(amount+sum)缴费数（为当月的缴费数,即当天缴费数+当天之后的缴费数）
			restAmount = periodDAO.getRestAmountByMid(mapParam);
			double ramount = restAmount + amount + sum;
			if (ramount < 0.0) {
				ramount = 0;
			}
			resultMap.put("uname", memberInfo.get("uname"));
			resultMap.put("name", memberInfo.get("name"));
			resultMap.put("restAmount", ramount);
			resultMap.put("amount", amount);
			Object object = memberInfo.get("tday");
			int time = Integer.parseInt(object.toString().substring(8, 10));
			int day = Integer.parseInt(date.substring(8, 10));
			resultMap.put("time", time);
			resultMap.put("days", time - day);
			maps.add(resultMap);
		}
		result.put("Rows", maps);
		return result;
	}

	// 获取会员的缴费信息
	@RequestMapping("getMonthDetail.action")
	@ResponseBody
	public Map<String, Object> getMonthDetail(String date) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> maps = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> ids = accountLogDAO.getMemByMonth(date + "-31 23:59:59");
		Iterator<Map<String, Object>> its = ids.iterator();
		int count = 0;
		while (its.hasNext()) {
			Map<String, Object> memberInfo = its.next();
			String mdate = null;
			int days = 0;
			if (memberInfo.get("date") != null) {
				mdate = memberInfo.get("date").toString();
			}
			Map<String, Object> mapParam = new HashMap<String, Object>();
			Map<String, Object> mapAmount = new HashMap<String, Object>();
			Map<String, Object> resultMap = new HashMap<String, Object>();
			mapParam.put("mid", memberInfo.get("id"));
			mapParam.put("date", date + "-01 23:59:59");
			double restAmount = 0;
			double amount = 0;
			double sum = 0;
			// 获取当天缴费金额
			if (mdate != null) {
				mapParam.put("date", mdate + " 23:59:59");
			}
			amount = accountLogDAO.getAmountByMid(mapParam);
			String restdate = date + "-31 23:59:59";
			mapAmount.put("mid", memberInfo.get("id"));
			mapAmount.put("start", date + "-01 23:59:59");
			mapAmount.put("end", restdate);

			if (mdate != null) {
				mapAmount.put("start", mdate + " 23:59:59");
			}
			// 获取当天到月末的缴费金额
			sum = accountLogDAO.getSumAmountByMid(mapAmount);
			mapParam.put("date", restdate);
			// 获取应交金额：restAmount(到当天为止的剩余应交金额-分配给之后分期的金额)+(amount+sum)缴费数（为当月的缴费数,即当天缴费数+当天之后的缴费数）
			restAmount = periodDAO.getRestAmountByMid(mapParam);
			double ramount = restAmount + amount + sum;
			if (ramount < 0.0) {
				ramount = 0;
			}
			resultMap.put("uname", memberInfo.get("uname"));
			resultMap.put("name", memberInfo.get("name"));
			resultMap.put("restAmount", ramount);
			resultMap.put("amount", amount);
			Object object = memberInfo.get("tday");
			int time = Integer.parseInt(object.toString().substring(8, 10));
			// int day = Integer.parseInt(date.substring(8,10));
			// System.out.println(time - day);
			if (memberInfo.get("date") != null) {
				int day = Integer.parseInt(memberInfo.get("date").toString().substring(8, 10));
				days = time - day;
			}
			resultMap.put("time", time);
			resultMap.put("days", days);
			maps.add(resultMap);
		}
		result.put("Rows", maps);
		return result;
	}

	@RequestMapping("/setAbnormal.action")
	public void setAbnormal(HttpSession session, int id) {
		QueryType queryType = new QueryType();
		queryType.setType(1);
		queryType.setNo(id);
		User user = userDAO.getUser(queryType).get(0);
		Member member = user.getMember();
		member.setUser(user);
		if (member.isAbnormal()) {
			member.setAbnormal(false);
		} else {
			member.setAbnormal(true);
		}
		memberDAO.update(member);
	}

	/*
	 * 功能：从管理费用页面，点审核之后取出相应用户数据存入session中， 跳转到period页面。 说明：由于要避免服务器跳转，所以这个方法弃用了
	 * 作者：刘娈莎 日期：2016-5-11
	 */
	@RequestMapping("/initPeriod")
	public String initPeriod(HttpSession session, int id) {
		QueryType queryType = new QueryType();
		queryType.setType(1);
		queryType.setNo(id);
		User user = userDAO.getUser(queryType).get(0);
		session.setAttribute("user", user);
		return "/admin/period";
	}

	@RequestMapping("/show.action")
	public String show(int id, HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		/*
		 * 统计用户图片的总数，如果为空，则显示默认图片，如果不为空，则显示封面的 修改：农大辉
		 */
		int count = pictureDAO.count(id);
		session.setAttribute("conut", count);
		int allcount = pictureDAO.allcount(id);
		session.setAttribute("allconut", allcount);

		/*----------------------------------*/

		QueryType queryType = new QueryType();
		queryType.setType(1);
		queryType.setNo(id);
		User user = userDAO.getUser(queryType).get(0);
		session.setAttribute("myuserinfo", user);
		return "/member/apiinfoshow";
	}

	/*
	 * 作者:陈泽帆 最后修改日期:2016-1-9 作用:在缴费审核页面增加删除未审核accountlog的功能
	 */
	@ResponseBody
	@RequestMapping("/getSumAll.action")
	public List<Summary> getSumAll(HttpSession session, Summary summary, int page) {
		if (page <= 0) {
			page = 1;
		}
		User user = (User) session.getAttribute("myuser");
		summary.setMember(user.getMember());
		List<Summary> list = memberDAO.getSumAll(summary);
		int datasize = list.size();
		if (datasize == 0) {
			return list;
		}
		int pageCounts = Paging.pageCount(datasize, sumpageSize);
		session.setAttribute("pageCount", pageCounts);
		if (page > pageCounts) {
			page = pageCounts;
		}
		Paging<Summary> paging = new Paging<>();
		return paging.paging(list, sumpageSize, pageCounts);
	}

	// 获取会员的缴费信息

	/*
	 * 修改： 修改内容：getprovinces.action改成getProvinces.action 作者：刘文启 日期：2016-04-23
	 * 
	 */
	@RequestMapping("getProvinces.action")
	@ResponseBody
	public List<Province> getProvinces() {
		List<Province> provinces = memberDAO.getProvinces();
		if (provinces.size() == 0) {
			return null;
		}
		return provinces;
	}

	/*
	 * 功能: 保存用户注册的用户名和密码的信息(新的注册用户机制，必要时可以快速回复成原来的)。 说明: root不为0表示有资料未填写 时间:
	 * 2016-09-13 作者: 张晓敏
	 * 
	 * 修改：暂时在session中添加USER变量 由于检查session的方法里面的变量名改了，不然新注册用户会一直在登录页面和主页循环跳转
	 * 日期：2016-12-01 作者：刘娈莎
	 */
	@RequestMapping("addUserTwo.action")
	public String addUserTwo(HttpSession session, User user, HttpServletRequest request) {
		String path = "/user/login";
		List<User> list = userDAO.getExist(user);
		if (list.size() == 0) {
			String salt = MD5SaltUtils.randomCreateSalt();
			user.setTime(new Date());
			user.setSalt(salt);
			user.setPwd(MD5SaltUtils.encode(user.getPwd(), salt));
			user.setRoot(2);
			userDAO.add(user);
			// 以上是创建User用户

			Member member = new Member();
			member.setTime(new Date());
			member.setUser(user);
			member.setAlog(0);
			member.setGraduateDate(new Date());
			// 由于这个字段不允许为空 故直接将注册时间，暂时当做毕业时间，之后会在用户登陆的时候强行要求补充资料的
			memberDAO.update(member);
			user.setMember(member);
			// 以上是创建User用户对应的Member

			UserInfo userInfo = new UserInfo();
			userInfo.setUid(user.getId());
			userInfoDAO.add(userInfo);

			int count = pictureDAO.count(user.getId());
			session.setAttribute("conut", count);
			session.setAttribute("myuser", user);
			session.setAttribute("USER", user);
		}
		return path;
	}

	/*
	 * 功能: 保存用户个人信息(新的注册用户机制，必要时可以快速回复成原来的)。 说明: root不为0表示有资料未填写 时间: 2016-09-13
	 * 作者: 张晓敏
	 */
	@ResponseBody
	@RequestMapping("/addPersonal.action")
	public String addUserPersonal(HttpSession session, User user, HttpServletRequest request, Member member) {
		user = (User) session.getAttribute("myuser");
		if (user != null) {
			List<Member> members = memberDAO.getByUid(user.getId());
			member.setId(members.get(0).getId());
			member.setTime(members.get(0).getTime());
			member.setAlog(0);
			member.setUser(user);
			memberDAO.update(member);
			user.setRoot(1);
			userDAO.update(user);
			user.setMember(member);
			session.setAttribute("myuser", user);

			int count = pictureDAO.count(user.getId());
			session.setAttribute("conut", count);
		}

		return null;
	}

	/*
	 * 功能: 保存用户信用信息(新的注册用户机制，必要时可以快速回复成原来的)。 说明: root不为0表示有资料未填写 时间: 2016-09-13
	 * 作者: 张晓敏
	 */
	@ResponseBody
	@RequestMapping("addCredit.action")
	public String addUserCredit(HttpSession session, User user, HttpServletRequest request, UserInfo userInfo) {
		user = (User) session.getAttribute("myuser");
		if (user != null) {
			userInfo.setUid(user.getId());
			userInfoDAO.update(userInfo);
			user.setUserInfo(userInfo);
			user.setRoot(0);
			userDAO.update(user);
			session.setAttribute("myuser", user);

			String title = SummaryTitle.getTitle();
			session.setAttribute("TITLE", title);

			int count = pictureDAO.count(user.getId());
			session.setAttribute("conut", count);
		}
		return null;
	}

	/*
	 * 功能：保存用户注册的用户名和密码的信息。 Root等于0说明用户仅仅注册了用户名和密码，将会有权限限制。 杨凯 2016-04-30
	 */
	@RequestMapping("addUser.action")
	public String addUser(HttpServletResponse response, HttpSession session, HttpServletRequest request, Member member,
			UserInfo userInfo, User user) throws IOException {
		// 用户注册时，点击下一页直接保存用户信息
		// 防止重复提交
		PrintWriter out = response.getWriter();
		List<User> list = userDAO.getExist(user);
		if (list.size() > 0) {
			out.print("1");
		} else {
			out.print("2");
			String salt = MD5SaltUtils.randomCreateSalt();
			user.setTime(new Date());
			user.setPwd(MD5SaltUtils.encode(user.getPwd(), salt));
			user.setSalt(salt);
			userDAO.add(user);
			int uid = user.getId();
			int count = pictureDAO.count(uid);
			session.setAttribute("conut", count);
			session.setAttribute("myuser", user);
		}
		return null;
	}

	/*
	 * 功能：保存用户注册的个人的信息。 Root等于0说明用户仅仅注册了用户名和密码，将会有权限限制。 杨凯 2016-05-06
	 * 
	 * 修改： 涉及东西太多，暂时只是把如果是update的情况，要改的东西都设置上
	 * 原本也是因为没有设置member的id，导致sql一直执行的是insert而不是update 导致每次新加入会员都会有两条不一样的记录 刘娈莎
	 * 2016-12-04
	 */
	@RequestMapping("addMember.action")
	public String addMember(HttpServletResponse response, @ModelAttribute("user") User user, Member member,
			HttpSession session, HttpServletRequest request, UserInfo userInfo) throws IOException {
		PrintWriter out = response.getWriter();

		if (session.getAttribute("myuser") == null) {
			int uid = user.getId();
			int count = pictureDAO.count(uid);
			session.setAttribute("conut", count);
			session.setAttribute("myuser", user);
		} else {
			user = (User) session.getAttribute("myuser");
		}
		List<Member> mmMembers = memberDAO.getByUid(user.getId());
		if (mmMembers.size() > 0) {
			member.setId(mmMembers.get(0).getId());
			member.setAid(mmMembers.get(0).getAid());
			member.setEid(mmMembers.get(0).getEid());
			member.setSummaryflag(mmMembers.get(0).isSummaryflag());
			member.setFlag(mmMembers.get(0).isFlag());
			member.setAbnormal(mmMembers.get(0).isAbnormal());
			member.setAlog(mmMembers.get(0).getAlog());
			member.setRestAmount(mmMembers.get(0).getRestAmount());
			member.setRestInterest(mmMembers.get(0).getRestInterest());
			member.setFee(mmMembers.get(0).isFee());
			member.setTime(mmMembers.get(0).getTime());
		} else {
			member.setTime(new Date());
		}
		member.setUser(user);
		member.setAlog(0);
		System.out.println(member);
		memberDAO.update(member);
		user.setMember(member);
		session.setAttribute("myuser", user);
		return null;
	}

	/*
	 * 功能：保存用户注册时家庭联系人的信息
	 */
	@RequestMapping("/add.action")
	public String add(HttpSession session, HttpServletRequest request, @ModelAttribute("user") User user,
			@ModelAttribute("member") Member member, UserInfo userInfo) {
		String path = "/member/navbar1";
		if (session.getAttribute("myuser") == null) {
			// 保存用户信息
			// String salt=MD5SaltUtils.randomCreateSalt();
			// user.setTime(new Date());
			// user.setPwd(MD5SaltUtils.encode(user.getPwd(), salt));
			// user.setSalt(salt);
			// userDAO.add(user);
			int uid = user.getId();
			int count = pictureDAO.count(uid);
			user.setMember(member);
			session.setAttribute("conut", count);
			session.setAttribute("myuser", user);
			path = "/user/register";
		} else {
			user = (User) session.getAttribute("myuser");

			// List<Member> mmMembers = memberDAO.getByUid(user.getId());
			// if (mmMembers.size() > 0){
			// member.setFlag(mmMembers.get(0).isFlag());
			// member.setAbnormal(mmMembers.get(0).isAbnormal());
			// member.setAlog(mmMembers.get(0).getAlog());
			// member.setRestAmount(mmMembers.get(0).getRestAmount());
			// member.setRestInterest(mmMembers.get(0).getRestInterest());
			// member.setFee(mmMembers.get(0).isFee());
			// member.setTime(mmMembers.get(0).getTime());
			// }
			// else{
			// member.setTime(new Date());
			// }
			// member.setTime(new Date());
			// member.setUser(user);
			// member.setAlog(0);
			// memberDAO.update(member);

			userInfo.setUid(user.getId());
			List<UserInfo> infos = userInfoDAO.get(userInfo);
			if (infos.size() > 0) {
				userInfoDAO.update(userInfo);
			} else {
				userInfoDAO.add(userInfo);
			}

			// memberDAO.update(member);
			user.setMember(member);
			user.setUserInfo(userInfo);
			String title = SummaryTitle.getTitle();

			session.setAttribute("TITLE", title);
			session.setAttribute("myuser", user);
		}
		return path;
	}

	/*
	 * 修改： 修改内容：getflag.action改成getFlag.action 作者：刘文启 日期：2016-04-23
	 * 
	 */
	@ResponseBody
	@RequestMapping("/getFlag.action")
	public String getFlag(int uid) {
		String flagString = "0";
		List<Member> mmMembers = memberDAO.getByUid(uid);
		if (mmMembers.size() > 0) {
			if (mmMembers.get(0).isFlag()) {
				flagString = "1";
			}
		}
		return flagString;
	}

	@InitBinder("member")
	public void initAccountBinder(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("member.");
	}

	@InitBinder("user")
	public void initUserBinder(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("user.");
	}

	// 这是用户获得封面的信息，用于显示封面
	@RequestMapping("/getCover.action")
	public String getCover(HttpServletRequest request, HttpServletResponse response, HttpSession session, int uid)
			throws IOException {
		// User user=(User) session.getAttribute("myuser");//从session中取出当前登录用户
		response.setContentType("image/*"); // 设置返回的文件类型
		OutputStream toClient = null;
		Picture picture = new Picture();
		// picture.setUid(user.getId());;
		toClient = response.getOutputStream();
		picture = memberDAO.getCover(uid);
		if (picture.getPhoto() != null) {
			toClient.write(picture.getPhoto());
			toClient.close();
		}
		return null;
	}

	@RequestMapping("/getMemDetails.action")
	@ResponseBody // 从控制器直接把json对象返回到网页上
	public User getMemDetails(HttpSession session, HttpServletResponse response, HttpServletRequest request,
			Member member, UserInfo userInfo) {
		System.out.println(request.getParameter("id"));
		int id = Integer.parseInt(request.getParameter("id"));
		List<User> list = memberDAO.getMemDetails(id);
		User user = null;
		if (list.size() > 0) {
			user = list.get(0);
		}
		System.out.println(user);
		System.out.println(user.getMember());
		// 设置时间格式
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		user.getMember().setFormatTime(df.format(user.getMember().getTime()));
		return user;
	}

	/*
	 * 功能：通过 修改内容：getflag.action改成getFlag.action 作者：刘文启 日期：2016-04-23
	 * 
	 */
	@RequestMapping("/getMemberById.action")
	@ResponseBody
	public Member getMemberById(Member member) {
		member = memberDAO.getMemById(member.getId());
		// 设置时间格式
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		member.setFormatTime(df.format(member.getTime()));
		member.setFormatGraduateDate(df.format(member.getGraduateDate()));
		return member;
	}

	@RequestMapping("/getProvByProvId.action")
	@ResponseBody // 从控制器直接把json对象返回到网页上
	public Province getProvByProvId(HttpSession session, HttpServletResponse response, HttpServletRequest request,
			int provid) {

		// int id = Integer.parseInt(request.getParameter("provid"));
		return memberDAO.getProvByProvId(provid);
	}

	@RequestMapping("/sameAge.action")
	@ResponseBody // 从控制器直接把json对象返回到网页上
	public ArrayList<User> sameAge(HttpSession session, HttpServletResponse response, HttpServletRequest request,
			Member member, UserInfo userInfo) throws IOException {
		User user = (User) session.getAttribute("myuser");
		String idno = user.getUserInfo().getIdNo();
		// System.out.println("++++++++++++++++++++++++++++++++++++++++++");
		// System.out.println(idno);
		String idNo = idno.substring(6, 10);
		ArrayList<User> list = memberDAO.sameAge(idNo);
		return list;
	}

	@RequestMapping("/sameScho.action")
	@ResponseBody // 从控制器直接把json对象返回到网页上
	public ArrayList<User> sameScho(HttpSession session, HttpServletResponse response, HttpServletRequest request,
			Member member, UserInfo userInfo) throws IOException {
		User user = (User) session.getAttribute("myuser");
		ArrayList<User> list = memberDAO.sameScho(user.getMember().getSchool());
		return list;
	}

	@RequestMapping("/samePro.action")
	@ResponseBody // 从控制器直接把json对象返回到网页上
	public ArrayList<User> samePro(HttpSession session, HttpServletResponse response, HttpServletRequest request,
			Member member, UserInfo userInfo) throws IOException {
		User user = (User) session.getAttribute("myuser");
		ArrayList<User> list = memberDAO.samePro(user.getMember().getProvid());
		return list;
	}

	/*
	 * 修改： 修改内容：getprovince.action改成getProvince.action 作者：刘文启 日期：2016-04-23
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "getProvince.action", produces = "text/html; charset=utf-8")
	public String getProvince() {
		List<Province> provinces = memberDAO.getProvince();
		StringBuilder strXML = new StringBuilder("");
		strXML.append(
				"<chart caption='当前所在地分布图' yAxisName='人数' showNames='1' decimalPrecision='0' formatNumberScale='0' showBorder='1'>");
		for (int i = 0; i < provinces.size(); i++) {
			Province province = provinces.get(i);
			strXML.append("<set name='");
			strXML.append(province.getName());
			strXML.append("' value='");
			strXML.append(Integer.toString(province.getId()));
			strXML.append("'/> ");
		}
		strXML.append("</chart>");
		return strXML.toString();
	}

	/*
	 * 获取出生地
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "getBornProvince.action", produces = "text/html; charset=utf-8")
	public String getBornProvince() {
		List<Province> provinces = memberDAO.getBornProvince();
		StringBuilder strXML = new StringBuilder("");
		strXML.append(
				"<chart caption='出生地分布图' yAxisName='人数' showNames='1' decimalPrecision='0' formatNumberScale='0' showBorder='1'>");
		for (int i = 0; i < provinces.size(); i++) {
			Province province = provinces.get(i);
			strXML.append("<set name='");
			strXML.append(province.getName());
			strXML.append("' value='");
			strXML.append(Integer.toString(province.getId()));
			strXML.append("'/> ");
		}
		strXML.append("</chart>");
		return strXML.toString();
	}

	/*
	 * 修改： 修改内容：getage.action改成getAge.action 作者：刘文启 日期：2016-04-23
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "getAge.action", produces = "text/html; charset=utf-8")
	public String getAge() {
		ResultType resultType = memberDAO.getAge();
		StringBuilder strXML = new StringBuilder("");
		strXML.append(
				"<chart unescapeLinks='0' caption='年龄比例' xAxisName='Month' yAxisName='Units' showNames='1' decimalPrecision='0' formatNumberScale='0' showBorder='1'>");
		strXML.append("<set label='20岁以下' value='");
		strXML.append(Integer.toString(resultType.getFirst()));
		strXML.append("'/> ");
		strXML.append("<set label='20-25岁' value='");
		strXML.append(Integer.toString(resultType.getSecond()));
		strXML.append("'/> ");
		strXML.append("<set label='25-30岁' value='");
		strXML.append(Integer.toString(resultType.getThird()));
		strXML.append("'/> ");
		strXML.append("<set label='30岁以上' value='");
		strXML.append(Integer.toString(resultType.getFourth()));
		strXML.append("'/> ");
		strXML.append("</chart>");
		String xmlString = strXML.toString();
		try {
			URLEncoder.encode(xmlString, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return xmlString;
	}

	/*
	 * 修改： 修改内容：getstudent.action改成getStudent.action 作者：刘文启 日期：2016-04-23
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "getStudent.action", produces = "text/html; charset=utf-8")
	public String getStudent() {
		ResultType resultType = memberDAO.getStudent();
		StringBuilder strXML = new StringBuilder("");
		strXML.append(
				"<chart unescapeLinks='0' caption='学生比例' xAxisName='Month' yAxisName='Units' showNames='1' decimalPrecision='0' formatNumberScale='0' showBorder='1'>");
		strXML.append("<set label='学生' value='");
		strXML.append(Integer.toString(resultType.getFirst()));
		strXML.append("'/> ");
		strXML.append("<set label='非学生' value='");
		strXML.append(Integer.toString(resultType.getSecond()));
		strXML.append("'/> ");
		strXML.append("</chart>");
		String xmlString = strXML.toString();
		try {
			URLEncoder.encode(xmlString, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return xmlString;
	}

	/*
	 * 作者: 功能：获取会员的分期信息
	 * 
	 * 修改： 如果是管理员登录，查看api的信息，将不保存用户的session 判断并移除用户session信息。 杨凯 2016-04-17
	 * 
	 * 修改： 修改内容：getmyperiod.action改成getMyPeriod.action 作者：刘文启 日期：2016-04-23
	 */
	@RequestMapping("/getMyPeriod.action")
	@ResponseBody
	public String getMyPeriod(HttpSession session, HttpServletRequest request, PeriodDTO periodDTO, int pageNo) {
		// User user=(User) session.getAttribute("myuser");
		// Member member=user.getMember();
		periodDTO.getPage().setCurrentPage(pageNo);
		List<Period> list = periodDAO.getAllByPage(periodDTO);
		// 计算总的交费金额
		int sumAmount = 0;
		for (int i = 0; i < list.size(); i++) {
			Period period = list.get(i);
			sumAmount += (period.getAmount() - period.getRestAmount());
		}
		// 进行分页
		String url = request.getContextPath() + "/member/getMyPeriod.action";
		int pageCount = periodDTO.getPage().getTotalPage();
		int btnCount = 5;
		// 防止其它页面的按钮个数干扰
		if (session.getAttribute("pagecount") != null)
			session.removeAttribute("pagecount");

		// session.setAttribute("pagecount", pageCount);
		// if(session.getAttribute("admin")!=null)
		// {
		// session.removeAttribute("myuser");
		// }
		// return list;
		String str = NavigationBar.classNavBar(url, btnCount, pageNo, pageCount);
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("list", list);
		returnMap.put("navbar", str);
		returnMap.put("totalAmount", sumAmount);
		JSONObject json = new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();
	}

	/*
	 * 作者: 功能：获取会员的利息信息
	 * 
	 * 修改： 修改内容：getmyinterest.action改成getMyInterest.action 作者：刘文启 日期：2016-04-23
	 */
	@RequestMapping("getMyInterest.action")
	@ResponseBody
	public String getMyInterest(HttpSession session, HttpServletRequest request, InterestDTO interestDTO, int pageNo) {
		interestDTO.getPage().setCurrentPage(pageNo);
		List<InterestDetail> interests = interestDAO.getInterestDetail(interestDTO);
		List<InterestDetail> allinterests = interestDAO.getInterestDetailByMid(interestDTO.getMid());
		if (allinterests.size() == 0) {
			return null;
		}
		// 计算总利息
		float sumAmount = 0;
		for (int i = 0; i < allinterests.size(); i++) {
			InterestDetail interestDetail = allinterests.get(i);
			sumAmount += interestDetail.getI_amount();
		}
		// 进行分页
		String url = request.getContextPath() + "/member/getMyInterest.action";
		int pageCount = interestDTO.getPage().getTotalPage();
		int btnCount = 5;
		// 防止其它页面的按钮个数干扰
		if (session.getAttribute("pagecount") != null)
			session.removeAttribute("pagecount");

		// session.setAttribute("pagecount", pageCount);
		String str = NavigationBar.classNavBar(url, btnCount, pageNo, pageCount);
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("list", interests);
		returnMap.put("navbar", str);
		returnMap.put("totalAmount", sumAmount);
		JSONObject json = new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();
	}

	/*
	 * 作者: 功能：获取会员的缴费信息
	 * 
	 * 修改 修改内容：getmyaccount.action改成getMyAccount.action 作者：刘文启 日期：2016-04-23
	 * 
	 */

	/*
	 * 修改 进行分页 作者：苏铭 日期：2016-07-20
	 */
	@RequestMapping("getMyAccount.action")
	@ResponseBody
	public String getMyAccount(HttpSession session, HttpServletRequest request, AccountLogDTO accountLogDTO,
			int pageNo) {
		int newpage;
		accountLogDTO.getPage().setCurrentPage(pageNo);
		newpage = pageNo;
		List<AccountLog> accountLogs = accountLogDAO.getAccountLogByMId(accountLogDTO);
		// 当删除某页最后一天记录时，要往前一页取值
		if (accountLogs.size() == 0) {
			newpage = pageNo - 1;
			if (newpage == 0) {
				newpage = 1;
			}
			accountLogDTO.getPage().setCurrentPage(newpage);
			accountLogs = accountLogDAO.getAccountLogByMId(accountLogDTO);
		}
		if (accountLogs.size() == 0) {
			return null;
		}
		// 计算总的交费金额
		double sumAmount = 0;
		List<String> dates = new ArrayList<String>();
		for (int i = 0; i < accountLogs.size(); i++) {
			AccountLog accountLog = accountLogs.get(i);
			sumAmount += accountLog.getAmount();
			dates.add(DateFormatUtils.dateFormat(accountLog.getDate()));
		}
		// 进行分页
		String url = request.getContextPath() + "/member/getMyAccount.action";
		int pageCount = accountLogDTO.getPage().getTotalPage();
		int btnCount = 5;

		// 防止其它页面的按钮个数干扰
		if (session.getAttribute("pagecount") != null)
			session.removeAttribute("pagecount");

		// session.setAttribute("pagecount", pageCount);
		// if(session.getAttribute("admin")!=null)
		// {
		// session.removeAttribute("myuser");
		// }
		// return list;
		String str = NavigationBar.classNavBar(url, btnCount, pageNo, pageCount);
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("list", accountLogs);
		returnMap.put("dates", dates);
		returnMap.put("navbar", str);
		returnMap.put("totalAmount", sumAmount);
		JSONObject json = new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();
		// return accountLogs;
	}

	/*
	 * 编写:秦珊 修改:张中强 最后修改日期:2015-11-18 作用:用户交费的时候,提取截止今日应交本金,截止今日应缴利息
	 * 当日结清所有费用所需金额三个数据,供交费者参考。
	 */
	@ResponseBody
	@RequestMapping("/getdata")
	public String getData(int id, java.util.Date date, HttpSession session) throws IOException {
		// 截止当日应交本金
		double amount = periodDAO.getPeriodByMid(id);
		// 截止当日应交利息
		float interest = interestDAO.getAllInterest(id);
		// 结清所有费用所需金额
		// 计算交多少钱,可以让资金平衡
		float allmoney = getFeeRest(session, date);
		String info = amount + "!" + interest + "!" + allmoney;
		return info;
	}

	/*
	 * 作者:张晓敏 作用:检验是否可以提交缴费 日期:2016-08-12
	 *
	 * 修改 作用:暂无使用 作者:张晓敏 时间:2016-11-03
	 */
	@ResponseBody
	@RequestMapping("/checkpay")
	public int checkpay(HttpSession session) {
		User user = (User) session.getAttribute("myuser");
		AccountLog accountLog = new AccountLog();
		accountLog.setMember(user.getMember());
		return accountLogDAO.checkFlag(accountLog);
	}

	/*
	 * 作者:张晓敏 作用:检验时间是否合理 日期:2016-11-03
	 */
	@ResponseBody
	@RequestMapping("/checkdate")
	public String checkdate(HttpSession session, HttpServletRequest request) throws ParseException {
		// 防止非法操作
		User user = (User) session.getAttribute("myuser");
		if (user == null) {
			return "202";
		}
		AccountLog accountLog = accountLogDAO.getAccountLogLastById(user.getMember().getId());
		if (accountLog != null) {
			Date date = DateFormatUtils.dateParse(request.getParameter("date"));
			if (date.compareTo(accountLog.getDate()) >= 0) {
				return "100";
			} else {
				return "101&" + DateFormatUtils.dateFormat(accountLog.getDate());
			}
		} else {
			return "100";
		}
	}

	/*
	 * 作者:张晓敏 作用:获取凭证照片 日期:2016-08-12
	 */
	@RequestMapping(value = "/getPhoto")
	public void getPhoto(HttpServletResponse response, HttpServletRequest request) throws IOException {
		int accountLogId = Integer.parseInt(request.getParameter("accountLogId").toString());
		AccountLog accountLog = accountLogDAO.getAccountLogById(accountLogId);
		byte[] photo = accountLog.getPhoto();
		response.setContentType("image/jpeg");
		response.setCharacterEncoding("utf-8");
		OutputStream outputStream = response.getOutputStream();
		outputStream.write(photo);
		outputStream.close();
	}

	/*
	 * 作者:张晓敏 作用:显示缴费记录 日期:2016-08-19
	 */
	@ResponseBody
	@RequestMapping(value = "/getAllByMid")
	public String getAllByMid(HttpServletRequest request) {
		System.out.println(request.getParameter("mid"));
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Member member = memberDAO.getMemById(Integer.parseInt(request.getParameter("mid").toString()));
		member.setAlog(10);
		List<AccountLog> list = accountLogDAO.getAccountLogAllByMidAndFlag(member);
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setFormatDate(df.format(list.get(i).getDate()));
			System.out.println(list.get(i).toString());
		}
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		if (list.size() > 0) {
			returnMap.put("list", list);
		} else {
			returnMap.put("list", new ArrayList<>());
		}
		JSONObject json = new JSONObject();
		json.put("returnMap", returnMap);
		System.out.println("============="+json.toString());
		return json.toString();
	}

	/*
	 * 作者:张晓敏 作用:获取未审核的缴费 日期:2016-11-15
	 */
	@ResponseBody
	@RequestMapping(value = "/getByMidAndFlag")
	public String getByMidAndFlag(HttpServletRequest request) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Member member = memberDAO.getMemById(Integer.parseInt(request.getParameter("mid").toString()));
		member.setAlog(0);
		List<AccountLog> list = accountLogDAO.getAccountLogAllByMidAndFlag(member);
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setFormatDate(df.format(list.get(i).getDate()));
			System.out.println(list.get(i).toString());
		}
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		System.out.println("前台传的alog>0的两个值size：************"+list.size());
		if (list.size() > 0) {
			returnMap.put("list", list);
		} else {
			returnMap.put("list", new ArrayList<>());
		}
		JSONObject json = new JSONObject();
		json.put("returnMap", returnMap);
		System.out.println("前台传的alog>0的两个值：============"+json.toString());
		return json.toString();
	}

	/*
	 * 作者:张晓敏 作用:撤销缴费(审核的和未审核的) 日期:2016-08-21
	 */
	@ResponseBody
	@RequestMapping(value = "/revoke")
	public String revoke(HttpServletRequest request) {
		Member member = memberDAO.getMemById(Integer.parseInt(request.getParameter("mid").toString()));
		AccountLog accountLog = accountLogDAO.getAccountLogLastById(member.getId());
		if (member.getAlog() >= 1) {
			member.setAlog(member.getAlog() - 1);
			accountLogDAO.deleteAcountLogById(accountLog.getId());
			member.getUser().setId(member.getUid());// 必须要重新设置一下user的id，否则更新之后的uid会为0
			memberDAO.update(member);
			return null;
		}
		// 处理Period表
		List<Period> periods = periodDAO.getSettlement(member.getId());
		// 拿到所有的已经交费的记录
		List<Period> pList = new ArrayList<Period>();
		float f = accountLog.getAmount();
		// 最后一条交费记录的金额
		float sum = 0.0f;

		for (int i = periods.size() - 1; i >= 0; i--) {
			System.out.println(periods.get(i).toString());
			sum += periods.get(i).getAmount() - periods.get(i).getRestAmount();
			if (sum == f) {
				periods.get(i).setRestAmount(periods.get(i).getAmount());
				pList.add(periods.get(i));
				break;
			} else if (sum > f) {
				periods.get(i).setRestAmount(periods.get(i).getAmount() - (sum - f));
				System.out.println(sum - f);
				pList.add(periods.get(i));
				break;
			} else {
				periods.get(i).setRestAmount(periods.get(i).getAmount());
				pList.add(periods.get(i));
			}
		}

		for (int i = 0; i < pList.size(); i++) {
			periodDAO.update(pList.get(i));
		}
		// 处理Interest表
		interestDAO.delByAid(accountLog.getId());
		// 处理Member表
		List<Period> periodsByMid = periodDAO.getAllByMid(member.getId());
		double resrAmount = 0;
		for (int i = 0; i < periodsByMid.size(); i++) {
			resrAmount += periodsByMid.get(i).getRestAmount();
		}
		double restInterest = 0;
		InterestDTO interestDTO = new InterestDTO();
		interestDTO.setMid(member.getId());
		List<InterestDetail> interestDetails = interestDAO.getInterestDetailByMid(member.getId());
		for (int i = 0; i < interestDetails.size(); i++) {
			restInterest += interestDetails.get(i).getI_amount();
		}
		member.setAlog(0);
		member.setRestAmount(resrAmount);
		member.setRestInterest(restInterest);
		member.setFee(false);
		member.getUser().setId(member.getUid());
		memberDAO.update(member);
		// 处理Accountlog表
		accountLogDAO.deleteAcountLogById(accountLog.getId());
		return null;
	}

	/*
	 * 作者:张晓敏 作用:获取前一次的缴费记录 日期:2016-08-23
	 */
	@ResponseBody
	@RequestMapping(value = "/auditing")
	public String getRevoke(HttpServletRequest request) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Member member = memberDAO.getMemById(Integer.parseInt(request.getParameter("mid").toString()));
		member.setAlog(1);
		List<AccountLog> accountLogs = accountLogDAO.getAccountLogAllByMidAndFlag(member);
		String string = null;
		if (accountLogs.size() >= 1)
			string = df.format(accountLogs.get(accountLogs.size() - 1).getDate()) + ","
					+ accountLogs.get(accountLogs.size() - 1).getAmount();
		return string;
	}

	/*
	 * 作者:秦珊 作用:会员自己提交交费信息 最后修改日期:2015-11-18
	 *
	 * 修改: 功能:允许多次提交缴费 作者：张晓敏 时间:2015-11-03
	 *
	 */
	@ResponseBody
	@RequestMapping(value = "/paying", method = RequestMethod.POST)
	public String paying(HttpSession session, HttpServletResponse response, HttpServletRequest request)
			throws IOException, ParseException, SerialException, SQLException {
		// 防止非法操作
		User user = (User) session.getAttribute("USER");
		if (null == user) {
			return "202";
		}
/*
		// 更新member表的信息
		Member member = memberDAO.getByUid(user.getId()).get(0);
		int memberAlog = member.getAlog();
		member.setAlog(memberAlog + 1);
		member.setUser(user);*/
		// 制做缴费记录
		AccountLog accountLog = new AccountLog();
		Member member = memberDAO.getByUid(user.getId()).get(0);
		member.setUser(user);
		accountLog.setMember(member);
		accountLog.setAmount(Float.parseFloat(request.getParameter("pay")));
		accountLog.setDate(DateFormatUtils.dateParse(request.getParameter("date")));
		accountLog.setFlag(false);
		if (request.getParameter("fileflag").toString().equals("1")) {
			MultipartHttpServletRequest mulReq = (MultipartHttpServletRequest) request;
			MultipartFile file = mulReq.getFile("file");
			String[] string = file.getOriginalFilename().split("\\.");
			if (string[1].equals("png") || string[1].equals("gif") || string[1].equals("jpg")
					|| string[1].equals("jpeg")) {
				accountLog.setPhoto(file.getBytes());
				accountLog.setType(request.getParameter("type"));
				accountLog.setFileflag(1);
			}
		}
		accountLogDAO.add(accountLog);
		/*if (memberAlog <= 0) {
			// 没有未审核记录
			accountLog.setAmount(Float.parseFloat(request.getParameter("pay")));
			setAccountLog(request, member, accountLog);
			accountLog.setUpflag(1);
			accountLogDAO.add(accountLog);
		} else {
			// 有未审核条目
			String date = accountLogDAO.getLastAmountDateByMid(member.getId());
			if (!date.split(" ")[0].equals(request.getParameter("date").split(" ")[0])) {
				// 未审核的条目不是今天的
				accountLog.setAmount(Float.parseFloat(request.getParameter("pay")));
				setAccountLog(request, member, accountLog);
				accountLog.setUpflag(1);
				accountLogDAO.add(accountLog);
			} else {
				// 未审核的条目是今天的
				accountLog.setAmount(Float.parseFloat(request.getParameter("pay"))
						+ accountLogDAO.getAccountLogForCheck(member.getId()).get(0).getAmount());
				List<AccountLog> list = accountLogDAO.getAccountLogForCheck(member.getId());
				int accId = 0;
				for (int i = 0; i < list.size(); i++) {
					if (accId < list.get(i).getId()) {
						accId = list.get(i).getId();
						accountLog.setUpflag(list.get(i).getUpflag() + 1);
					}
				}
				accountLog.setId(accId);
				setAccountLog(request, member, accountLog);
				accountLogDAO.updateAccountLog(accountLog);
			}
		}*/
		
		
		
		
/*		memberDAO.update(member);
		user.setMember(member);
		session.setAttribute("myuser", user);*/

		
		return "100";
	}

	private void setAccountLog(HttpServletRequest request, Member member, AccountLog accountLog)
			throws ParseException, IOException {
		accountLog.setDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("date")));
		accountLog.setMember(member);
		accountLog.setFlag(false);
		if (request.getParameter("fileflag").toString().equals("1")) {
			MultipartHttpServletRequest mulReq = (MultipartHttpServletRequest) request;
			MultipartFile file = mulReq.getFile("file");
			String[] string = file.getOriginalFilename().split("\\.");
			if (string[1].equals("png") || string[1].equals("gif") || string[1].equals("jpg")
					|| string[1].equals("jpeg")) {
				accountLog.setPhoto(file.getBytes());
				accountLog.setType(request.getParameter("type"));
				accountLog.setFileflag(1);
			} else {
				accountLog.setFileflag(0);
			}
		} else {
			accountLog.setFileflag(0);
		}
	}

	/*
	 * 功能：为会员设置小助手 作者：刘娈莎 日期：2016-05-16
	 * 
	 */
	@RequestMapping("setAssistant.action")
	@ResponseBody
	public String setAssistant(int aid, Member member) {
		member = memberDAO.getMemById(member.getId());
		member.setAid(aid);
		updateMember(member);
		return null;
	}

	/*
	 * 功能：重置会员小助手 作者：刘娈莎 日期：2016-05-16
	 * 
	 */
	@RequestMapping("resetAssistant.action")
	@ResponseBody
	public String resetAssistant(Member member) {
		member = memberDAO.getMemById(member.getId());
		member.setAid(0);
		updateMember(member);
		return null;
	}

	/*
	 * 功能:切换是否需要写周报的标记，summaryflag 作者:刘娈莎 日期2016-5-31
	 */
	@RequestMapping("toggleSummryflag.action")
	@ResponseBody
	public String toggleSummryflag(Member member) {
		member = memberDAO.getMemById(member.getId());
		boolean newflag = true;
		if (member.isSummaryflag()) {
			newflag = false;
		}
		member.setSummaryflag(newflag);
		updateMember(member);
		return null;
	}

	/*
	 * 功能：更新会员信息 作者：刘娈莎 日期：2016-05-16
	 */
	@RequestMapping("updateMember.action")
	@ResponseBody
	public Member updateMember(Member member) {
		// System.out.println(member);
		QueryType queryType = new QueryType();
		queryType.setType(1);
		queryType.setNo(member.getUid());
		List<User> list = userDAO.getUser(queryType);
		User user = list.get(0);
		member.setUser(user);
		memberDAO.update(member);
		return member;
	}

	/*
	 * 功能：管理员端修改会员信息，只修改以下信息 （姓名，性别，学校，工作单位，电话，是否毕业，毕业时间） 作者：刘娈莎 日期：2016-09-07
	 */
	@RequestMapping("updateMemberByadmin.action")
	@ResponseBody
	public Member updateMemberByadmin(Member member) {
		// System.out.println(member);
		Member oldMember = memberDAO.getMemById(member.getId());
		System.out.println("============================================");
		System.out.println(oldMember);
		oldMember.setName(member.getName());
		oldMember.setSex(member.getSex());
		oldMember.setSchool(member.getSchool());
		oldMember.setCompany(member.getCompany());
		oldMember.setMobile(member.getMobile());
		oldMember.setStudent(member.getStudent());
		oldMember.setGraduateDate(member.getGraduateDate());
		memberDAO.update(oldMember);
		return member;
	}

	/*
	 * 功能：修改会员信息页面，部分前台缺少字段重新写入member中,添加判断session是否过期 作者：左琪 日期：2016-05-18
	 */
	@RequestMapping("updateMember1.action")
	@ResponseBody
	public String updateMember1(Member member, HttpSession session) {
		User user = (User) session.getAttribute("myuser");
		if (user != null) {
			Member member2 = memberDAO.getMemById(member.getId());
			// 将页面未传过来的信息注入到member中
			member.setUser(member2.getUser());
			member.setAbnormal(member2.isAbnormal());
			member.setFlag(member2.isFlag());
			member.setAlog(member2.getAlog());
			member.setRestAmount(member2.getRestAmount());
			member.setRestInterest(member2.getRestInterest());
			member.setFee(member2.isFee());
			member.setProvid(member2.getProvid());
			member.setAid(member2.getAid());
			System.out.println(member);
			// 更新member
			memberDAO.update(member);
			// 将修改后的member信息重新存入session
			user.setMember(member);
			session.setAttribute("myuser", user);
			return "1";
		}
		return "0";
	}
	// =====================================分隔符=================================

	@ResponseBody
	@RequestMapping("/checkExisSum.action")
	public String checkExisSum(HttpSession session, Summary summary) {
		User user = (User) session.getAttribute("myuser");
		summary.setMember(user.getMember());
		List<Summary> list = memberDAO.getSumAll(summary);
		if (list.size() > 0) {
			return "1";
		} else {
			return "0";
		}

	}

	// 获取会员的缴费信息
	@RequestMapping("getDateAmount.action")
	@ResponseBody
	public int getDateAmount(String date) {
		return accountLogDAO.getDateAmount(date);
	}

	// 获取会员的缴费信息
	@RequestMapping("getDateDetail.action")
	@ResponseBody
	public Map getDateDetail(String date) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> map = accountLogDAO.getDateDetail(date);
		result.put("Rows", map);
		return result;
	}

	/*
	 * 功能：从管理费用页面，点审核之后取出相应用户数据存入session中， 跳转到feedetail页面。
	 * 说明：由于要避免服务器跳转，所以这个方法弃用了 作者：刘娈莎 日期：2016-5-10
	 */
	@RequestMapping("/initFeeDetail")
	public String initFeeDetail(HttpSession session, Model model, int id, int page) {
		QueryType queryType = new QueryType();
		queryType.setType(1);
		queryType.setNo(id);
		User user = userDAO.getUser(queryType).get(0);
		session.setAttribute("user", user);
		model.addAttribute("page", page);
		return "/admin/feedetail";
	}

	/*
	 * 作者:张中强,秦珊 最后修改日期:2015-11-17 作用:计算截止到指定日期,需要交多少费用,才能结清所有的费用
	 * 包括本金和利息。如果利息为整数则舍弃,为负数,计入所交费用中。
	 */
	public float getFeeRest(HttpSession session, Date time) {
		User user = (User) session.getAttribute("myuser");
		Member member = user.getMember();
		List<Period> list = periodDAO.getAll(member.getId());
		float restMoney = 0f;
		float interests = 0f;
		boolean changed = false;
		// 对于所有已经还完的条目,统计之前产生的利息
		for (int i = 0; i < list.size(); i++) {
			Period period = list.get(i);
			Float f = interestDAO.getInterest(period);
			if (f != null) {
				interests += f;
			}
			if (period.getRestAmount() == 0) {
				continue;
			}
			changed = true;
			// 做一个空的list用于记录预览数据
			Date d1 = period.getDuetime();
			Date d2 = time;
			int flag = 0;
			int days = 0;
			if (d1.getTime() > d2.getTime()) {
				flag = 1;// 正向利息
				days = getBetweenDay(d2, d1);
			} else if (d1.getTime() < d2.getTime()) {
				flag = -1;// 负向利息
				days = getBetweenDay(d1, d2);
			}
			// 计算利息(按月息2%,每月30天计算利息)
			float rates = (float) (0.02 / 30.0f) * days * flag;
			// 加上每期的本金
			restMoney += period.getRestAmount();
			// 利息累加
			interests += Float.valueOf(String.format("%.2f", rates * period.getRestAmount()));
		}
		// 正向利息舍弃
		if (interests < 0) {
			restMoney -= interests;
		}
		if (!changed) {
			restMoney = 0 - Float.valueOf(String.format("%.2f", member.getRestInterest()));
		}
		return restMoney;
	}

	/**
	 * 加载xml中保存的用来计算付款期数的数据到类的静态变量中
	 * 
	 * @param request
	 * @param flag
	 * @throws IOException
	 * @throws XPathExpressionException
	 * @throws ParserConfigurationException
	 * @throws SAXException
	 */
	private void initData(HttpServletRequest request, boolean flag)
			throws IOException, XPathExpressionException, ParserConfigurationException, SAXException {
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		String xmlfile = request.getServletContext().getRealPath("/WEB-INF/data.xml");
		Document document = db.parse(new File(xmlfile));
		XPathFactory xpfactory = XPathFactory.newInstance();
		XPath path = xpfactory.newXPath();
		String mypath = "normal";
		if (flag) {
			mypath = "abnormal";
		}

		FeeData.totalamount = Integer.valueOf(path.evaluate("/datas/" + mypath + "/totalamount", document));
		FeeData.firstamount = Integer.valueOf(path.evaluate("/datas/" + mypath + "/firstamount", document));
		FeeData.monthlyforstudent = Integer.valueOf(path.evaluate("/datas/" + mypath + "/monthlyforstudent", document));
		FeeData.monthlyforworker = Integer.valueOf(path.evaluate("/datas/" + mypath + "/monthlyforworker", document));
	}

	/**
	 * 计算两个日期之间的月份
	 * 
	 * @param minDate
	 * @param maxDate
	 * @return
	 * @throws ParseException
	 */
	private static List<Date> getMonths(Date minDate, Date maxDate) throws ParseException {
		ArrayList<Date> result = new ArrayList<Date>();
		Calendar min = Calendar.getInstance();
		Calendar max = Calendar.getInstance();
		min.setTime(minDate);
		max.setTime(maxDate);
		Calendar curr = min;
		while (curr.before(max)) {
			result.add(curr.getTime());
			curr.add(Calendar.MONTH, 1);
		}
		return result;
	}

	public int getBetweenDay(Date date1, Date date2) {
		Calendar d1 = new GregorianCalendar();
		d1.setTime(date1);
		Calendar d2 = new GregorianCalendar();
		d2.setTime(date2);
		int days = d2.get(Calendar.DAY_OF_YEAR) - d1.get(Calendar.DAY_OF_YEAR);
		int y2 = d2.get(Calendar.YEAR);
		if (d1.get(Calendar.YEAR) != y2) {
			do {
				days += d1.getActualMaximum(Calendar.DAY_OF_YEAR);
				d1.add(Calendar.YEAR, 1);
			} while (d1.get(Calendar.YEAR) != y2);
		}
		return days;
	}

	// 比较第一个日期是否早于第二个日期
	public Boolean dateCompare(Date date1, Date date2) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		int d1 = Integer.parseInt(sdf.format(date1));
		int d2 = Integer.parseInt(sdf.format(date2));
		return d1 < d2;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
		// true:允许输入空值,false:不能为空值ֵ
	}

	/*
	 * 功能:添加沟通信息 作者:刘娈莎 日期2016-6-2
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
	 * 功能:获取沟通信息 作者:刘娈莎 日期2016-6-2
	 */
	@ResponseBody
	@RequestMapping("/getCommunicationByMid.action")
	public List<Communication> getCommunicationByMid(HttpServletRequest request, HttpSession session, int mid) {
		List<Communication> list = communicationDAO.getCommunicationByMid(mid);
		// 设置时间格式
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (int i = 0; i < list.size(); i++) {
			Communication communication = list.get(i);
			communication.setFormatTime(df.format(communication.getTime()));
		}
		return list;
	}

	/*
	 * 功能:获取某个会员最后缴费日期 作者:刘娈莎 日期2016-6-5
	 */
	@ResponseBody
	@RequestMapping("/getLastAmountDateByMid.action")
	public String getLastAmountDateByMid(HttpServletRequest request, HttpSession session, int mid) {
		System.out.println(accountLogDAO.getLastAmountDateByMid(mid));
		return accountLogDAO.getLastAmountDateByMid(mid);
	}

	/*
	 * 
	 * 功能：将会员姓名转换为拼音 作者：苏铭 日期：2016.7.20
	 */
	@ResponseBody
	@RequestMapping("/getAllNames.action")
	public ArrayList<String> transformName(Character letter) {
		List<Member> list = memberDAO.getAll();
		ArrayList<String> plist = new ArrayList<String>();
		for (int i = 0; i < list.size(); i++) {
			if (letter == tools.PinYinUtil.getPinYin(list.get(i).getName()).charAt(0))
				plist.add(list.get(i).getName());
		}
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("list", plist);
		JSONObject json = new JSONObject();
		json.put("returnMap", returnMap);
		// return json.toString();
		return plist;
	}

	/*
	 * 
	 * 功能：设置会员信息，用于管理员查看详细信息 作者： 日期：
	 * 
	 * 修改：将myuser改为myuserinfo 作者：刘娈莎 日期：2016-11-08
	 * 
	 * 修改：将myuserinfo改为myuser，统一contract模板，统一参数 作者：袁超 日期：2016-12-16
	 * 
	 */
	@RequestMapping("/setMember.action")
	public String setMember(HttpServletRequest request, HttpSession session) {
		System.out.println(request.getParameter("name"));
		if (session.getAttribute("myuser") != null)
			session.removeAttribute("myuser");
		System.out.println(session.getAttribute("myuser"));
		String cname = request.getParameter("name");
		Member member = memberDAO.getMemByName(cname);
		// 获取联系人信息
		UserInfo userinfo = userInfoDAO.getUserInfoByUid(member.getUid());
		User user = new User();
		user = userDAO.getUserById(member.getUid());
		user.setMember(member);
		user.setUserInfo(userinfo);
		int mid = user.getMember().getId();
		session.setAttribute("Root", 1);
		user.setFirst((int) periodDAO.getFirst(mid));
		user.setMonthly((int) periodDAO.getMonthly(mid));
		user.setSum(periodDAO.getSum(mid));
		user.setAllMonth(periodDAO.getAllMonthByMid(mid) - 2);
		user.setLast(periodDAO.getLast(mid));
		user.setDelayMonth(periodDAO.getDelayMonthyByMid(mid));
		session.setAttribute("myuser", user);
		System.out.println("123" + session.getAttribute("myuser"));
		return "../admin/navbar1";
	}

	/*
	 * 
	 * 功能：下载VIP会员应缴费用表 作者：张晓敏 日期：2016.10.15
	 */
	@RequestMapping("/getMemberCosts.action")
	@ResponseBody
	public Result getMemberCosts(HttpServletRequest request, HttpServletResponse response) {
		String fileName = RandomNumberUtils.getLongRandomNumber();
		String path = request.getServletContext().getRealPath("//") + fileName + ".xls";
		String title = "VIP会员应缴费用表";
		String[] headers = { "序号", "会员编号", "姓名", "学校", "电话", "QQ", "欠缴金额", "最后缴费日期", "协议缴费日期" };
		try {
			memberDAO.print(headers, path, title);
			return Result.ok(fileName + ".xls");
		} catch (IOException e) {
			e.printStackTrace();
			return Result.build(999, "服务器发生错误");
		}
	}

	/*
	 * 功能:获取全部学校信息 作者:刘娈莎 日期2016-11-30
	 */
	@ResponseBody
	@RequestMapping("/getAllSchoolByPage.action")
	public String getAllSchoolByPage(HttpServletRequest request, HttpSession session, SchoolDTO schoolDTO, int page2) {
		int newpage;
		schoolDTO.getPage().setCurrentPage(page2);
		newpage = page2;
		List<String> list = memberDAO.getAllSchoolByPage(schoolDTO);
		// 当删除某页最后一天记录时，要往前一页取值
		if (list.size() == 0) {
			newpage = page2 - 1;
			if (newpage == 0) {
				newpage = 1;
			}
			schoolDTO.getPage().setCurrentPage(newpage);
			list = memberDAO.getAllSchoolByPage(schoolDTO);
		}

		String url = request.getContextPath() + "/member/getAllSchoolByPage.action";
		int btnCount = 5;
		int pageCount = schoolDTO.getPage().getTotalPage();
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("navbar", str);
		returnMap.put("totalCount", schoolDTO.getPage().getTotalCount());
		returnMap.put("list", list);
		JSONObject json = new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();
	}

	/*
	 * 
	 * 功能：获取在改学校的会员人数 作者：刘娈莎 日期：2016.12.01
	 */
	@ResponseBody
	@RequestMapping("/getSchoolMemberCount.action")
	public int getSchoolMemberCount(String school) {
		return memberDAO.getSchoolMemberCount(school);
	}

	/*
	 * 作用:获取会员的分期信息（新计算方法）
	 * 
	 * 并将member信息一起传到前端去 作者：袁超 日期：2016-12-8
	 */
	@RequestMapping(value = "/getNewPeriod.action", method = RequestMethod.POST)
	@ResponseBody
	public PeriodsResult getNewPeriod(int id, PeriodsResult periodsResult) {
		if (periodsResult.getStatus() == true) {
			/*int num = periodDAO.exists(id);
			if (num > 0) {
				periodsResult.setStatus(false);
				return periodsResult;
			}*/
			periodDAO.initInstalment(id);
		}
		// 费用
		float totalamount = periodsResult.getTotalamount();
		// 首付
		float firstamount = periodsResult.getFirstamount();
		// 利率
		float interest = periodsResult.getInterest();
		// 月供
		float monthpay = periodsResult.getMonthpay();
		// 实付总额
		float amount = firstamount;
		// 利息总额
		float interests;
		// 剩余本金与利息总额
		float total = totalamount - firstamount;
		// 还款金额中的利息
		float minterest;

		List<Period> periods = new ArrayList<>();
		Member member = memberDAO.getMemById(id);
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		member.setFormatTime(df.format(member.getTime()));
		periodsResult.setMember(member);
		Calendar c = Calendar.getInstance();
		c.setTime(member.getTime());

		for (int i = 0; i < 800; i++) {
			// 首付
			if (i == 0) {
				Period period = new Period();
				period.setMember(member);
				period.setAmount(firstamount);
				period.setRestAmount(firstamount);
				period.setMinterest(0);
				period.setTotal(total);
				c.setTime(member.getTime());
				period.setDuetime(c.getTime());
				if (periodsResult.getStatus() == true) {
					periodDAO.add(period);
				}
				periods.add(period);
				continue;
			}
			if (total != 0) {
				if (total * (interest + 1) > monthpay) {
					amount += monthpay;
					minterest = total * interest;
					total = total * (interest + 1) - monthpay;
					Period period = new Period();
					period.setMember(member);
					period.setAmount(monthpay);
					period.setRestAmount(monthpay);
					period.setMinterest(minterest);
					period.setTotal(total);
					c.setTime(member.getTime());
					c.add(Calendar.MONTH, i);
					period.setDuetime(c.getTime());
					if (periodsResult.getStatus() == true) {
						periodDAO.add(period);
					}
					periods.add(period);
				} else {
					minterest = total * interest;
					amount += total * (1 + interest);

					Period period = new Period();
					period.setMember(member);
					period.setAmount(total * (interest + 1));
					period.setRestAmount(total * (interest + 1));
					period.setMinterest(minterest);
					period.setTotal(0);
					c.setTime(member.getTime());
					c.add(Calendar.MONTH, i);
					period.setDuetime(c.getTime());
					if (periodsResult.getStatus() == true) {
						periodDAO.add(period);
						member.setFlag(true);
						member.setPeriodStatus(1);
						// 设置会员表中的本金总额
						member.setRestAmount(amount);
						memberDAO.update(member);
					}
					periods.add(period);
					break;
				}
			}
		}
		periodsResult.setPeriods(periods);
		periodsResult.setAmount(amount);
		interests = amount - totalamount;
		periodsResult.setInterests(interests);
		return periodsResult;
	}

	/*
	 * 作用:获取会员的全款分期信息
	 * 
	 * 并将member信息一起传到前端去 作者：袁超 日期：2016-12-10
	 */
	@RequestMapping(value = "/getAllAmountPeriod.action", method = RequestMethod.POST)
	@ResponseBody
	public PeriodsResult getAllAmountPeriod(int id, Boolean status) {
		PeriodsResult periodsResult = new PeriodsResult();
		if (status == true) {
			/*int num = periodDAO.exists(id);
			if (num > 0) {
				periodsResult.setStatus(false);
				return periodsResult;
			} else {
				periodsResult.setStatus(true);
			}*/
			periodsResult.setStatus(true);
			periodDAO.initInstalment(id);
		}
		List<Period> periods = new ArrayList<>();
		Member member = memberDAO.getMemById(id);
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		member.setFormatTime(df.format(member.getTime()));
		periodsResult.setMember(member);
		Calendar c = Calendar.getInstance();
		c.setTime(member.getTime());

		for (int i = 0; i < 8; i++) {

			Period period = new Period();
			period.setMember(member);
			period.setAmount(1000);
			period.setRestAmount(1000);
			c.setTime(member.getTime());
			c.add(Calendar.MONTH, i);
			period.setDuetime(c.getTime());
			if (status == true) {
				periodDAO.add(period);
				member.setFlag(true);
				member.setPeriodStatus(2);
				member.setRestAmount(8000);
				memberDAO.update(member);
			}
			periods.add(period);
		}

		periodsResult.setPeriods(periods);
		;
		return periodsResult;
	}

	/*
	 * 作用:删除会员分期信息、利息信息、交费信息
	 * 
	 * 作者：袁超 日期：2016-12-10
	 * 
	 * 
	 * 修改：袁超 内容：不删除缴费记录，将缴费记录变为未审核 日期：2016-12-28
	 * 
	 */
	@RequestMapping(value = "/deletePeriodById.action", method = RequestMethod.POST)
	@ResponseBody
	public String deletePeriodById(int id) {
		try {
			// 删除利息信息,修改交费信息
			List<AccountLog> list = accountLogDAO.getAccountLogByMid(id);
			for (AccountLog accountLog : list) {
				interestDAO.delByAid(accountLog.getId());
				accountLog.setFlag(false);
				accountLogDAO.updateAccountLog(accountLog);
			}
			Member mem = memberDAO.getMemById(id);
			mem.setAlog(list.size());
			mem.setFee(false);
			mem.setRestInterest(0);
			memberDAO.update(mem);
			// 删除分期信息
			periodDAO.deleteByMid(id);

			return "OK";

		} catch (Exception e) {
			e.printStackTrace();
			return "ERROR";
		}
	}

	@RequestMapping(value = "/setcustomPay.action", method = RequestMethod.POST)
	@ResponseBody
	public String setcustomPay(HttpServletRequest request) throws IOException, ParseException {
		int mid = Integer.parseInt(request.getParameter("mid"));
		Member member = memberDAO.getMemById(mid);
		MultipartHttpServletRequest mulReq = (MultipartHttpServletRequest) request;
		MultipartFile xmlfile = mulReq.getFile("file");
		ArrayList<Period> list = new ArrayList<>();
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(xmlfile.getInputStream());
		HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(0);
		float restAmount = 0.0f;
		for (int i = 1; i < hssfSheet.getLastRowNum() + 1; i++) {
			HSSFRow row = hssfSheet.getRow(i);
			Period period = new Period();
			period.setMember(member);
			period.setDuetime(row.getCell(1).getDateCellValue());
			float amount = (float) row.getCell(2).getNumericCellValue();
			restAmount += amount;
			period.setAmount(amount);
			period.setRestAmount(amount);
			list.add(period);
		}
		hssfWorkbook.close();
		member.setFlag(true);
		member.setPeriodStatus(3);
		member.setRestAmount(restAmount);
		member.setRestInterest(0);
		member.setAlog(periodDAO.initInstalment(mid));
		memberDAO.setcustomPay(list, member);
		return "";
	}

	@RequestMapping("/getMemberCost.action")
	@ResponseBody
	public Result getMemberCost(@RequestParam(defaultValue = "0") int type, @RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int  rows) {
		return memberDAO.getMemberCost(type, page, rows);
	}
	
	@ResponseBody
	@RequestMapping(value = "/getAccountLogLast")
	public Result getAccountLogLast(HttpSession session, HttpServletRequest request, @RequestParam(defaultValue = "0") int type, @RequestParam(defaultValue = "1") int page2, @RequestParam(defaultValue = "10") int  rows) {	
		return accountLogDAO.getAccountLogLast(type,page2,rows);
	}
}
