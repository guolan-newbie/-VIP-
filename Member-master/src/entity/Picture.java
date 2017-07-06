package entity;

import java.util.Arrays;
import java.util.Date;
public class Picture {
	private int id;
	private int uid;
	private byte[]  Photo;
	private String title;
	private Date time;
	private boolean flag;
	private boolean cover;
	private User user;
	private Member member;
	private boolean share;
	private String url;
	private String photoString;
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public boolean isShare() {
		return share;
	}
	public void setShare(boolean share) {
		this.share = share;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public byte[] getPhoto() {
		return Photo;
	}
	public void setPhoto(byte[] photo) {
		Photo = photo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public boolean isFlag() {
		return flag;
	}
	public void setFlag(boolean flag) {
		this.flag = flag;
	}
	public boolean isCover() {
		return cover;
	}
	public void setCover(boolean cover) {
		this.cover = cover;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public String getPhotoString() {
		return photoString;
	}
	public void setPhotoString(String photoString) {
		this.photoString = photoString;
	}
	@Override
	public String toString() {
		return "Picture [id=" + id + ", uid=" + uid + ", Photo=" + Arrays.toString(Photo) + ", title=" + title
				+ ", time=" + time + ", flag=" + flag + ", cover=" + cover + ", user=" + user + ", member=" + member
				+ ", share=" + share + ", url=" + url + ", photoString=" + photoString + "]";
	}
	
}
