package entity;

/**
 * 
 * @Title ExcelEntity
 * @Desription 前端table整合类
 * @author 熊杰
 */
public class ExcelEntity {
	private String month;
	
	private String time;
	
	private String mpay;
	
	private String interest;
	
	private String capital;
	
	private String numInterest;

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}
	
	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}
	
	public String getMpay() {
		return mpay;
	}

	public void setMpay(String mpay) {
		this.mpay = mpay;
	}

	public String getInterest() {
		return interest;
	}

	public void setInterest(String interest) {
		this.interest = interest;
	}

	public String getCapital() {
		return capital;
	}

	public void setCapital(String capital) {
		this.capital = capital;
	}

	public String getNumInterest() {
		return numInterest;
	}

	public void setNumInterest(String numInterest) {
		this.numInterest = numInterest;
	}

	@Override
	public String toString() {
		return "ExcelEntity [month=" + month + ", time=" + time + ", mpay=" + mpay + ", interest=" + interest
				+ ", capital=" + capital + ", numInterest=" + numInterest + "]";
	}

	
}
