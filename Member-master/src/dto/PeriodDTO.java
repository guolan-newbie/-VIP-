package dto;

import pageinterceptor.PageParameter;

public class PeriodDTO {
	private PageParameter page;
	private int mid;
	public PeriodDTO(){
		page=new PageParameter();
	}
	public PageParameter getPage() {
		return page;
	}
	public void setPage(PageParameter page) {
		this.page = page;
	}
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
	
}
