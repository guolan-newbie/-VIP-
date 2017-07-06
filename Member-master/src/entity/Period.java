package entity;

import java.util.Date;

public class Period {
	private int id;
	private Member member;
	private Date duetime;
	private float amount;
	private float restAmount;
	private String formateDuetime;
	private float minterest;
	private float total;
	
	
	public float getTotal() {
		return total;
	}

	public void setTotal(float total) {
		this.total = total;
	}

	public float getMinterest() {
		return minterest;
	}

	public void setMinterest(float minterest) {
		this.minterest = minterest;
	}

	public String getFormateDuetime() {
		return formateDuetime;
	}

	public void setFormateDuetime(String formateDuetime) {
		this.formateDuetime = formateDuetime;
	}

	public Period() {
		super();
	}
	
	public Period(Date duetime, float amount,float restAmount) {
		super();
		this.duetime = duetime;
		this.amount = amount;
		this.restAmount=restAmount;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public Date getDuetime() {
		return duetime;
	}
	public void setDuetime(Date duetime) {
		this.duetime = duetime;
	}
	public float getAmount() {
		return amount;
	}
	public void setAmount(float amount) {
		this.amount = amount;
	}
	public float getRestAmount() {
		return restAmount;
	}
	public void setRestAmount(float restAmount) {
		this.restAmount = restAmount;
	}
	@Override
	public String toString() {
		return "Period [id=" + id + ", member=" + member + ", duetime=" + duetime + ", amount=" + amount
				+ ", restAmount=" + restAmount + "]";
	}	
}
