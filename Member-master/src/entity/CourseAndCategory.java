package entity;

public class CourseAndCategory {
	private int caid;//类别id
	private int cid;//章节id
	private int order;//顺序
	public int getCaid() {
		return caid;
	}
	public void setCaid(int caid) {
		this.caid = caid;
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	
	public int getOrder() {
		return order;
	}
	public void setOrder(int order) {
		this.order = order;
	}
	@Override
	public String toString() {
		return "CourseAndCategory [caid=" + caid + ", cid=" + cid + ", order=" + order + "]";
	}
	
}
