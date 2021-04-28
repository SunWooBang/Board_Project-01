<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.*"%>
<%@ page import="comment.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- CSS 참조하는 링크 --%>
<link rel="stylesheet" href="../css/bootstrap/bootstrap.css">
<link rel="stylesheet" href="../css/board/board.css">

<%-- 부트스트랩 참조 영역 --%>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../css/js/bootstrap.js"></script>

<title>Main</title>
</head>
<body>
	<%-- 
		페이지 지정. 첫페이지는 1로 지정. 이후 페이징 할 때마다 페이지 수 받음. 
		페이징을 위해서 searchWord를 세션으로 받아둔다.
	--%>
	<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");

	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	if (pageNumber < 1) {
		pageNumber = pageNumber + 1;
	}
	String searchWord = request.getParameter("searchWord");
	System.out.println("searchword from parameter is :" + searchWord);

	String searchType = request.getParameter("searchType");
	%>

	<%-- 메인 배너 시작 --%>
	<%@ include file="../includes/mainBanner.jsp"%>
	<%-- 메인 배너 끝 --%>

	<%
	BoardDAO bd = new BoardDAO(); // 인스턴스 생성
	CommentDAO cd = new CommentDAO();
	ArrayList<Board> searchlist;
	ArrayList<Board> searchlist2;

	if (searchType.equals("title")) {
		searchlist = bd.getSearchedTitle(searchWord, pageNumber);
		searchlist2 = bd.getSearchedList2(searchWord);
	} else if (searchType.equals("nick")) {
		searchlist = bd.getSearchedNick(searchWord, pageNumber);
		searchlist2 = bd.getSearchedList3(searchWord);
	} else {
		searchlist = bd.getSearchedCom(searchWord, pageNumber);
		searchlist2 = bd.getSearchedList4(searchWord);
	}
	%>


	<%-- 검색창 시작. 입력내용은 search.jsp로 --%>
	<form method="post" action="search.jsp" accept-charset="utf-8">
		<select class="form-control searchType" name="searchType"
			id="searchType">
			<option value="title">제목</option>
			<option value="nick">작성자</option>
			<option value="com">제목+내용</option>
		</select>
		<div class="mainSelectBox">
			<input type="text" class="form-control pull-left" placeholder="<%= searchWord %>" name="searchWord" maxlength="50">
		</div>
		<button class="btn btn-primary btnSearch" type="submit">검색</button>
		<br> <br> <br>
	</form>
	<%-- 검색창 끝 --%>



	<%-- 게시판 메인 페이지 영역 시작 --%>
	<div class="container">
		<div class="row">
			<div class="curpage">
				"<b><%=searchWord%></b>" 라는 키워드로 <b><%=searchlist2.size()%></b>개의
				검색결과가 있습니다.
			</div>
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
					<%
					int com_no = 0;
					for (int i = 0; i < searchlist.size(); i++) {
						ArrayList<Comment> commentList = cd.getListcomment(searchlist.get(i).getBoardno(), com_no);
					%>
					<tr>
						<td><%=searchlist.get(i).getBoardno()%></td>
						<%-- 게시글 제목을 누르면 해당 글을 볼 수 있도록 링크를 걸어둔다 --%>
						<td class="mainTitleLength">
						<nobr>
						<a href="../view/view.jsp?boardno=<%=searchlist.get(i).getBoardno()%>">
						<%=searchlist.get(i).getBd_title()%></a>
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
						<nobr><%=searchlist.get(i).getBd_nickname()%></nobr></td>
						
						<td><%=searchlist.get(i).getBd_regtime().split(" ")[0]%></td>
						<td><%=searchlist.get(i).getBd_views()%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>

			<%-- 글쓰기 버튼 생성 --%>
			<a href="../writeBoard/writeForm.jsp" class="btn btn-primary pull-right">글쓰기</a>

			<%-- 페이징 처리 영역 --%>
			<div class="pagingMargin-left">
				<% if(pageNumber>1){%>
				<a href="search.jsp?searchType=<%=searchType%>&searchWord=<%=searchWord%>&pageNumber=<%=pageNumber - 1%>"
					class="btn btn-success">◀</a>
				<%
				}
				System.out.println("리스트 길이: " + searchlist2.size());
				int j = (searchlist2.size() / 10) + 1;
				if (pageNumber == 1) {
					for (int i = 1; i <= j; i++) {
						if (pageNumber == i) {
				%>
				<a href="search.jsp?searchType=<%=searchType%>&searchWord=<%=searchWord%>&pageNumber=<%=i%>"
					class="btn btn-success btn-arraw-left curpageBtn"><%=i%></a>
				<%
				} else {
				%>

				<a href="search.jsp?searchType=<%=searchType%>&searchWord=<%=searchWord%>&pageNumber=<%=i%>"
					class="btn btn-success btn-arraw-left"><%=i%></a>
				<%
				}
				}
				} else if (pageNumber != 1) {
				for (int i = 1; i <= j; i++) {
				if (pageNumber == i) {
				%>
				<a href="search.jsp?searchType=<%=searchType%>&searchWord=<%=searchWord%>&pageNumber=<%=i%>"
					class="btn btn-success btn-arraw-left curpageBtn"><%=i%></a>
				<%
				} else {
				%>

				<a href="search.jsp?searchType=<%=searchType%>&searchWord=<%=searchWord%>&pageNumber=<%=i%>"
					class="btn btn-success btn-arraw-left"><%=i%></a>
				<%
				}
				}
				}
				if(pageNumber < (searchlist2.size() / 10)+1){
				%>
				<a href="search.jsp?searchType=<%=searchType%>&searchWord=<%=searchWord%>&pageNumber=<%=pageNumber + 1%>"
					class="btn btn-success ">▶</a>
				<%}
				if (pageNumber > (searchlist2.size() / 10)) {
				pageNumber = pageNumber - 1;
				}%>
				<%-- 페이징 처리 끝 --%>

			</div>
		</div>
	</div>
</body>
</html>