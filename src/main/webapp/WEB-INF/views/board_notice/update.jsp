<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<!-- include summernote css/js-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>

<title>글쓰기</title>

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
						$('#update').bind('click', updateRun);
						$('[name=content]').val(
								$('[name=content]').val().trim());
						$('[name=content]').val(
								$('[name=content]').val().replace(
										/<br\s?\/?>/g, "\n"));
					});

	function updateRun() {
		$('[name=content]').val(
				$('[name=content]').val().replace(/\n/gi, '<br/>'));

		$('#frm').attr('action', 'nupdate.do').submit();
	}
</script>

<body>
	<div id="bodywrap" class="container">
		
		<div style="text-align: center;width: 60%;margin: 0 auto;">
			<br>
			<h2>공지 수정하기</h2>
			<hr>
		</div>
		
		<!-- 썸머노트, 글작성 버튼 -->
		<div style="width: 60%; margin:0 auto;">
			<form name="frm" id="frm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="num" value="${dto.num}" /> 
				<input type="hidden" name="currentPage" value="${currentPage}" /> 
				<input type="text" name="subject" style="width: 40%;" placeholder="제목" value="${dto.subject}" /> 
				<br> 
					<span>대표 이미지 업로드</span><input type="file" name="filename" id="imgpath" accept=".jpg, .png" />
				<br>
				<textarea id="summernote" name="content">${dto.content}</textarea>
				<input class="btn btn-outline-secondary btn-lg" id="update" type="button" style="float: right;" value="수정" onclick="goWrite(this.form)" />
			</form>
			<input type="button" id="list" class="btn btn-outline-secondary btn-lg" value="목록" />
		</div>
		<br>
	</div>
</body>