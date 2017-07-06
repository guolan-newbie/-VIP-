package controller;

import java.text.DateFormat;
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

import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.apache.log4j.Logger;
import org.apache.poi.ss.util.SSCellRange;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.sym.Name;

import dao.AccountLogDAO;
import dao.MemberDAO;
import dao.OndutyDAO;
import dto.OndutyDTO;
import entity.AccountLog;
import entity.Member;
import entity.OnDuty;
import entity.StatusCode;
import entity.User;
import mapper.OnDutyLogMapper;
import tools.Authentication;
import tools.DateFormatUtils;
import tools.NavigationBar;
import tools.Paging;
import tools.ReturnJson;

/**
 * @author a1274
 *
 */
@Controller
@RequestMapping("/onduty")
public class OndutyController {
	private static Logger logger = Logger.getLogger(OndutyController.class);
	private int btnCount=7;
	private int pageSize=10;
	@Resource
	OndutyDAO ondutyDAO;
	@Resource
	MemberDAO memberDAO;
	@Resource
	AccountLogDAO accountLogDAO;
	@ResponseBody
	@RequestMapping("/update.action")
	public String update(OnDuty onduty){
		onduty.setRead(new Date());
		ondutyDAO.update(onduty);
		return null;
	}
	@ResponseBody
	@RequestMapping("/navbar.action")
	public String navbar(HttpSession session,@RequestParam(value="type1", defaultValue="0")int type1,String start,String end,String url,@RequestParam(value="page", defaultValue="1")int page,@RequestParam(value="type2", defaultValue="0")int type2,String date,String uname,int size){
	//System.out.println("=="+type1+"||"+type2+"||"+date+"||"+start+"||"+end+"||"+url+"||"+page+"||"+uname+"||"+size+"||"+"==");
		int pageCount=1;
		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> list = new ArrayList<>();
		//会员相关导航条
		if(session.getAttribute("myuser")!=null){
			url+="?date="+date+"&type="+type1;
		}else{
			//管理相关导航条
			if(uname!=null&&uname!=""){
				//姓名查询导航条
				url+="?uname="+uname;
			}else{
				//非姓名查询导航条
				url+="?start="+start+"&end="+end+"&type2="+type2;
			}
		}
		if(size==0){
			return null;
		}
		pageCount=size / pageSize;
		if(size % pageSize>0){
			pageCount++;
		}
	//System.out.println(url);
		return NavigationBar.sickNavBar(url, btnCount, page , pageCount);
	}
	//提取函数1
	private Map<String, Object> queryparameter(int type, String start, String end) {
		Map<String, Object> map = new HashMap<>();
		SimpleDateFormat sFormat = new SimpleDateFormat("yyyy-MM-dd");
		if(start==""&&end==""){
			start = sFormat.format(new Date());
			map.put("start", start);
		}else{
		map.put("start", start);
		map.put("end", end);
		}
		if(type==0){
			map.put("flag", type);
		}
		map.put("date","");
		return map;
	}
	@ResponseBody
	@RequestMapping("/query.action")
	public String query(HttpServletRequest request,@RequestParam(value="type2",defaultValue="0")int type,OndutyDTO ondutyDTO, @RequestParam(value="page", defaultValue="1")int page2,String start,String end){
		SimpleDateFormat sFormat = new SimpleDateFormat("yyyy-MM-dd");
		if(start==""&&end==""){
			start = sFormat.format(new Date());
			ondutyDTO.setStart(start);
		}else{
            ondutyDTO.setStart(start);
            ondutyDTO.setEnd(end);
		}
		if(type==0){
			ondutyDTO.setFlag(type);
		}
		List<Map<String, Object>> list=ondutyDAO.get(ondutyDTO);
		if(list.size()==0)
			return null;
		String url=request.getContextPath()+"/onduty/getAll.action";
		int btnCount=5;
		int pageCount=ondutyDTO.getPage().getTotalPage();
		//取数据
		int newpage;
		ondutyDTO.getPage().setCurrentPage(page2);
		newpage=page2;
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		//System.out.println(str);
		HashMap<String, Object> returnMap= new HashMap<String, Object>();
		returnMap.put("navbar", str);
		returnMap.put("totalCount", ondutyDTO.getPage().getTotalCount());
		returnMap.put("list", list);
		JSONObject json=new JSONObject();
		json.put("returnMap", returnMap);

		return json.toString();	
		//return newlist(page, list);
	}
	@ResponseBody
	@RequestMapping("/del.action")
	public String del(int id){
		ondutyDAO.del(id);
		return null;
	}
	@ResponseBody
	@RequestMapping("/checkName.action")
	public String[] checkName(String name){
		return ondutyDAO.getuname(name);
	}
	@ResponseBody
	@RequestMapping("/add.action")
	public String add(HttpSession session,OnDuty onduty,@RequestParam(value="uname", defaultValue="null")String uname) throws Exception 
	{
		int cmid;
		if(!uname.equals("null")){
			cmid=ondutyDAO.getmid(uname);	
		}
		else{
			User user=(User)session.getAttribute("myuser");
			cmid=user.getMember().getId();
		}
		onduty.setMid(cmid);
		onduty.setTime(new Date());
		onduty.setFlag(0);
		ondutyDAO.add(onduty);
		return "0";		
	}
	@ResponseBody
	@RequestMapping("/test.action")
	public String test(HttpSession session,OnDuty onduty) throws Exception 
	{	
		return null;		
	}
	@ResponseBody
	@RequestMapping("/get.action")
	public String get(HttpServletRequest request,HttpSession session,OndutyDTO ondutyDTO,@RequestParam(value="page", defaultValue="1")int page2,@RequestParam(value="type1", defaultValue="0")int type,String date){
		SimpleDateFormat sFormat = new SimpleDateFormat("yyyy-MM-dd");
		if(date==null || date==""){
			date = sFormat.format(new Date());
		}
		ondutyDTO.setDate("%"+date+"%");
		if(type==0){
			User user=(User)session.getAttribute("myuser");
			ondutyDTO.setMid(user.getMember().getId());
		}
		List<Map<String, Object>> list=ondutyDAO.get(ondutyDTO);
		if(list.size()==0)
			return null;
		String url=request.getContextPath()+"/onduty/get.action";
		int btnCount=5;
		int pageCount=ondutyDTO.getPage().getTotalPage();
		//取数据
		int newpage;
		ondutyDTO.getPage().setCurrentPage(page2);
		newpage=page2;
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		//System.out.println(str);
		HashMap<String, Object> returnMap= new HashMap<String, Object>();
		returnMap.put("navbar", str);
		returnMap.put("totalCount", ondutyDTO.getPage().getTotalCount());
		returnMap.put("list", list);
		JSONObject json=new JSONObject();
		json.put("returnMap", returnMap);

		return json.toString();	
		//return newlist(page, list);
	}
	//获取所有记录
	@ResponseBody
	@RequestMapping("/getAll.action")
	public String getAll(HttpSession session,HttpServletRequest request,@RequestParam(value="uname", defaultValue="null")String uname,@RequestParam(value="page2", defaultValue="1")int page2,@RequestParam(value="type1", defaultValue="0")int type,OndutyDTO ondutyDTO){
		System.out.println(ondutyDTO);
		ondutyDTO.getPage().setCurrentPage(page2);
		if(!uname.equals("null")){
			System.out.println(uname);
			ondutyDTO.setMid(ondutyDAO.getmid(uname));
		}
		//SimpleDateFormat sFormat = new SimpleDateFormat("yyyy-MM-dd");
		//设置查询的起始和结束时间
		if(ondutyDTO.getStart()==""&&ondutyDTO.getEnd()==""){
			//String start = sFormat.format(new Date());
			String start=null;
			String end=null;
			ondutyDTO.setStart(start);
			ondutyDTO.setEnd(end);
		}
		if(type==0){
			ondutyDTO.setFlag(type);
		}
		List<Map<String, Object>> list=ondutyDAO.getAllByPage(ondutyDTO);
		if(list.size()==0)
			return null;
		String url=request.getContextPath()+"/onduty/getAll.action";
		int btnCount=5;
		int pageCount=ondutyDTO.getPage().getTotalPage();
		//取数据
		int newpage;
		ondutyDTO.getPage().setCurrentPage(page2);
		newpage=page2;
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		//System.out.println(str);
		HashMap<String, Object> returnMap= new HashMap<String, Object>();
		returnMap.put("navbar", str);
		returnMap.put("totalCount", ondutyDTO.getPage().getTotalCount());
		returnMap.put("list", list);
		JSONObject json=new JSONObject();
		json.put("returnMap", returnMap);

		return json.toString();	
		//return newlist(page2, list);
	}
	//通过会员id获取值班信息
	@ResponseBody
	@RequestMapping("/getOndutyByMid.action")
	public List<Map<String, Object>> getgetOndutyByMid(OndutyDTO ondutyDTO,HttpSession session){
		User user=(User)session.getAttribute("myuser");
		int cmid=user.getMember().getId();
		ondutyDTO.setMid(cmid);
		List<Map<String, Object>> list=ondutyDAO.get(ondutyDTO);
		return list;
	}

    //=============================分割线=================================
	
	@ResponseBody
	@RequestMapping("/superadd.action")
	public String add(OnDuty onduty, String uname) throws ParseException
	{	
		onduty.setMid(ondutyDAO.getmid((uname)));
		onduty.setTime(new Date());
		onduty.setFlag(1);
		onduty.setRead(new Date());
		ondutyDAO.add(onduty);
		return null;		
	}
	//用来审核后将flag设置为1,并且设置审核时间
	@RequestMapping("/setFlag.action")
	public String setFlag(OnDuty onduty,int oid){
		onduty.setRead(new Date());
		onduty.setId(oid);
		ondutyDAO.setFlag(onduty);
		return null;
	}

	
	//=====================================规范代码区 以下为新标准 请不要将未规范的代码写在这之后========================================================
	/**
	 * <p>
	 * Title: getAllMemberByFlag
	 * </p>
	 * <p>
	 * Description: 获取所有有未审核值班记录的会员信息
	 * </p>
	 * 
	 * @author 张晓敏 日期： 2016年11月13日
	 *
	 * @param session
	 *            HttpSession
	 * @return json String 统一的数据返回形式
	 */
	@ResponseBody
	@RequestMapping(value = "/getAllMemberByFlag.action", method = RequestMethod.POST)
	public String getAllMemberByFlag(HttpSession session) {
		ReturnJson returnJson = new ReturnJson();
		returnJson.setStatusCode(Authentication.checkAdmin(session));
		if (returnJson.getStatusCode().getErrNum() != 100) {
			return returnJson.returnJson();
		}

		List<OnDuty> lists = ondutyDAO.getAllMidByFlag();
		List<Member> members = new ArrayList<Member>();
		for (OnDuty onDuty : lists) {
			members.add(memberDAO.getMemById(onDuty.getMid()));
		}
		returnJson.put("members", members);

		return returnJson.returnJson();
	}

	/**
	 * <p>
	 * Title: getOndutyByMidAndFlag
	 * </p>
	 * <p>
	 * Description: 根据Mid获取所有未审核的值班记录
	 * </p>
	 * 
	 * @author 张晓敏 日期： 2016年11月13日
	 * 
	 * @param session
	 *            HttpSession
	 * @param mid
	 *            int 会员的mid
	 * @return json String 统一的数据返回形式
	 */
	@ResponseBody
	@RequestMapping(value = "/getOndutyByMidAndFlag.action", method = RequestMethod.POST)
	public String getOndutyByMidAndFlag(HttpSession session, int mid) {
		ReturnJson returnJson = new ReturnJson();
		returnJson.setStatusCode(Authentication.checkAdmin(session));
		if (returnJson.getStatusCode().getErrNum() != 100) {
			return returnJson.returnJson();
		}

		List<OnDuty> ondutys = ondutyDAO.getOndutyByMidAndFlag(mid);
		List<String> dates = new ArrayList<String>();
		List<String> starts = new ArrayList<String>();
		List<String> ends = new ArrayList<String>();
		for (OnDuty onDuty : ondutys) {
			String[] start = DateFormatUtils.dateTimeFormat(onDuty.getStart()).split(" ");
			dates.add(start[0]);
			starts.add(start[1]);
			ends.add(DateFormatUtils.dateTimeFormat(onDuty.getEnd()).split(" ")[1]);
		}
		returnJson.put("ondutys", ondutys);
		returnJson.put("dates", dates);
		returnJson.put("starts", starts);
		returnJson.put("ends", ends);

		return returnJson.returnJson();
	}

	/**
	 * <p>
	 * Title: auditing
	 * </p>
	 * <p>
	 * Description:审核值班记录并添加缴费记录
	 * </p>
	 * 
	 * @author 张晓敏 日期： 2016年11月26日
	 *
	 * @param session
	 * @param string
	 *            String 值班记录的id
	 * @param mid
	 *            String 会员的mid
	 * @return json String 统一的数据返回形式
	 */
	@ResponseBody
	@RequestMapping(value = "/auditing.action", method = RequestMethod.POST)
	public String auditing(HttpSession session, String string, String mid) {
		ReturnJson returnJson = new ReturnJson();
		returnJson.setStatusCode(Authentication.checkAdmin(session));
		if (returnJson.getStatusCode().getErrNum() != 100) {
			return returnJson.returnJson();
		}
		
		//通过值班记录的审核
		String[] strings = string.split(",");
		int time = 0;
		for (int i = 0; i < strings.length; i++) {
			OnDuty onduty = ondutyDAO.getOndutyByid(Integer.parseInt(strings[i]));
			time += (onduty.getEnd().getTime() - onduty.getStart().getTime()) / (60 * 60 * 1000l);
			onduty.setRead(new Date());
			onduty.setId(onduty.getId());
			ondutyDAO.setFlag(onduty);
			System.out.println(onduty);
		}
		
		//更新member表的信息
		Member member = memberDAO.getMemById(Integer.parseInt(mid));
		if(member.getAlog() <= 0) {
			member.setAlog(1);
		} else {
			member.setAlog(member.getAlog() + 1);
		}
		memberDAO.update(member);
		System.out.println(member);
		
		//添加一条缴费记录
		AccountLog accountLog = new AccountLog();
		accountLog.setUpflag(1);
		accountLog.setFileflag(0);
		accountLog.setFlag(false);
		accountLog.setDate(new Date());
		accountLog.setAmount(time * 10);
		accountLog.setMember(member);
		accountLogDAO.add(accountLog);
		System.out.println(accountLog);
		
		return returnJson.returnJson();
	}
}
