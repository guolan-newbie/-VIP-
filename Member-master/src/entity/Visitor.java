package entity;

import java.util.Date;


public class Visitor {
	private int id;
	private int meid;
	private int identityType;
	private Date VisitTime;
	private Date LeftTime;
	private String ip;
	private boolean agent;
	private String formatVisitTime;
	private String formatLeftTime;
	private MemAndExp memAndExp;
	
	public String getFormatVisitTime() {
		return formatVisitTime;
	}
	public void setFormatVisitTime(String formatVisitTime) {
		this.formatVisitTime = formatVisitTime;
	}
	public String getFormatLeftTime() {
		return formatLeftTime;
	}
	public void setFormatLeftTime(String formatLeftTime) {
		this.formatLeftTime = formatLeftTime;
	}
	public boolean getAgent() {
		return agent;
	}
	public void setAgent(Boolean agent) {
		this.agent = agent;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getVisitTime() {
		return VisitTime;
	}
	public void setVisitTime(Date visitTime) {
		VisitTime = visitTime;
	}
	public Date getLeftTime() {
		return LeftTime;
	}
	public void setLeftTime(Date leftTime) {
		LeftTime = leftTime;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getMeid() {
		return meid;
	}
	public void setMeid(int meid) {
		this.meid = meid;
	}
	public void setAgent(boolean agent) {
		this.agent = agent;
	}
	
	public int getIdentityType() {
		return identityType;
	}
	public void setIdentityType(int identityType) {
		this.identityType = identityType;
	}
	
	public MemAndExp getMemAndExp() {
		return memAndExp;
	}
	public void setMemAndExp(MemAndExp memAndExp) {
		this.memAndExp = memAndExp;
	}
	@Override
	public String toString() {
		return "Visitor [id=" + id + ", meid=" + meid + ", identityType=" + identityType + ", VisitTime=" + VisitTime
				+ ", LeftTime=" + LeftTime + ", ip=" + ip + ", agent=" + agent + ", formatVisitTime=" + formatVisitTime
				+ ", formatLeftTime=" + formatLeftTime + ", memAndExp=" + memAndExp + "]";
	}



}
