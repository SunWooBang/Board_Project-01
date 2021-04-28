<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="comment.*"%>
<%@ page import="board.*"%>
<%@ page import="java.io.PrintWriter"%>
<%-- 
댓글 쓰기 기능 실제 구현 페이지
@author 방선우
@since 2021.01.16
--%>

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 작성</title>
</head>
<body>
	<%
	/**
	닉네임, 내용, 비밀번호 등을 request로 받아 CommentDAO의 메소드 호출 및 댓글작성 완료.
	**/
	Board bd = new Board();
	CommentDAO cd = new CommentDAO();
	int com_no = cd.getNextComment();
	//String boardNo = request.getParameter("boardNo");
	
	int boardno= Integer.parseInt(request.getParameter("boardno"));
	
	String com_nickname = request.getParameter("com_nickname");
	String com_content = request.getParameter("com_content");
	String com_pw = request.getParameter("com_pw");

	if (com_nickname == null || com_content == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다')");
		script.println("history.back()");
		script.println("</script>");
	}else if(com_pw.equals(null)){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호를 입력해주세요')");
		script.println("history.back()");
		script.println("</script>");
	}else {
		/** 정상적으로 입력이 되었다면 댓글쓰기 로직을 수행한다**/
		int result = cd.writecomment(com_no, boardno, com_nickname, com_content, com_pw);

		// 데이터베이스 오류인 경우
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('댓글쓰기에 실패했습니다')");
			script.println("history.back()");
			script.println("</script>");

			/** 댓글쓰기가 정상적으로 실행되면 게시글로 이동한다**/
		} else {
		}
		%>
		<jsp:forward page="../view/view.jsp?boardno=<%=boardno%>"/>
	<%
	}
	%>
</body>
</html>