<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
* {
	margin: 0;
	padding: 0;
	border-width: 0;
}

#login_frm {
	/*background-color: yellow;*/
	width: 500px;
	height: 700px;
	/*border: 1px solid #000000;*/
	margin: 0 auto;
}

/*로그인*/
h1 {
	text-align: center;
	position: relative;
	top: 130px;
}

/*div*/
.login_page {
	/*background-color: red;*/
	width: 450px;
	height: 550px;
	margin: 25px;
	border: 1px solid #000000;
}

.log {
	position: relative;
	border: 1px solid #000000;
	width: 380px;
	height: 60px;
	font-size:18px;
}

/*로그인 아이디창*/
.login_page #id {
	top: 170px;
	left: 35px;
}

/*로그인 비밀번호창*/
.login_page #password {
	top: 180px;
	left: 35px;
}

/*버튼*/
.login_btn {
	width: 300px;
	height: 40px;
	position: relative;
	border: 1px solid #000000;
	border-radius: 12px;
}

/*로그인 버튼*/
.logbtn {
	top: 230px;
	left: 75px;
}

/*회원가입 버튼*/
.joinbtn {
	top: 240px;
	left: 75px;
}

input[type=button]:active {
	background-color: darkgrey;
}
</style>
<form name="log_f" id="login_frm">
	<h1>로그인</h1>
	<div class="login_page">
		<input type="text" name="id" class="log" id="id" placeholder="아이디 입력" />
		<input type="password" name="password" class="log" id="password" placeholder="비밀번호 입력" /> 
		<span><input type="button" class="login_btn logbtn" id="login" value="login" /></span> 
		<!-- <span><input type="button" class="login_btn joinbtn" value="join" onclick="location.href='join.do'" /></span> -->
	</div>
</form>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#login').on('click', process);
	});

	function process() {

		var idNode = document.querySelector('#id');
		var passNode = document.querySelector('#password');

		if (idNode.value == '') {
			alert('아이디를 입력하세요');
			return false;
		}

		if (passNode.value == '') {
			alert('비밀번호를 입력하세요');
			return false;
		}

		//alert('test');
		$.ajax({
			type : 'POST',
			url : 'logpro.do',
			dataType : 'text',
			data : {
				"id" : $('#id').val(),
				"password" : $('#password').val()
			},
			success : viewMessage,
			error : function(xhr, textStatus, error) {
				alert("error:" + xhr.status);
			}
		});
	}

	function viewMessage(res) {
		//console.log("res: " +res)
		if (res == 'n') {
			alert("로그인에 실패하였습니다.");
			location.href = "admin.do";
		} else {
			alert(res + "님 환영합니다.");
			// document.referrer 이전페이지로 이동
			location.href = document.referrer;
		}

	}
</script>