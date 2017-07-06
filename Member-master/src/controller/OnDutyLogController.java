package controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dao.OnDutyLogDAO;
import dao.OndutyDAO;
import dto.OnDutyLogDTO;
import entity.OnDuty;
import entity.OnDutyApply;
import entity.OnDutyLog;
import entity.User;
import tools.NavigationBar;

@Controller
@RequestMapping("/ondutylog")
public class OnDutyLogController {
	private static Logger logger = Logger.getLogger(OnDutyLogController.class);
	@Resource
	OnDutyLogDAO onDutyLogDAO;	
	@RequestMapping("/add.action")
	public String add(HttpSession session,OnDutyLog onDutyLog,int oid) throws Exception 
	{	
		User user=(User)session.getAttribute("myuser");
//		System.out.println("oid="+ onDutyLog.getOid());
//		System.out.println("oid2="+ oid);
		onDutyLog.setOid(onDutyLog.getOid());
		onDutyLog.setMid(user.getMember().getId());
		onDutyLog.setBeHelpedName(onDutyLog.getBeHelpedName());
		onDutyLog.setBeHelpedQQ(onDutyLog.getBeHelpedQQ());
		onDutyLog.setBeHelpedInfo(onDutyLog.getBeHelpedInfo());
		onDutyLog.setQustionDescription(onDutyLog.getQustionDescription());
		onDutyLog.setSolutionReport(onDutyLog.getSolutionReport());
		onDutyLog.setFlag(false);
		onDutyLog.setSubmitTime(new Date());
		onDutyLogDAO.add(onDutyLog);
		return "/member/lookonduty";		
	}
	
	@RequestMapping("/modify.action")
	public String modify(HttpSession session,OnDutyLog onDutyLog)
	{	
		onDutyLogDAO.modify(onDutyLog);
		return "/member/infoshow";
	}
	
	@ResponseBody
	@RequestMapping("/getLogs.action")
	public ArrayList<OnDutyLog> getLogs(HttpSession session,OnDutyLog onDutyLog,HttpServletRequest request)
	{	
		//System.out.println(onDutyLog.getOid());
		ArrayList<OnDutyLog> list;
		if(session.getAttribute("myuser")!=null)
		{
			User user=(User)session.getAttribute("myuser");
			int mid =user.getMember().getId();
			onDutyLog.setMid(mid);	
			list=onDutyLogDAO.getLogsByOidAndMid(onDutyLog);
			return setFormatTime(list);
		}
		else if(session.getAttribute("admin")!=null){
			list=onDutyLogDAO.getLogsByOid(onDutyLog);
			return setFormatTime(list);
		}
		return null;
	}
	
	@RequestMapping("/checkLogById.action")
	public String checkLogById(HttpSession session,int id,OnDutyLog onDutyLog)
	{	
		//System.out.println(id);
		if(session.getAttribute("admin")==null)
		{
			return "/admin/dutymanagement";
		}		
		onDutyLog.setId(id);
		onDutyLog.setCheckTime(new Date());
		onDutyLogDAO.checkLogById(onDutyLog);
		return "/admin/dutymanagement";
	}
	
	@RequestMapping("/getSRById.action")
	public String getSRById(HttpSession session,int id)
	{	
		session.setAttribute("SR", onDutyLogDAO.getSRById(id));
		return "/onduty/showsr";
	}
	
	@RequestMapping("/modifyThis.action")
	public ModelAndView modifyThis(HttpSession session,int id)
	{
		//选日期下拉菜单
		User user=(User)session.getAttribute("myuser");
		int mid =user.getMember().getId();
		ArrayList<OnDuty> list= onDutyLogDAO.getApply(mid);
		if(list.size()>0)
		{
			ArrayList<OnDutyApply> applies=new ArrayList<OnDutyApply>();
			DateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for(int i=0;i<list.size();i++)
			{
				OnDuty oDuty=list.get(i);
				OnDutyApply oda=new OnDutyApply();
				String str=df.format(oDuty.getStart());
				oda.setOid(oDuty.getId());
				oda.setTime(str);
				applies.add(oda);
			}
			String path="/onduty/modify";
			ModelAndView mav=new ModelAndView(path);
			mav.addObject("APPLY",applies);
			mav.addObject("command",new OnDutyApply());
			//日志内容
			OnDutyLog log= onDutyLogDAO.getLogById(id);	
			mav.addObject("LOG",log);
			return mav;
		}
		
		return new ModelAndView("null");
	}
	
	@RequestMapping("/toCheck.action")
	public String toCheck(HttpSession session,HttpServletRequest request)
	{
		int page=1;
		int newpage;
		if(request.getParameter("page")!=null)
		{
			page= Integer.parseInt(request.getParameter("page"));
		}
		OnDutyLogDTO onDutyLogDTO=new OnDutyLogDTO();
		onDutyLogDTO.getPage().setCurrentPage(page);
		newpage=page;
		ArrayList<OnDutyLog> list=onDutyLogDAO.getLogsByPage(onDutyLogDTO);
		//当删除某页最后一天记录时，要往前一页取值
		if(list.size()==0)
		{
			newpage=page-1;
			if(newpage==0)
			{
				newpage=1;
			}
			onDutyLogDTO.getPage().setCurrentPage(newpage);		
			list=onDutyLogDAO.getLogsByPage(onDutyLogDTO);
		}	
		String url=request.getContextPath()+"/ondutylog/tocheck.action";
		int btnCount=onDutyLogDTO.getPage().getTotalPage();
		int pageCount=btnCount;
		String str = NavigationBar.NavBar(url, btnCount, newpage, pageCount);
		//	System.out.println(str.toString());
		session.setAttribute("NAVBAR", str);
		
		session.setAttribute("PAGE", newpage);
		session.setAttribute("LIST", list);
		return "/admin/checkondutylog";
	}
	/*
	 * 功能：获取符合条件的值班申请（审核过的并且已经开始了的）
	 * 修改：统一方法名：
	 * 将getapply.action改为getApply.action
	 * 杨凯
	 * 2016-04-20
	 * 
	 * */
	@RequestMapping("/getApply.action")
//	public String getApply(HttpSession session)
//	{
//		User user=(User)session.getAttribute("myuser");
//		int mid =user.getMember().getId();
//		ArrayList<OnDuty> list= onDutyLogDAO.getApply(mid);
//		if(list.size()>0)
//		{
//			session.setAttribute("APPLY", list);
//			return "/onduty/choose";
//		}
//		return null;
//	}
	public ModelAndView getApply(HttpSession session)
	{
		
		User user=(User)session.getAttribute("myuser");
		int mid =user.getMember().getId();
		ArrayList<OnDuty> list= onDutyLogDAO.getApply(mid);
		System.out.println(list.size());
		OnDutyApply oda=new OnDutyApply();
		if(list.size()>0)
		{
			ArrayList<OnDutyApply> applies=new ArrayList<OnDutyApply>();
			DateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for(int i=0;i<list.size();i++)
			{
				OnDuty oDuty=list.get(i);
				oda.setOid(oDuty.getId());
				System.out.println(oDuty.getId());
				//设置时间				
				Date start=oDuty.getStart();
				Date end=oDuty.getEnd();
				long between=(start.getTime()-end.getTime())/1000;//除以1000是为了转换成秒
			    long hour=between%(24*3600)/3600;
			    long min=between%3600/60;
				String str=df.format(start);
				oda.setTime(str);
				applies.add(oda);
			}
			String path="/onduty/write";
			ModelAndView mav=new ModelAndView(path);
			mav.addObject("APPLY",applies);
			System.out.println(mav.getViewName());
			mav.addObject("command",new OnDutyApply());
			//session.setAttribute("APPLY", list);	
			return mav;
		}
		return new ModelAndView("/member/navbar1");
	}
	@RequestMapping("/towrite.action")
	public String toWrite(HttpSession session,OnDutyApply onDutyApply)
	{
		session.setAttribute("OID", onDutyApply.getOid());
		return "/onduty/write";
	}
//=================================== 分隔线  ================================================
	


	@RequestMapping("/tomodify.action")
	public String toModify(HttpSession session,HttpServletRequest request)
	{
		int page=1;
		int newpage;
		if(request.getParameter("page")!=null)
		{
			page= Integer.parseInt(request.getParameter("page"));
		}
		OnDutyLogDTO onDutyLogDTO=new OnDutyLogDTO();
		onDutyLogDTO.getPage().setCurrentPage(page);
		newpage=page;
		User user=(User)session.getAttribute("myuser");
		onDutyLogDTO.setId(user.getMember().getId());
		ArrayList<OnDutyLog> list=onDutyLogDAO.getLogsForModifyByPage(onDutyLogDTO);
		//当删除某页最后一天记录时，要往前一页取值
		if(list.size()==0)
		{
			newpage=page-1;
			if(newpage==0)
			{
				newpage=1;
			}
			onDutyLogDTO.getPage().setCurrentPage(newpage);		
			list=onDutyLogDAO.getLogsByPage(onDutyLogDTO);
		}	
		//设置时间格式
		for(int i=0;i<list.size();i++)
		{
			DateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			list.get(i).setFormatStart(df.format(list.get(i).getOnDuty().getStart()));
		}
		//设置导航条
		String url=request.getContextPath()+"/ondutylog/tomodify.action";
		int btnCount=onDutyLogDTO.getPage().getTotalPage();
		int pageCount=btnCount;
		String str = NavigationBar.NavBar(url, btnCount, newpage, pageCount);

		//	System.out.println(str.toString());
		session.setAttribute("NAVBAR", str);
		
		session.setAttribute("PAGE", newpage);
		session.setAttribute("LIST", list);
		return "/onduty/tomodify";
	}

	

	
	


	private ArrayList<OnDutyLog> setFormatTime(ArrayList<OnDutyLog> list) {
		//设置时间格式
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		DateFormat df1=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		DateFormat df2=new SimpleDateFormat("HH:mm");
		for(int i=0;i<list.size();i++)
		{
			list.get(i).setFormatSubmitTime(df.format(list.get(i).getSubmitTime()));
			list.get(i).setFormatTime(df1.format(list.get(i).getOnDuty().getStart())+"-"+df2.format(list.get(i).getOnDuty().getEnd()));
		}
		return list;
	}
	@RequestMapping(value="/addOnDutyLog",method = RequestMethod.GET)
	public ModelAndView initForm(ModelMap model){
		OnDutyLog ondutylog = new OnDutyLog(); //用于转换到form表单的对象
		return new ModelAndView("write").addObject(ondutylog); //跳转到addCompany页面
	}
}
//@ResponseBody
//@RequestMapping("/getlogs.action")
//public ArrayList<OnDutyLog> getLogs(HttpSession session,int page,HttpServletRequest request)
//{
//	OnDutyLogDTO onDutyLogDTO=new OnDutyLogDTO();
//	onDutyLogDTO.getPage().setCurrentPage(page);		
//	ArrayList<OnDutyLog> list=onDutyLogDAO.getLogsByPage(onDutyLogDTO);
//	if(list.size()==0)
//	{
//		onDutyLogDTO.getPage().setCurrentPage(page-1);		
//		list=onDutyLogDAO.getLogsByPage(onDutyLogDTO);
//	}	
//		//设置导航条,让当前页尽量在中间
//		int btns=onDutyLogDTO.getPage().getTotalPage();
//		int half_btns=btns/2;
//		int start=page-half_btns;
//		int end=page+half_btns;
//		if(start<1)
//		{
//			start=1;
//			end=(start+btns)-1;
//		}
//		if(end>btns)
//		{
//			end=btns;
//			start=(end-btns)+1;
//		}
//		if(start<1)
//		{
//			start=1;
//		}
//		//导航条字符串
//		StringBuilder str=new StringBuilder();
//		for(int i=start;i<=end;i++)
//		{
//			str.append("<a href='"+request.getContextPath()+"/admin/checkondutylog.jsp?page="+i+"'>");
//			if(i==page)
//			{
//				str.append("<font color='red'><b>");
//				str.append(i);
//				str.append("</b></font>");
//			}
//			else{
//				str.append(i);
//			}
//			str.append("</a>");
//			str.append("&nbsp;&nbsp;&nbsp;");
//		}
//		str.append("<br>");
//	//	System.out.println(str.toString());
//		session.setAttribute("NAVBAR", str.toString());
//		session.setAttribute("LIST", list);
//	//session.setAttribute("PAGECOUNT", onDutyLogDTO.getPage().getTotalPage());
//	return list;
//}