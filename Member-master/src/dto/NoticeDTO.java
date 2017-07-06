package dto;

import java.util.Date;

import pageinterceptor.PageParameter;
/*	
 *功能:Notice类的分页参数类
 *作者:张晓敏
 *日期:2016-6-11
 *参数:
 *	page:分页必须的参数
 *	type:公告的类型
 *	front:公告最早发布时间
 *	after:公告最晚发布时间
 *	title:公告主题
*/
public class NoticeDTO {
	private PageParameter page;
	private int type;
	private Date front;
	private Date after;
	private String title;
	
	public NoticeDTO() {
		page = new PageParameter();
	}

	public PageParameter getPage() {
		return page;
	}

	public void setPage(PageParameter page) {
		this.page = page;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public Date getFront() {
		return front;
	}

	public void setFront(Date front) {
		this.front = front;
	}

	public Date getAfter() {
		return after;
	}

	public void setAfter(Date after) {
		this.after = after;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Override
	public String toString() {
		return "NoticeDTO [page=" + page + ", type=" + type + ", front=" + front + ", after=" + after + ", title="
				+ title + "]";
	}
	
}
