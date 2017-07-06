package dto;

import pageinterceptor.PageParameter;

public class ClueDTO {
	private PageParameter page;
	public ClueDTO()
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
		return "ClueDTO [page=" + page + "]";
	}
	
}
