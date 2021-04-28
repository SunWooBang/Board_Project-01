package comment;

import java.sql.*;
import java.util.ArrayList;

/**
 * Database와 연결하여 CRUD기능 구현. 댓글에 대한 기능들
 * @author sunwoo
 * @since 2021.01.12 
 */
public class CommentDAO {
	private Connection conn; // connection:db에접근하게 해주는 객체
	private ResultSet rs;

	/**
	 * <pre>
	* DB와 연결
	* </pre>
	* @author sunwoo
	* @since 2021.01.12 
	*/
	public CommentDAO() {
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
	 * 댓글 수정, 삭제시 비밀번호 비교할 때 입력받은 비밀번호를 sha2로 암호화 하는 메소드
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.25
	 */
	public String getPw(String bd_pw) {
		String sql = "select sha2(? ,256)";
		String getPwS = "";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bd_pw);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				getPwS = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return getPwS;
	}

	/**
	 * <pre>
	 * 댓글 번호 부여 메소드
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.14
	 * @return 기존 마지막 댓글번호에 +1 한 값을 리턴
	 */
	public int getNextComment() {
		// 현재 댓글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		String sql = "select com_no from tb_comment order by com_no desc";
		int comCnt = 0;
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				comCnt = rs.getInt(1) + 1;
			} else {
				comCnt = 1;
			}
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
		return comCnt; // 데이터베이스 오류
	}

	/**
	 * <pre>
	 * 댓글 작성 메소드
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.16
	 * @param commentNo       getNextComment()를 이용해 댓글번호를 만든다.
	 * @param boardNo         댓글이 달리는 게시물의 번호
	 * @param commentNickname 댓글 작성자
	 * @param commentContent  댓글 내용
	 * @param commentPw       댓글 비밀번호
	 * @return executeUpdate()
	 */
	public int writecomment(int com_no, int boardno, String com_nickname, String com_content, String com_pw) {
		String SQL = "insert into tb_comment values(?, ?, ?, ?, sha2(? ,256), now())";
		int writeCnt = 0;
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, com_no);
			pstmt.setInt(2, boardno);
			pstmt.setString(3, com_nickname);
			pstmt.setString(4, com_content);
			pstmt.setString(5, com_pw);
			writeCnt = pstmt.executeUpdate();

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
		return writeCnt; // 데이터베이스 오류
	}
	/**
	 * <pre>
	 * 댓글 수정 메소드
	 * </pre>
	 * @author sunwoo
	 * @since 2021.02.05
	 */
	public int comModify(int com_no, String com_content) {
		String sql = "update tb_comment set com_content = ? where com_no = ?";
		int updateCnt = 0;
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, com_content);
			pstmt.setInt(2, com_no);
			updateCnt = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return updateCnt;
	}
	
	/**
	 * <pre>
	 * 댓글 목록을 출력한다.
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.16
	 * @param boardNo   댓글이 달린 게시물의 번호
	 * @param commentNo 댓글의 번호
	 * @return while문에서 설정된 comment의 객체인 cd를 return
	 */
	public ArrayList<Comment> getListcomment(int boardno, int com_no) {
		String SQL = "select * from tb_comment where com_no < ? and boardno = ?";
		ArrayList<Comment> list = new ArrayList<Comment>();
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNextComment() - (com_no - 1) * 10); // 일단 10개까지만 출력되게 만들어보자
			pstmt.setInt(2, boardno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Comment cd = new Comment();
				cd.setCom_no(rs.getInt(1));
				cd.setBoardno(rs.getInt(2));
				cd.setCom_nickname(rs.getString(3));
				cd.setCom_content(rs.getString(4));
				cd.setCom_pw(rs.getString(5));
				cd.setCom_regtime(rs.getString(6));
				list.add(cd);
			}
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
		return list;
	}
}
