package dto;

import java.util.Date;

public class CostDTO {
	/** 会员编号 */
	private String no;
	/** 会员member的id */
	private Integer mid;
	/** 会员user的id */
	private Integer uid;
	/** 会员姓名 */
	private String name;
	/** 学校 */
	private String school;
	/** 联系电话 */
	private String mobile;
	/** qq号码 */
	private String qq;
	/** 小助手名字 */
	private String aname;
	/** 未审核缴费条数 */
	private int alog;
	/** 剩余本金 */
	private double restAmount;
	/** 剩余利息 */
	private double restInterest;
	/** 逾期金额 */
	private double unpaidAmount;
	/** 最后缴费日期 */
	private Date finalPaymentDate;
	/** 协议缴费日期(XX号) */
	private Date agreementPaymentDate;

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public Integer getMid() {
		return mid;
	}

	public void setMid(Integer mid) {
		this.mid = mid;
	}

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getAname() {
		return aname;
	}

	public void setAname(String aname) {
		this.aname = aname;
	}

	public int getAlog() {
		return alog;
	}

	public void setAlog(int alog) {
		this.alog = alog;
	}

	public double getRestAmount() {
		return restAmount;
	}

	public void setRestAmount(double restAmount) {
		this.restAmount = restAmount;
	}

	public double getRestInterest() {
		return restInterest;
	}

	public void setRestInterest(double restInterest) {
		this.restInterest = restInterest;
	}

	public double getUnpaidAmount() {
		return unpaidAmount;
	}

	public void setUnpaidAmount(double unpaidAmount) {
		this.unpaidAmount = unpaidAmount;
	}

	public Date getFinalPaymentDate() {
		return finalPaymentDate;
	}

	public void setFinalPaymentDate(Date finalPaymentDate) {
		this.finalPaymentDate = finalPaymentDate;
	}

	public Date getAgreementPaymentDate() {
		return agreementPaymentDate;
	}

	public void setAgreementPaymentDate(Date agreementPaymentDate) {
		this.agreementPaymentDate = agreementPaymentDate;
	}

	@Override
	public String toString() {
		return "CostDTO [no=" + no + ", mid=" + mid + ", name=" + name + ", school=" + school + ", mobile=" + mobile
				+ ", qq=" + qq + ", aname=" + aname + ", alog=" + alog + ", restAmount=" + restAmount
				+ ", restInterest=" + restInterest + ", unpaidAmount=" + unpaidAmount + ", finalPaymentDate="
				+ finalPaymentDate + ", agreementPaymentDate=" + agreementPaymentDate + "]";
	}

}
