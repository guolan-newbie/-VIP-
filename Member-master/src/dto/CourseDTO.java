package dto;

import pageinterceptor.PageParameter;

public class CourseDTO {
	private PageParameter page;
	private String num;
	private int range;


	public CourseDTO(){
		page=new PageParameter();
	}
	
	public PageParameter getPage() {
		return page;
	}
	public void setPage(PageParameter page) {
		this.page = page;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public int getRange() {
		return range;
	}
	public void setRange(int range) {
		this.range = range;
	}
	@Override
	public String toString() {
		return "CourseDTO [page=" + page + ", num=" + num + ", range=" + range + "]";
	}

	
}
