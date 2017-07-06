package dto;

import java.util.List;

import entity.Communication;
import pageinterceptor.PageParameter;

public class CommunicationDTO {
	private PageParameter page;
	public CommunicationDTO()
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
		return "CommunicationDTO [page=" + page + "]";
	}
	
}
