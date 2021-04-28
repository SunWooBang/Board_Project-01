<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="java.io.*"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.*"%>
<%@page import="java.io.File"%>
<%@ page import="java.util.Date"%>
<%--
게시글 수정로직 구현 페이지
@author 방선우
@since 2021.01.21
 --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수정로직</title>
</head>
<body>
	<%-- 입력내용을 request로 가져와서 null여부 확인 및 DAO 매소드 호출로 수정완료 --%>
	<%
	/** 글쓰기에 문제가 생길 시 다 지우고 이 코드를 사용할 것**/
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");

	BoardDAO bd = new BoardDAO();
	int boardno = Integer.parseInt(request.getParameter("boardno"));
	String bd_title = request.getParameter("bd_title");
	String bd_nickname = request.getParameter("bd_nickname");
	String bd_content = request.getParameter("bd_content");
	int bd_views = 0;

	int result = bd.update(boardno, bd_title, bd_nickname, bd_content);

	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('게시글 수정 완료')");
	script.println("location.href='../main.jsp'");
	script.println("</script>");
	%>
</body>
</html>