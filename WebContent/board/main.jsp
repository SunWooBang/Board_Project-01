<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.*"%>
<%@ page import ="comment.*" %>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%-- CSS 참조하는 링크 --%>
<link rel="stylesheet" href="css/bootstrap/bootstrap.css">
<link rel="stylesheet" href="css/board/board.css">

<%-- 부트스트랩 참조 영역 --%>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="css/js/bootstrap.js"></script>
<title>Main</title>
</head>
<body>
	<%-- 네비게이션 --%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<%-- 상단 바에 제목이 나타나고 클릭하면 main 페이지로 이동한다 --%>
			<div class="titleHeader mainTitle">
				<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
			</div>
		</div>
	</nav>


	<%-- 페이지 지정. 첫페이지는 1로 지정. 이후 페이징 할 때마다 페이지 수 받음. --%>
	<%
	int pageNumber = 1; //기본은 1 페이지를 할당
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	if (pageNumber < 1) {
		pageNumber = pageNumber + 1;
	}
	%>

	<%-- 검색창 시작. 입력내용은 search.jsp로 --%>
	<form method="post" action="search/search.jsp" accept-charset="utf-8">
		<select class="form-control searchType" name="searchType"
			id="searchType">
			<option value="title">제목</option>
			<option value="nick">작성자</option>
			<option value="com">제목+내용</option>
		</select>
		<div class="mainSelectBox">
			<input type="text" class="form-control pull-left"
				placeholder="Search" name="searchWord" maxlength="30" />
		</div>
		<button class="btn btn-primary btnSearch" type="submit">검색</button>
		<br> <br> <br>
	</form>
	<%-- 검색창 끝. --%>



	<%-- 게시판 메인 페이지 영역 시작 --%>
	<div class="container">
		<div class="row">
			<div class="curpage">
				현재페이지:
				<%=pageNumber%></div>
			<table class="table table-striped boardMainTable">
				<thead>
					<tr>
						<th class="boardIdTh">번호</th>
						<th class="boardTh">제목</th>
						<th class=boardWriterTh>글쓴이</th>
						<th class="boardIdTh">작성일</th>
						<th class="boardViewTh">조회수</th>
					</tr>
				</thead>
				<tbody>
					<%--boradDAO에서 메소드 호출. CommentDAO에서는 댓글 수를 산정 --%>
					<%
					BoardDAO bd = new BoardDAO(); // 인스턴스 생성
					Board b = new Board();
					CommentDAO cd = new CommentDAO();
					int com_no = 0;
					ArrayList<Board> list = bd.getList(pageNumber);
					ArrayList<Board> listAll = bd.getAllList();
					for (int i = 0; i < list.size(); i++) {
						ArrayList<Comment> commentList = cd.getListcomment(list.get(i).getBoardno(), com_no);
					%>
					<tr>
						<td><%=list.get(i).getBoardno()%></td>
						<%-- 게시글 제목을 누르면 해당 글을 볼 수 있도록 링크를 걸어둔다 --%>
						<td class="mainTitleLength">
						<nobr>
								<a href="view/view.jsp?boardno=<%=list.get(i).getBoardno()%>"> <%=list.get(i).getBd_title()%></a>
						</nobr>
						<%
							if (commentList.size() != 0) {
						%> &nbsp;
						<span class="comNum">
						(<%=commentList.size()%>)
						</span>
						<%
						}
 						%></td>
						<td class="mainNameLength">
						<nobr><%=list.get(i).getBd_nickname()%></nobr>
						</td>
						<td><%=list.get(i).getBd_regtime().split(" ")[0]%></td>
						<td><%=list.get(i).getBd_views()%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>

			<%-- 글쓰기 버튼 생성 --%>
			<a href="writeBoard/writeForm.jsp" class="btn btn-primary pull-right">글쓰기</a>

			<%-- 페이징 처리 영역 --%>
			<div class="pagingMargin-left">
			<% if(pageNumber>1){%>
				<a href="main.jsp?pageNumber=<%=pageNumber - 1%>"
					class="btn btn-success">◀</a>
				<%
				}
				System.out.println("리스트 길이: " + listAll.size());
				int j = (listAll.size() / 10) + 1;
				if (pageNumber == 1) {
					for (int i = 1; i <= j; i++) {
						if (pageNumber == i) {
				%>
				<a href="main.jsp?pageNumber=<%=i%>"
					class="btn btn-success btn-arraw-left curpageBtn"><%=i%></a>
				<%
				} else {
				%>

				<a href="main.jsp?pageNumber=<%=i%>"	
					class="btn btn-success btn-arraw-left"><%=i%></a>
				<%
				}
				}
				} else if (pageNumber != 1) {
				for (int i = 1; i <= j; i++) {
				if (pageNumber == i) {
				%>
				<a href="main.jsp?pageNumber=<%=i%>"
					class="btn btn-success btn-arraw-left curpageBtn"><%=i%></a>
				<%
				} else {
				%>

				<a href="main.jsp?pageNumber=<%=i%>"
					class="btn btn-success btn-arraw-left"><%=i%></a>
				<%
				}
				}
				}
				if(pageNumber < (listAll.size() / 10)+1){
				%>
				<a href="main.jsp?pageNumber=<%=pageNumber + 1%>"
					class="btn btn-success ">▶</a>
				<%}
				if (pageNumber > (listAll.size() / 10)) {
				pageNumber = pageNumber - 1;
				}%>
				<%-- 페이징 처리 끝 --%>

			</div>
		</div>
	</div>
</body>
</html>