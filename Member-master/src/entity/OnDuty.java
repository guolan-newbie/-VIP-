package entity;

import java.util.Date;

public class OnDuty {
	/**
	 * 值班数据表备注
	 * start:值班开始时间;end:值班结束时间;time:申请时间;read:审核时间;
	 * 		   提取时一律用时间戳，格式化后存放为字符串类型;
	 */
	private int id;
	private int mid;
	private Date start;
	private Date end;
	private Date time;
	private int flag;
	private Date read;
	@Override
	public String toString() {
		return "OnDuty [id=" + id + ", mid=" + mid + ", start=" + start + ", end=" + end + ", time=" + time + ", flag="
				+ flag + ", read=" + read + "]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
	public Date getStart() {
		return start;
	}
	public void setStart(Date start) {
		this.start = start;
	}
	public Date getEnd() {
		return end;
	}
	public void setEnd(Date end) {
		this.end = end;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}
	public Date getRead() {
		return read;
	}
	public void setRead(Date read) {
		this.read = read;
	}
}
