package entity;

import java.util.List;

/**
 * 分期结果pojo
 * @author xiaochaozi
 *
 */
public class PeriodsResult {

	private List<Period> periods;
	private float totalamount;
	private float firstamount;
	private float interest;
	private float monthpay;
	private float amount;
	private float interests;
	private Member member;
	private Boolean status;
	
	public Boolean getStatus() {
		return status;
	}
	public void setStatus(Boolean status) {
		this.status = status;
	}
	public List<Period> getPeriods() {
		return periods;
	}
	public void setPeriods(List<Period> periods) {
		this.periods = periods;
	}
	public float getTotalamount() {
		return totalamount;
	}
	public void setTotalamount(float totalamount) {
		this.totalamount = totalamount;
	}
	public float getFirstamount() {
		return firstamount;
	}
	public void setFirstamount(float firstamount) {
		this.firstamount = firstamount;
	}
	public float getInterest() {
		return interest;
	}
	public void setInterest(float interest) {
		this.interest = interest;
	}
	public float getMonthpay() {
		return monthpay;
	}
	public void setMonthpay(float monthpay) {
		this.monthpay = monthpay;
	}
	public float getAmount() {
		return amount;
	}
	public void setAmount(float amount) {
		this.amount = amount;
	}
	public float getInterests() {
		return interests;
	}
	public void setInterests(float interests) {
		this.interests = interests;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	

}
