package entity;

import java.util.Date;

public class OnDutyLog {
	private int id;
	private int oid;
	private int mid;
	private int cid;
	private String beHelpedName;
	private String beHelpedQQ;
	private String beHelpedInfo;
	private String qustionDescription;
	private String solutionReport;
	private boolean flag;
	private Date checkTime;
	private Date submitTime;
	private Member member;
	private OnDuty onDuty;
	private String formatStart;
	private String formatTime;
	private String formatSubmitTime;
	
	public String getFormatStart() {
		return formatStart;
	}
	public void setFormatStart(String formatStart) {
		this.formatStart = formatStart;
	}
	public String getFormatTime() {
		return formatTime;
	}
	public void setFormatTime(String formatTime) {
		this.formatTime = formatTime;
	}
	public String getFormatSubmitTime() {
		return formatSubmitTime;
	}
	public void setFormatSubmitTime(String formatSubmitTime) {
		this.formatSubmitTime = formatSubmitTime;
	}


	public OnDuty getOnDuty() {
		return onDuty;
	}
	public void setOnDuty(OnDuty onDuty) {
		this.onDuty = onDuty;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public String getBeHelpedName() {
		return beHelpedName;
	}
	public void setBeHelpedName(String beHelpedName) {
		this.beHelpedName = beHelpedName;
	}
	public String getBeHelpedQQ() {
		return beHelpedQQ;
	}
	public void setBeHelpedQQ(String beHelpedQQ) {
		this.beHelpedQQ = beHelpedQQ;
	}
	public String getBeHelpedInfo() {
		return beHelpedInfo;
	}
	public void setBeHelpedInfo(String beHelpedInfo) {
		this.beHelpedInfo = beHelpedInfo;
	}
	public String getQustionDescription() {
		return qustionDescription;
	}
	public void setQustionDescription(String qustionDescription) {
		this.qustionDescription = qustionDescription;
	}
	public String getSolutionReport() {
		return solutionReport;
	}
	public void setSolutionReport(String solutionReport) {
		this.solutionReport = solutionReport;
	}
	public boolean isFlag() {
		return flag;
	}
	public void setFlag(boolean flag) {
		this.flag = flag;
	}
	public Date getCheckTime() {
		return checkTime;
	}
	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}
	public Date getSubmitTime() {
		return submitTime;
	}
	public void setSubmitTime(Date submitTime) {
		this.submitTime = submitTime;
	}
	@Override
	public String toString() {
		return "OnDutyLog [id=" + id + ", oid=" + oid + ", mid=" + mid + ", cid=" + cid + ", beHelpedName="
				+ beHelpedName + ", beHelpedQQ=" + beHelpedQQ + ", beHelpedInfo=" + beHelpedInfo
				+ ", qustionDescription=" + qustionDescription + ", solutionReport=" + solutionReport + ", flag=" + flag
				+ ", checkTime=" + checkTime + ", submitTime=" + submitTime + ", member=" + member + ", onDuty="
				+ onDuty + ", formatStart=" + formatStart + ", formatTime=" + formatTime + ", formatSubmitTime="
				+ formatSubmitTime + "]";
	}
	
}
