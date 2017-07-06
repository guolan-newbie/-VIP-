package dto;


import pageinterceptor.PageParameter;

public class SchoolDTO {
	private PageParameter page;
	public SchoolDTO()
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
		return "SchoolDTO [page=" + page + "]";
	}
	
}
