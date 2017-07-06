package tools;

/**
 * 统一的返回对象
 *
 * @version V1.0
 * @author 张晓敏
 *         <p>
 *         时间：
 *         </p>
 *         2017年2月16日 下午8:53:35
 *
 */
public class Result {

	/** 这个值是状态码 */
	private Integer status;

	/** 这个值是错误消息 */
	private String msg;

	/** 这个值是当前页数 */
	private Integer page;

	/** 这个值是总页数 */
	private Integer count;

	/** 这个值是数据对象 */
	private Object data;
	
	/** 这个值是总记录数*/
	private Long total;


	/**
	 * 获取状态码
	 *
	 * @return 状态码
	 * 
	 */
	public Integer getStatus() {
		return status;
	}

	/**
	 * 设置状态码
	 *
	 * @param status
	 *            Integer 状态码的值
	 * 
	 */
	public void setStatus(Integer status) {
		this.status = status;
	}

	/**
	 * 获取错误消息
	 *
	 * @return 错误消息
	 * 
	 */
	public String getMsg() {
		return msg;
	}

	/**
	 * 设置错误消息
	 *
	 * @param msg
	 *            String 错误消息
	 * 
	 */
	public void setMsg(String msg) {
		this.msg = msg;
	}

	/**
	 * 获取当前页数
	 *
	 * @return 当前页数
	 * 
	 */
	public Integer getPage() {
		return page;
	}

	/**
	 * 设置当前页数
	 *
	 * @param page
	 *            Integer 当前页数
	 * 
	 */
	public void setPage(Integer page) {
		this.page = page;
	}

	/**
	 * 获取总页数
	 *
	 * @return 总页数
	 * 
	 */
	public Integer getCount() {
		return count;
	}

	/**
	 * 设置总页数
	 *
	 * @param count
	 *            Integer 总页数
	 * 
	 */
	public void setCount(Integer count) {
		this.count = count;
	}

	/**
	 * 设置返回数据
	 *
	 * @return Object 返回数据
	 * 
	 */
	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}
	
	
	/**
	 * 
	 * @return 总记录数
	 */
	public Long getTotal() {
		return total;
	}

	public void setTotal(Long total) {
		this.total = total;
	}

	/**
	 * 默认的构造方法
	 * 
	 */
	public Result() {
	}

	/**
	 * 带返回数据的构造方法
	 * 
	 * @param data
	 *            Object 返回数据
	 */
	public Result(Object data) {
		this.status = 100;
		this.msg = "OK";
		this.data = data;
	}

	/**
	 * 自定错误消息并有返回数据的构造方法
	 * 
	 * @param status
	 *            Integer 状态码
	 * @param msg
	 *            String 错误消息
	 * @param data
	 *            Object 返回数据
	 */
	public Result(Integer status, String msg, Object data) {
		this.status = status;
		this.msg = msg;
		this.data = data;
	}

	/**
	 * 带有返回数据并有分页信息的构造方法
	 * 
	 * @param data
	 *            Object 返回数据
	 * @param page
	 *            Integer 当前页数
	 * @param count
	 *            Integer 总页数
	 */
	public Result(Object data, Integer page, Integer count) {
		this.status = 100;
		this.msg = "OK";
		this.data = data;
		this.page = page;
		this.count = count;
	}
	/**
	 * 带有返回数据和分页信息的构造方法
	 * @param data
	 * 			Object 返回数据
	 * @param page
	 * 			 Integer 当前页数
	 * @param count
	 * 			Integer 总页数
	 * @param total
	 * 			Integer 总记录数
	 */
	public Result(Object data, Integer page, Integer count,Long total) {
		this.status = 100;
		this.msg = "OK";
		this.data = data;
		this.page = page;
		this.count = count;
		this.total = total;
	}
	/**
	 * 不带返回数据的方法
	 *
	 * @return Result 统一返回对象
	 * 
	 */
	public static Result ok() {
		return new Result(null);
	}

	/**
	 * 带返回数据的方法
	 *
	 * @param data
	 *            Object 返回数据
	 * @return Result 统一返回对象
	 * 
	 */
	public static Result ok(Object data) {
		return new Result(data);
	}

	/**
	 * 带返回数据并有分页信息的方法
	 *
	 * @param data
	 *            Object 返回数据
	 * @param page
	 *            Integer 当前页数
	 * @param count
	 *            Integer 总页数
	 * @return Result 统一返回对象
	 * 
	 */
	public static Result ok(Object data, Integer page, Integer count) {
		return new Result(data, page, count);
	}
	/**
	 * 带返回数据并有分页信息的方法
	 * 
	 * @param data
	 * 			  Object 返回数据
	 * @param page
	 * 			  Integer 当前页数
	 * @param count
	 * 			  Integer 总页数
	 * @param total
	 * 			  Integer 总记录数
	 * @return    Result 统一返回对象
	 */
	public static Result ok(Object data, Integer page, Integer count,Long total){
		return new Result(data, page, count,total);
	}

	/**
	 * 自定义返回消息的方法
	 *
	 * @param status
	 *            Integer 状态码
	 * @param msg
	 *            String 错误消息
	 * @return Result 统一的返回对象
	 * 
	 */
	public static Result build(Integer status, String msg) {
		return new Result(status, msg, null);
	}

	/**
	 * 自定义返回消息带返回数据的方法
	 *
	 * @param status
	 *            Integer 状态码
	 * @param msg
	 *            String 错误消息
	 * @param data
	 *            Object 返回数据
	 * @return Result 统一的返回对象
	 * 
	 */
	public static Result build(Integer status, String msg, Object data) {
		return new Result(status, msg, data);
	}

	/**
	 * 将统一返回对象转换json
	 *
	 * @return String 返回json字符串
	 * 
	 */
	public final String toJson() {
		return JsonUtils.objectToJson(this);
	}
}
