<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
* {
	margin: 0;
	padding: 0;
	border-width: 0;
}

#user_profile {
	width: 100%;
	height: 750px;
	/*background-color: red;*/
}

#pmenu {
	width: 35%;
	height: 400px;
	/*background-color: olive;*/
	position: absolute;
	float: left;
}

.ulist {
	background-color: #f2f2f2;
	width: 170px;
	height: 150px;
	text-align: center;
	position: relative;
	left: 460px;
	top: 50px;
}

#lm {
	font-weight: bold;
	font-size: 18px;
	list-style: none;
}

#lm>a {
	color: #000000;
	text-decoration-line: none;
	position: relative;
	left: -18px;
	top: 20px;
}

#userinfor {
	width: 65%;
	height: 400px;
	/*background-color: green;*/
	float: right;
}

#user_frm {
	/*background-color: yellow;*/
	width: 550px;
	height: 750px;
	/*border: 1px solid #000000;*/
	position: relative;
	left: 40px;
	top: 10px;
}

h1 {
	text-align: center;
	font-size: 30px;
}

#user_img {
	width: 100px;
	height: 100px;
	position: relative;
	left: 225px;
}

.user {
	/*background-color: red;*/
	text-align: center;
	height: 70px;
	width: 500px;
	position: relative;
	top: 20px;
	left: 25px;
	font-weight: bold;
	font-size: 20px;
}

.ubtn {
	width: 100px;
	height: 35px;
	border: 1px solid #000000;
	position: relative;
	top: 20px;
	left: 178px;
	border-radius: 12px;
}

input[type=button]:active, button[type=button]:active {
	background-color: darkgrey;
}

.pop_inner {
	border: 1px solid #000000;
	width: 300px;
	height: 100px;
	background-color: white;
	position: absolute;
	top: 500px;
	left: 842px;
}

.dsc {
	/*background-color: red; */
	position: relative;
	top: 20px;
	left: 12px;
}

.quit, .cancle {
	/*background-color: red; */
	width: 80px;
	height: 25px;
	position: relative;
	top: 25px;
	left: 100px;
	border: 1px solid #000000;
	border-radius: 12px;
}

</style>
<div id="user_profile">
	<div id="pmenu">
		<ul class="ulist">
			<li id="lm"><a href="">프로필</a></li>
			<li id="lm"><a href="userreview.do?list=user&usercode=${dto.usercode}">내가 작성한 리뷰</a></li>
			<li id="lm"><a href="userqna.do?list=user&usercode=${dto.usercode}">내가 작성한 질문</a></li>
			<li id="lm"><a href="userbookmark.do?list=user&usercode=${dto.usercode}">북마크</a></li>
		</ul>
	</div>
	<div id="userinfor">

		<form name="frm_my" id="user_frm" method="get" action="modify.do">
			<h1>회원정보수정</h1>
			<div class="user_img">
				<img id="user_img" src="${dto.img}" width="100%" height="100%" />
			</div>
			<div class="user">
				<span id="user_info">아이디</span> <span id=user_dto>${dto.id}</span>
			</div>

			<div class="user">
				<span id="user_info">닉네임</span> <span id="user_dto">${dto.nickname}</span>
			</div>
			<div class="user birth">
				<span id="user_info">출생년도</span> <span id=user_dto>${dto.birth}</span>
			</div>
			<div class="user gender">
				<span id="user_info">성별</span> <span id="user_dto">${dto.gender}</span>
			</div>
			<div class="user loc">
				<span id="user_info">지역</span> <span id="user_dto">${dto.loc}</span>
			</div>
			<div class="user phone">
				<span id="user_info">번호</span> <span id="user_dto">${dto.phone}</span>
			</div>
			<div class="user email">
				<span id="user_info">이메일</span> <span id="user_dto">${dto.email}</span>
			</div>

			<input type="button" class="ubtn update" id="update" value="정보수정" onclick="location.href='modify.do'" /> 
			<input type="button" class="ubtn del" id="del" value="회원탈퇴" onclick="location.href='#popup'" />
		</form>
	</div>

	<!-- 팝업 -->
	<div id="popup" class="popup" style="display: none;">
		<form name="frm_quit" id="f_quit" method="post" action="quit.do">
			<div class="pop_inner">
				<p class="dsc">정말로 탈퇴하시겠습니까?</p>
				<button type="button" class="quit" id="quit">탈퇴하기</button>
				<button type="button" class="cancle" id="cancle">취소</button>
			</div>
		</form>
	</div>
</div>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	// 회원탈퇴 버튼
	$(document).ready(function() {
		$("#del").click(function() {
			$("#popup").fadeIn();
		});
		$("#cancle").click(function() {
			$("#popup").fadeOut();
		});
		$('#quit').on('click', process);

	});

	function process() {

		//alert('test');
		$.ajax({
			type : 'POST',
			url : 'quit.do',
			dataType : 'text',
			success : viewMessage,
			error : function(xhr, textStatus, error) {
				alert("error:" + xhr.status);
			}
		});

	}

	function viewMessage(res) {
		alert("탈퇴되었습니다.")
		/*if (res == 0) {
			alert("탈퇴에 실패하였습니다.");
			location.href = "login.do";
		} else {
			alert("탈퇴에 성공하셨습니다.");*/
		// document.referrer 이전페이지로 이동
		location.href = "index.do";
		//}

	}
</script>


