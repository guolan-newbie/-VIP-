package entity;

import java.util.Date;

/**
 *
 * @author 张晨旭
 * @date 2017年1月2日上午11:32:58
 */
public class Social {
	private int mid;
	private int uid;
	private int pid;
	private String realname;//名字
	private String sex;//性别
	private int age;//年龄
	private String school;//学校
	private String phone;//手机号
	private String qq;//qq
	private boolean student;//是否学生
	private Date graduateDate;//毕业时间
	private boolean flag;//是否会员
	private String pname;//所在省份
	private String psname;//出生地
	

	public String getPsname() {
		return psname;
	}
	public void setPsname(String psname) {
		this.psname = psname;
	}
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getRealname() {
		return realname;
	}
	public void setRealname(String realname) {
		this.realname = realname;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
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
	public boolean isStudent() {
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
	public boolean isFlag() {
		return flag;
	}
	public void setFlag(boolean flag) {
		this.flag = flag;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	@Override
	public String toString() {
		return "Social [mid=" + mid + ", uid=" + uid + ", pid=" + pid + ", realname=" + realname + ", sex=" + sex
				+ ", age=" + age + ", school=" + school + ", phone=" + phone + ", qq=" + qq + ", student=" + student
				+ ", graduateDate=" + graduateDate + ", flag=" + flag + ", pname=" + pname + ", psname=" + psname + "]";
	}


}
