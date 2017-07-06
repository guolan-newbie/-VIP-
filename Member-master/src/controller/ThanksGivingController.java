package controller;



import java.io.IOException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.AdminDAO;
import dao.MemberDAO;
import dao.ThanksGivingDAO;
import dao.UserDAO;
import dto.ThanksGivingDTO;
import dto.UserDTO;
import entity.Member;
import entity.ThanksGiving;
import entity.User;
import entity.Visitor;
import tools.NavigationBar;
import tools.Paging;
/*
*修改:将mapping由memberpay改为thanksgiving
*统一起来比较好，省得大家都找不到
*作者:刘娈莎	
*日期:2016-5-13
*/
@Controller
@RequestMapping("/thanksgiving")
public class ThanksGivingController {
	private static Logger logger = Logger.getLogger(ThanksGivingController.class);
	private int pageSize=8;
	private int pageCount=0;
	@Resource
	AdminDAO adminDAO;
	@Resource
	MemberDAO memberDAO;
	@Resource
	UserDAO userDAO;
	@Resource
	ThanksGivingDAO thanksgivingDAO;
	@RequestMapping("/pay.action")
	@ResponseBody
	//页面传值：mname:接受方,money:金额
	public String pay(HttpSession session,String mobile,String money)
	{	
		User user=(User) session.getAttribute("myuser");
		Member member=user.getMember();
		Member member1=memberDAO.getMemByMobile(mobile);
		if(Double.parseDouble(money)>member.getRestInterest()){
			return "***操作未成功,请检查金额的填写!";
		}
		//更新利息交易信息
		ThanksGiving thanksgiving=new ThanksGiving();
		thanksgiving.setMgid(member.getId());
		thanksgiving.setMrid(member1.getId());
		thanksgiving.setGname(member.getName());
		thanksgiving.setRname(member1.getName());
		thanksgiving.setMoney(Integer.parseInt(money));
		thanksgiving.setTime(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date()));
		thanksgivingDAO.add(thanksgiving);
		//更新两个用户的利息信息
		Double ch=Double.parseDouble(money);
		member.setRestInterest(member.getRestInterest()-ch);
		member1.setRestInterest(member1.getRestInterest()+ch);
		memberDAO.updateRest(member);
		memberDAO.updateRest(member1);
		session.setAttribute("rest", member.getRestInterest());
		return "";
	}
	/*
	 * 功能：初步判断一下手机是否正确，并且返回用户名
	 * 修改：统一方法名：
	 * 将check.action改为checkName.action
	 * 杨凯
	 * 2016-04-20
	 * 
	 * 修改：判断本金是否缴清的判断条件member改成member1
	 * 作者：刘娈莎
	 * 日期：20·6-5-13
	 * */
	@RequestMapping("/checkName.action")
	@ResponseBody
	public String checkName(String mobile,HttpSession session){
		User user=(User) session.getAttribute("myuser");
		Member member=user.getMember();
		Member member1=memberDAO.getMemByMobile(mobile);
		if(member1==null){
			return "1,";
		}
		if(!member1.isFee()){
			return "1,"+member1.getName()+"本金尚未交清!";
		}
		if(member.getId()==member1.getId()){
			return "1,自己不能给自己转账";
		}
		return "2,"+member1.getName();		
	}
	
	//得到所有利息交易的列表信息(分页处理)
	@RequestMapping("/getInfo.action")
	@ResponseBody
	public List<ThanksGiving> getInfo(HttpServletRequest request,@RequestParam(value="page", defaultValue="1")int page,@RequestParam(value="mark", defaultValue="0")int mark){
		List<ThanksGiving> list = thanksgivingDAO.getAll();
		pageCount = Paging.pageCount(list.size(), pageSize);
		Paging<ThanksGiving> paging = new Paging<>();
		return paging.paging(list, pageSize, page);
	}
	/*
	 * 功能:得到所有利息交易的列表信息(分页处理)，对getInfo方法的改写
	 * 目的：统一分页逻辑
	 * 作者:刘娈莎
	 * 日期：2016-5-13
	*/
	@ResponseBody
	@RequestMapping("/getThanksgivingByPage.action")	
	public String getThanksgivingByPage(HttpServletRequest request,ThanksGivingDTO  thanksGivingDTO,int page2){
		System.out.println(thanksGivingDTO);
		int newpage;
		thanksGivingDTO.getPage().setCurrentPage(page2);
		newpage=page2;
		List<ThanksGiving> list = thanksgivingDAO.getAllByPage(thanksGivingDTO);
		//当删除某页最后一天记录时，要往前一页取值
		if(list.size()==0)
		{
			newpage=page2-1;
			if(newpage==0)
			{
				newpage=1;
			}
			thanksGivingDTO.getPage().setCurrentPage(newpage);		
			list = thanksgivingDAO.getAllByPage(thanksGivingDTO);
		}
		String url=request.getContextPath()+"/thanksgiving/getThanksgivingByPage.action";
		int btnCount=5;
		int pageCount=thanksGivingDTO.getPage().getTotalPage();
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		System.out.println(str);
		HashMap<String, Object> returnMap= new HashMap<String, Object>();
		returnMap.put("navbar", str);
		//returnMap.put("totalCount", userDTO.getPage().getTotalCount());
		returnMap.put("list", list);
		JSONObject json=new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();	
	}
	//设置分页导航条，根据请求页面的URL，返回一个分页导航条数据
	@RequestMapping("/getNavBar.action")
	@ResponseBody
	public String getNavBar(@RequestParam(value="mark", defaultValue="0")int mark,HttpServletRequest request,@RequestParam(value="page", defaultValue="1")int page,String path){
		if(mark==1){
			page=pageCount;
		}
		int btnCount=5;
		String url=request.getContextPath()+path;
		return NavigationBar.NavBar(url, btnCount, page, pageCount);
	}
	/*
	 *功能:得到已经缴完本金的VIP的列表信息(分页处理)，对getMem方法的改写
	 * 目的：统一分页逻辑
	 * 作者:刘娈莎
	 * 日期：2016-5-13
	*/
	@ResponseBody
	@RequestMapping("/getInfoByPage.action")	
	public String getInfoByPage(HttpServletRequest request,UserDTO userDTO,int page2){
		//List<User> list = userDAO.getUserByPage(userDTO);
		System.out.println(userDTO);
		int newpage;
		userDTO.getPage().setCurrentPage(page2);
		newpage=page2;
		List<User> list = userDAO.getUserByPage(userDTO);
		//当删除某页最后一天记录时，要往前一页取值
		if(list.size()==0)
		{
			newpage=page2-1;
			if(newpage==0)
			{
				newpage=1;
			}
			userDTO.getPage().setCurrentPage(newpage);		
			list = userDAO.getUserByPage(userDTO);
		}
		String url=request.getContextPath()+"/thanksgiving/getInfoByPage.action";
		int btnCount=5;
		int pageCount=userDTO.getPage().getTotalPage();
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		System.out.println(str);
		HashMap<String, Object> returnMap= new HashMap<String, Object>();
		returnMap.put("navbar", str);
		//returnMap.put("totalCount", userDTO.getPage().getTotalCount());
		returnMap.put("list", list);
		JSONObject json=new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();	
	}
	/*
	*功能:得到已经缴完本金的VIP的列表信息(分页处理)
	*修改:利息四舍五入到小数点两位
	*作者:傅新顺	
	*日期:2016-4-25
	*/
	@RequestMapping("/getMem.action")
	@ResponseBody
	public List<User> getMem(@RequestParam(value="page", defaultValue="1")int page){
		List<User> list = userDAO.getInfo();
		DecimalFormat df = new DecimalFormat("#.00");
		for(int i=0; i<list.size(); i++) {
			list.get(i).member.setRestInterest(Double.parseDouble(df.format(list.get(i).member.getRestInterest())));
		}
		pageCount = Paging.pageCount(list.size(), pageSize);
		Paging<User> paging = new Paging<>();
		return paging.paging(list, pageSize, page);
	}
	/*
	 * 功能：判断是否要跳转
	 * 修改：统一方法名：
	 * 将main.action改为Direction.action
	 * 杨凯
	 * 2016-04-20
	 * 
	 * 修改：方法名改为canDell，改为判断是否显示利息交易，1表示可以显示，0表示不能显示
	 * 作者：刘娈莎
	 * 日期：2016-5-13
	 * 
	 * */
	@ResponseBody
	@RequestMapping("canDell.action")
	public String canDell(HttpServletResponse response,HttpSession session,HttpServletRequest request) throws IOException{
		if(session.getAttribute("myuser")!=null){
			User user=(User) session.getAttribute("myuser");
			Member member=user.getMember();
			if(member.isFee()&&member.getRestInterest()>0){
				session.setAttribute("rest", member.getRestInterest());
				return "1";
			}
		}		
		return "0";
	}
//=================================分割线==========================================
	
	



}
