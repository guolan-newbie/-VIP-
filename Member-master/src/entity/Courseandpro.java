package entity;


public class Courseandpro {
	private int id;
	private int meid;//会员或体验者id
	private int identityType;
	private int caid;//类别id
	private int chorder;//章节order
	private int corder;//课程order
	private double proportion;//完成比例
	private MemAndExp memAndExp;
	private Admin admin;
	
	public Admin getAdmin() {
		return admin;
	}
	public void setAdmin(Admin admin) {
		this.admin = admin;
	}
	public MemAndExp getMemAndExp() {
		return memAndExp;
	}
	public void setMemAndExp(MemAndExp memAndExp) {
		this.memAndExp = memAndExp;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
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
	public int getCaid() {
		return caid;
	}
	public void setCaid(int caid) {
		this.caid = caid;
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
		return "Courseandpro [id=" + id + ", meid=" + meid + ", identityType=" + identityType + ", caid=" + caid
				+ ", chorder=" + chorder + ", corder=" + corder + ", proportion=" + proportion + ", memAndExp="
				+ memAndExp + ", admin=" + admin + "]";
	}



	
}
