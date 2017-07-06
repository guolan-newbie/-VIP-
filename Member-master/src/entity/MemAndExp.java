package entity;

import java.util.List;

public class MemAndExp {
	private int id;
	private String num;
	private String name;
	private boolean summaryflag;
	private int identityType;
	private int aid;
	private Member member;
	private Experience experience;
	private Admin admin;
	private Category category;
	private Courseandpro courseandpro;
	List<StudentAndProcess> categorys;
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
	public boolean isSummaryflag() {
		return summaryflag;
	}
	public void setSummaryflag(boolean summaryflag) {
		this.summaryflag = summaryflag;
	}
	public int getIdentityType() {
		return identityType;
	}
	public void setIdentityType(int identityType) {
		this.identityType = identityType;
	}
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
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
	
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	public Courseandpro getCourseandpro() {
		return courseandpro;
	}
	public void setCourseandpro(Courseandpro courseandpro) {
		this.courseandpro = courseandpro;
	}
	
	public List<StudentAndProcess> getCategorys() {
		return categorys;
	}
	public void setCategorys(List<StudentAndProcess> categorys) {
		this.categorys = categorys;
	}
	@Override
	public String toString() {
		return "MemAndExp [id=" + id + ", num=" + num + ", name=" + name + ", summaryflag=" + summaryflag
				+ ", identityType=" + identityType + ", aid=" + aid + ", member=" + member + ", experience="
				+ experience + ", admin=" + admin + ", category=" + category + ", courseandpro=" + courseandpro
				+ ", categorys=" + categorys + "]";
	}
	
}
