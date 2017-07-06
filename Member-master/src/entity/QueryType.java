package entity;
/*
 * 作者:张中强
 * 最后修改日期:2015-11-15
 * 功能:查询不同范围(未审核的、已审核费用未交清的、费用已交清的,
 * 指定用户编号的)的会员时, * 需要用这个枚举类型来区分用户范围。
 * type表示不同范围的用户。
 * type=0表示提取所有数据
 * type=1表示提取指定id为指定no的数据
 * type=2表示提取所有需要审核的数据
 * type=3表示提取所有未缴清费用的数据
 * type=4表示已审核的数据
 * 修改：添加
 * type=5表示提取所有已缴清费用的数据
 */
public class QueryType {
	private int type;
	private int no;
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
}
