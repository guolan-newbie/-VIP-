package entity;

public class ThanksGiving {
	private int id;
	private int mgid;
	private int mrid;
	private int money;
	private String gname;
	private String rname;
	private String time;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getMgid() {
		return mgid;
	}
	public void setMgid(int mgid) {
		this.mgid = mgid;
	}
	public int getMrid() {
		return mrid;
	}
	public void setMrid(int mrid) {
		this.mrid = mrid;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getGname() {
		return gname;
	}
	public void setGname(String gname) {
		this.gname = gname;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public int getMoney() {
		return money;
	}
	public void setMoney(int money) {
		this.money = money;
	}
	@Override
	public String toString() {
		return "ThanksGiving [id=" + id + ", mgid=" + mgid + ", mrid=" + mrid + ", money=" + money + ", gname=" + gname
				+ ", rname=" + rname + ", time=" + time + "]";
	}
}
