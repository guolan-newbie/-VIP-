package dto;

import pageinterceptor.PageParameter;

public class CourseandproDTO {
	private PageParameter page;
	private int meid;
	private int identityType;
	private int caid;
	private double proportion;
	private int range;
	public CourseandproDTO()
	{
		page=new PageParameter();
	}
	public PageParameter getPage() {
		return page;
	}
	public void setPage(PageParameter page) {
		this.page = page;
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
	public double getProportion() {
		return proportion;
	}
	public void setProportion(double proportion) {
		this.proportion = proportion;
	}
	public int getRange() {
		return range;
	}
	public void setRange(int range) {
		this.range = range;
	}
	@Override
	public String toString() {
		return "CourseandproDTO [page=" + page + ", meid=" + meid + ", identityType=" + identityType + ", caid=" + caid
				+ ", proportion=" + proportion + ", range=" + range + "]";
	}
	
}
