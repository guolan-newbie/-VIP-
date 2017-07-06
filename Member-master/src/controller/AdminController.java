package controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.AdminDAO;
import entity.Admin;
import entity.Summary;
import tools.MD5SaltUtils;
import tools.SummaryTitle;
import tools.VerifyIdentity;


@Controller
@RequestMapping("/admin")
public class AdminController {
	private static Logger logger = Logger.getLogger(AdminController.class);
	@Resource
	AdminDAO adminDAO;
	@ResponseBody
	@RequestMapping("/checkAdminAuthorith.action")
	public String checkAdminAuthorith(HttpSession session)
	{
		
		Admin admin=(Admin)session.getAttribute("admin");
		String authority=adminDAO.getAuthority(admin);
		//当数据库admin表中,authority字段为1时具备重设密码权限
		if(authority.equals("1"))
		{
			return "1";
		}
		else {
			return "0";
		}
	}
	/*
	 * 把审核周报的方法移去了周报模块
	 */

	@ResponseBody
	@RequestMapping("/add.action")
	public String add(HttpSession session,Admin admin)
	{
		String salt=MD5SaltUtils.randomCreateSalt();
		admin.setName(admin.getName());
		admin.setPwd(MD5SaltUtils.encode(admin.getPwd(), salt));
		admin.setSalt(salt);
		adminDAO.add(admin);
		session.setAttribute("admin", admin);
		return "null";
	}
	/*
	 * 修改：管理员登陆权限判断
	 * 日期：2016-10-09
	 * 
	 * 修改：当用户名错误时，获取权限会爆空指针
	 * 修改内容：加上try-catch，报错时返回登陆页面
	 * 作者：陈伟盛
	 * 日期：2016-10-12
	 * 
	 * 修改
	 * 内容:登陆成功返回1，否则返回0
	 * 作者：张晓敏
	 * 日期：2016-10-15
	 */
	@ResponseBody
	@RequestMapping("/check.action")
	public String check(HttpSession session,Admin admin,HttpServletRequest request) throws Exception 
	{
		String path="/user/login";
		try{			
			// 0 为有登陆权限 ，2 为没有登陆权限
			if(!adminDAO.getLoginAuthority(admin.getName()).equals("2")){
				String salt=adminDAO.getSalt(admin);
				admin.setPwd(MD5SaltUtils.encode(admin.getPwd(), salt));
				List<Admin> list=adminDAO.getValid(admin);
				session.setAttribute("TITLEDATE", SummaryTitle.getTitle());
				if(list.size()>0)
				{
					admin=list.get(0);
					//变量名用admin 第一次登陆进去，就只有用户名和密码的值，其他的都是空
					//所以加一个admin1
					session.setAttribute("admin", admin);
					session.setAttribute("admin1", admin);
					//管理员登录时将其信息保存在session中，用于页面判断是否首次登陆。
					session.setAttribute("TURE", admin);
					//session.setMaxInactiveInterval(15);
					//管理员登录时将session中会员的值删掉，防止交叉测试的时候，出现一些问题			
					session.removeAttribute("myuser");
					//项目重构需要
					session.setAttribute("ADMIN", admin);
					session.removeAttribute("USER");
					
					path="/admin/navbar1";    //sm
				}
				return "1";
			} else {
				request.setAttribute("chmod", "无登陆权限");
			}
		} catch (Exception e) {
			// TODO: handle exception
			return "0";
		}
		return "0";
	}
	/*
	*作者:左琪
	*作用:周报评论时管理员session过期后重新登录
	*最后修改:2016-05-10
	*/
	@ResponseBody
	@RequestMapping("/adminlayerLogin.action")
	public String adminlayerLogin(HttpSession session,Admin admin) throws Exception 
	{
		String salt=adminDAO.getSalt(admin);
		admin.setPwd(MD5SaltUtils.encode(admin.getPwd(), salt));
		List<Admin> list=adminDAO.getValid(admin);
		session.setAttribute("TITLEDATE", SummaryTitle.getTitle());
		if(list.size()>0)
		{
			admin=list.get(0);
			//变量名用admin 第一次登陆进去，就只有用户名和密码的值，其他的都是空
			//所以加一个admin1
			session.setAttribute("admin", admin);
			session.setAttribute("admin1", admin);
			//管理员登录时将其信息保存在session中，用于页面判断是否首次登陆。
			session.setAttribute("TURE", admin);
			
			//管理员登录时将session中会员的值删掉，防止交叉测试的时候，出现一些问题			
			session.removeAttribute("myuser");
			return "1";    
		}
		return "0";
		
	}
	/*
	 * 功能：获取所有管理员信息
	 * 作者:刘娈莎
	 * 日期:2016-05-16
	*/
	@ResponseBody
	@RequestMapping("/getAll.action")
	public List<Admin> getAll(HttpSession session) throws Exception 
	{
		List<Admin> list=adminDAO.getAll();
		return list;
	}
	//============================分割线==================================
	/*
	 * 作者:张晓敏
	 * 作用:检查管理员session是否过期
	 * 日期:2016-07-15
	 */
	@ResponseBody
	@RequestMapping("/checkAdminSession.action")
	public String checkAdminSession(HttpSession session)
	{
		if(VerifyIdentity.verifyAdmin(session)!=null) {
			return "1";
		}
		return "0";
	}
	
	//==============================分割线=====================================
	/*
	*功能:检查密码是否正确，正确直接修改并返回信息，否则直接返回信息
	*作者:陈伟盛
	*日期:2016-10-09
	*/
	@ResponseBody
	@RequestMapping("/checkAndModify")
	public String checkAndModify(HttpSession session,Admin admin,String oldPwd)
	{
		String flag="1";//1代表检查不合格
		Admin adminInfo = (Admin) session.getAttribute("admin");
		oldPwd = MD5SaltUtils.encode(oldPwd, adminInfo.getSalt());
		if(oldPwd.equals(adminInfo.getPwd()))
		{
			flag="2";
			String salt=MD5SaltUtils.randomCreateSalt();
			admin.setPwd(MD5SaltUtils.encode(admin.getPwd(), salt));
			admin.setSalt(salt);
			admin.setId(adminInfo.getId());
			adminDAO.modifyPwd(admin);
		}
		
		return flag;		
	}
	
	/*
	*功能:获取除了超级管理员外的所有管理员
	*作者:陈伟盛
	*日期:2016-10-09
	*/
	@ResponseBody
	@RequestMapping("/getAllAdmin")
	public String getAllAdmin(HttpSession session)
	{
		List<Admin> list = adminDAO.getAllAdmin((Admin)session.getAttribute("admin"));
		StringBuffer str = new StringBuffer();
		int size = list.size();
		for(int i=0; i<size; i++ )
		{
			Admin admin = list.get(i);
			str.append("<tr><td>");
			str.append(i+1);
			str.append("</td>");
			str.append("<td>");
			str.append(admin.getName());
			str.append("</td>");
			str.append("<td>");
			str.append(admin.getRealname());
			//权限单元格设置
			str.append("</td>");
			str.append("<td><span lang=\"");
			str.append(admin.getId()+"?"+admin.getAuthority());
			// 0 为有登陆权限 ，2 为没有登陆权限
			if(admin.getAuthority().equals("0")){
				str.append("\" class=\"chmod label label-success radius\">有");
			}
			else {
				str.append("\" class=\"chmod label label-danger radius\">无");
			}
			str.append("</span></td></tr>");
		}
		return str.toString();
	}
	/*
	*功能:修改管理员登陆权限
	*作者:陈伟盛
	*日期:2016-10-09
	*/
	@ResponseBody
	@RequestMapping("/chmod")
	public String chmod(Admin admin)
	{
		if(admin.getAuthority().equals("0")){
			admin.setAuthority("2");
		}
		else {
			admin.setAuthority("0");
		}
		adminDAO.modifyAuthority(admin);
		return admin.getAuthority();
	}
	//==============================================================================================
	
	@ResponseBody
	@RequestMapping("/getWorkAdmin")
	public List<Admin> getWorkAdmin() {
		List<Admin> list = adminDAO.getWorkAdmin();
		return list;
	}
}
