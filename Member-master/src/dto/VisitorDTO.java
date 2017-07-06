package dto;

import pageinterceptor.PageParameter;

public class VisitorDTO {
	private PageParameter page;
	public VisitorDTO()
	{
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
		return "VisitorDTO [page=" + page + "]";
	}
	
}
