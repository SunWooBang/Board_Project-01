package files;

/**
 * <pre>
 * File DB의 DTO
 * </pre>
 * @author sunwoo
 * @since 2021.02.03
 */
public class Files {
	private int boardno;
	private int file_no;
	private String bd_filename;

	public int getBoardno() {
		return boardno;
	}

	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}

	public String getBe_filename() {
		return bd_filename;
	}

	public void setBe_filename(String be_filename) {
		this.bd_filename = be_filename;
	}

	public int getFile_no() {
		return file_no;
	}

	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	
}
