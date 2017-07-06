package controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.VisitDAO;
import dto.VisitorDTO;
import entity.History;
import entity.Member;
import entity.User;
import entity.Visitor;
import tools.NavigationBar;
import tools.Paging;

@Controller
@RequestMapping("/visit")
public class VisitController {
	private static Logger logger = Logger.getLogger(VisitController.class);
	@Resource
    VisitDAO visitDAO;
	int pageSize=10;
	/*
	 * 作者:
	 * 
	 * 功能:设置每夜显示的页数，从数据库中返回所有的用户的放入list中
	 * 
	 */	
	@ResponseBody
	@RequestMapping("/get.action")
	public List<Visitor> get(HttpServletRequest request,HttpSession session,int pageno){
		List<Visitor> visitors=visitDAO.getAll();
		int pageCount=Paging.pageCount(visitors.size(),pageSize);
		//这是传入的页码的
		int datasize=visitors.size();
		if(pageno>pageCount)
		{
			pageno=pageCount;	
		}
		if(pageno<=0)
		{
			pageno=1;
		}
		//这是从数据库中拿到的全部数据进行按数显示
		session.setAttribute("pagecount", pageCount);
		Paging<Visitor> paging = new Paging<>();
		return paging.paging(visitors, pageSize, pageno);
	}
	/*
	 * 功能:获取访客信息，对get方法的改写
	 * 目的：统一分页逻辑
	 * 作者:刘娈莎
	 * 日期：2016-5-13
	 * 
	 * 修改：增加判断，没有数据时不生成导航条字符串
	 * 作者：刘娈莎
	 * 日期：2016-6-13 
	 */	
	@ResponseBody
	@RequestMapping("/getVisitorByPage.action")
	public String getVisitorByPage(HttpServletRequest request,VisitorDTO visitorDTO,int page2){
		System.out.println(visitorDTO);
		int newpage;
		visitorDTO.getPage().setCurrentPage(page2);
		newpage=page2;
		List<Visitor> list=visitDAO.getVisitorByPage(visitorDTO);
		//当删除某页最后一天记录时，要往前一页取值
		if(list.size()==0)
		{
			newpage=page2-1;
			if(newpage==0)
			{
				newpage=1;
			}
			visitorDTO.getPage().setCurrentPage(newpage);		
			list=visitDAO.getVisitorByPage(visitorDTO);
		}
		//设置时间格式
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for(int i=0;i<list.size();i++)
		{
			Visitor visitor=list.get(i);
			visitor.setFormatVisitTime(df.format(visitor.getVisitTime()));
			if(visitor.getLeftTime()!=null){
				visitor.setFormatLeftTime(df.format(visitor.getLeftTime()));
			}		
		}
		String url=request.getContextPath()+"/visit/getVisitorByPage.action";
		int btnCount=5;
		int pageCount=visitorDTO.getPage().getTotalPage();
		String str = "";
		if(list.size()>0){
			str=NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		}		
		System.out.println(str);
		HashMap<String, Object> returnMap= new HashMap<String, Object>();
		returnMap.put("navbar", str);
		//returnMap.put("totalCount", userDTO.getPage().getTotalCount());
		returnMap.put("list", list);
		JSONObject json=new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();	
	}
	@ResponseBody
	@RequestMapping("/getone.action")
	public List<History> getone(HttpServletRequest request,HttpSession session,int vid,int pageno){
		List<History> history=visitDAO.get(vid);
		int pageCount=Paging.pageCount(history.size(),pageSize);
		//这是传入的页码的
		int datasize=history.size();
		if(pageno>pageCount)
		{
			pageno=pageCount;	
		}
		if(pageno<=0)
		{
			pageno=1;
		}
		//这是从数据库中拿到的全部数据进行按数显示
		session.setAttribute("pagecount", pageCount);
		Paging<History> paging = new Paging<>();
		return paging.paging(history, pageSize, pageno);
	}
	
	//===========================分割线====================================
	
	
	@RequestMapping("/update.action")
	public void update(Visitor visitors){
		visitDAO.update(visitors);
	}
}
