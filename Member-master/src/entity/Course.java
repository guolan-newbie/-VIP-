package entity;


import java.util.List;

public class Course {
	private int id;	
	private String title;
	private int chid;//章节号
	private boolean optional_flag;//是否为选修课
	private int order;//顺序号
	private String chtitle;
	private String caid;
	private String catitle;
	private List<String> categoryTitles;
	
	
	private CourseAndCategory courseAndCategory;
	private List<Member> member;
	private List<Courseandpro> courseandpro;
	private List<CourseInfo> courseinfo;
	




	public String getChtitle() {
		return chtitle;
	}
	public void setChtitle(String chtitle) {
		this.chtitle = chtitle;
	}

	public String getCaid() {
		return caid;
	}
	public void setCaid(String caid) {
		this.caid = caid;
	}
	public String getCatitle() {
		return catitle;
	}
	public void setCatitle(String catitle) {
		this.catitle = catitle;
	}
	public int getChid() {
		return chid;
	}
	public void setChid(int chid) {
		this.chid = chid;
	}
	public boolean isOptional_flag() {
		return optional_flag;
	}
	public void setOptional_flag(boolean optional_flag) {
		this.optional_flag = optional_flag;
	}
	public int getOrder() {
		return order;
	}
	public void setOrder(int order) {
		this.order = order;
	}
	public List<CourseInfo> getCourseinfo() {
		return courseinfo;
	}
	public void setCourseinfo(List<CourseInfo> courseinfo) {
		this.courseinfo = courseinfo;
	}
	public List<Member> getMember() {
		return member;
	}
	public void setMember(List<Member> member) {
		this.member = member;
	}
	public List<Courseandpro> getCourseandpro() {
		return courseandpro;
	}
	public void setCourseandpro(List<Courseandpro> courseandpro) {
		this.courseandpro = courseandpro;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public CourseAndCategory getCourseAndCategory() {
		return courseAndCategory;
	}
	public void setCourseAndCategory(CourseAndCategory courseAndCategory) {
		this.courseAndCategory = courseAndCategory;
	}
	
	public List<String> getCategoryTitles() {
		return categoryTitles;
	}
	public void setCategoryTitles(List<String> categoryTitles) {
		this.categoryTitles = categoryTitles;
	}
	@Override
	public String toString() {
		return "Course [id=" + id + ", title=" + title + ", chid=" + chid + ", optional_flag=" + optional_flag
				+ ", order=" + order + ", chtitle=" + chtitle + ", caid=" + caid + ", catitle=" + catitle
				+ ", categoryTitles=" + categoryTitles + ", courseAndCategory=" + courseAndCategory + ", member="
				+ member + ", courseandpro=" + courseandpro + ", courseinfo=" + courseinfo + "]";
	}






	
}
