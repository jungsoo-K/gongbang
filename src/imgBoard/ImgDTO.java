package imgBoard;

public class ImgDTO {
	private int imgno;
	private String name;
	private String title;
	private String content;
	private String passwd;
	private String wdate;
	private String fname;
	private int grpno;
	private int indent;
	private int ansnum;
	private int refnum;
	
	public ImgDTO() {
		super();
	}
	public ImgDTO(int imgno, String name, String title, String content, String passwd, String wdate, String fname,
			int grpno, int indent, int ansnum, int refnum) {
		super();
		this.imgno = imgno;
		this.name = name;
		this.title = title;
		this.content = content;
		this.passwd = passwd;
		this.wdate = wdate;
		this.fname = fname;
		this.grpno = grpno;
		this.indent = indent;
		this.ansnum = ansnum;
		this.refnum = refnum;
	}
	public int getImgno() {
		return imgno;
	}
	public void setImgno(int imgno) {
		this.imgno = imgno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public int getGrpno() {
		return grpno;
	}
	public void setGrpno(int grpno) {
		this.grpno = grpno;
	}
	public int getIndent() {
		return indent;
	}
	public void setIndent(int indent) {
		this.indent = indent;
	}
	public int getAnsnum() {
		return ansnum;
	}
	public void setAnsnum(int ansnum) {
		this.ansnum = ansnum;
	}
	public int getRefnum() {
		return refnum;
	}
	public void setRefnum(int refnum) {
		this.refnum = refnum;
	}
	@Override
	public String toString() {
		return "ImgDTO [imgno=" + imgno + ", name=" + name + ", title=" + title + ", content=" + content + ", passwd="
				+ passwd + ", wdate=" + wdate + ", fname=" + fname + ", grpno=" + grpno + ", indent=" + indent
				+ ", ansnum=" + ansnum + ", refnum=" + refnum + "]";
	}
	
	
}
