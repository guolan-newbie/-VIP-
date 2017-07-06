package entity;

import java.util.Date;

public class History {
	
	private int id;
	private Visitor visitor;
	private String ip;
	private Date VisitTime;
	private String Url;
	private boolean Agent;
	
	public boolean getAgent() {
		return Agent;
	}
	public void setAgent(Boolean agent) {
		Agent = agent;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Visitor getVisitor() {
		return visitor;
	}
	public void setVisitor(Visitor visitor) {
		this.visitor = visitor;
	}
	public Date getVisitTime() {
		return VisitTime;
	}
	public void setVisitTime(Date visitTime) {
		VisitTime = visitTime;
	}
	public String getUrl() {
		return Url;
	}
	public void setUrl(String url) {
		Url = url;
	}
}
