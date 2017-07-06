package entity;

import java.util.Date;

public class Experience {
	private int id;
	private String num;
	private String password;
	private String salt;
	private String name;
	private String sex;
	private String phone;
	private boolean student;
	private String school;
	private String company;
	private Date graduateDate;
	private String province;
	private Date begintime;
	private Date endtime;
	private int aid;
	private int flag;
	// private boolean pre_vip;
	private String memo;
	private String formatGraduateDate;
	private String formatBegintime;
	private String formatEndtime;
	private Date noticeTime;
	private Admin admin;
	private Member member;
	private User user;
	private int seat_provid;
	private String qq;
	private int clueid;
	private Period period;

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public int getSeat_provid() {
		return seat_provid;
	}

	public void setSeat_provid(int seat_provid) {
		this.seat_provid = seat_provid;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	private boolean summaryflag;

	public boolean isSummaryflag() {
		return summaryflag;
	}

	public void setSummaryflag(boolean summaryflag) {
		this.summaryflag = summaryflag;
	}

	public String getFormatGraduateDate() {
		return formatGraduateDate;
	}

	public void setFormatGraduateDate(String formatGraduateDate) {
		this.formatGraduateDate = formatGraduateDate;
	}

	public String getFormatBegintime() {
		return formatBegintime;
	}

	public void setFormatBegintime(String formatBegintime) {
		this.formatBegintime = formatBegintime;
	}

	public String getFormatEndtime() {
		return formatEndtime;
	}

	public void setFormatEndtime(String formatEndtime) {
		this.formatEndtime = formatEndtime;
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

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public boolean isStudent() {
		return student;
	}

	public void setStudent(boolean student) {
		this.student = student;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public Date getBegintime() {
		return begintime;
	}

	public void setBegintime(Date begintime) {
		this.begintime = begintime;
	}

	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public Date getGraduateDate() {
		return graduateDate;
	}

	public void setGraduateDate(Date graduateDate) {
		this.graduateDate = graduateDate;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getNoticeTime() {
		return noticeTime;
	}

	public void setNoticeTime(Date noticeTime) {
		this.noticeTime = noticeTime;
	}

	public Period getPeriod() {
		return period;
	}

	public void setPeriod(Period period) {
		this.period = period;
	}

	@Override
	public String toString() {
		return "Experience [id=" + id + ", num=" + num + ", password=" + password + ", salt=" + salt + ", name=" + name
				+ ", sex=" + sex + ", phone=" + phone + ", student=" + student + ", school=" + school + ", company="
				+ company + ", graduateDate=" + graduateDate + ", province=" + province + ", begintime=" + begintime
				+ ", endtime=" + endtime + ", aid=" + aid + ", flag=" + flag + ", memo=" + memo
				+ ", formatGraduateDate=" + formatGraduateDate + ", formatBegintime=" + formatBegintime
				+ ", formatEndtime=" + formatEndtime + ", noticeTime=" + noticeTime + ", admin=" + admin + ", member="
				+ member + ", user=" + user + ", seat_provid=" + seat_provid + ", qq=" + qq + ", clueid=" + clueid
				+ ", period=" + period + ", summaryflag=" + summaryflag + "]";
	}

	public int getClueid() {
		return clueid;
	}

	public void setClueid(int clueid) {
		this.clueid = clueid;
	}

}
