<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- 화면 최적화 --%>
<%-- css 참조하는 링크 --%>
<link rel="stylesheet" href="../css/bootstrap/bootstrap.css">
<link rel="stylesheet" href="../css/board/board.css">

<%-- 부트스트랩 참조 영역 --%>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../css/js/bootstrap.js"></script>

<script type="text/javascript">
	/**
	* 전체 폼 유효성 검사
	* @author sunwoo
	* @since 2021.2.1
	*/
	var i = 1;
	
	
	function validateform(){
		var title = document.getElementById('bd_title').value.trim();
		var name = document.getElementById('bd_nickname').value.trim();
		var weditor = document.getElementById('weditor').value.trim();
		var password = document.getElementById('bd_pw').value.trim();
		var form1 = $("#writeform");
		
		if(title.length == 0 || name.length == 0 || weditor.length == 0 || password.length == 0){
			validateTitle();
			validateNickname();
			validateContent();
			validatePassword();
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
			var title = document.getElementById('bd_title').value.trim();
			var alertEl = document.getElementById('title_alert');
			if (title.length == 0) {
				alertEl.innerHTML = '필수 정보입니다.';
				alertEl.style.display = 'block';
				return false;
			}
			alertEl.style.display = 'none';
		}
			
		/**
		* 닉네임 유효성 검사
		* @author sunwoo
		* @since 2021.01.20
		*/
		function validateNickname() {
			var name = document.getElementById('bd_nickname').value.trim();
			var alertEl = document.getElementById('nick_alert');
			if (name.length == 0) {
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
			var con = document.getElementById('weditor').value.trim();
			var alertEl = document.getElementById('content_alert');
			if (con.length == 0) {
				alertEl.innerHTML = '내용을 입력해주세요.';
				alertEl.style.display = 'block';
				return false;
			}
			alertEl.style.display = 'none';
		}

		/**
		* 비밀번호 유효성 검사
		* @author sunwoo
		* @since 2021.01.20
		*/
		function validatePassword() {
			var password = document.getElementById('bd_pw').value.trim();
			var alertEl = document.getElementById('pw_alert');
			if (password.length == 0) {
				alertEl.innerHTML = '필수 정보입니다.';
				alertEl.style.display = 'block';
				return false;
			}
			alertEl.style.display = 'none';
		}
		$(document).ready(function(e) {
		});
	</script>

<title>글 작성</title>
</head>
<body>
	<%-- 메인 배너 시작 --%>
	<%@ include file="../includes/mainBanner.jsp"%>
	<%-- 메인 배너 끝 --%>



	<%-- 게시판 글쓰기 양식 영역 시작 --%>
	<div class="container">
		<div class="row writeHeight">
			<form method="post" id="writeform" action="writeAct.jsp?"
				enctype="Multipart/form-data" keyValue="multipart">
				<table class="table table-striped updateForm">
					<thead>
						<tr class="updateHeader">
							<th class="updateHeaderAllg">게시판 글쓰기 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="글 제목" id="bd_title" name="bd_title" maxlength="50"
								onfocusout="validateTitle()">
								<div id="title_alert" class="alert">필수 정보입니다.</div></td>
						</tr>
						<tr>
							<td><input type="text" class="form-control" placeholder="별명"
								id="bd_nickname" name="bd_nickname" maxlength="16"
								onfocusout="validateNickname()">
								<div id="nick_alert" class="alert">필수 정보입니다.</div></td>
						<tr>
							<td><textarea class="updateContent" id="weditor"
									placeholder="글 내용" name="bd_content" maxlength="2048"
									onfocusout="validateContent()"></textarea>
								<div id="content_alert" class="alert">내용을 입력해주세요.</div></td>
						</tr>
						<tr>
							<td class="fileOne">
								<div>
									<button type="button" class="fileAddBtn" id="btn_file_add">파일추가</button>
								</div> <br> <br>
								<div>
									<input class="fileBtn" type="file" name="fileTag-0" />
									<button type="button" class="btn_minus fileDelBtn">삭제</button>
								</div>
							</td>
						</tr>
						<tr>
							<td><input type="text" class="form-control writePw"
								placeholder="비밀번호" id="bd_pw" name="bd_pw" maxlength="30"
								maxlength=2 onfocusout="validatePassword()">
								<div id="pw_alert" class="alert">필수 정보입니다.</div></td>
						</tr>
					</tbody>
				</table>
				<%-- 글쓰기 버튼 생성 --%>
				<a href="main.jsp" class="btn btn-primary updateListBtn">목록</a> <input
					type="submit" class="btn btn-primary pull-right writeSubmitBtn"
					value="글쓰기" id="btn_submit" onclick="validateform(); return false;">
			</form>
		</div>
	</div>
	<%-- 게시판 글쓰기 양식 영역 끝 --%>
</body>
</html>