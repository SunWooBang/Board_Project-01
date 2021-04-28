package board;
import java.sql.*;
import java.util.ArrayList;


/**
 * <pre>
 * Database와 연결하여 CRUD기능 구현. 게시글에 대한 기능들.
 * </pre>
 * @author sunwoo
 * @since 2021.01.12
 */
public class BoardDAO {
	
	private Connection conn;
	private ResultSet rs;
	String resource = "../properties/db.properties";
	
	/**
	 * <pre>
	 * 게시판 생성자 메소드
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.20
	 */
	public BoardDAO(){
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
	 * 게시글 번호를 부여한다. 중요한 메소드.
	 * </pre>
	 * 
	 * @author sunwoo
	 * @since @since 2021.01.12
	 * @return 마지막 게시글 번호를 구해서 +1한 값을 리턴
	 */
	public int getNext() {
		// 현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		String sql = "select boardno from tb_board order by boardno desc";
		int getNextCnt = 0;
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				getNextCnt = rs.getInt(1) + 1;
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
		return getNextCnt;
	}
	
	/**
	 * <pre>
	 * 등록된 게시글의 게시글번호를 구하는 메소드. 파일 입력시 사용.
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.29
	 */
	public int getBoardno2(){
		String sql = "select boardno from tb_board order by boardno desc limit 1";
		int getBoardnoCnt = 0;
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				getBoardnoCnt = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return getBoardnoCnt;
	}

	/**
	 * <pre>
	 * 글 수정, 삭제시 비밀번호 비교할 때 입력받은 비밀번호를 sha2로 암호화 하는 메소드
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.25
	 */
	public String getPw(String bd_pw) {
		String sql = "select sha2(? ,256)";
		String getPwS = null;
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
	 * 게시글을 작성하는 메소드
	 * </pre>
	 * 
	 * @author sunwoo
	 * @since 2020.01.14
	 * @param boardno  getNext()를 통해 게시글의 번호를 구한다.
	 * @param title    게시글 제목
	 * @param nickname 게시글 작성자
	 * @param content  게시글 내용
	 * @param pw       게시글 비밀번호
	 * @param views    게시글 조회수
	 * @param files    게시글 첨부파일
	 * @return
	 */
	public int write(int boardno, String bd_title, String bd_nickname, String bd_content, String bd_pw, int bd_views, String bd_regtime,
			String bd_mod_time) {
		PreparedStatement pstmt = null;
		int insertCnt = 0;
		String SQL = "insert into tb_board values(?, ?, ?, ?, sha2(? ,256), ?, now(), now())";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardno);
			pstmt.setString(2, bd_title);
			pstmt.setString(3, bd_nickname);
			pstmt.setString(4, bd_content);
			pstmt.setString(5, bd_pw);
			pstmt.setInt(6, bd_views);
			insertCnt = pstmt.executeUpdate();

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
		return insertCnt;
	}

	/**
	 * <pre>
	 * 게시글을 수정하는 메소드. 게시글 쓰기와 거의 유사하나 게시글 번호를 부여하지 않는다.
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.13
	 * @param boardno  게시물 번호를 통해 어떤 게시글을 업데이트 할 것인지 식별
	 * @param title    게시글 제목
	 * @param nickname 게시글작성인
	 * @param content  게시글 내용
	 * @return update한 값을 executeUpdate()로 DB에 반영
	 */
	public int update(int boardno, String bd_title, String bd_nickname, String bd_content) {
		String sql = "update tb_board set bd_title = ?, bd_nickname = ? , bd_content = ?, bd_mod_time = now() where boardno = ?";
		int updateCnt = 0;
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bd_title);
			pstmt.setString(2, bd_nickname);
			pstmt.setString(3, bd_content);
			pstmt.setInt(4, boardno);
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
	 * 게시글의 목록을 구한다.
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.13
	 * @param pageNumber 페이지의 수와 등차수열을 이용해 출력
	 * @return while문에서 list에 담은 값을 리턴
	 */
	public ArrayList<Board> getList(int pageNumber) {
		String SQL = "select * from tb_board where boardno < ? order by boardno desc limit 10";
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Board bd = new Board();
				bd.setBoardno(rs.getInt(1));
				bd.setBd_title(rs.getString(2));
				bd.setBd_nickname(rs.getString(3));
				bd.setBd_content(rs.getString(4));
				bd.setBd_pw(rs.getString(5));
				bd.setBd_views(rs.getInt(6));
				bd.setBd_regtime(rs.getString(8));
				list.add(bd);
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
		return list;
	}

	/**
	 * <pre>
	 * 게시글의 전체 목록을 구한다.
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.27
	 */
	public ArrayList<Board> getAllList() {
		String SQL = "select * from tb_board";
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Board bd = new Board();
				bd.setBoardno(rs.getInt(1));
				bd.setBd_title(rs.getString(2));
				bd.setBd_nickname(rs.getString(3));
				bd.setBd_content(rs.getString(4));
				bd.setBd_pw(rs.getString(5));
				bd.setBd_views(rs.getInt(6));
				bd.setBd_regtime(rs.getString(8));
				list.add(bd);
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
		return list;
	}

	/**
	 * <pre>
	 * 페이징처리 메소드. 등차수열을 이용해서 10개 단위로 배열한다.
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.15
	 * @param pageNumber 등차수열의 페이지 번호 쪽에 들어가는 변수
	 * @return 1혹은 0의 값이 리턴된다.
	 */
	public int nextPage(int pageNumber) {
		String sql = "select * from tb_board where bd_regtime < ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); // 10개씩 출력해보겠다.
			rs = pstmt.executeQuery();
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
		return 1;
	}

	/**
	 * <pre>
	 * 조회수 증가 메소드
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.18
	 * @param boardno 해당 게시글 번호가 있는 행의 views에 +1을 한다.
	 * @return views+1의 값
	 */
	public int getViews(int boardno) {
		String sql = "update tb_board set bd_views = bd_views+1 WHERE boardno = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardno);
			pstmt.executeUpdate();
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
		return -1; // 데이터베이스 오류
	}

	/**
	 * <pre>
	 * 하나의 게시글을 보는 메소드
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.14
	 * @param boardno 게시글 번호를 통해 볼 게시글을 식별한다.
	 * @return Board의 객체인 bd를 return한다.
	 */
	public Board getBoard(int boardno) {
		String sql = "select * from tb_board where boardno = ?";
		Board getBoardCnt = null;
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardno);
			getViews(boardno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Board bd = new Board();
				bd.setBoardno(rs.getInt(1));
				bd.setBd_title(rs.getString(2));
				bd.setBd_nickname(rs.getString(3));
				bd.setBd_content(rs.getString(4));
				bd.setBd_pw(rs.getString(5));
				bd.setBd_views(rs.getInt(6));
				bd.setBd_regtime(rs.getString(7));
				bd.setBd_mod_time(rs.getString(8));
				getBoardCnt = bd;
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
		return getBoardCnt;
	}

	/**
	 * <pre>
	 * 게시글 제목으로 검색 메소드
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.17
	 */
	public ArrayList<Board> getSearchedTitle(String searchWord, int pageNumber) {
		String SQL = "select * from tb_board where bd_title like concat('%', ?, '%') and boardno < ? order by boardno desc limit 10";
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, searchWord);
			pstmt.setInt(2, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Board bd = new Board();
				bd.setBoardno(rs.getInt(1));
				bd.setBd_title(rs.getString(2));
				bd.setBd_nickname(rs.getString(3));
				bd.setBd_content(rs.getString(4));
				bd.setBd_pw(rs.getString(5));
				bd.setBd_views(rs.getInt(6));
				bd.setBd_regtime(rs.getString(7));
				bd.setBd_mod_time(rs.getString(8));
				list.add(bd);
			}
		} catch (Exception e) {
			System.out.println("Exception:search");
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
		System.out.println(" resultset_return list:search");
		return list;
	}

	/**
	 * <pre>
	 * 게시자 닉네임으로 검색 메소드
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.25
	 */
	public ArrayList<Board> getSearchedNick(String searchWord, int pageNumber) {
		String SQL = "select * from tb_board where bd_nickname like concat('%', ?, '%') and boardno < ? order by boardno desc limit 10";
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, searchWord);
			pstmt.setInt(2, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Board bd = new Board();
				bd.setBoardno(rs.getInt(1));
				bd.setBd_title(rs.getString(2));
				bd.setBd_nickname(rs.getString(3));
				bd.setBd_content(rs.getString(4));
				bd.setBd_pw(rs.getString(5));
				bd.setBd_views(rs.getInt(6));
				bd.setBd_regtime(rs.getString(7));
				bd.setBd_mod_time(rs.getString(8));
				list.add(bd);
			}
		} catch (Exception e) {
			System.out.println("Exception:search");
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
		System.out.println(" resultset_return list:search");
		return list;
	}

	/**
	 * <pre>
	 * 게시글 제목 및 내용으로 검색 메소드
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.25
	 */
	public ArrayList<Board> getSearchedCom(String searchWord, int pageNumber) {
		String SQL = "select * from tb_board where bd_title or bd_content like concat('%', ?, '%') and boardno < ? order by boardno desc limit 10";
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, searchWord);
			pstmt.setInt(2, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Board bd = new Board();
				bd.setBoardno(rs.getInt(1));
				bd.setBd_title(rs.getString(2));
				bd.setBd_nickname(rs.getString(3));
				bd.setBd_content(rs.getString(4));
				bd.setBd_pw(rs.getString(5));
				bd.setBd_views(rs.getInt(6));
				bd.setBd_regtime(rs.getString(7));
				bd.setBd_mod_time(rs.getString(8));
				list.add(bd);
			}
		} catch (Exception e) {
			System.out.println("Exception:search");
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
		System.out.println(" resultset_return list:search");
		return list;
	}

	/**
	 * <pre>
	 * 제목 검색결과 수를 출력하는 메소드
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.20
	 * @param searchWord 입력받은 검색어
	 * @param pageNumber 페이지 개수
	 * @return list
	 */
	public ArrayList<Board> getSearchedList2(String searchWord) {
		String SQL = "select * from tb_board where bd_title like concat('%', ?, '%')";
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, searchWord);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Board bd = new Board();
				bd.setBoardno(rs.getInt(1));
				bd.setBd_title(rs.getString(2));
				bd.setBd_nickname(rs.getString(3));
				bd.setBd_content(rs.getString(4));
				bd.setBd_pw(rs.getString(5));
				bd.setBd_views(rs.getInt(6));
				bd.setBd_regtime(rs.getString(7));
				bd.setBd_mod_time(rs.getString(8));
				list.add(bd);
			}
		} catch (Exception e) {
			System.out.println("Exception:search");
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
		System.out.println(" resultset_return list:search");
		return list;
	}

	/**
	 * <pre>
	 * 닉네임 검색결과 수를 출력하는 메소드
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.25
	 * @param searchWord 입력받은 검색어
	 * @param pageNumber 페이지 개수
	 * @return list
	 */
	public ArrayList<Board> getSearchedList3(String searchWord) {
		String SQL = "select * from tb_board where bd_nickname like concat('%', ?, '%')";
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, searchWord);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Board bd = new Board();
				bd.setBoardno(rs.getInt(1));
				bd.setBd_title(rs.getString(2));
				bd.setBd_nickname(rs.getString(3));
				bd.setBd_content(rs.getString(4));
				bd.setBd_pw(rs.getString(5));
				bd.setBd_views(rs.getInt(6));
				bd.setBd_regtime(rs.getString(7));
				bd.setBd_mod_time(rs.getString(8));
				list.add(bd);
			}
		} catch (Exception e) {
			System.out.println("Exception:search");
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
		System.out.println(" resultset_return list:search");
		return list;
	}

	/**
	 * </pre>
	 * 제목+내용 검색결과 수를 출력하는 메소드
	 * <pre>
	 * @author sunwoo
	 * @since 2021.01.25
	 * @param searchWord 입력받은 검색어
	 * @param pageNumber 페이지 개수
	 * @return list
	 */
	public ArrayList<Board> getSearchedList4(String searchWord) {
		String SQL = "select * from tb_board where bd_title or bd_content like concat('%', ?, '%')";
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, searchWord);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Board bd = new Board();
				bd.setBoardno(rs.getInt(1));
				bd.setBd_title(rs.getString(2));
				bd.setBd_nickname(rs.getString(3));
				bd.setBd_content(rs.getString(4));
				bd.setBd_pw(rs.getString(5));
				bd.setBd_views(rs.getInt(6));
				bd.setBd_regtime(rs.getString(7));
				bd.setBd_mod_time(rs.getString(8));
				list.add(bd);
			}
		} catch (Exception e) {
			System.out.println("Exception:search");
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
		System.out.println(" resultset_return list:search");
		return list;
	}

	/**
	 * <pre>
	 * 게시글에 달린 첨부파일 삭제 메소드
	 * </pre>
	 * @author sunwoo
	 * @since 2021.02.2
	 * @param boardno 게시글 번호를 통해 해당 게시글에 달린 댓글을 지정한다.
	 * @return 댓글 삭제
	 */
	public int deleteFiles(int boardno) {
		String sql = "delete from tb_file where boardno = ?";
		int delCnt = 0;
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardno);
			delCnt = pstmt.executeUpdate();
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
		return delCnt;
	}

	/**
	 * <pre>
	 * 게시글에 달린 댓글 삭제 메소드
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.20
	 * @param boardno 게시글 번호를 통해 해당 게시글에 달린 댓글을 지정한다.
	 * @return 댓글 삭제
	 */
	public int deleteComment(int boardno) {
		String sql = "delete from tb_comment where boardno = ?";
		int delCnt = 0;
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardno);
			delCnt = pstmt.executeUpdate();
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
		return delCnt;
	}

	/**
	 * <pre>
	 * 게시글 삭제 메소드
	 * </pre>
	 * @author sunwoo
	 * @since 2021.01.20
	 * @param boardno 게시글 번호를 통해 삭제할 게시글을 지정한다.
	 * @return 게시글 삭제
	 */
	public int delete(int boardno) {
		String sql = "delete from tb_board where boardno = ?";
		int delCnt = 0;
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardno);
			deleteComment(boardno);
			deleteFiles(boardno);
			delCnt = pstmt.executeUpdate();
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
		return delCnt; // 데이터베이스 오류
	}

}
