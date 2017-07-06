package entity;

//查看周报所需的视图对应的实体类
public class LookSummary {
	private int sid;	//周报id
	private String title;	//周报标题
	private String content;	//周报内容（这个好像没有什么用，不过已经生成了，就不删了）
	private int ischeckval;	//是否已审核
	private String time;	//周报提交时间
	private int id;	//会员或体验者id
	private String num;	//会员或体验者账号
	private String name;	//会员或体验者姓名
	private int aid;	//会员或体验者学习小助手
	private boolean summaryflag;	//是否需要提交周报 true 需要，false不需要
	private boolean identityType;	//身份标识 true 会员 false 体验者
	private String arealname;	//管理员真实姓名

	public String getArealname() {
		return arealname;
	}
	public void setArealname(String arealname) {
		this.arealname = arealname;
	}
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
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
	public int getIscheckval() {
		return ischeckval;
	}
	public void setIscheckval(int ischeckval) {
		this.ischeckval = ischeckval;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public boolean isSummaryflag() {
		return summaryflag;
	}
	public void setSummaryflag(boolean summaryflag) {
		this.summaryflag = summaryflag;
	}
	public boolean isIdentityType() {
		return identityType;
	}
	public void setIdentityType(boolean identityType) {
		this.identityType = identityType;
	}
	@Override
	public String toString() {
		return "LookSummary [sid=" + sid + ", title=" + title + ", content=" + content + ", ischeckval=" + ischeckval
				+ ", time=" + time + ", id=" + id + ", num=" + num + ", name=" + name + ", aid=" + aid
				+ ", summaryflag=" + summaryflag + ", identityType=" + identityType + ", arealname=" + arealname + "]";
	}

	
}
