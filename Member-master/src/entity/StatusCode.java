package entity;

/**
 * 状态码类
 * 
 * @author 刘娈莎 日期： 2016年11月20日
 */
public class StatusCode {
	/** 消息状态码 */
	private int errNum;
	/** 消息状态信息 */
	private String errMsg;

	public StatusCode() {
		super();
	}

	public StatusCode(int errNum, String errMsg) {
		super();
		this.errNum = errNum;
		this.errMsg = errMsg;
	}

	public int getErrNum() {
		return errNum;
	}

	public void setErrNum(int errNum) {
		this.errNum = errNum;
	}

	public String getErrMsg() {
		return errMsg;
	}

	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}

	@Override
	public String toString() {
		return "StatusCode [errNum=" + errNum + ", errMsg=" + errMsg + "]";
	}

}
