package dto;

import pageinterceptor.PageParameter;

public class PictureDTO {
	private PageParameter page;
	private int uid;
	private String school;
	
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public PictureDTO()
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
		return "PictureDTO [page=" + page + ", uid=" + uid + ", school=" + school + "]";
	}
	
}
