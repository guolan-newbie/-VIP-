package dto;

import pageinterceptor.PageParameter;

public class InterestDTO {
	private PageParameter page;
	private int mid;
	public InterestDTO(){
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
	@Override
	public String toString() {
		return "InterestDTO [page=" + page + ", mid=" + mid + "]";
	}
	
	
}
