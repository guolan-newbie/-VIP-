package entity;

import java.util.Date;

public class User {
	private int id;
	private String pwd;
	public Member member;
	public UserInfo userInfo;
	private Picture picture;
	private Date time;
	private String name;
	private String salt;
	private Admin admin;
	private Date noticeTime;
	private String finish;
	private AccountLog accountLog;
	private int root;//0表示通过 1表示未填写信用信息 2表示未填写个人信息和信用信息
	private double first;//第一个月交多少钱
	private double monthly;//之后每月交多少钱
	private double sum;//总共要交多少钱
	private int allMonth;//总共要交多少月
	private int delayMonth;//延期交费多少月
	private double last;
	private Experience experience;
	
	

	public int getDelayMonth() {
		return delayMonth;
	}




	public void setDelayMonth(int delayMonth) {
		this.delayMonth = delayMonth;
	}




	public int getId() {
		return id;
	}




	public void setId(int id) {
		this.id = id;
	}




	public String getPwd() {
		return pwd;
	}




	public void setPwd(String pwd) {
		this.pwd = pwd;
	}




	public Member getMember() {
		return member;
	}




	public void setMember(Member member) {
		this.member = member;
	}




	public UserInfo getUserInfo() {
		return userInfo;
	}




	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}




	public Picture getPicture() {
		return picture;
	}




	public void setPicture(Picture picture) {
		this.picture = picture;
	}




	public Date getTime() {
		return time;
	}




	public void setTime(Date time) {
		this.time = time;
	}




	public String getName() {
		return name;
	}




	public void setName(String name) {
		this.name = name;
	}




	public String getSalt() {
		return salt;
	}




	public void setSalt(String salt) {
		this.salt = salt;
	}




	public Admin getAdmin() {
		return admin;
	}




	public void setAdmin(Admin admin) {
		this.admin = admin;
	}




	public Date getNoticeTime() {
		return noticeTime;
	}




	public void setNoticeTime(Date noticeTime) {
		this.noticeTime = noticeTime;
	}




	public String getFinish() {
		return finish;
	}




	public void setFinish(String finish) {
		this.finish = finish;
	}




	public AccountLog getAccountLog() {
		return accountLog;
	}




	public void setAccountLog(AccountLog accountLog) {
		this.accountLog = accountLog;
	}




	public int getRoot() {
		return root;
	}




	public void setRoot(int root) {
		this.root = root;
	}




	public double getFirst() {
		return first;
	}




	public void setFirst(double first) {
		this.first = first;
	}




	public double getMonthly() {
		return monthly;
	}




	public void setMonthly(double monthly) {
		this.monthly = monthly;
	}




	public double getSum() {
		return sum;
	}




	public void setSum(double sum) {
		this.sum = sum;
	}





	public int getAllMonth() {
		return allMonth;
	}




	public void setAllMonth(int allMonth) {
		this.allMonth = allMonth;
	}




	public double getLast() {
		return last;
	}




	public void setLast(double last) {
		this.last = last;
	}




	public Experience getExperience() {
		return experience;
	}




	public void setExperience(Experience experience) {
		this.experience = experience;
	}




	@Override
	public String toString() {
		return "User [id=" + id + ", pwd=" + pwd + ", member=" + member + ", userInfo=" + userInfo + ", picture="
				+ picture + ", time=" + time + ", name=" + name + ", salt=" + salt + ", admin=" + admin
				+ ", noticeTime=" + noticeTime + ", finish=" + finish + ", accountLog=" + accountLog + ", root=" + root
				+ ", first=" + first + ", monthly=" + monthly + ", sum=" + sum + ", experience=" + experience + "]";
	}



}
