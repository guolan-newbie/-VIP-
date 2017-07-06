package entity;

import java.util.Date;
import java.util.List;

/**
 * @author Administrator
 *
 */
public class Member {
	private int id;
	private int uid;
	private int aid;
	private int eid;
	private User user;
	private String name;
	private String sex;
	private String school;
	private String company;
	private String mobile;
	private boolean student;
	private Date graduateDate;
	private Date time;
	private boolean flag;
	private boolean abnormal;
	private int alog;
	private double restAmount;
	private double restInterest;
	private boolean fee;
	private int provid;
	private List<OnDutyLog> logs;
	private Admin admin;
	private String formatTime;
	private String formatGraduateDate;
	private Experience experience;
	private boolean summaryflag;
	private UserInfo userInfo;
	private int age;
	private int seat_provid;
	private String provname;
	private String seat_provname;
	private int periodStatus;
	private Period period;

	public int getPeriodStatus() {
		return periodStatus;
	}

	public void setPeriodStatus(int periodStatus) {
		this.periodStatus = periodStatus;
	}

	public String getProvname() {
		return provname;
	}

	public void setProvname(String provname) {
		this.provname = provname;
	}

	public String getSeat_provname() {
		return seat_provname;
	}

	public void setSeat_provname(String seat_provname) {
		this.seat_provname = seat_provname;
	}

	public int getSeat_provid() {
		return seat_provid;
	}

	public void setSeat_provid(int seat_provid) {
		this.seat_provid = seat_provid;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public boolean isSummaryflag() {
		return summaryflag;
	}

	public void setSummaryflag(boolean summaryflag) {
		this.summaryflag = summaryflag;
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

	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public String getFormatGraduateDate() {
		return formatGraduateDate;
	}

	public void setFormatGraduateDate(String formatGraduateDate) {
		this.formatGraduateDate = formatGraduateDate;
	}

	public String getFormatTime() {
		return formatTime;
	}

	public void setFormatTime(String formatTime) {
		this.formatTime = formatTime;
	}

	public List<OnDutyLog> getLogs() {
		return logs;
	}

	public void setLogs(List<OnDutyLog> logs) {
		this.logs = logs;
	}

	private Province province;

	public Province getProvince() {
		return province;
	}

	public void setProvince(Province province) {
		this.province = province;
	}

	public int getProvid() {
		return provid;
	}

	public void setProvid(int provid) {
		this.provid = provid;
	}

	private List<Summary> summary;

	public List<Summary> getSummary() {
		return summary;
	}

	public void setSummary(List<Summary> summary) {
		this.summary = summary;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public boolean getStudent() {
		return student;
	}

	public void setStudent(boolean student) {
		this.student = student;
	}

	public Date getGraduateDate() {
		return graduateDate;
	}

	public void setGraduateDate(Date graduateDate) {
		this.graduateDate = graduateDate;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(java.util.Date time) {
		this.time = time;
	}

	public boolean isFlag() {
		return flag;
	}

	public void setFlag(boolean flag) {
		this.flag = flag;
	}

	public boolean isAbnormal() {
		return abnormal;
	}

	public void setAbnormal(boolean abnormal) {
		this.abnormal = abnormal;
	}

	public int getAlog() {
		return alog;
	}

	public void setAlog(int alog) {
		this.alog = alog;
	}

	public double getRestAmount() {
		return restAmount;
	}

	public double getRestInterest() {
		return restInterest;
	}

	public void setRestInterest(double restInterest) {
		this.restInterest = restInterest;
	}

	public void setRestAmount(double restAmount) {
		this.restAmount = restAmount;
	}

	public boolean isFee() {
		return fee;
	}

	public void setFee(boolean fee) {
		this.fee = fee;
	}

	public Period getPeriod() {
		return period;
	}

	public void setPeriod(Period period) {
		this.period = period;
	}

	@Override
	public String toString() {
		return "Member [id=" + id + ", uid=" + uid + ", aid=" + aid + ", eid=" + eid + ", user=" + user + ", name="
				+ name + ", sex=" + sex + ", school=" + school + ", company=" + company + ", mobile=" + mobile
				+ ", student=" + student + ", graduateDate=" + graduateDate + ", time=" + time + ", flag=" + flag
				+ ", abnormal=" + abnormal + ", alog=" + alog + ", restAmount=" + restAmount + ", restInterest="
				+ restInterest + ", fee=" + fee + ", provid=" + provid + ", logs=" + logs + ", admin=" + admin
				+ ", formatTime=" + formatTime + ", formatGraduateDate=" + formatGraduateDate + ", experience="
				+ experience + ", summaryflag=" + summaryflag + ", userInfo=" + userInfo + ", age=" + age
				+ ", seat_provid=" + seat_provid + ", provname=" + provname + ", seat_provname=" + seat_provname
				+ ", periodStatus=" + periodStatus + ", period=" + period + ", province=" + province + ", summary="
				+ summary + "]";
	}

}
