package dto;

import java.util.Date;
import java.util.Map;

import pageinterceptor.PageParameter;
/*	
 *功能:Social类的分页参数类
 *作者:王温迪
 *日期:2016-8-13
 *参数:
 *	page:分页必须的参数
 *	sql1:设置传过来的sql条件语句
 *	sql1:设置传过来的sql条件语句
*/
public class SocialDTO {
	private PageParameter page;
	private String sql1;
	private String sql2;

	


	public String getSql1() {
		return sql1;
	}

	public void setSql1(String membersql) {
		this.sql1 = membersql;
	}

	public String getSql2() {
		return sql2;
	}

	public void setSql2(String experiencesql) {
		this.sql2 = experiencesql;
	}

	public SocialDTO() {
		page = new PageParameter();
	}

	public PageParameter getPage() {
		return page;
	}

	public void setPage(PageParameter page) {
		this.page = page;
	}

	@Override
	public String toString() {
		return "SocialDTO [page=" + page + "]";
	}

	
}
