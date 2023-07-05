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



#modifybody {
		text-align: center;
		width: 30%;
		margin: 0 auto;
}

#usergrade {
	border: 1px solid black;
}

</style>

<h1>회원 등급 수정</h1>
<div id="modifybody">
	<br><br>
	<form name="frm" class="modify_frm" id="frm" method="post" action="usermodify.do">
		<input type="hidden" name="usercode" value="${dto.usercode}" />
	
		<div class="modify card">
			<h4 class="card-title">등급</h4>
			<div class="card-body"> 
				<select name="usergrade" id="usergrade">
					<option value="" id="choice" disabled="disabled">==선택==</option>
					<option value=0>탈퇴</option>
					<option value=1>일반</option>
					<option value=2>관리자</option>
				</select>
			</div>
		</div>
		<br>
		<button class="btn btn-secondary" type="submit" value="수정">수정</button>
	</form>
	<br><br>
</div>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		$("#usergrade").val("${dto.usergrade}").prop("selected", true);

	});
	
		
</script>
