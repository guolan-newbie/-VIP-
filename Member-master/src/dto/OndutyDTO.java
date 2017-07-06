package dto;

import java.util.Map;

import pageinterceptor.PageParameter;

public class OndutyDTO {
	
	private PageParameter page;
	private String start;
	private String end;
	private String date;
	private int type;
	private int flag;
	private int mid;
	public OndutyDTO()
	{
		page=new PageParameter();
	}
	public PageParameter getPage() {
		return page;
	}
	public void setPage(PageParameter page) {
		this.page = page;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
	@Override
	public String toString() {
		return "OndutyDTO [page=" + page + ", start=" + start + ", end=" + end + ", date=" + date + ", type=" + type
				+ ", flag=" + flag + ", mid=" + mid + "]";
	}
	
	
}
