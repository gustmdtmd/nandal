<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
* {
	margin: 0;
	padding: 0;
	border-width: 0;
}

h1 {
	text-align: center;
}

.modify_frm {
	/*background-color: yellow;*/
	width: 500px;
	height: 910px;
	/*border: 1px solid #000000;*/
	margin: 0 auto;
	position: relative;
	top: 10px;
}

.modify {
	position: relative;
	top: 100px;
	margin: 10px 0;
}

.modify #modify_info {
	width: 100%;
	font-weight: bold;
	font-size: 18px;
	float: left;
	position: relative;
	left: 80px;
}

.modify .modify_err {
	width: 100%;
	font-size: 15px;
	float: left;
	position: relative;
	left: 80px;
}

.modify input, select {
	position: relative;
	left: 75px;
}

#modify_img {
	width: 100px;
	height: 100px;
	position: absolute;
	left: 200px;
	top: -110px;
}

input[type=text], input[type=password], input[type=int], #loc {
	width: 380px;
	height: 30px;
	border: 1px solid #000000;
	font-size:15px;
}

input[type=file] {
	width: 300px;
	height: 25px;
	border: 1px solid #000000;
}

.modify_btn {
	/*background-color: gray;*/
	width: 400px;
	height: 25px;
	position: relative;
	top: 95px;
	left: 51px;
}

.modify_update {
	width: 160px;
	height: 25px;
	border: 1px solid #000000;
	position: relative;
	top: 0px;
	left: 35px;
	border-radius: 12px;
}

.modify_cancel {
	width: 160px;
	height: 25px;
	border: 1px solid #000000;
	position: relative;
	top: 0px;
	left: 35px;
	border-radius: 12px;
}

input[type=button]:active {
	background-color: darkgrey;
}
</style>
<form name="frm" class="modify_frm" id="frm" method="post"
	enctype="multipart/form-data">
	<h1>회원정보 수정</h1>

	<div class="modify m_img">
		<img id="modify_img" src="resources/images/profile/${dto.img}" /> <input
			type="file" name="filename" id="imgpath" accept=".jpg, .png" />
	</div>
	<div class="modify">
		<span id="modify_info">아이디</span><input type="text" name="id" id="id"
			value="${dto.id}" readonly />
	</div>


	<div class="modify">
		<span id="modify_info">비밀번호</span><input type="password"
			name="password" id="password" onchange="isSame()"
			value="${dto.password}" placeholder="영어, 숫자, 특수문자를 조합하여 8~12자 안으로 입력" /><span
			class="modify_err" id="passworderror"></span>
	</div>
	<div class="modify">
		<span id="modify_info">비밀번호 확인</span><input type="password"
			name="ckpassword" id="ckpassword" onchange="isSame()"
			value="${dto.password}" placeholder="비밀번호 확인" /><span
			class="modify_err" id="same"></span>
	</div>
	<div class="modify">
		<span id="modify_info">닉네임</span><input type="text" name="nickname"
			id="nickname" onchange="checkNick()" value="${dto.nickname}"
			placeholder="영어,한글,숫자 상관없이 2~7자 안으로 입력 " /> <span class="modify_err"
			id="nickerror"></span>
	</div>
	<div class="modify birth">
		<span id="modify_info">출생년도</span><input type="int" name="birth"
			id="birth" value="${dto.birth}" readonly />
	</div>
	<div class="modify gender">
		<span id="modify_info">성별</span>
		<div>
			<input type="text" name="gender" id="gender" value="${dto.gender}"
				readonly />
		</div>
	</div>
	<div class="modify loc">
		<span id="modify_info">지역</span> <select name="loc" id="loc">
			<option value="" id="choice">==선택==</option>
			<option value="서울">서울</option>
			<option value="인천">인천</option>
			<option value="대전">대전</option>
			<option value="대구">대구</option>
			<option value="광주">광주</option>
			<option value="부산">부산</option>
			<option value="울산">울산</option>
			<option value="세종">세종</option>
			<option value="경기">경기</option>
			<option value="강원">강원</option>
			<option value="충북">충북</option>
			<option value="충남">충남</option>
			<option value="경북">경북</option>
			<option value="경남">경남</option>
			<option value="전북">전북</option>
			<option value="전남">전남</option>
			<option value="제주">제주</option>
			<option value="해외">해외</option>
		</select>
	</div>
	<div class="modify phone">
		<span id="modify_info">번호</span><input type="text" name="phone"
			id="phone" onchange="isPhone()" value="${dto.phone}"
			placeholder="전화번호 입력 " /><span class="modify_err" id="phoneerror"></span></span>
	</div>
	<div class="modify email">
		<span id="modify_info">이메일</span><input type="text" name="email"
			id="email" onchange="isEmail()" value="${dto.email}"
			placeholder="이메일 입력" /><span class="modify_err" id="emailerror"></span>
	</div>

	<div class="modify_btn">
		<input type="hidden" name="usercode" value="${dto.usercode }" /> <input
			type="hidden" name="usergrade" value="${dto.usergrade }" /> <input
			type="button" class="modify_update" id="update" value="수정" /> <input
			type="button" class="modify_cancel" id="cancel" value="취소" />
	</div>
</form>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	var pwJ = /^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,12}$/;
	var nicknameJ = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,7}$/;
	var emailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	var phoneJ = /^01([0|1|6|7|8|9]?)([0-9]{3,4})([0-9]{4})$/;

	$(document).ready(function() {
		$("#loc").val("${dto.loc}").prop("selected", true);
		$('#update').bind('click', updateRun);
		$('#cancel').bind('click', cancelRun);
	});
	function updateRun() {
		var p1 = document.getElementById("password").value;
		var p2 = document.getElementById("ckpassword").value;
		var nickname = document.getElementById("nickname").value;
		var loc = document.getElementById("loc");
		var phone = document.getElementById("phone").value;
		var email = document.getElementById("email").value;

		if (p1 == "" || !pwJ.test(p1) || p1 != p2) {
			alert("비밀번호를 확인하세요.")
			return false;
		}

		if (nickname == "" || !nicknameJ.test(nickname)) {
			alert("닉네임을 확인하세요.")
			return false;
		}

		if ($("#loc").val() == "") {
			alert("지역을 선택하세요");
			return false;
		}
		if (phone = "" || !phoneJ.test(phone)) {
			alert("전화번호를 확인하세요.")
			return false;
		}

		if (email = "" || !emailJ.test(email)) {
			alert("이메일을 확인하세요.")
			return false;
		}
		$('#frm').attr('action', 'modify.do').submit();
	}

	function cancelRun() {
		history.go(-1);
	}

	// 닉네임 중복체크
	function checkNick() {
		$.ajax({
			url : 'nickCheck.do',
			type : 'POST',
			data : {
				"nickname" : $('#nickname').val()
			},
			dataType : 'text',
			success : viewMessage,
			error : function(request, status, error) {
				alert("status : " + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		});
	}

	function viewMessage(res) {
		//alert("viewMessage: " + res)
		var nickname = document.getElementById("nickname").value;
		if (res == "n") {
			document.getElementById("nickerror").innerHTML = "<span style='color: red;'>이미 사용중인 닉네임입니다.</span>";
		} else {
			if (nicknameJ.test(nickname)) {
				document.getElementById("nickerror").innerHTML = "<span style='color: blue;'>사용가능한 닉네임입니다.</span>";
			} else {
				document.getElementById("nickerror").innerHTML = "<span style='color: red;'>조건에 맞지 않는 닉네임입니다.</span>";
			}
		}
	}

	function isSame() {
		var p1 = document.getElementById("password").value;
		var p2 = document.getElementById("ckpassword").value;
		if (p1 == "" || !pwJ.test(p1)) {
			document.getElementById("passworderror").innerHTML = "<span style='color: red;'>비밀번호를 다시 입력하세요.</span>";
		} else {
			document.getElementById("passworderror").innerHTML = "<span style='color: blue;'>완료.</span>";
			if (p1 != p2) {
				document.getElementById("same").innerHTML = "<span style='color: red;'>비밀번호가 일치하지 않습니다.</span>";
			} else {
				document.getElementById("same").innerHTML = "<span style='color: blue;'>비밀번호가 일치합니다.</span>";
			}
		}
	}

	function isPhone() {
		var phone = document.getElementById("phone").value;
		if (phone = "" || !phoneJ.test(phone)) {
			document.getElementById("phoneerror").innerHTML = "<span style='color: red;'>잘못된 번호입니다.</span>";
		} else {
			document.getElementById("phoneerror").innerHTML = "<span style='color: blue;'>완료.</span>";
		}
	}

	function isEmail() {
		var email = document.getElementById("email").value;
		if (email = "" || !emailJ.test(email)) {
			document.getElementById("emailerror").innerHTML = "<span style='color: red;'>잘못된 메일입니다.</span>";
		} else {
			document.getElementById("emailerror").innerHTML = "<span style='color: blue;'>완료.</span>";
		}
	}
</script>
