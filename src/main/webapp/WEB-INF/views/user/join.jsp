<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
* {
	margin: 0;
	padding: 0;
	border-width: 0;
}

#join_frm {
	/*background-color: yellow;*/
	width: 500px;
	height: 1000px;
	/*border: 1px solid #000000;*/
	margin: 0 auto;
	position: relative;
	top: 10px;
}

/*회원가입*/
h1 {
	text-align: center;
}

.field {
	position: relative;
	top: 20px;
	margin: 10px 0;
}

.field #join_info {
	width: 100%;
	font-weight: bold;
	font-size: 20px;
	float: left;
	position: relative;
	left: 80px;
}

.field .join_err {
	width: 100%;
	font-size: 18px;
	float: left;
	position: relative;
	left: 80px;
}

.field input, select, label {
	position: relative;
	left: 75px;
}

/*정보입력*/
input[type=text], input[type=password], input[type=int], #loc {
	width: 380px;
	height: 30px;
	border: 1px solid #000000;
	font-size:15px;
}

label {
	vertical-align: -1px
}

.genchk {
	width: 13px;
	height: 13px;
}

input[type=file] {
	width: 250px;
	height: 35px;
	border: 1px solid #000000;
}

input[type=submit] {
	width: 250px;
	height: 35px;
	border: 1px solid #000000;
	position: relative;
	top: 45px;
	left: 125px;
	border-radius: 12px;
}

input[type=submit]:active {
	background-color: darkgrey;
}
</style>
<!-- multipart/form-data	파일(<input type="file">)이 포함된 폼을 전송할 때 사용. -->
<form name="frm" id="join_frm" action="join.do" method="post"
	enctype="multipart/form-data">
	<h1>회원가입</h1>
	<div class="field">
		<span id="join_info">아이디</span><input type="text" name="id" id="id"
			onchange="checkId()" placeholder="영문과 숫자를 조합하여 4~12자 안으로 입력." /> <span
			class="join_err" id="iderror"></span>
	</div>


	<div class="field">
		<span id="join_info">비밀번호</span><input type="password" name="password" id="password"
			onchange="isSame()" placeholder="영어, 숫자, 특수문자를 조합하여 8~12자 안으로 입력" /><span class="join_err"	
			id="passworderror"></span>
	</div>
	<div class="field">
		<span id="join_info">비밀번호 확인</span><input type="password" name="ckpassword"
			id="ckpassword" onchange="isSame()" placeholder="비밀번호 확인" /> <span class="join_err"
			id="same"></span>
	</div>
	<div class="field">
		<span id="join_info">닉네임</span><input type="text" name="nickname" id="nickname"
			onchange="checkNick()" placeholder="영어,한글,숫자 상관없이 2~7자 안으로 입력 " /> <span class="join_err" id="nickerror"></span>
	</div>
	<div class="field birth">
		<span id="join_info">출생년도</span><input type="int" name="birth" id="birth"
			onchange="isBirth()" placeholder="출생년도 4자리 입력 "/> <span class="join_err" id="birtherror"></span>
	</div>
	<div class="field gender">
		<span id="join_info">성별</span>
		<div>
			<input type="radio" name="gender" class="genchk" id="gender" /><label
				for="">남</label> <input type="radio" name="gender" class="genchk"
				id="gender" /><label for="">여</label>
		</div>
		<span id="gendererror"></span>
	</div>
	<div class="field loc">
		<span id="join_info">지역</span> <select name="loc" id="loc" onchange="isLoc()">
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
		</select> <span id="locerror"></span>
	</div>
	<div class="field phone">
		<span id="join_info">번호</span><input type="text" name="phone" id="phone"
			onchange="isPhone()" placeholder="전화번호 입력 "/> <span class="join_err" id="phoneerror"></span>
	</div>
	<div class="field email">
		<span id="join_info">이메일</span><input type="text" name="email" id="email"
			onchange="isEmail()" placeholder="이메일 입력"/> <span class="join_err" id="emailerror"></span>
	</div>
	<div class="field img">
		<span id="join_info">프로필이미지</span> <input type="file" name="filename" id="imgpath"
			accept=".jpg, .png" />
	</div>
	<p>
		<input type="submit" id="submit" value="가입하기" />
	</p>
</form>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	// 정규식
	var idJ = /^(?=.*[a-z])(?=.*\d)[a-z0-9]{4,12}$/;
	var pwJ = /^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,12}$/;
	var nicknameJ = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,7}$/;
	var birthJ = /^[0-9]{4,4}$/;
	var emailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	var phoneJ = /^01([0|1|6|7|8|9]?)([0-9]{3,4})([0-9]{4})$/;

	//정보 미입력시 가입 불가
	$(document).ready(function() {
		$('#submit').on('click', submit);
	});

	function submit() {
		var id = document.getElementById("id").value;
		var p1 = document.getElementById("password").value;
		var p2 = document.getElementById("ckpassword").value;
		var nickname = document.getElementById("nickname").value;
		var birth = document.getElementById("birth").value;
		var gender = document.getElementById("gender");
		var loc = document.getElementById("loc");
		var phone = document.getElementById("phone").value;
		var email = document.getElementById("email").value;

		if (id == "" || !idJ.test(id)) {
			alert("아이디를 확인하세요.")
			return false;
		}

		if (p1 == "" || !pwJ.test(p1) || p1 != p2) {
			alert("비밀번호를 확인하세요.")
			return false;
		}

		if (nickname == "" || !nicknameJ.test(nickname)) {
			alert("닉네임을 확인하세요.")
			return false;
		}

		if (birth == "" || !birthJ.test(birth) || birth < 1900) {
			alert("생일을 확인하세요.")
			return false;
		}

		if ($("input[name=gender]:radio:checked").length < 1) {
			alert("성별을 선택하세요");
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
		alert('회원가입을 축하드립니다!')
	}

	// 아이디 중복체크
	function checkId() {

		$.ajax({
			url : 'idCheck.do',
			type : 'POST',
			data : {
				"id" : $('#id').val()
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
		var id = document.getElementById("id").value;
		if (res == "n") {
			document.getElementById("iderror").innerHTML = "<span style='color: red;'>이미 사용중인 아이디입니다.</span>";
		} else {
			if (idJ.test(id)) {
				document.getElementById("iderror").innerHTML = "<span style='color: blue;'>사용가능한 아이디입니다.</span>";
			} else{
				document.getElementById("iderror").innerHTML = "<span style='color: red;'>조건에 맞지 않는 아이디입니다.</span>";
			}
		}
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
			success : view,
			error : function(request, status, error) {
				alert("status : " + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		});
	}

	function view(res) {
		//alert("viewMessage: " + res)
		var nickname = document.getElementById("nickname").value;
		if (res == "n") {
			document.getElementById("nickerror").innerHTML = "<span style='color: red;'>이미 사용중인 닉네임입니다.</span>";
		} else {
			if (nicknameJ.test(nickname)) {
				document.getElementById("nickerror").innerHTML = "<span style='color: blue;'>사용가능한 닉네임입니다.</span>";
			} else{
				document.getElementById("nickerror").innerHTML = "<span style='color: red;'>조건에 맞지 않는 닉네임입니다.</span>";
			}
		}
	}

	// 각 정보 입력 및 정규식 체크 
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

	function isBirth() {
		var birth = document.getElementById("birth").value;
		if (birth == "" || !birthJ.test(birth) || birth < 1900) {
			document.getElementById("birtherror").innerHTML = "<span style='color: red;'>태어난 년도를 입력하세요.</span>";
		} else {
			document.getElementById("birtherror").innerHTML = "<span style='color: blue;'>완료.</span>";
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

	$(document).ready(function() {
		$('#imgpath').change(function() {
			if (this.files[0].size > 1000000000) {
				alert('1GB 이하만 첨부할 수 있습니다.');
				$('#imgpath').val('');
				return false;
			}
		});

	});
</script>