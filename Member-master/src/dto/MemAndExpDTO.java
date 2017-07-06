package dto;

import pageinterceptor.PageParameter;

public class MemAndExpDTO {
	private PageParameter page;
	public MemAndExpDTO()
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
		return "MemAndExpDTO [page=" + page + "]";
	}

	
}
