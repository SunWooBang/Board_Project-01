<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="comment.*" %>
<%@ page import="java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
System.out.println("무야호~");
CommentDAO cd = new CommentDAO();
int com_no = 0;
int boardno = 0;
String com_content = "";

if(request.getParameter("com_no") != null){
	com_no = Integer.parseInt(request.getParameter("com_no"));
}
if(request.getParameter("boardno") != null){
	boardno = Integer.parseInt(request.getParameter("boardno"));
}
if(request.getParameter("com_content") != null){
	com_content = request.getParameter("com_content");
}
cd.comModify(com_no, com_content);
%>
<jsp:forward page="view.jsp?boardno=<%=boardno%>"/>
</body>
</html>