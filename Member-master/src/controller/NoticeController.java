package controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.NoticeDAO;
import dto.NoticeDTO;
import dto.SummaryDTO;
import entity.Admin;
import entity.Experience;
import entity.Notice;
import entity.User;
import tools.NavigationBar;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	private static Logger logger = Logger.getLogger(NoticeController.class);
	@Resource
	NoticeDAO noticeDAO;
	/*
	*功能:查询单个公告
	*作者:
	*日期:
	*/
	@RequestMapping("/get.action")
	@ResponseBody
	public Notice get(HttpSession session,Notice notice) throws Exception 
	{
		List<Notice> notices = noticeDAO.get(notice);
		if(notices.size()==0){
			return null;
		}
		return notices.get(0);
	}
	@RequestMapping("/updatePublish.action")
	public String updatePublish(HttpSession session,Notice notice) throws Exception 
	{
		notice.setPublishtime(new Date());
		noticeDAO.updatePublish(notice);
		return "/admin/notice";
	}
	
	/*
	*功能:添加公告
	*日期：
	*作者:
	*/
	@RequestMapping("/add.action")
	public String add(HttpSession session,Notice notice) throws Exception 
	{
		if (notice.getId() == 0){
			Admin admin=(Admin)session.getAttribute("admin");
			notice.setAdmin(admin);
			notice.setEnable(false);
			notice.setStatus(false);
			notice.setSettop(false);
			notice.setCreatetime(new Date());
			noticeDAO.add(notice);
		}
		else{
			Admin admin=(Admin)session.getAttribute("admin");
			notice.setAdmin(admin);
			noticeDAO.update(notice);
		}
		return "/admin/notice";
	}
	
	/*
	*功能:更新公告
	*日期：
	*作者:
	*/
	@RequestMapping("/updateSettop.action")
	public String updateSettop(HttpSession session,Notice notice) throws Exception 
	{
		noticeDAO.updateSettop(notice);
		return "/admin/notice";
	}
	
	/*
	*修改:
	*作者:张晓敏
	*修改内容:添加时间条件查询
	*修改日期:2016-6-6
	*状态:未使用，被getNoticeByPage.action代替
	*/
	@RequestMapping("/getall.action")
	@ResponseBody
	public List<Notice> getall(HttpSession session,HttpServletRequest request,Notice notice) throws Exception 
	{
		Map<String, Object> mapParam = new HashMap<String, Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		Date front = sdf.parse("1970-01-01 00:00:00.000");
		Date after = new Date();
		if(request.getParameter("front") != null && request.getParameter("front") != "") {
			front= sdf.parse(request.getParameter("front") + " 00:00:00.000");
		}
		if(request.getParameter("after") != null && request.getParameter("after") != "") {
			after= sdf.parse(request.getParameter("after") + " 23:59:59.999");
		}
		mapParam.put("front", front);
		mapParam.put("after", after);
		if (notice == null){
		}
		else{
			if (notice.getTitle() != "" && notice.getTitle() != null){
				mapParam.put("title", notice.getTitle());			
			}
		}
		List<Notice> notices = noticeDAO.getall(mapParam);
		if(notices.size()==0){
			return null;
		}
		return notices;
	}
	/*
	 *修改：
	 *修改的内容：getLastest.action改成getLastestNotice.action
	 *作者：刘文启
	 *最后修改:2016-04-22
	*/
	@RequestMapping("/getLastestNotice.action")
	@ResponseBody
	public String getLastestNotice(HttpSession session){
		User user=(User) session.getAttribute("myuser");
		Map<String, Object> mapParam = new HashMap<String, Object>();
		mapParam.put("uid", user.getId());
		mapParam.put("date", new Date());
		noticeDAO.updatenoticeTime(mapParam);
		Map<String, Object> map=noticeDAO.getLastest();
		if(map==null)
			return "";
		JSONObject jsonObject=new JSONObject(map);
		return jsonObject.toString();
	}
	
	
	@RequestMapping("/notice.action")
	@ResponseBody
	public String notice(HttpSession session) throws ParseException{
		User user=(User) session.getAttribute("myuser");
		String time = noticeDAO.getnoticeTime(user.getId());
		//System.out.println(time);
		Map<String, Object> map=noticeDAO.getLastest();
		if(map==null)
			return "2";
		String time1=(String)map.get("publishtime");
		SimpleDateFormat format =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(time==null){
			return "1";
		}
		Date time2=format.parse(time);
		return (time2.before(format.parse(time1))) ? "1" : "2";
	}
	/*
	*作者:王温迪
	*功能：添加历史公告分页
	*日期:2016-7-30
	*/
	@RequestMapping("/getNotices.action")
	@ResponseBody
	public String getNotices(HttpSession session,HttpServletRequest request, NoticeDTO noticeDTO,int page2 ) throws Exception {
		int newpage;
		//设置每页只显示1条数据 设置当前页为前端传过来的页数
		noticeDTO.getPage().setPageSize(1);
		noticeDTO.getPage().setCurrentPage(page2);
		newpage = page2;
		//为了以后需求更改 这里用list接收
		List<Notice> list = noticeDAO.getAllByPage(noticeDTO);
		//当删除某页最后一天记录时，要往前一页取值
		if(list.size()==0)
		{
			newpage=page2-1;
			if(newpage==0)
			{
				newpage=1;
			}
			//把新的当前页传入 重新获取数据
			noticeDTO.getPage().setCurrentPage(newpage);
			list = noticeDAO.getAllByPage(noticeDTO);
		}
		String url=request.getContextPath()+"/notice/getNotices.action";
		//设置按钮数
		int btnCount=5;
		//获得总页数
		int pageCount=noticeDTO.getPage().getTotalPage();
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		System.out.println(url);
		System.out.println(str);
		HashMap<String, Object> returnMap= new HashMap<String, Object>();
		returnMap.put("navbar", str);
		returnMap.put("list", list);
		JSONObject json=new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();	
	}
	/*
	*作者:严海玉
	*功能：添加体验者可以看最新公告的功能
	*日期:2016-7-15
	*/
	@RequestMapping("/getLastestNoticeExperience.action")
	@ResponseBody
	public String getLastestNoticeExperience(HttpSession session){
		Experience experience =(Experience) session.getAttribute("experience");
		Map<String, Object> mapParam = new HashMap<String, Object>();
		mapParam.put("eid", experience.getId());
		mapParam.put("dateEx", new Date());
		noticeDAO.updatenoticeExperienceTime(mapParam);
		Map<String, Object> map=noticeDAO.getLastest();
		if(map==null)
			return "";
		JSONObject jsonObject=new JSONObject(map);
		return jsonObject.toString();
	}
	/*
	*作者:严海玉
	*功能：根据公告时间判断体验者有没有阅读公告
	*日期:2016-7-15
	*/    
	@RequestMapping("/noticeExperience.action")
	@ResponseBody
	public String noticeExperience(HttpSession session) throws ParseException
	{
		Experience experience =(Experience) session.getAttribute("experience");
		String time = noticeDAO.getnoticeExperienceTime(experience.getId());
		//System.out.println(time);
		Map<String, Object> map=noticeDAO.getLastest();
		if(map==null)
			return "2";
		String time1=(String)map.get("publishtime");
		SimpleDateFormat format =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(time==null){
			return "1";
		}
		Date time2=format.parse(time);
		return (time2.before(format.parse(time1))) ? "1" : "2";
	}
	
	
	//==============================分割线=================================

	/*
	*功能:删除公告
	*作者:张晓敏
	*日期:2016-6-5
	*/
	@ResponseBody
	@RequestMapping("/delNotice.action")
	public String delNotice(int id) {
		noticeDAO.delNotice(id);
		return null;
	}
	
	/*
	*功能:批量删除公告
	*作者:张晓敏
	*日期:2016-6-5
	*/
	@ResponseBody
	@RequestMapping("/delNotices.action")
	public String delNotices(HttpServletRequest request) {
        String ids=request.getParameter("ids");
        String[] id=ids.split(",");
		for(int i=0;i<id.length;i++) {
			noticeDAO.delNotice(Integer.parseInt(id[i]));
		}
		return null;
	}
	
	/*
	*功能:获取公告分页（不从服务器跳转，返回一个json对象）
	*作者:张晓敏
	*日期:2016-6-11
	*/
	@ResponseBody
	@RequestMapping("/getNoticeByPage.action")
	public String getNoticeByPage(HttpSession session,HttpServletRequest request) throws ParseException {
		NoticeDTO noticeDTO =new NoticeDTO();
		if(request.getParameter("title") != "" && request.getParameter("title") != null) {
			noticeDTO.setTitle(request.getParameter("title"));
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		Date front = sdf.parse("1970-01-01 00:00:00.000");
		Date after = new Date();
		if(request.getParameter("front") != null && request.getParameter("front") != "") {
			front= sdf.parse(request.getParameter("front") + " 00:00:00.000");
		}
		if(request.getParameter("after") != null && request.getParameter("after") != "") {
			after= sdf.parse(request.getParameter("after") + " 23:59:59.999");
		}
		noticeDTO.setFront(front);
		noticeDTO.setAfter(after);
		
		int page2 = Integer.parseInt(request.getParameter("page2").toString());
		int newpage = page2;
		noticeDTO.getPage().setCurrentPage(newpage);
		List<Notice> notices = noticeDAO.getNoticeByPage(noticeDTO);
		for(;notices.size()==0;) {
			newpage = newpage - 1;
			if (newpage == 0) {
				newpage = 1;
			}
			noticeDTO.getPage().setCurrentPage(newpage);
			notices = noticeDAO.getNoticeByPage(noticeDTO);
			if(newpage == 1) break;
		}
		
		/*设置字符串时间*/
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		for(int i = 0;i < notices.size();i++) {
			if(notices.get(i).getStatus()) {
				notices.get(i).setPublishtimeStr(df.format(notices.get(i).getPublishtime()));
			}
		}
		
		String url = request.getContextPath() + "/notice/getNoticeByPage.action";
		int btnCount=5;
		int pageCount=noticeDTO.getPage().getTotalPage();
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		HashMap<String, Object> returnMap= new HashMap<String, Object>();
		returnMap.put("navbar", str);
		returnMap.put("totalCount", noticeDTO.getPage().getTotalCount());
		returnMap.put("list", notices);
		JSONObject json = new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();
	}
	
}
