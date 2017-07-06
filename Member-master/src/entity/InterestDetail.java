package entity;

import java.util.Date;;

/**
 * @author Administrator
 *
 */
public class InterestDetail {
	private float i_amount;
	private float i_money;
	private float a_amount;
	private Date a_date;
	private Date p_duetime;
	private float p_amount;
	private int mid;
	public float getI_amount() {
		return i_amount;
	}
	public void setI_amount(float i_amount) {
		this.i_amount = i_amount;
	}
	public float getA_amount() {
		return a_amount;
	}
	public float getI_money() {
		return i_money;
	}
	public void setI_money(float i_money) {
		this.i_money = i_money;
	}
	public void setA_amount(float a_amount) {
		this.a_amount = a_amount;
	}
	
	public Date getA_date() {
		return a_date;
	}
	public void setA_date(Date a_date) {
		this.a_date = a_date;
	}
	public Date getP_duetime() {
		return p_duetime;
	}
	public void setP_duetime(Date p_duetime) {
		this.p_duetime = p_duetime;
	}
	public float getP_amount() {
		return p_amount;
	}
	public void setP_amount(float p_amount) {
		this.p_amount = p_amount;
	}
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
	@Override
	public String toString() {
		return "InterestDetail [i_amount=" + i_amount + ", i_money=" + i_money + ", a_amount=" + a_amount + ", a_date="
				+ a_date + ", p_duetime=" + p_duetime + ", p_amount=" + p_amount + ", mid=" + mid + "]";
	}
}
