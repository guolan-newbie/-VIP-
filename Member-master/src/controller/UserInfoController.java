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

import dao.UserInfoDAO;
import entity.User;
import entity.UserInfo;


@Controller
@RequestMapping("/userinfo")
public class UserInfoController {
	private static Logger logger = Logger.getLogger(UserInfoController.class);
	@Resource
    UserInfoDAO userInfoDAO;
	
	/*
	 * 功能:获取信用信息
	 * 作者:刘娈莎
	 * 日期:2016-09-07
	 */
	@ResponseBody
	@RequestMapping("/getUserInfoByUid.action")
	public UserInfo getUserInfoByUid(HttpServletRequest request,HttpSession session,int uid){
		return userInfoDAO.getUserInfoByUid(uid);

	}
	/*
	 * 功能:修改信用信息
	 * 作者:刘娈莎
	 * 日期:2016-09-07
	 */
	@ResponseBody
	@RequestMapping("/updateUserInfo.action")
	public String updateUserInfo(HttpSession session,UserInfo userInfo)
	{
			userInfoDAO.update(userInfo);
			return null;
	}
	
}
