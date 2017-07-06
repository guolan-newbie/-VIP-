package entity;

import java.util.List;

public class CourseInfo {
	private int id;
	private int uid;	
	private String uname;
	private String realname;
	private String sex;
	private String school;
	private String ctitle;
	private int cpid;
	private int cid;
	private String finish;
	private String chapter;
	private List<Member> member;
	private List<Course> course;
	private List<Courseandpro> courseandpro;
	private List<CourseInfo> courseinfo;
	private User user;
	
	public String getChapter() {
		return chapter;
	}
	public void setChapter(String chapter) {
		this.chapter = chapter;
	}
	public String getFinish() {
		return finish;
	}
	public void setFinish(String finish) {
		this.finish = finish;
	}
	public List<Member> getMember() {
		return member;
	}
	public void setMember(List<Member> member) {
		this.member = member;
	}
	public String getRealname() {
		return realname;
	}
	public void setRealname(String realname) {
		this.realname = realname;
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
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public List<Course> getCourse() {
		return course;
	}
	public void setCourse(List<Course> course) {
		this.course = course;
	}
	public List<Courseandpro> getCourseandpro() {
		return courseandpro;
	}
	public void setCourseandpro(List<Courseandpro> courseandpro) {
		this.courseandpro = courseandpro;
	}
	public List<CourseInfo> getCourseinfo() {
		return courseinfo;
	}
	public void setCourseinfo(List<CourseInfo> courseinfo) {
		this.courseinfo = courseinfo;
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
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getCtitle() {
		return ctitle;
	}
	public void setCtitle(String ctitle) {
		this.ctitle = ctitle;
	}
	public int getCpid() {
		return cpid;
	}
	public void setCpid(int cpid) {
		this.cpid = cpid;
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	
}
