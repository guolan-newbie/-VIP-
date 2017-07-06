package entity;

public class OnDutyApply {
	private int oid;
	private String time;

	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	@Override
	public String toString() {
		return "OnDutyApply [oid=" + oid + ", time=" + time + "]";
	}

	

}
