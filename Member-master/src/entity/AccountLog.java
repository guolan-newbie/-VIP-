package entity;

import java.util.Date;
public class AccountLog {
	private int id;
	private Member member;
	private float amount;
	private Date date;
	private boolean flag;
	private String formatDate;
	private byte[] photo;
	private String type;
	private int fileflag;
	private int upflag;
	private User user;
	private int rid;
	private Admin admin;
	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	public int getRid() {
		return rid;
	}

	public void setRid(int rid) {
		this.rid = rid;
	}

	public int getUpflag() {
		return upflag;
	}

	public void setUpflag(int upflag) {
		this.upflag = upflag;
	}

	public int getFileflag() {
		return fileflag;
	}

	public void setFileflag(int fileflag) {
		this.fileflag = fileflag;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public byte[] getPhoto() {
		return photo;
	}

	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}

	public String getFormatDate() {
		return formatDate;
	}

	public void setFormatDate(String formatDate) {
		this.formatDate = formatDate;
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

	public float getAmount() {
		return amount;
	}

	public void setAmount(float amount) {
		this.amount = amount;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public boolean isFlag() {
		return flag;
	}

	public void setFlag(boolean flag) {
		this.flag = flag;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "AccountLog [id=" + id + ", member=" + member + ", amount=" + amount + ", date=" + date + ", flag="
				+ flag + ", formatDate=" + formatDate + ", photo=" + photo + ", type=" + type
				+ ", fileflag=" + fileflag + ", upflag=" + upflag + "]";
	}
}
