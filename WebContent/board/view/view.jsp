<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="board.*"%>
<%@ page import="files.*"%>
<%@ page import="comment.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<script type="text/javascript">
<%-- 유효성 검사 영역 --%>
function validatePassword() {
	var password = document.getElementById('com_pw').value.trim();
	var alertEl = document.getElementById('pw_alert');
	if (password.length == 0) {
		alertEl.innerHTML = '미입력시 1111';
		alertEl.style.display = 'block';
		return false;
		}
	alertEl.style.display = 'none';
	}
<%-- 유효성 검사 영역 끝 --%>

<%-- 댓글 삭제하기 --%>
function delBtn(pw, i) {
	var pw1 = SHA256(prompt("비밀번호를 입력하세요" + ""));
	var pw2 = pw;
	var i = i;

if(pw1 != null){
	if(pw1 == pw2){
		alert("삭제기능은 아직 구현중입니다.");
	} else{
		alert("비밀번호 불일치");
	}
} else {
	return false;
}
}

<%-- 댓글 삭제하기 끝--%>

<%-- 댓글 수정하기 --%>
function modifyBtn(pw, i) {
	var pw1 = SHA256(prompt("비밀번호를 입력하세요" + ""));
	var pw2 = pw;
	var i = i;

if(pw1 != null){
	if(pw1 == pw2){
		modifyOpen(i);
	}else if (pw1 != pw2){
		alert("비밀번호 불일치");
	}
}else{
	return false;
}	
}
<%-- 댓글 수정하기 끝--%>


<%-- 자바스크립트 SHA암호화 함수 --%>

function SHA256(s){
    var chrsz   = 8;
    var hexcase = 0;

    function safe_add (x, y) {
        var lsw = (x & 0xFFFF) + (y & 0xFFFF);
        var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
        
        return (msw << 16) | (lsw & 0xFFFF);
    }
    
    function S (X, n) { return ( X >>> n ) | (X << (32 - n)); }

    function R (X, n) { return ( X >>> n ); }

    function Ch(x, y, z) { return ((x & y) ^ ((~x) & z)); }

    function Maj(x, y, z) { return ((x & y) ^ (x & z) ^ (y & z)); }

    function Sigma0256(x) { return (S(x, 2) ^ S(x, 13) ^ S(x, 22)); }

    function Sigma1256(x) { return (S(x, 6) ^ S(x, 11) ^ S(x, 25)); }

    function Gamma0256(x) { return (S(x, 7) ^ S(x, 18) ^ R(x, 3)); }

    function Gamma1256(x) { return (S(x, 17) ^ S(x, 19) ^ R(x, 10)); }

    function core_sha256 (m, l) {
        var K = new Array(0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5, 0x3956C25B, 0x59F111F1, 0x923F82A4, 0xAB1C5ED5, 0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3, 0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174, 0xE49B69C1, 0xEFBE4786, 0xFC19DC6, 0x240CA1CC, 0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA, 0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7, 0xC6E00BF3, 0xD5A79147, 0x6CA6351, 0x14292967, 0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13, 0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85, 0xA2BFE8A1, 0xA81A664B, 0xC24B8B70, 0xC76C51A3, 0xD192E819, 0xD6990624, 0xF40E3585, 0x106AA070, 0x19A4C116, 0x1E376C08, 0x2748774C, 0x34B0BCB5, 0x391C0CB3, 0x4ED8AA4A, 0x5B9CCA4F, 0x682E6FF3, 0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208, 0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2);
        var HASH = new Array(0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A, 0x510E527F, 0x9B05688C, 0x1F83D9AB, 0x5BE0CD19);
        var W = new Array(64);
        var a, b, c, d, e, f, g, h, i, j;
        var T1, T2;

        m[l >> 5] |= 0x80 << (24 - l % 32);
        m[((l + 64 >> 9) << 4) + 15] = l;

        for ( var i = 0; i<m.length; i+=16 ) {
            a = HASH[0];
            b = HASH[1];
            c = HASH[2];
            d = HASH[3];
            e = HASH[4];
            f = HASH[5];
            g = HASH[6];
            h = HASH[7];

            for ( var j = 0; j<64; j++) {
                if (j < 16) W[j] = m[j + i];	
                 else W[j] = safe_add(safe_add(safe_add(Gamma1256(W[j - 2]), W[j - 7]), Gamma0256(W[j - 15])), W[j - 16]);
                
                T1 = safe_add(safe_add(safe_add(safe_add(h, Sigma1256(e)), Ch(e, f, g)), K[j]), W[j]);
                T2 = safe_add(Sigma0256(a), Maj(a, b, c));
                
                h = g;
                g = f;
                f = e;
                e = safe_add(d, T1);
                d = c;
                c = b;
                b = a;
                a = safe_add(T1, T2);
            }
            HASH[0] = safe_add(a, HASH[0]);
            HASH[1] = safe_add(b, HASH[1]);
            HASH[2] = safe_add(c, HASH[2]);
            HASH[3] = safe_add(d, HASH[3]);
            HASH[4] = safe_add(e, HASH[4]);
            HASH[5] = safe_add(f, HASH[5]);
            HASH[6] = safe_add(g, HASH[6]);
            HASH[7] = safe_add(h, HASH[7]);
        }
        return HASH;
    }

    function str2binb (str) {
        var bin = Array();
        var mask = (1 << chrsz) - 1;
        
        for(var i = 0; i < str.length * chrsz; i += chrsz) {
            bin[i>>5] |= (str.charCodeAt(i / chrsz) & mask) << (24 - i%32);
        }
        return bin;
    }

    function Utf8Encode(string) {
        string = string.replace(/\r\n/g,"\n");
        var utftext = "";
        
        for (var n = 0; n < string.length; n++) {
            var c = string.charCodeAt(n);

            if (c < 128) {
                utftext += String.fromCharCode(c);
            } else if((c > 127) && (c < 2048)) {
                utftext += String.fromCharCode((c >> 6) | 192);
                utftext += String.fromCharCode((c & 63) | 128);
            } else {
                utftext += String.fromCharCode((c >> 12) | 224);
                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                utftext += String.fromCharCode((c & 63) | 128);
            }
        }
        return utftext;
    }

    function binb2hex (binarray) {
        var hex_tab = hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
        var str = "";
        for(var i = 0; i < binarray.length * 4; i++) {
            str += hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8+4)) & 0xF) +
            hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8  )) & 0xF);
        }
        return str;
    }
    s = Utf8Encode(s);
    
    return binb2hex(core_sha256(str2binb(s), s.length * chrsz));
}

<%-- 자바스크립트 SHA암호화 함수 끝 --%>



<%-- 댓글 수정창 열기 --%>
function modifyOpen(i){
	var i = i;
	var originFrm = document.getElementById('originComment'+i);
	var frm = document.getElementById('comModify'+i);
	
	originFrm.style.display = 'none';
	frm.style.display = 'table-row';
}	 
<%-- 댓글 수정창 열기 끝 --%>

<%-- 댓글 수정창 닫기 --%>
function modifyClose(i){
	var i = i;
	var originFrm = document.getElementById('originComment'+i);
	var frm = document.getElementById('comModify'+i);
	
	originFrm.style.display = 'table-row';
	frm.style.display = 'none';
}	 
<%-- 댓글 수정창 열기 끝 --%>

<%-- 댓글 수정 제출 --%>
function modifySubmit(i, com_no, com_content){
	var i =i;
	var originFrm = document.getElementById('originComment'+i);
	var frm = document.getElementById('comModify'+i);
	var commentFrm = document.getElementById("commentFrm");
	
	originFrm.style.display = 'table-row';
	frm.style.display = 'none';
	commentFrm.submit();
	
}	 
<%-- 댓글 수정 제출 끝 --%>

</script>

<title>게시글 보기</title>
</head>
<body>
	<%-- 게시글 번호를 검사 및 Board, BoardDAO 객체 생성 --%>
	<%
	int boardno = 0;
	if (request.getParameter("boardno") != null) {
		boardno = Integer.parseInt(request.getParameter("boardno"));
	}

	FileDAO fd = new FileDAO();

	String directory = application.getRealPath("/upload/");
	String files[] = new File(directory).list();

	if (boardno == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다')");
		script.println("location.href='../main.jsp'");
		script.println("</script>");
	}

	Board bd = new BoardDAO().getBoard(boardno);
	BoardDAO bdd = new BoardDAO();
	Files fi = new Files();
	int com_no = 0;

	if (request.getParameter("com_no") != null) {
		com_no = Integer.parseInt(request.getParameter("com_no"));
	}
	%>
	
	<%-- 메인 배너 시작 --%>
	<%@ include file="../includes/mainBanner.jsp" %>
	<%-- 메인 배너 끝 --%>




	<%
	String bd_title = bd.getBd_title();
	String bd_nickname = bd.getBd_nickname();
	String bd_content = bd.getBd_content();
	String bd_mod_time = bd.getBd_mod_time();
	String bd_regtime = bd.getBd_regtime();
	%>
	<fmt:parseDate var="bd_mod_time" value="${bd_mod_time}" pattern="dd-MM-yyyy HH:mm:ss"/>
	<fmt:parseDate var="bd_regtime" value="${bd_regtime}" pattern="dd-MM-yyyy HH:mm:ss"/>
	<%-- 게시판 글 보기 양식 영역 시작 --%>
	<div class="container">
		<div class="row">
			<table class="table table-striped updateForm">
				<thead>
					<tr class="updateHeader">
						<th class="updateHeaderAllg viewTitle" colspan="2"><%=bd_title.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<%-- replaceAll은 문자열 치환 방식이다. replace와는 좀 다름. 정규표현식. 띄어쓰기, 줄바꿈 등 가능하다. --%>
						<td class="viewTable viewName" colspan="2"><%=bd_nickname.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%>
						</td>
					</tr>
					<tr class="viewRegtime">
					<%if(bd_regtime.equals(bd_mod_time)){%>
						<td class="viewTable" colspan="2"> <script>document.write(bd_mod_time);</script> &nbsp; 작성됨</td>
					<%}else{%>
						<td class="viewTable" colspan="2">${bd_mod_time} &nbsp; 수정됨</td>
					<%}%>
					</tr>
					<tr>
						<td class="viewTable viewTableHeight" colspan="2">
						<%=bd_content.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%>
						</td>
					</tr>
					<%
					ArrayList<Files> fdd = fd.getFiles(boardno);
					System.out.println("파일개수: "+fdd.size());
					if (fdd.size() != 0) {
					%>
					<tr>
						<td>첨부파일</td>
						<td class="viewTable" colspan="2">
							<%
							for (int i = 0; i < fdd.size(); i++) {
								for (String filename : files) {
									if (fdd.get(i).getBe_filename().equals(filename)) {
								out.write("<a href=\"" + request.getContextPath() + "/downloadAct?file="
										+ java.net.URLEncoder.encode(filename, "UTF-8") + "\">" + filename + "</a><br>");
									}
								}
							}
							%>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<div class="viewdiv">
				<a href="../main.jsp" class="btn btn-primary viewList">목록</a> <a
					href="../modify/modifyPass.jsp?boardno=<%=boardno%>" class="btn btn-primary">수정</a>
				<a id="delete" href="../delete/deletePass.jsp?boardno=<%=boardno%>"
					class="btn btn-primary">삭제</a>
			</div>
			<%-- 게시판 글 보기 양식 영역 끝 --%>

			<%-- 댓글 쓰기 시작--%>
			<div class="row viewcomDiv">
				<form method="post" action="../comment/commentAct.jsp">
					<input type="hidden" value="<%=boardno%>" name="boardno">
					<table class="table table-striped viewcomTable">
						<tbody>
							<tr>
								<td><div class=" col-lg-5">
										<input type="text" class="form-control" placeholder="별명" id="com_nickname" name="com_nickname" maxlength="16">
										<input type="text" class="form-control" placeholder="비밀번호" id="com_pw" name="com_pw" maxlength="20" onfocusout="validatePassword()">
										<div id="pw_alert" class="alert">미입력시 1111</div>
									</div>
								</td>
								<td>
									<div class=" col-lg-7">
										<textarea class="form-control pull-left input-lg commentText" id="weditor" placeholder="내용" name="com_content" maxlength="300"></textarea>
									</div>
									<div id="content_alert" class="alert">필수 정보입니다.</div>
								</td>
								<td><input type="submit"
									class="btn btn-primary pull-left commentWrite" value="글쓰기">
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<%-- 댓글 쓰기 끝--%>
			
			<%-- 댓글 보기 영역 시작--%>
			<form method="post" id="commentFrm" action="../comment/commentModifyAct.jsp">
			<input type="hidden" name="boardno" value="<%=boardno%>">
			<table class="table table-striped viewcomTable">
				<thead>
					<tr>
						<th class="boardTh commentWidth01"></th>
						<th class="boardTh commentWidth02">댓글</th>
						<th class="boardTh commentWidth03"></th>
						<th class="boardTh commentWidth04"></th>
					</tr>
					<tr>
						<th class="boardTh commentWidth01">번호</th>
						<th class="boardTh commentWidth02">작성자</th>
						<th class="boardTh commentWidth03">내용</th>
						<th class="boardTh commentWidth04"></th>
					</tr>
				</thead>
				<tbody>
					<%
					CommentDAO cd = new CommentDAO();
					ArrayList<Comment> list = cd.getListcomment(boardno, com_no);
					for (int i = 0; i < list.size(); i++) {
						String com_pw = list.get(i).getCom_pw();
						int com_no2 = list.get(i).getCom_no();
						int boardno2 = list.get(i).getBoardno();
					%>
					<tr id="originComment<%=i%>">
						<td class="commentNo"><%=list.get(i).getCom_no()%></td>
						<td class="commentName"><%=list.get(i).getCom_nickname()%></td>
						<td><%=list.get(i).getCom_content()%></td>
						<td>
						<button class="btn btn-primary commentDelBtn" id="com_delBtn<%=i%>" onclick="delBtn('<%=com_pw%>',<%=com_no2%>); return false;">삭제</button>
						<button class="btn btn-primary commentDelBtn" id="com_modiBtn<%=i%>" onclick="modifyBtn('<%=com_pw%>',<%=i%>); return false;">수정</button>
						</td>
					</tr>
					<tr class="commentModify" id="comModify<%=i%>">
						<td class="commentNo" id="com_no" name="com_no"><%=list.get(i).getCom_no()%></td>
						<td class="commentName"><%=list.get(i).getCom_nickname()%></td>
						<td class="align-left" id="com_content">
						<input type="hidden" name="com_no" value="<%=com_no2%>">
						<textarea class="form-control pull-left input-lg commentContent" id="weditor" name="com_content"
							placeholder="내용" name="com_content" maxlength="300"><%=list.get(i).getCom_content()%>
							</textarea>
						</td>
						<td>
						<button class="btn btn-primary commentDelBtn" id="com_modify<%=i%>" onclick="modifyClose(<%=i%>); return false;">취소</button>
						<button type="submit" class="btn btn-primary commentDelBtn" id="com_modify<%=i%>" onclick="modifySubmit(<%=i%>,<%=list.get(i).getCom_no()%>,'<%=list.get(i).getCom_content()%>'); return false;">수정</button>
						</td>
					</tr>
					<%}%>
				</tbody>
			</table>
			
			</form>
			<%-- 댓글 보기 영역 끝 --%>

		</div>
	</div>
</body>
</html>