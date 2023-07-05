<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>

<head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	
}

h5 {
	text-align: left;
}

thead {
	text-align: center;
}

tboby {
	text-align: center;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">	</script>
</head>

<body>
	<section class="container">
		<br>
		<h4>질문게시판</h4>
		<br>
		<!-- 본글 -->
		<table class="table table-sm" style="width:80%;margin:0 auto;table-layout: fixed;">
			<thead>
				<tr>
					<!-- 제목 -->
					<td style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
						<h4>${dto.subject}</h4>
					</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<div>
							<span>작성일: </span> ${dto.reg_date}
						</div>
						<div>
							<span>작성자: </span>${dto.nickname}
						</div>
						<div>
							<span>조회수: </span>${dto.readcount}
						</div>
					</td>
				</tr>

				<c:if test="${!empty dto.upload}">
					<tr>
						<td>
							<div class="pt-4 pb-2" align="center">
								<img src="resources/board/qna/${dto.upload}" width="80%" />
							</div>
						</td>
					</tr>
				</c:if>


				<tr>
					<!-- 내용 -->
					<td style="overflow:hidden;word-wrap:break-word;">
						<div class="pt-4 pb-2">${dto.content}</div>
					</td>
				</tr>
				<tr>
					<!--             <th>파일</th>   -->
					<td><c:if test="${!empty dto.upload}">
							<a href="qcontentdownload.do?num=${dto.num}">
								${fn:substringAfter(dto.upload,"_")} </a>
						</c:if> <c:if test="${empty dto.upload }">
							<c:out value="첨부파일 없음" />
						</c:if></td>
				</tr>
			</tbody>
		</table>
		<form name="frm" id="frm" method="get" style="text-align: end;width:80%;margin:0 auto;">
			<input type="hidden" name="contentid" value="${dto.contentid}" />
			<input type="hidden" name="num" value="${dto.num}" /> 
			<input type="hidden" name="currentPage" id="currentPage" value="${currentPage}" /> 
			<input type="hidden" name="ref" value="${dto.ref}" /> 
			<input type="hidden" name="re_step" value="${dto.re_step}" /> 
			<input type="hidden" name="re_level" value="${dto.re_level}" /> 
			<input type="button" id="list" class="btn btn-outline-secondary btn-sm" value="목록" />
			<!-- 회원만 가능 -->
			<c:choose>
				<c:when test="${user.usergrade==1 || user.usergrade==2}">
					<input type="button" id="reply"
						class="btn btn-outline-secondary btn-sm" value="답변" />
				</c:when>
			</c:choose>
			<!-- 작성자만 가능 -->
			<c:choose>
				<c:when test="${user.usercode==dto.writer || user.usergrade==2}">
					<input type="button" id="update"
						class="btn btn-outline-secondary btn-sm" value="수정" />
					<input type="button" id="delete"
						class="btn btn-outline-secondary btn-sm" value="삭제" />
				</c:when>
			</c:choose>


		</form>


		<br> <br> <br>
		<!-- 댓글 리스트 -->

		<div style="width:80%;margin:0 auto;">
			<ol>
				<c:forEach items="${bList}" var="dto" varStatus="status">
					<p><h4 style="float:left;">${dto.nickname}</h4><p>${dto.reg_date}</p>
					<hr>
					<p style="word-wrap:break-word;">
						<c:if test="${dto.re_level>1}">
							<img src="resources/images/level.gif" width="${20*dto.re_level}"
								height="15" />
							<img src="resources/images/re.gif" />
						</c:if>
						${dto.subject}
					</p>
					<hr>
					
					<!-- 작성자만 가능 -->
					<c:choose>
						<c:when test="${user.usercode==dto.writer || user.usergrade==2}">
							<form name="rfrm" id="rfrm" method="post" style="text-align: end;">
								<input type="hidden" name="pnum" value="${dto.pnum}" /> 
								<input type="hidden" name="num" value="${dto.num}" /> 
								<input type="hidden" name="currentPage" id="currentPage" value="${currentPage}" /> 
								<input type="hidden" name="ref" value="${dto.ref}" /> <input type="hidden" name="re_step" value="${dto.re_step}" />
								<input type="hidden" name="re_level" value="${dto.re_level}" />
					
								<input type="button" class="rdelete btn btn-outline-secondary btn-sm" value="삭제" />
							</form>
						</c:when>	
							</c:choose>
						</form>	
				</c:forEach>
			</ol>
		</div>


		<!-- 댓글 입력창 -->
		<c:choose>
			<c:when test="${user.usergrade==1 || user.usergrade==2}">
				<div class="card" style="width:80%;margin:0 auto;">
					<form name="frm" method="post" action="qrview.do">
						<input type="hidden" name="pnum" value="${dto.num}" /> <input
							type="hidden" name="num" value="${dto.num}" /> <input
							type="hidden" name="writer" value="${user.usercode}" /> <input
							type="hidden" name="ref" value="${dto.ref}" /> <input
							type="hidden" name="re_step" value="${dto.re_step}" /> <input
							type="hidden" name="re_level" value="${dto.re_level}" /> <input
							type="hidden" name="currentPage" id="currentPage" value="${currentPage}" />
						<div class="card-body">
							<textarea class="form-control" row="1" name="subject"></textarea>
						</div>
						<div class="card-footer">
							<button class="btn btn-outline-secondary btn-sm" id="btn">등록</button>
						</div>
					</form>
				</div>
			</c:when>
		</c:choose>

		<br />
	</section>

</body>

<script type="text/javascript">
	$(document).ready(function() {
		//본글에 달린 버튼 
		$("#list").click(function() {
			$('#frm').attr("action", "qlist.do?contentid=${contentid}").submit();
		});

		$("#reply").click(function() {
			$('#frm').attr("action", "qwrite.do?contentid=${contentid}").submit();
		});

		$('#update').click(function() {
			$('#frm').attr("action", "qupdate.do?contentid=${contentid}").submit();
		});

		$('#delete').click(function() {
			if (!confirm("삭제 하시겠습니까?")) {
				return false;
			}
			$('#frm').attr("action", "qdelete.do?contentid=${contentid}").submit();
		});
		
		//댓글에 달린 버튼
		$('.rupdate').click(function() {
			if (!confirm("수정 하시겠습니까?")) {
				return false;
			}
			$('#rfrm').attr("action", "qrupdate.do?contentid=${contentid}").submit();
		});

		$('div>ol form').on('click', this, function(){
			if (!confirm("삭제 하시겠습니까?")) {
				return false;
			}
			$(this).attr("action", "qrdelete.do?contentid=${contentid}").submit();
		})
	});
</script>





