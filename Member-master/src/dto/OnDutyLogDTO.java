package dto;



import pageinterceptor.PageParameter;

public class OnDutyLogDTO {
	private PageParameter page;
	private int id; 
	public OnDutyLogDTO()
	{
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
	
}
