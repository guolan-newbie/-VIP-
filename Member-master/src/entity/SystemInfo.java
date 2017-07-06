package entity;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

public class SystemInfo {
	private Date time;
	private String formateTime;
	private String ip;
	private int port;
	private String browser;
	private String systemUserName;
	private String sessionId;
	public SystemInfo(){
		this.time=new Date();
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.formateTime=df.format(this.time);
	}
	public SystemInfo(HttpServletRequest request){
		this.time=new Date();
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.formateTime=df.format(this.time);
		this.ip=request.getRemoteAddr();
		this.port=request.getRemotePort();
		this.browser=request.getHeader("user-agent");
		this.systemUserName=request.getRemoteHost();
		this.sessionId=request.getSession().getId();

	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getFormateTime() {
		return formateTime;
	}
	public void setFormateTime(String formateTime) {
		this.formateTime = formateTime;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getPort() {
		return port;
	}
	public void setPort(int port) {
		this.port = port;
	}
	public String getBrowser() {
		return browser;
	}
	public void setBrowser(String browser) {
		this.browser = browser;
	}
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public String getSystemUserName() {
		return systemUserName;
	}
	public void setSystemUserName(String systemUserName) {
		this.systemUserName = systemUserName;
	}
	@Override
	public String toString() {
		return "SystemInfo [time=" + time + ", formateTime=" + formateTime + ", ip=" + ip + ", port=" + port
				+ ", browser=" + browser + ", systemUserName=" + systemUserName + ", sessionId=" + sessionId + "]";
	}

	
}
