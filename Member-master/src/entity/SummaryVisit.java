package entity;

public class SummaryVisit {
	private int id;
	private int sid;
	private int flag;
	private String name;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
	}
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public String toString() {
		return "SummaryVisit [id=" + id + ", sid=" + sid + ", flag=" + flag + ", name=" + name + "]";
	}
	
}
