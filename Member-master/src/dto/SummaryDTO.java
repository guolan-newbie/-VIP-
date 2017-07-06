package dto;

import pageinterceptor.PageParameter;

public class SummaryDTO {
	private PageParameter page;//这个是实现mybatis物理分页必须要传的一个参数
	
	private String cnum;    //获取当前周报的会员编号
	
	private int id;//会员或体验者id
	private String ownerType;//周报所属人状态：my自己的；others表示查询其他人；all表示查询所有人；
	private String checkType; //审核状态：checked已审核；nonchecked未审核；all全部；
	private String weekType;//周数状态：previous上一周；current本周；next下一周；all全部；
	private String title;//如果weektype不是all的话，需要这个参数来提取数据。
	private String identityType;//身份标识 member为会员 experience为体验者。
	private int assistant;//小助手id 0为全部，其他为指定小助手
	
	public int getAssistant() {
		return assistant;
	}
	public void setAssistant(int assistant) {
		this.assistant = assistant;
	}
	public SummaryDTO()
	{
		page=new PageParameter();
	}
	public PageParameter getPage() {
		return page;
	}
	public void setPage(PageParameter page) {
		this.page = page;
	}
	public String getCheckType() {
		return checkType;
	}
	public void setCheckType(String checkType) {
		this.checkType = checkType;
	}
	public String getWeekType() {
		return weekType;
	}
	public void setWeekType(String weekType) {
		this.weekType = weekType;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getOwnerType() {
		return ownerType;
	}
	public void setOwnerType(String ownerType) {
		this.ownerType = ownerType;
	}
	
	public String getIdentityType() {
		return identityType;
	}
	public void setIdentityType(String identityType) {
		this.identityType = identityType;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCnum() {
		return cnum;
	}
	public void setCnum(String cnum) {
		this.cnum = cnum;
	}
	@Override
	public String toString() {
		return "SummaryDTO [page=" + page + ", cnum=" + cnum + ", id=" + id + ", ownerType=" + ownerType
				+ ", checkType=" + checkType + ", weekType=" + weekType + ", title=" + title + ", identityType="
				+ identityType + ", assistant=" + assistant + "]";
	}
	
	
}
