package entity;

import java.util.Date;

public class Clue {
	private int id;
	private String num;
	private String realName;
	private String sex;
	private String qq;
	private String school;
	private String diploma;
	private Date btime;
	private Date etime;
	private boolean type;
	private int aid;
	private String phone;
	private Date graduateDate;
	private String formatGraduateDate;
	private String formatBtime;
	private String formatEtime;
	private Admin admin;
	private User user;
	private int flag;
	private String exnum;
	private Experience experience;
	private int eid;
	private int counts;

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

	public String getFormatBtime() {
		return formatBtime;
	}

	public void setFormatBtime(String formatBtime) {
		this.formatBtime = formatBtime;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public String getDiploma() {
		return diploma;
	}

	public void setDiploma(String diploma) {
		this.diploma = diploma;
	}

	public Date getBtime() {
		return btime;
	}

	public void setBtime(Date btime) {
		this.btime = btime;
	}

	public Date getEtime() {
		return etime;
	}

	public void setEtime(Date etime) {
		this.etime = etime;
	}

	public boolean isType() {
		return type;
	}

	public void setType(boolean type) {
		this.type = type;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getGraduateDate() {
		return graduateDate;
	}

	public void setGraduateDate(Date graduateDate) {
		this.graduateDate = graduateDate;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public int getCounts() {
		return counts;
	}

	public void setCounts(int counts) {
		this.counts = counts;
	}

	@Override
	public String toString() {
		return "Clue [id=" + id + ", num=" + num + ", realName=" + realName + ", sex=" + sex + ", qq=" + qq
				+ ", school=" + school + ", diploma=" + diploma + ", btime=" + btime + ", etime=" + etime + ", type="
				+ type + ", aid=" + aid + ", phone=" + phone + ", graduateDate=" + graduateDate
				+ ", formatGraduateDate=" + formatGraduateDate + ", formatBtime=" + formatBtime + ", formatEtime="
				+ formatEtime + ", admin=" + admin + ", user=" + user + ", flag=" + flag + ", exnum=" + exnum
				+ ", experience=" + experience + ", eid=" + eid + ", counts=" + counts + "]";
	}

	public String getFormatGraduateDate() {
		return formatGraduateDate;
	}

	public void setFormatGraduateDate(String formatGraduateDate) {
		this.formatGraduateDate = formatGraduateDate;
	}

	public String getFormatEtime() {
		return formatEtime;
	}

	public void setFormatEtime(String formatEtime) {
		this.formatEtime = formatEtime;
	}

	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String getExnum() {
		return exnum;
	}

	public void setExnum(String exnum) {
		this.exnum = exnum;
	}

}
