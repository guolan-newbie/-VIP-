package entity;



import java.util.Date;


public class Notice {
	private int id;
	private Admin admin;
	private String title;
	private String content;
	private String publishtimeStr;
	private Date publishtime;
	private Date createtime;
	private Boolean status;
	private Boolean enable;
	private Boolean settop;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Admin getAdmin() {
		return admin;
	}
	public void setAdmin(Admin admin) {
		this.admin = admin;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPublishtimeStr() {
		return publishtimeStr;
	}
	public void setPublishtimeStr(String publishtimeStr) {
		this.publishtimeStr = publishtimeStr;
	}

	public Date getPublishtime() {
		return publishtime;
	}
	public void setPublishtime(Date publishtime) {
		this.publishtime = publishtime;
	}
	
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public Boolean getStatus() {
		return status;
	}
	public void setStatus(Boolean status) {
		this.status = status;
	}
	public Boolean getEnable() {
		return enable;
	}
	public void setEnable(Boolean enable) {
		this.enable = enable;
	}
	public Boolean getSettop() {
		return settop;
	}
	public void setSettop(Boolean settop) {
		this.settop = settop;
	}

	
}
