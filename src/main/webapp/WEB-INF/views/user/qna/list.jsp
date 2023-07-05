<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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

<body>
	<div id="bodywrap" class="container">
		<h4>내가 작성한 질문</h4>
		<input class="btn btn-outline-secondary btn-sm" type="button" onclick="location.href='user.do'" value='뒤로가기'>
		<!-- 검색창 -->
		<form action="/myapp/qlist.do" method="get">
			<div class="form-wrap">
				<div class="search-wrap" style="text-align: -webkit-right;">
					<div class="input-group mb-3 w-50">
						<select name="type" class="form-control">
							<option value="subject"
								<c:if test="${pv.searchKey eq 'subject'}">selected</c:if>>제목</option>
							<option value="content"
								<c:if test="${pv.searchKey eq 'content'}">selected</c:if>>내용</option>
							<option value="total"
								<c:if test="${pv.searchKey eq 'total'}">selected</c:if>>제목+내용</option>
						</select> 
						<input type="text" name="searchWord" class="w-75 form-control" placeholder="검색어를 입력해주세요.">
						<input type="hidden" name="contentid" value="${contentid}">
						<button class="btn btn-outline-secondary" type="submit">검색</button>
					</div>
				</div>
			</div>
		</form>
		<!-- END 검색창 -->

		<c:if test="${empty aList}">
			<c:choose>
				<c:when test="${empty param.searchWord}">
					<div style="width:80%;margin:0 auto;text-align: center;">
						<p>작성한 질문이 없습니다.</p>
							<input type="button" class="btn btn-outline-secondary btn-sm" onclick="history.back()" value='뒤로가기'>
					</div>
					
					<!-- 글쓰기 버튼 -->
					<c:choose>
						<c:when test="${user.usergrade == 2 || user.usergrade == 1}">
							<div class="container">
								<div class="col text-end">
									<button class="btn btn-light row justify-content-end" type="button" onclick="location.href='qwrite.do?contentid=${contentid}'">첫 질문 작성하기</button>
								</div>
							</div>
						</c:when>
					</c:choose>	
				</c:when>
				<c:otherwise>
					<div style="width:80%;margin:0 auto;text-align: center;">
						<p><c:out value="${param.searchWord}"/> 에 대한 검색결과가 없습니다.</p><br>
						<input type="button" class="btn btn-outline-secondary btn-sm" onclick="history.back()" value='뒤로가기'>
					</div>
				</c:otherwise>
			</c:choose>
		</c:if>
		<c:if test="${!empty aList}">
		<table class="table table-hover" style="table-layout: fixed;">
			<thead>
				<tr>
					<th width="10%">번호</th>
					<th width="40%">제목</th>
					<th width="15%">작성자</th>
					<th width="15%">작성일</th>
					<th width="10%">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${aList}" var="dto" varStatus="status">
					<tr>
						<td>${cntt - (pv.blockCount*(pv.currentPage-1)) - status.index}</td>
						<td style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
							<c:url var="path" value="qview.do">
								<c:param name="currentPage" value="${pv.currentPage}" />
								<c:param name="num" value="${dto.num}" />
								<c:param name="contentid" value="${dto.contentid}" />
							</c:url> 
							<c:if test="${dto.re_level>0}">
								<img src="resources/images/level.gif" width="${20*dto.re_level}" height="15" />
								<img src="resources/images/re.gif" />
							</c:if> 
							<a href="${path}">${dto.subject}</a>
						</td>
						<td>${dto.nickname}</td>
						<td>${dto.reg_date}</td>
						<td>${dto.readcount}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>


         <!-- 페이징 -->
         <div class="pagelist text-center"  >
          <ul class="pagination justify-content-center" >
            <!-- 이전 출력 시작 -->
            <c:if test="${pv.startPage>1}">
               <a href="qlist.do?currentPage=${pv.startPage-pv.blockPage}" class="page-link text-dark text-decoration-none" aria-label="Next">&laquo;</a>
            </c:if>   
            <!-- 이전 출력 끝 -->

            <!-- 페이지 출력 시작 -->
            <c:forEach var="i" begin="${pv.startPage}" end="${pv.endPage}">
               <span> <c:url var="currPage" value="qlist.do">
                     <c:param name="currentPage" value="${i}" />
                     <c:param name="searchKey" value="${pv.searchKey}" />
                     <c:param name="searchWord" value="${pv.searchWord}" />
                     <c:param name="contentid" value="${pv.contentid}" />
                  </c:url> 
                  <c:choose>
                     <c:when test="${i==pv.currentPage}">
                        <li class="page-item"><a href="${currPage}" class=" page-link text-primary text-decoration-none" >${i}</a></li>
                     </c:when>
                     <c:otherwise>
                        <li class="page-item"><a href="${currPage}" class="page-link text-dark text-decoration-none">${i}</a></li>
                     </c:otherwise>
                  </c:choose>
               </span>
            </c:forEach>
            <!-- 페이지 출력 끝 -->

            <!-- 다음 출력 시작 -->
            <c:if test="${pv.endPage<pv.totalPage}">
               <a href="qlist.do?currentPage=${pv.startPage+pv.blockPage}" class="page-link text-dark text-decoration-none" aria-label="Next">&raquo;</a>
            </c:if>
            <!-- 다음 출력 끝 -->
            </ul>
         </div>
         <!-- 페이징 -->


		<!-- 게시물 count -->
		<div class="container px-4">
			<div class="row gx-5">
				<div class="container">총 ${cntt}개 게시물이 있습니다.</div>
			</div>

		</div>
		</c:if>
		</div>
</body>