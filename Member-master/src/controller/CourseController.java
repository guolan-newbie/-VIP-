package controller;

import java.util.ArrayList;
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

import tools.NavigationBar;
import dao.CourseDAO;
import dao.CourseandproDAO;
import dto.CourseDTO;
import dto.CourseandproDTO;
import entity.Category;
import entity.Course;
import entity.CourseAndCategory;
import entity.CourseInfo;
import entity.Courseandpro;
import entity.Experience;
import entity.MemAndExp;
import entity.Member;
import entity.User;

@Controller
@RequestMapping("/course")
public class CourseController {
	private static Logger logger = Logger.getLogger(CourseController.class);
	@Resource
	CourseDAO courseDAO;
	@Resource
	CourseandproDAO courseandproDAO;
	//获取进度相似或同期加入学员的维度
	static int RANGE=3;

	/*
	 * 功能:添加课程
	 * 作者:严海玉
	 * 日期2016-7-21
	 * 
	 * 修改：
	 * 改为单纯的添加
	 * 作者：刘娈莎
	 * 日期：2016-8-7
	 */	
	@ResponseBody
	@RequestMapping("/add.action")
	public String add(HttpSession session,Course course)
	{
		
		courseDAO.add(course);
		CourseAndCategory cac = new CourseAndCategory();
		cac.setCid(course.getId());
		cac.setCaid(0);
		cac.setOrder(0);
		courseDAO.addCourseAndCategory(cac);
		return null;
	}
	/*
	 * 功能:获取课程，分页
	 * 作者:严海玉
	 * 日期2016-7-22
	 */	
	@ResponseBody
	@RequestMapping("/getCourseByPage.action")
	public String getCourseByPage(HttpServletRequest request,HttpSession session,CourseDTO courseDTO,int page2){
		int newpage;
		courseDTO.getPage().setCurrentPage(page2);
		newpage=page2;
		List<Course> list=courseDAO.getCourseByPage(courseDTO);
		if(list.size()==0)
		{
			newpage=page2-1;
			if(newpage==0)
			{
				newpage=1;
			}
			courseDTO.getPage().setCurrentPage(page2);
			list=courseDAO.getCourseByPage(courseDTO);
		}
		for(int i=0;i<list.size();i++){
			Course course=list.get(i);
			if(course.getChid()==0){
				List<String> categoryTitles=courseDAO.getCategoryTitleByCid(course.getId());
				list.get(i).setCategoryTitles(categoryTitles);
			}
		}
		String url=request.getContextPath()+"/course/getCourseByPage.action";
		int btnCount=5;
		int pageCount=courseDTO.getPage().getTotalPage();
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
	//	System.out.println("/getCourseByPage:"+str);
		HashMap<String, Object> returnMap= new HashMap<String, Object>();
		returnMap.put("navbar", str);
		returnMap.put("totalCount", courseDTO.getPage().getTotalCount());
		if(list.size()>0){
			returnMap.put("list", list);
		}else{
			returnMap.put("list", new ArrayList<>());
		}	
		for(int i=0;i<list.size();i++){
			System.out.println(list.get(i));
		}
		JSONObject json=new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();	
	}
	/*
	 * 功能:通过id获取课程进度信息(未添加)
	 * 作者:严海玉
	 * 日期2016-7-25
	 */	
	@ResponseBody
	@RequestMapping("/getCourseById.action")
	public Course getCourseById(HttpServletRequest request,HttpSession session,int id){
		return courseDAO.getCourseById(id);
	}
	
	/*
	 * 功能:点击查看课程属于哪个大目录
	 * 作者:严海玉
	 * 日期2016-8-3
	 */	
	@ResponseBody
	@RequestMapping("/getchapter.action")
	public String getchapter(int cid)
	{	
		return courseDAO.getchapter(cid);
	}
	
	/*
	 * 功能:点击查看课程属于哪个大目录
	 * 作者:严海玉
	 * 日期2016-8-3
	 */	
	@ResponseBody
	@RequestMapping("/getChapters.action")
	public List<Course> getChapters()
	{	
		return courseDAO.getChapters();
	}
	
	
	/*
	 * 功能:取出该章节下的所有课程
	 * 作者:严海玉
	 * 日期2016-8-3
	 */	
	@ResponseBody
	@RequestMapping("/getLessons.action")
	public List<Course> getLessons(int chid)
	{	
		return courseDAO.getLessons(chid);	
	}
	
	
	/*
	 * 功能:查看已经学过的课程信息
	 * 作者:严海玉
	 * 日期2016-8-3
	 */	
	@ResponseBody
	@RequestMapping("/finishcourse.action")
	public String finishcourse(int uid)
	{
		List<CourseInfo> list=courseDAO.finishcourse(uid);
		HashMap<String, Object> returnMap= new HashMap<String, Object>();		
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
	 * 功能:删除课程记录
	 * 作者:严海玉
	 * 日期:2016-8-4
	 * 
	 * 修改：
	 * 返回值类型由void改为string，否则报错java.lang.IllegalAccessException
	 * 参数由id改为course，接收其中的两个值（id、chid）
	 * 增加如果是章节的话，还要删除章节类别关联表的相关信息已经章节下所有课程
	 * 作者：刘娈莎
	 * 日期：2016-8-17
	 */
	@ResponseBody
	@RequestMapping("/delete.action")
	public String delete(Course course) {
		if(course.getChid()==0){
			//删除章节类别关联表的相关信息
			courseDAO.deleteCCByCid(course.getId());
			//删除章节下所有课程
			courseDAO.deleteByChid(course.getId());
		}
		courseDAO.delete(course.getId());		
		return null;
	}	
	/*
	 * 功能:给课程排序
	 * 作者:刘娈莎
	 * 日期:2016-8-9
	 */
	@ResponseBody
	@RequestMapping("/sortLessons.action")
	public String sortLessons(HttpServletRequest request,@RequestParam(value = "order[]") int[] order) {
		//这里是传的数组，不知道为什么会报java.lang.IllegalAccessException这个错
		//但是暂时不影响功能，我也不知道怎么解决，就先不处理了
		for(int i=0;i<order.length;i++){
			Course course =courseDAO.getCourseById(order[i]);
			course.setOrder((i+1));
			courseDAO.setOrder(course);
		}
		return null;
	}
	/*
	 * 功能:设置类别，给章节排序
	 * 作者:刘娈莎
	 * 日期:2016-8-9
	 */
	@ResponseBody
	@RequestMapping("/setCategory.action")
	public String setCategory(HttpServletRequest request,@RequestParam(value = "order[]") int[] order,Category category) {
		courseDAO.addCategory(category);
		int caid=courseDAO.getLastCategoryId();
		for(int i=0;i<order.length;i++){
			//System.out.println(order[i]);
			//设置关联表
			CourseAndCategory courseAndCategory=new CourseAndCategory();
			courseAndCategory.setCaid(caid);
			courseAndCategory.setCid(order[i]);
			courseAndCategory.setOrder((i+1));
			courseDAO.addCourseAndCategory(courseAndCategory);
		}
		return null;
	}
	/*
	 * 功能:修改类别
	 * 作者:刘娈莎
	 * 日期:2016-8-13
	 */
	@ResponseBody
	@RequestMapping("/modifyCategory.action")
	public String modifyCategory(HttpServletRequest request,@RequestParam(value = "order[]") int[] order,Category category) {
		courseDAO.updateCategory(category);
		int caid=category.getId();
		//删除关联表原来的值（这样比较方便，否则一个一个改更加繁琐）
		courseDAO.deleteCCByCaid(caid);
		for(int i=0;i<order.length;i++){
			//System.out.println(order[i]);
			//设置关联表
			CourseAndCategory courseAndCategory=new CourseAndCategory();
			courseAndCategory.setCaid(caid);
			courseAndCategory.setCid(order[i]);
			courseAndCategory.setOrder((i+1));
			courseDAO.addCourseAndCategory(courseAndCategory);
		}
		courseDAO.deleteCCByCaid(0);
		return null;
	}
	/*
	 * 功能:得到专业类别
	 * 作者:严海玉
	 * 日期:2016-8-10
	 */
	@ResponseBody
	@RequestMapping("/getcategory.action")
	public  List<Category> getCategory()
	{
		return courseDAO.getcategory();
	}
	/*
	 * 功能:得到专业类别下章节
	 * 作者:严海玉
	 * 日期:2016-8-10
	 */
	@ResponseBody
	@RequestMapping("/getcachapter.action")
	public List<Course> getcachapter(int caid)
	{
		return courseDAO.getcachapter(caid);
	}
	/*
	 * 功能:得到不在该专业类别下的所有章节
	 * 作者:刘娈莎
	 * 日期:2016-8-13
	 */
	@ResponseBody
	@RequestMapping("/getChaptersNotInThisCategory.action")
	public List<Course> getChaptersNotInThisCategory(int caid)
	{
		return courseDAO.getChaptersNotInThisCategory(caid);
	}
	/*
	 * 功能:得到某人学过的各个类别
	 * 作者:刘娈莎
	 * 日期:2016-8-13
	 */
	@ResponseBody
	@RequestMapping("/getCategoryByMeid.action")
	public  List<Category> getCategoryByMeid(MemAndExp memAndExp)
	{
		return courseDAO.getCategoryByMeid(memAndExp);
	}
	/*
	 * 功能:得到自己学过的各个类别
	 * 作者:刘娈莎
	 * 日期:2016-8-19
	 */
	@ResponseBody
	@RequestMapping("/getMyCategory.action")
	public  List<Category> getMyCategory(HttpSession session)
	{
		MemAndExp memAndExp=new MemAndExp();
		if(session.getAttribute("myuser")!=null){
			User user=(User)session.getAttribute("myuser");
			memAndExp.setId(user.getMember().getId());
			memAndExp.setIdentityType(1);
		}
		if(session.getAttribute("experience")!=null){
			Experience experience=(Experience) session.getAttribute("experience");
			memAndExp.setId(experience.getId());
			memAndExp.setIdentityType(0);
		}	
		return courseDAO.getCategoryByMeid(memAndExp);
	}
	/*
	 * 功能:修改课程信息
	 * 作者:刘娈莎
	 * 日期:2016-8-17
	 */
	@ResponseBody
	@RequestMapping("/modifyLesson.action")
	public  String modifyLesson(Course course)
	{
		Course newcourse=courseDAO.getCourseById(course.getId());
		newcourse.setChid(course.getChid());
		newcourse.setTitle(course.getTitle());
		courseDAO.update(newcourse);
		return null;
	}
	/*
	 * 功能:修改章节信息
	 * 作者:刘娈莎
	 * 日期:2016-8-17
	 */
	@ResponseBody
	@RequestMapping("/modifyChapter.action")
	public  String modifyChapter(Course course)
	{
		Course newcourse=courseDAO.getCourseById(course.getId());
		newcourse.setTitle(course.getTitle());
		newcourse.setOptional_flag(course.isOptional_flag());
		courseDAO.update(newcourse);
		return null;
	}
	
	/*
	 * 功能:获取同期加入的学员
	 * 作者:刘娈莎
	 * 日期:2016-8-19
	 */
	@ResponseBody
	@RequestMapping("/getTheSamePeriodMember.action")
	public  List<Member> getTheSamePeriodMember(HttpSession session)
	{
		if(session.getAttribute("myuser")!=null){
			User user=(User)session.getAttribute("myuser");
			CourseDTO courseDTO =new CourseDTO();
			courseDTO.setNum(user.getName());
			courseDTO.setRange(RANGE);			
			return courseDAO.getTheSamePeriodMember(courseDTO);
		}
		return new ArrayList<>();
	}
	/*
	 * 功能:获取进度相近的学员
	 * 作者:刘娈莎
	 * 日期:2016-8-19
	 */
	@ResponseBody
	@RequestMapping("/getTheSameProgressStudent.action")
	public  List<MemAndExp> getTheSameProgressStudent(HttpSession session,Courseandpro courseandpro)
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
		CourseandproDTO courseandproDTO =new CourseandproDTO();
		courseandproDTO.setMeid(courseandpro.getMeid());
		courseandproDTO.setIdentityType(courseandpro.getIdentityType());
		courseandproDTO.setCaid(courseandpro.getCaid());
		courseandproDTO.setProportion(courseandpro.getProportion());
		courseandproDTO.setRange(RANGE);
		List<MemAndExp> list=courseDAO.getTheSameProgressStudent(courseandproDTO);
		if(list.size()>0){
			return list;
		}
		return new ArrayList<>();
	}
}
