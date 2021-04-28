package files;

import java.sql.*;
import java.util.ArrayList;


public class FileDAO {
	private Connection conn;
	private ResultSet rs;

	/**
	 * <pre>
	 * 게시판 생성자 메소드
	 * </pre>
	 * 
	 * @author 방선우
	 * @since 2021.01.20
	 */
	public FileDAO() {
		// 생성자를 만들어준다.
		try {
			String dbURL = "jdbc:mariadb://127.0.0.1:3306/board";
			String dbID = "bang";
			String dbPassword = "8535";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * <pre>
	 * 업로드를 진행하는 함수
	 * <pre>
	 * @author sunwoo
	 * @since 2021.02.01
	 */
	public int upload(int file_no, int boardno, String bd_filename) {
		String SQL = "insert into tb_file values (?, ?, ?)";
		PreparedStatement pstmt = null;
		int uploadCnt = 0;

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, file_no);
			pstmt.setInt(2, boardno);
			pstmt.setString(3, bd_filename);
			uploadCnt = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return uploadCnt;
	}
	
	/**
	 * <pre>
	 * 해당 board번호에 따른 파일 이름 출력
	 * </pre>
	 * @author sunwoo
	 * @since 2021.02.01
	 */
	public ArrayList<Files> getFiles(int boardno){
		String SQL ="select bd_filename from tb_file where boardno = ?";
		ArrayList<Files> list = new ArrayList<Files>();
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Files fi = new Files();
				fi.setBe_filename(rs.getString(1));
				list.add(fi);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch(SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
}