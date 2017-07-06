package entity;

/**
 * @author Administrator
 *
 */
public class Interest {
	private int id;
	private Period period;
	private AccountLog accountLog;
	private float money;
	private float amount;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Period getPeriod() {
		return period;
	}
	public void setPeriod(Period period) {
		this.period = period;
	}
	public AccountLog getAccountLog() {
		return accountLog;
	}
	public void setAccountLog(AccountLog accountLog) {
		this.accountLog = accountLog;
	}
	public float getMoney() {
		return money;
	}
	public void setMoney(float money) {
		this.money = money;
	}
	public float getAmount() {
		return amount;
	}
	public void setAmount(float amount) {
		this.amount = amount;
	}
	@Override
	public String toString() {
		return "Interest [id=" + id + ", period=" + period + ", accountLog=" + accountLog + ", money=" + money
				+ ", amount=" + amount + "]";
	}
}
