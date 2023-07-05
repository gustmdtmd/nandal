<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- include libraries(jQuery, bootstrap) -->
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<!-- include summernote css/js-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>
<title>글쓰기</title>
<link href="resources/css/board.css" type="text/css" rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		$('#summernote').summernote({
			placeholder : 'content',
			minHeight : 370,
			maxHeight : null,
			focus : true,
			lang : 'ko-KR'
		});
		
		//목록으로 
		$("#list").click(function() {
			location.href = document.referrer;
		});
	});

	function goWrite(frm) {
		console.log(frm);
		var subject = frm.subject.value;
		var content = frm.content.value;

		if (subject.trim() == '') {
			alert("제목을 입력해주세요");
			return false;
		}

		if (content.trim() == '') {
			alert("내용을 입력해주세요");
			return false;
		}
		frm.submit();
	}

	$(document).ready(
			function() {
				$('#btnSave').click(
						function() {
							$('[name=content]').val(
									$('[name=content]').val().replace(/\n/gi,
											'<br/>'));
							$('#frm').attr('action', 'qwrite.do').submit();
						});
			});
	
	$(document).ready(function(){
		   $('#imgpath').change(function(){
			  if(this.files[0].size>1000000000 ){
				  alert('1GB 이하만 첨부할 수 있습니다.');
				  $('#imgpath').val('');
				  return false;
			  }
		   });  
		  	  
		});
</script>

<body>
	<div id="bodywrap" class="container">
		
		<div style="text-align: center;width: 60%;margin: 0 auto;">
			<br>
			<h2>질문 글쓰기</h2>
			<hr>
		</div>
		
		<!-- 썸머노트, 글작성 버튼 -->
		<div style="width: 60%; margin: auto;">
			<form name="frm" method="post" enctype="multipart/form-data" action="qwrite.do">
				<input type="hidden" name="contentid" id="contentid" value="${contentid}" />
				<input type="hidden" name="writer" value="${user.usercode}" />
				<input type="text" name="subject" style="width: 40%;" placeholder="제목" /> 
				<br> 				
				<span>대표 이미지 업로드</span><input type="file" name="filename" id="imgpath" accept=".jpg, .png" />
				<br>
				<textarea id="summernote" name="content"></textarea>
				<input class="btn btn-outline-secondary btn-lg" id="subBtn" type="button" value="작성" style="float: right;" onclick="goWrite(this.form)" />
				<!-- 답변글일때 -->
			 <c:if test="${dto!=null}">
			 	 <input type="hidden" name="num" id="num" value="${dto.num}" />
				 <input type="hidden" name="currentPage" id="currentPage" value="${currentPage}" />
				 <input type="hidden" name="ref" value="${dto.ref}" />
				 <input type="hidden" name="re_step" value="${dto.re_step}" />
				 <input type="hidden" name="re_level" value="${dto.re_level}" />
			 </c:if>
			</form>
			<input type="button" id="list" class="btn btn-outline-secondary btn-lg" value="목록" />
		</div>
	</div>
</body>