<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="board.BoardDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@page import="board.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- CSS 참조영역 --%>
<link rel="stylesheet" href="../css/bootstrap/bootstrap.css">
<link rel="stylesheet" href="../css/board/board.css">

<%-- js 참조 영역 --%>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>

<script type="text/javascript">
	/**
	* 전체 폼 유효성 검사
	* @author sunwoo
	* @since 2021.2.1
	*/
var i = 1;
	
function validateform(){
	var title = document.getElementById('bd_title').value.trim();
	var weditor = document.getElementById('weditor').value.trim();
	var form1 = $("#writeform");
	if(title.length == 0 || weditor.length == 0){
		validateTitle();
		validateContent();
		alert('항목을 모두 채워주세요.');	
	} else{
		form1.submit();
		}
	};
	
	
$(document).ready(function(e){
		/**
		* 파일 추가 버튼 클릭 이벤트
		* @author sungrangkong
		* @since 2020.12.12.
		*/
	$("#btn_file_add").click(function(e){
		$file_txt = '<br><br><div><input class="fileBtn" type="file" name="fileTag-'+i+'"/><button type="button" class="btn_minus fileDelBtn">삭제</button></div>';
		$('.fileOne').append($file_txt);
		var a = i;
		i = ++a;
		});

	$(document).on("click",".btn_minus",function(e){
		$(this).parent().remove();
		});
	});
		/**
		* 제목 유효성 검사
		* @author sunwoo
		* @since 2021.01.20
		*/
function validateTitle() {
	var id = document.getElementById('bd_title').value.trim();
	var alertEl = document.getElementById('title_alert');
	if (id.length == 0) {
		alertEl.innerHTML = '필수 정보입니다.';
		alertEl.style.display = 'block';
		return false;
		}
	alertEl.style.display = 'none';
	}	
			
		/**
		* 내용 유효성 검사
		* @author sunwoo
		* @since 2021.01.20
		*/
function validateContent() {
	var id = document.getElementById('weditor').value.trim();
	var alertEl = document.getElementById('content_alert');
	if (id.length == 0) {
		alertEl.innerHTML = '내용을 입력해주세요.';
		alertEl.style.display = 'block';
		return false;
		}
	alertEl.style.display = 'none';
	}
</script>

<title>글 수정</title>
</head>
<body>
<%-- 기존 게시물의 값을 그대로 가져와서 수정 후 DAO를 통해 수정을 진행한다. --%>
	<%
	int boardno = 0;
	if (request.getParameter("boardno") != null) {
		boardno = Integer.parseInt(request.getParameter("boardno"));
	} else if (request.getParameter("boadno") == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('게시판 번호가 NULL 값')");
		script.println("history.back()");
		script.println("</script>");
	}
	Board bd = new BoardDAO().getBoard(boardno);
	String bd_nickname = bd.getBd_nickname();
	System.out.println(bd_nickname);
	%>
	<script type="text/javascript">
		
	</script>
	<%-- 메인 배너 시작 --%>
	<%@ include file="../includes/mainBanner.jsp"%>
	<%-- 메인 배너 끝 --%>


	<%-- 부트스트랩 참조 영역 --%>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

	<%-- 게시판 수정 양식 영역 시작 --%>
	<div class="container">
		<div class="row">
			<form method="post" id="writeform" action="modifyAct.jsp?boardno=<%=boardno%>">
				<input type="hidden" name="boardno" value="<%=bd.getBoardno()%>">
				<input type="hidden" name="bd_nickname" value="<%=bd_nickname%>">
				<table class="table table-striped updateForm">
					<thead>
						<tr class = "updateHeader">
							<th class = "updateHeaderAllg">게시글 수정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="제목"
								id="bd_title" name="bd_title" value="<%=bd.getBd_title()%>" maxlength="50" onfocusout="validateTitle()">
								<div id="title_alert" class="alert">필수 정보입니다.</div>	
							</td>
						</tr>
						<tr>
							<td><textarea class="updateContent" id="weditor"
									placeholder="글 내용" name="bd_content" maxlength="2048" onfocusout="validateContent()"><%=bd.getBd_content()%>
									</textarea>
								<div id="content_alert" class="alert">필수 정보입니다.</div>
							</td>
						</tr>
					</tbody>
				</table>
				<a href="../main.jsp" class="btn btn-primary updateListBtn">목록</a>
				<input type="submit" class="btn btn-primary pull-right updateSubmitBtn" value="수정하기" onclick="validateform(); return false;">
			</form>
		</div>
	</div>
	<%-- 게시판 글쓰기 양식 영역 끝 --%>
</body>
</html>