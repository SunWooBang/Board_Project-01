package board;
/**
* <pre>
* board 테이블의 칼럼에 대한 구현.
* </pre>
* @author sunwoo
* @since 2021.01.12
*/
public class Board {
	private int boardno;
	private String bd_title;
	private String bd_nickname;
	private String bd_content;
	private String bd_pw;
	private int bd_views;
	private String bd_files;
	private String bd_regtime;
	private String	bd_mod_time;
	
	public int getBoardno() {
		return boardno;
	}
	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}
	public String getBd_title() {
		return bd_title;
	}
	public void setBd_title(String bd_title) {
		this.bd_title = bd_title;
	}
	public String getBd_nickname() {
		return bd_nickname;
	}
	public void setBd_nickname(String bd_nickname) {
		this.bd_nickname = bd_nickname;
	}
	public String getBd_content() {
		return bd_content;
	}
	public void setBd_content(String bd_content) {
		this.bd_content = bd_content;
	}
	public String getBd_pw() {
		return bd_pw;
	}
	public void setBd_pw(String bd_pw) {
		this.bd_pw = bd_pw;
	}
	public int getBd_views() {
		return bd_views;
	}
	public void setBd_views(int bd_views) {
		this.bd_views = bd_views;
	}
	public String getBd_files() {
		return bd_files;
	}
	public void setBd_files(String bd_files) {
		this.bd_files = bd_files;
	}
	public String getBd_regtime() {
		return bd_regtime;
	}
	public void setBd_regtime(String bd_regtime) {
		this.bd_regtime = bd_regtime;
	}
	public String getBd_mod_time() {
		return bd_mod_time;
	}
	public void setBd_mod_time(String bd_mod_time) {
		this.bd_mod_time = bd_mod_time;
	}

}
