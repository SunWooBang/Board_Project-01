<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.*"%>
<%@ page import="files.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 
실제 삭제 기능이 구현되는 페이지
@author 방선우
@since 2021.01.20
--%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 삭제</title>
</head>
<body>
	<%
	int boardno = Integer.parseInt(request.getParameter("boardno"));
	
	/** 첨부파일 삭제 **/
	FileDAO fd = new FileDAO();
	String filePath = "C:\\Users\\prays\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\Board_Project\\upload\\";
	
	ArrayList <Files> fdd = fd.getFiles(boardno);
	for(int i = 0; i<fdd.size(); i++){
		String fileName = fdd.get(i).getBe_filename(); //지울 파일명
	   
		filePath = filePath+fileName;
		File f = new File(filePath); // 파일 객체생성
		if( f.exists()) 
			f.delete(); // 파일이 존재하면 파일을 삭제한다.
			
		filePath = "C:\\Users\\prays\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\Board_Project\\upload\\";
	}
	
	/** 글 삭제 로직을 수행한다 **/
	BoardDAO bd = new BoardDAO();
	int result = bd.delete(boardno);
	
	/** 데이터베이스 오류인 경우 **/
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스에 오류가 있습니다.')");
		script.println("history.back()");
		script.println("</script>");

		/** 글 삭제가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다 **/
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글 삭제하기 성공')");
		script.println("location.href='../main.jsp'");
		script.println("</script>");
	}
	%>
</body>
</html>