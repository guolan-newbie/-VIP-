package dto;

import pageinterceptor.PageParameter;

public class AccountLogDTO {
	private PageParameter page;
	private int id;
	private int mid;
	public AccountLogDTO(){
		page=new PageParameter();
	}
	public PageParameter getPage() {
		return page;
	}
	public void setPage(PageParameter page) {
		this.page = page;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
	@Override
	public String toString() {
		return "AccountLogDTO [page=" + page + ", id=" + id + ", mid=" + mid + "]";
	} 
	
	
	

}
