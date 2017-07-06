package entity;

public class StudentAndProcess {
	private int meid;
	private int identityType;
	private String num;
	private String name;
	private int aid;
	private int capid;//courseandpro id
	private int caid;//类别id
	private String title;
	private int chorder;//章节order
	private int corder;//课程order
	private double proportion;//完成比例
	public int getMeid() {
		return meid;
	}
	public void setMeid(int meid) {
		this.meid = meid;
	}
	public int getIdentityType() {
		return identityType;
	}
	public void setIdentityType(int identityType) {
		this.identityType = identityType;
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
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public int getCapid() {
		return capid;
	}
	public void setCapid(int capid) {
		this.capid = capid;
	}
	public int getCaid() {
		return caid;
	}
	public void setCaid(int caid) {
		this.caid = caid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getChorder() {
		return chorder;
	}
	public void setChorder(int chorder) {
		this.chorder = chorder;
	}
	public int getCorder() {
		return corder;
	}
	public void setCorder(int corder) {
		this.corder = corder;
	}
	public double getProportion() {
		return proportion;
	}
	public void setProportion(double proportion) {
		this.proportion = proportion;
	}
	@Override
	public String toString() {
		return "StudentAndProcess [meid=" + meid + ", identityType=" + identityType + ", num=" + num + ", name=" + name
				+ ", aid=" + aid + ", capid=" + capid + ", caid=" + caid + ", title=" + title + ", chorder=" + chorder
				+ ", corder=" + corder + ", proportion=" + proportion + "]";
	}
	
	
	
	
}
