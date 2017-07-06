package tools;

import javax.servlet.http.HttpSession;

import entity.Admin;
import entity.Experience;
import entity.StatusCode;
import entity.User;

/**
 * 用户认证类
 * 
 * @author 张晓敏
 *
 */
public class Authentication {
	/**
	 * <p>
	 * Title: checkOK
	 * </p>
	 * <p>
	 * Description:返回成功的消息状态码
	 * </p>
	 * 
	 * @author 张晓敏 日期： 2016年11月21日
	 *
	 * @param statusCode
	 *            StatusCode 消息状态码对象
	 * @return statusCode StatusCode 消息状态码对象
	 */
	public static final StatusCode checkOK(StatusCode statusCode) {
		statusCode.setErrNum(100);
		statusCode.setErrMsg("OK");
		return statusCode;
	}

	/**
	 * <p>
	 * Title: checkAdmin
	 * </p>
	 * <p>
	 * Description:检查是否是管理员
	 * </p>
	 * 
	 * @author 张晓敏 日期： 2016年11月21日
	 *
	 * @param session
	 *            HttpSession
	 * @return statusCode StatusCode 消息状态码对象
	 */
	public static final StatusCode checkAdmin(HttpSession session) {
		StatusCode statusCode = new StatusCode();
		Admin admin = (Admin) session.getAttribute("ADMIN");
		if (admin == null) {
			statusCode.setErrNum(201);
			statusCode.setErrMsg("不是管理员!");
		} else {
			statusCode = checkOK(statusCode);
		}
		return statusCode;
	}

	/**
	 * <p>
	 * Title: checkUser
	 * </p>
	 * <p>
	 * Description:检查是否是会员
	 * </p>
	 * 
	 * @author 张晓敏 日期： 2016年11月21日
	 *
	 * @param session
	 *            HttpSession
	 * @return statusCode StatusCode 消息状态码对象
	 */
	public static final StatusCode checkUser(HttpSession session) {
		StatusCode statusCode = new StatusCode();
		User user = (User) session.getAttribute("USER");
		if (user == null) {
			statusCode.setErrNum(202);
			statusCode.setErrMsg("不是会员!");
		} else {
			statusCode = checkOK(statusCode);
		}
		return statusCode;
	}

	/**
	 * <p>
	 * Title: checkExperience
	 * </p>
	 * <p>
	 * Description:检查是否是体验者
	 * </p>
	 * 
	 * @author 张晓敏 日期： 2016年11月21日
	 *
	 * @param session
	 *            HttpSession
	 * @return statusCode StatusCode 消息状态码对象
	 */
	public static final StatusCode checkExperience(HttpSession session) {
		StatusCode statusCode = new StatusCode();
		Experience experience = (Experience) session.getAttribute("EXPERIENCE");
		if (experience == null) {
			statusCode.setErrNum(203);
			statusCode.setErrMsg("不是体验者!");
		} else {
			statusCode = checkOK(statusCode);
		}
		return statusCode;
	}

	/**
	 * <p>
	 * Title: checkAdminAndUser
	 * </p>
	 * <p>
	 * Description:检查是否是管理员或者会员
	 * </p>
	 * 
	 * @author 张晓敏 日期： 2016年11月21日
	 *
	 * @param session
	 *            HttpSession
	 * @return statusCode StatusCode 消息状态码对象
	 */
	public static final StatusCode checkAdminAndUser(HttpSession session) {
		StatusCode statusCode = new StatusCode();
		Admin admin = (Admin) session.getAttribute("ADMIN");
		User user = (User) session.getAttribute("USER");
		if (admin == null && user == null) {
			statusCode.setErrNum(200);
			statusCode.setErrMsg("不是合法用户!");
		} else {
			statusCode = checkOK(statusCode);
		}
		return statusCode;
	}

	/**
	 * <p>
	 * Title: checkAdminAndExperience
	 * </p>
	 * <p>
	 * Description:检查是否是管理员或者体验者
	 * </p>
	 * 
	 * @author 张晓敏 日期： 2016年11月21日
	 *
	 * @param session
	 *            HttpSession
	 * @return statusCode StatusCode 消息状态码对象
	 */
	public static final StatusCode checkAdminAndExperience(HttpSession session) {
		StatusCode statusCode = new StatusCode();
		Admin admin = (Admin) session.getAttribute("ADMIN");
		Experience experience = (Experience) session.getAttribute("EXPERIENCE");
		if (admin == null && experience == null) {
			statusCode.setErrNum(200);
			statusCode.setErrMsg("不是合法用户!");
		} else {
			statusCode = checkOK(statusCode);
		}
		return statusCode;
	}

	/**
	 * <p>
	 * Title: checkUserAndExperience
	 * </p>
	 * <p>
	 * Description:检查是否是会员或者体验者
	 * </p>
	 * 
	 * @author 张晓敏 日期： 2016年11月21日
	 *
	 * @param session
	 *            HttpSession
	 * @return statusCode StatusCode 消息状态码对象
	 */
	public static final StatusCode checkUserAndExperience(HttpSession session) {
		StatusCode statusCode = new StatusCode();
		User user = (User) session.getAttribute("USER");
		Experience experience = (Experience) session.getAttribute("EXPERIENCE");
		if (user == null && experience == null) {
			statusCode.setErrNum(200);
			statusCode.setErrMsg("不是合法用户!");
		} else {
			statusCode = checkOK(statusCode);
		}
		return statusCode;
	}

	/**
	 * <p>
	 * Title: checkAll
	 * </p>
	 * <p>
	 * Description:检查是否是合法用户
	 * </p>
	 * 
	 * @author 张晓敏 日期： 2016年11月21日
	 *
	 * @param session
	 *            HttpSession
	 * @return statusCode StatusCode 消息状态码对象
	 */
	public static final StatusCode checkAll(HttpSession session) {
		StatusCode statusCode = new StatusCode();
		Admin admin = (Admin) session.getAttribute("ADMIN");
		User user = (User) session.getAttribute("USER");
		Experience experience = (Experience) session.getAttribute("EXPERIENCE");
		if (admin == null && user == null && experience == null) {
			statusCode.setErrNum(200);
			statusCode.setErrMsg("不是合法用户!");
		} else {
			statusCode = checkOK(statusCode);
		}
		return statusCode;
	}

}
