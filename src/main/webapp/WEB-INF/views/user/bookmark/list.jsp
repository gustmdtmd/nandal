<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
<meta charset="UTF-8">

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

<style>
.profile {
	width: 30px;
	height: 30px;
	object-fit: cover;
}
</style>


<body>
	<div id="bodywrap" class="container">
		<h4>내가 찜한 관광정보</h4>
		<input class="btn btn-outline-secondary btn-sm" type="button" onclick="location.href='user.do'" value='뒤로가기'>
		<hr>		
		<c:if test="${empty aList}">
					<div style="width:80%;margin:0 auto;text-align: center;">
						<p><c:out value="${param.searchWord}"/> 에 대한 검색결과가 없습니다.</p><br>
						<input type="button" class="btn btn-outline-secondary btn-sm" onclick="history.back()" value='뒤로가기'>
					</div>
		</c:if>
		<c:if test="${!empty aList}">
			<!-- Bootstrap Card  -->
			<div class="row g-4" >
				<c:forEach items="${aList}" var="dto" varStatus="status">
					<div class="col-3">
						<a href=detail.do?list=user&contentid=${dto.contentid}>
							<div class="card">
								<img src=${ dto.firstimage} class="card-img-top" alt="..." onerror="this.src='resources/images/noimg.png'" height=250px />
								<div class="card-body">
									<div>
										<span class="card-title">${dto.title}</span>
									</div>
								</div>
							</div>
						</a>
						</div>
				</c:forEach>
			</div>

			</c:if>

	</div>
</body>


