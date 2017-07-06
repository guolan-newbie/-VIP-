package dto;

import pageinterceptor.PageParameter;
/*
 * type=0表示提取所有数据
 * type=1表示提取指定id为指定no的数据
 * type=2表示提取所有需要审核的数据
 * type=3表示提取所有需要缴费的数据
 * type=4表示已审核的数据
 * type=5提取缴清费用的数据(不包含利息)
 * type=6表示提取未审核的缴费数据
 * 
 * no:会员id
 */
public class UserDTO {
	private PageParameter page;
	private int type;
	private int no;
	public UserDTO()
	{
		page=new PageParameter();
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public PageParameter getPage() {
		return page;
	}
	public void setPage(PageParameter page) {
		this.page = page;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	@Override
	public String toString() {
		return "UserDTO [page=" + page + ", type=" + type + ", no=" + no + "]";
	}
	
	
}
