package dto;

import pageinterceptor.PageParameter;

public class ThanksGivingDTO {
	private PageParameter page;
	public ThanksGivingDTO()
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
		return "ThanksGivingDTO [page=" + page + "]";
	}
	
}
