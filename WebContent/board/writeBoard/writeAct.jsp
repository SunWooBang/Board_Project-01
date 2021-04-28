<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.*"%>
<%@ page import="files.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@page import="com.oreilly.servlet.multipart.*"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<%--
게시글 쓰기 실제로직 구현 페이지
@author 방선우
@since 2021.01.12
 --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 올리는 중</title>
</head>
<body>
	<%-- write에서 입력받은 값을 request로 가져온 후 DAO의 메소드를 호출해서 글쓰기 실행 --%>


	<%
	Board bdd = new Board();
	BoardDAO bd = new BoardDAO();
	int file_no = 0;
	String directory = application.getRealPath("/upload/");
	int maxSize = 1024 * 1024 * 100;
	String encoding = "UTF-8";

	MultipartRequest multi = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());

	Enumeration<?> fileNames = multi.getFileNames();
	

	/** 글쓰기에 문제가 생길 시 다 지우고 이 코드를 사용할 것**/

	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
	int boardno = 0;
	String bd_title = multi.getParameter("bd_title");
	String bd_nickname = multi.getParameter("bd_nickname");
	String bd_content = multi.getParameter("bd_content");
	String bd_pw = multi.getParameter("bd_pw");
	int bd_views = 0;
	String bd_regtime = "";
	String bd_mod_time = "";

	
		// 정상적으로 입력이 되었다면 글쓰기 로직을 수행한다
		int result = bd.write(boardno, bd_title, bd_nickname, bd_content, bd_pw, bd_views, bd_regtime, bd_mod_time);
		int i = 0;
		while (fileNames.hasMoreElements()) {
			String parameter = (String) fileNames.nextElement();
			String scr = "fileTag-";
			String scr2 = scr+i;
			System.out.println("\br\br"+scr2);
			String bd_filename = multi.getOriginalFileName(scr2);
			
			System.out.println("\br\br"+bd_filename);
			int a = i;
			a++;
			i = a;
			
			//String fileRealName = multi.getFilesystemName("fileTag");

			if (bd_filename == null)
				continue;

			new FileDAO().upload(file_no, bd.getBoardno2(), bd_filename);
			
				}
		
		// 데이터베이스 오류인 경우
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기에 실패했습니다')");
			script.println("history.back()");
			script.println("</script>");
			// 글쓰기가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기 성공')");
			script.println("location.href='../main.jsp'");
			script.println("</script>");
		}
	
	%>




</body>
</html>