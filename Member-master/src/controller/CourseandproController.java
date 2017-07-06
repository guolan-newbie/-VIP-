package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import tools.NavigationBar;
import dao.CourseDAO;
import dao.CourseandproDAO;
import dao.UserDAO;
import dto.CourseandproDTO;
import entity.CourseInfo;
import entity.Courseandpro;
import entity.Experience;
import entity.MemAndExp;
import entity.StudentAndProcess;
import entity.User;

@Controller
@RequestMapping("/courseandpro")
public class CourseandproController {
	private static Logger logger = Logger.getLogger( CourseandproController.class);
	@Resource
	CourseandproDAO courseandproDAO;
	@Resource
	CourseDAO courseDAO;
	@Resource
	UserDAO userDAO;
	/*
	 * 功能:点击查看进度信息
	 * 作者:严海玉
	 * 日期2016-8-2
	 */	
	@ResponseBody
	@RequestMapping("/finished.action")
	public void finished(int uid)
	{
		User user=userDAO.getUserById(uid);
		double mycid=courseandproDAO.getmyCid(uid);
		double allcid=courseDAO.getallCid();
		double jindu=(mycid*100.0)/allcid;
		//String str=Double.toString(jindu);
		String str=String.format("%.2f", jindu);
		str=str+"%";
		user.setFinish(str);
		userDAO.updatefinish(user);	
		//System.out.println("mycid:"+mycid+"allcid:"+allcid+"str:"+str);
	}
	
	/*
	 * 功能:添加课程进度
	 * 作者:严海玉
	 * 日期2016-7-25
	 * 
	 * 修改：由于数据库完全改了，所以改动较大，不好详细说
	 * 作者：刘娈莎
	 * 日期：2016-8-11
	 */	
	@ResponseBody
	@RequestMapping("/add.action")
	public String add(HttpSession session,HttpServletResponse response,Courseandpro courseandpro) throws IOException
	{	
		if(session.getAttribute("myuser")!=null){
			User user=(User)session.getAttribute("myuser");
			courseandpro.setMeid(user.getMember().getId());
			courseandpro.setIdentityType(1);
		}
		if(session.getAttribute("experience")!=null){
			Experience experience=(Experience) session.getAttribute("experience");
			courseandpro.setMeid(experience.getId());
			courseandpro.setIdentityType(0);
		}	
		Courseandpro temp=courseandproDAO.exists(courseandpro);
		int amount=0;
		List<Integer> list =courseDAO.getCourseAmountBeforeThisChapter(courseandpro);
		for(int j:list){
			amount+=j;
		}
		amount+=courseandpro.getCorder();
		courseandpro.setProportion(amount*100.00/courseDAO.getCourseGross(courseandpro));
		if(temp!=null){
			courseandpro.setId(temp.getId());
			courseandproDAO.update(courseandpro);
		}else{
			courseandproDAO.add(courseandpro);
		}	
		return null;
	}
	/*
	 * 功能:获取是否存在当前在线用户详细进度信息（某人的每个类别category）
	 * 作者:刘娈莎
	 * 日期2016-8-11
	 */	
	@ResponseBody
	@RequestMapping("/exists.action")
	public Courseandpro exists(HttpSession session,Courseandpro courseandpro)
	{
		if(session.getAttribute("myuser")!=null){
			User user=(User)session.getAttribute("myuser");
			courseandpro.setMeid(user.getMember().getId());
			courseandpro.setIdentityType(1);
		}
		if(session.getAttribute("experience")!=null){
			Experience experience=(Experience) session.getAttribute("experience");
			courseandpro.setMeid(experience.getId());
			courseandpro.setIdentityType(0);
		}	
		courseandpro=courseandproDAO.exists(courseandpro);
		return courseandpro;
	}
	
	/*
	 * 功能:获取是否存在某用户详细进度信息（某人的每个类别category）
	 * 作者:刘娈莎
	 * 日期2016-8-15
	 */	
	@ResponseBody
	@RequestMapping("/existsByMemAndExp.action")
	public Courseandpro existsByMemAndExp(HttpSession session,Courseandpro courseandpro,MemAndExp memAndExp)
	{

		courseandpro.setMeid(memAndExp.getId());
		courseandpro.setIdentityType(memAndExp.getIdentityType());
		courseandpro=courseandproDAO.exists(courseandpro);
		return courseandpro;
	}
	
	/*
	 * 功能:获取进度信息，分页
	 * 作者:严海玉
	 * 日期2016-7-25
	 */	
	@ResponseBody
	@RequestMapping("/getCourseandproByPage.action")
	public String getCourseandproByPage(HttpServletRequest request,HttpSession session,CourseandproDTO courseandproDTO,int page2){
		int newpage;
		courseandproDTO.getPage().setCurrentPage(page2);
		newpage=page2;
		List<MemAndExp> list=courseandproDAO.getCourseandproByPage(courseandproDTO);
		//当删除某页最后一天记录时，要往前一页取值
		if(list.size()==0)
		{
			newpage=page2-1;
			if(newpage==0)
			{
				newpage=1;
			}
			courseandproDTO.getPage().setCurrentPage(page2);
			list=courseandproDAO.getCourseandproByPage(courseandproDTO);
		}
		
		String url=request.getContextPath()+"/courseandpro/getCourseandproByPage.action";
		int btnCount=5;
		int pageCount=courseandproDTO.getPage().getTotalPage();
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		//System.out.println("getCourseInfoByPage:"+str);
		HashMap<String, Object> returnMap= new HashMap<String, Object>();
		returnMap.put("navbar", str);
		returnMap.put("totalCount", courseandproDTO.getPage().getTotalCount());
		for(int i=0;i<list.size();i++){
			StudentAndProcess studentAndProcess=new StudentAndProcess();
			studentAndProcess.setMeid(list.get(i).getId());
			studentAndProcess.setIdentityType(list.get(i).getIdentityType());
			List<StudentAndProcess> categorys=courseandproDAO.getStudentLearnedCategory(studentAndProcess);
			list.get(i).setCategorys(categorys);
		}
		if(list.size()>0){
			returnMap.put("list", list);
		}else{
			returnMap.put("list", new ArrayList<>());
		}	
		JSONObject json=new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();
	}
	
	/*
	 * 功能:获取某类别所有进度信息，分页
	 * 作者:刘娈莎
	 * 日期2016-8-29
	 */	
	@ResponseBody
	@RequestMapping("/getCategoryCourseandproByPage.action")
	public String getCategoryCourseandproByPage(HttpServletRequest request,HttpSession session,CourseandproDTO courseandproDTO,int page2){
		int newpage;
		courseandproDTO.getPage().setCurrentPage(page2);
		newpage=page2;
		List<Courseandpro> list=courseandproDAO.getCategoryCourseandproByPage(courseandproDTO);
		//当删除某页最后一天记录时，要往前一页取值
		if(list.size()==0)
		{
			newpage=page2-1;
			if(newpage==0)
			{
				newpage=1;
			}
			courseandproDTO.getPage().setCurrentPage(page2);
			list=courseandproDAO.getCategoryCourseandproByPage(courseandproDTO);
		}
		
		String url=request.getContextPath()+"/courseandpro/getCategoryCourseandproByPage.action";
		int btnCount=5;
		int pageCount=courseandproDTO.getPage().getTotalPage();
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		//System.out.println("getCourseInfoByPage:"+str);
		HashMap<String, Object> returnMap= new HashMap<String, Object>();
		returnMap.put("navbar", str);
		returnMap.put("totalCount", courseandproDTO.getPage().getTotalCount());
		if(list.size()>0){
			returnMap.put("list", list);
		}else{
			returnMap.put("list", new ArrayList<>());
		}	
		JSONObject json=new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();
	}
	
	/*
	 * 功能:获取某个学员的专业选择情况
	 * 作者:刘娈莎
	 * 日期2016-9-3
	 */	
	@ResponseBody
	@RequestMapping("/getStudentCategory.action")
	public List<StudentAndProcess> getStudentCategory(HttpSession session,StudentAndProcess studentAndProcess)
	{
		List<StudentAndProcess> list=courseandproDAO.getStudentCategory(studentAndProcess);
		return list;
	}
	/*
	 * 功能:获取当前在线学员的专业选择情况
	 * 作者:刘娈莎
	 * 日期2016-9-3
	 */	
	@ResponseBody
	@RequestMapping("/getOnlineStudentCategory.action")
	public List<StudentAndProcess> getOnlineStudentCategory(HttpSession session,StudentAndProcess studentAndProcess)
	{
		if(session.getAttribute("myuser")!=null){
			User user=(User)session.getAttribute("myuser");
			studentAndProcess.setMeid(user.getMember().getId());
			studentAndProcess.setIdentityType(1);
		}
		if(session.getAttribute("experience")!=null){
			Experience experience=(Experience) session.getAttribute("experience");
			studentAndProcess.setMeid(experience.getId());
			studentAndProcess.setIdentityType(0);
		}	
		List<StudentAndProcess> list=courseandproDAO.getStudentCategory(studentAndProcess);
		return list;
	}
	/*
	 * 功能:设置某个学员对某个专业的学习状态
	 * 作者:刘娈莎
	 * 日期2016-9-3
	 */	
	@ResponseBody
	@RequestMapping("/setStudentCategory.action")
	public String setStudentCategory(HttpSession session,Courseandpro courseandpro,String flag)
	{
//		System.out.println(courseandpro);
//		System.out.println(flag);
		//flag：true 设置为已学（在进度表里加一个空进度的记录） false 设置为未学(删除进度表中的信息)
		if(flag.equals("true")){
			courseandproDAO.add(courseandpro);
		}else{
			courseandproDAO.deleteByCaid(courseandpro);
		}
		return null;
	}
}
