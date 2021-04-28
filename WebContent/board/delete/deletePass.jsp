<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.*"%>
<%-- 
삭제로직이 발생하기 전 비밀번호를 기입하는 페이지이다.
@author 방선우
@since 2021.01.21

--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/board/board.css">
<title>delete Pass</title>
</head>
<body>
	<%-- request로 boardNo의 값을 가져와서 deletePassAct로 넘겨준다. --%>
	<%
	int boardno = 0;
	if (request.getParameter("boardno") != null) {
		boardno = Integer.parseInt(request.getParameter("boardno"));
		System.out.println(boardno);
	}
	Board bd = new BoardDAO().getBoard(boardno);
	%>

	<div class="container">
		<div class="row passForm">
			<div class="passDiv">
				<b>비밀번호를 입력해주세요</b>
			</div>
			<form method="post" action="deletePassAct.jsp">
				<input type="hidden" value="<%=bd.getBoardno()%>" name="boardno">
				<table class="table table-striped passTable">
					<thead>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="비밀번호" name="pw2" maxlength="50"> <input
								type="submit" class="btn btn-primary pull-right" value="확인">
							</td>
						</tr>
						<tr>
							<td><a class="btn btn-primary"
								href="../view/view.jsp?boardno=<%=boardno%>">돌아가기</a></td>
						</tr>
					</thead>
				</table>
			</form>
		</div>
	</div>
</body>
</html>