package dto;

import pageinterceptor.PageParameter;

public class ExperienceDTO {
	private PageParameter page;
	private int flag;

	public ExperienceDTO() {
		page = new PageParameter();
	}

	public PageParameter getPage() {
		return page;
	}

	public void setPage(PageParameter page) {
		this.page = page;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	@Override
	public String toString() {
		return "ExperienceDTO [page=" + page + ", flag=" + flag + "]";
	}

}
