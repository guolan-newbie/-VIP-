package entity;

import java.util.Date;

/**
 * @author LUFFY
 *
 */
public class Communication {
	private int id;
	private int eid;
	private int mid;
	private int aid;
	private Date time;
	private String content;
	private String formatTime;
	private Experience experience;
	private Member member;
	private Admin admin;	
	private String name;
	private String realname;
	private int cid;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRealname() {
		return realname;
	}
	public void setRealname(String realname) {
		this.realname = realname;
	}
	
	public Admin getAdmin() {
		return admin;
	}
	public void setAdmin(Admin admin) {
		this.admin = admin;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFormatTime() {
		return formatTime;
	}
	public void setFormatTime(String formatTime) {
		this.formatTime = formatTime;
	}
	public int getEid() {
		return eid;
	}
	public void setEid(int eid) {
		this.eid = eid;
	}
	
	public Experience getExperience() {
		return experience;
	}
	public void setExperience(Experience experience) {
		this.experience = experience;
	}
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}

	@Override
	public String toString() {
		return "Communication [id=" + id + ", eid=" + eid + ", mid=" + mid + ", aid=" + aid + ", time=" + time
				+ ", content=" + content + ", formatTime=" + formatTime + ", experience=" + experience + ", member="
				+ member + ", admin=" + admin + ", name=" + name + ", realname=" + realname + "]";
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}




	
}
