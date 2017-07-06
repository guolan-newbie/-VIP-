package dto;

import pageinterceptor.PageParameter;

public class InstaDTO {

	private PageParameter page;
	public InstaDTO(){
		page=new PageParameter();
	}
	public PageParameter getPage() {
		return page;
	}
	public void setPage(PageParameter page) {
		this.page = page;
	}
	@Override
	public String toString() {
		return "InstaDTO [page=" + page + "]";
	}
	
	
}
