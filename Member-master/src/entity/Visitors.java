package entity;

import java.util.Date;


public class Visitors {
	private int id;
	public User user;
	private Date VisitTime;
	private Date LeftTime;
	private String ip;
	private String comfrom;
	public Member member;
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
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
	public String getComfrom() {
		return comfrom;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public void setComfrom(String comfrom) {
		this.comfrom = comfrom;
	}
	@Override
	public String toString() {
		return "Visitors [id=" + id + ", VisitTime=" + VisitTime + ", LeftTime=" + LeftTime + ", ip="
				+ ip + ", comfrom=" + comfrom + ", member=" + member + "]";
	}
}
