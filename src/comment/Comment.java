package comment;
/**
 * <pre>
* comment 테이블의 칼럼에 대한 구현.
* </pre>
* @author sunwoo
* @since 2021.01.12
*/
public class Comment {
	private int com_no;
	private int boardno;
	private String com_nickname;
	private String com_content;
	private String com_pw;
	private String com_regtime;
	
	public int getCom_no() {
		return com_no;
	}
	public void setCom_no(int com_no) {
		this.com_no = com_no;
	}
	public int getBoardno() {
		return boardno;
	}
	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}
	public String getCom_nickname() {
		return com_nickname;
	}
	public void setCom_nickname(String com_nickname) {
		this.com_nickname = com_nickname;
	}
	public String getCom_content() {
		return com_content;
	}
	public void setCom_content(String com_content) {
		this.com_content = com_content;
	}
	public String getCom_pw() {
		return com_pw;
	}
	public void setCom_pw(String com_pw) {
		this.com_pw = com_pw;
	}
	public String getCom_regtime() {
		return com_regtime;
	}
	public void setCom_regtime(String com_regtime) {
		this.com_regtime = com_regtime;
	}
}
