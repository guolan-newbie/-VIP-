package tools;

import javax.servlet.http.HttpSession;

import entity.Admin;
import entity.Experience;
import entity.User;

/**
 * 验证用户信息
 *
 * @version V1.0
 * @author 张晓敏
 *         <p>
 *         时间：
 *         </p>
 *         2017年3月23日 上午11:31:32
 *
 */
public class VerifyIdentity {
	/**
	 * 校验是否是管理员
	 *
	 * @param session
	 *            必须的参数
	 * @return 若管理员存在则返回管理员对象，否者返回null
	 * 
	 */
	public static Admin verifyAdmin(HttpSession session) {
		Admin admin = (Admin) session.getAttribute("ADMIN");
		return admin != null ? admin : null;
	}

	/**
	 * 校验是否是会员
	 *
	 * @param session
	 *            必须的参数
	 * @return 若会员存在则返回会员对象，否者返回null
	 * 
	 */
	public static User verifyUser(HttpSession session) {
		User user = (User) session.getAttribute("USER");
		return user != null ? user : null;
	}

	/**
	 * 校验是否是体验者
	 *
	 * @param session
	 *            必须的参数
	 * @return 若体验者存在则返回体验者对象，否者返回null
	 * 
	 */
	public static Experience verifyExperience(HttpSession session) {
		Experience experience = (Experience) session.getAttribute("EXPERIENCE");
		return experience != null ? experience : null;
	}

	/**
	 * 校验是否是管理员或者是会员
	 *
	 * @param session
	 *            必须的参数
	 * @return 若管理员或会员存在则返回管理员或会员对象，否者返回null
	 * 
	 */
	public static Object verifyAdminAndUser(HttpSession session) {
		Admin admin = (Admin) session.getAttribute("ADMIN");
		if (admin != null) {
			return admin;
		}
		User user = (User) session.getAttribute("USER");
		return user != null ? user : null;
	}

	/**
	 * 校验是否是管理员或者是体验者
	 *
	 * @param session
	 *            必须的参数
	 * @return 若管理员或体验者存在则返回管理员或体验者对象，否者返回null
	 * 
	 */
	public static Object verifyAdminAndExperience(HttpSession session) {
		Admin admin = (Admin) session.getAttribute("ADMIN");
		if (admin != null) {
			return admin;
		}
		Experience experience = (Experience) session.getAttribute("EXPERIENCE");
		return experience != null ? experience : null;
	}

	/**
	 * 校验是否是会员或者是体验者
	 *
	 * @param session
	 *            必须的参数
	 * @return 若会员或体验者存在则返回会员或体验者对象，否者返回null
	 * 
	 */
	public static Object verifyUserAndExperience(HttpSession session) {
		User user = (User) session.getAttribute("USER");
		if (user != null) {
			return user;
		}
		Experience experience = (Experience) session.getAttribute("EXPERIENCE");
		return experience != null ? experience : null;
	}

	/**
	 * 校验是否有用户
	 *
	 * @param session
	 *            必须的参数
	 * @return 若用户存在则对应用户对象，否者返回null
	 * 
	 */
	public static Object verifyAll(HttpSession session) {
		Admin admin = (Admin) session.getAttribute("ADMIN");
		if (admin != null) {
			return admin;
		}
		User user = (User) session.getAttribute("USER");
		if (user != null) {
			return user;
		}
		Experience experience = (Experience) session.getAttribute("EXPERIENCE");
		return experience != null ? experience : null;
	}

}
