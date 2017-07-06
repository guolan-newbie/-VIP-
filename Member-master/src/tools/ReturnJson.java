package tools;

import java.util.HashMap;

import org.json.JSONObject;

import entity.StatusCode;

/**
 * 返回JSON格式数据类
 * 
 * @author 张晓敏
 *
 */
public class ReturnJson {
	/** 返回的数据集合对象 */
	private HashMap<String, Object> returnMap = new HashMap<String, Object>();
	/** 消息状态码对象 */
	private StatusCode statusCode = null;

	/**
	 * <p>
	 * Title: getStatusCode
	 * </p>
	 * <p>
	 * Description: 获取消息状态码对象
	 * </p>
	 * 
	 * @author 张晓敏 日期： 2016年11月28日
	 *
	 * @return statusCode StatusCode 消息状态码对象
	 */
	public StatusCode getStatusCode() {
		return statusCode;
	}

	/**
	 * <p>
	 * Title: setStatusCode
	 * </p>
	 * <p>
	 * Description: 设置消息状态码对象
	 * </p>
	 * 
	 * @author 张晓敏 日期： 2016年11月28日
	 *
	 * @param statusCode
	 *            StatusCode 消息状态码对象
	 */
	public void setStatusCode(StatusCode statusCode) {
		this.statusCode = statusCode;
	}

	/**
	 * <p>
	 * Title: put
	 * </p>
	 * <p>
	 * Description: 以键值对的方式添加数据
	 * </p>
	 * 
	 * @author 张晓敏 日期： 2016年11月26日
	 *
	 * @param key
	 *            String 指定要关联的值的键
	 * @param value
	 *            Object 要与指定的键关联的值
	 */
	public void put(String key, Object value) {
		returnMap.put(key, value);
	}

	/**
	 * <p>
	 * Title: returnJson
	 * </p>
	 * <p>
	 * Description: 返回json数据
	 * </p>
	 * 
	 * @author 张晓敏 日期： 2016年11月26日
	 *
	 * @return json String 统一的数据返回形式
	 */
	public final String returnJson() {
		returnMap.put("statusCode", statusCode);
		return new JSONObject().put("returnMap", returnMap).toString();
	}
}