<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.*" %>
<%-- 
deletePass에서 넘어온 비밀번호를 검증하고 그에 대한 반응을 해주는 페이지
@author 방선우
@since 2021.01.21
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- 비밀번호 검증 로직. 사용자가 입력한 번호와 실제 번호를 비교 --%>
<%
int boardno = 0;
if(request.getParameter("boardno") != null){
	boardno = Integer.parseInt(request.getParameter("boardno"));
	Board bd = new BoardDAO().getBoard(boardno);
	BoardDAO bdd = new BoardDAO();
	String pw1 = bd.getBd_pw();
	String pw2 = bdd.getPw(request.getParameter("pw2"));
	System.out.println("게시글 번호: "+boardno);
	System.out.println("pw1 값: "+pw1);
	System.out.println("pw2 값: "+pw2);
	
	if(pw1.equals(pw2)){
		%>
		<jsp:forward page="deleteAct.jsp?boardno=<%= boardno %>">
   	 		<jsp:param name="boardno" value="<%=bd.getBoardno()%>"/>
		</jsp:forward>
		<%
	} else{
		%>
		<script>alert('비밀번호가 불일치합니다'); 
			window.history.back(); </script>
		<%
	}
}
%>
	
</body>
</html>