<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
#wrap2 {
	margin-left:  200px;
	margin-right:  200px;
}

		.locmap{
			width: 700px; 
			height: 700px;
        	z-index: 0;
        	position: relative;
        	}
        	
        .mapimg{
        	position : absolute;
        	top : -1px;
        	left : -8px;
        	height: 100%;
        	z-index: 1;
        }
		.c{
			width:100px; 
			height:50px;
			position : absolute;
			/*background: red;*/
		}
		.con1{
		
			top: 145px;
			left: 225px;
			z-index: 30;
		}
		.con2{
		
			top: 95px;
			left: 175px;
			z-index: 29;
		}
		.con3{
		
			top: 310px;
			left: 300px;
			z-index: 28;
		}
		.con4{
			
			top: 380px;
			left: 390px;
			z-index: 27;
		}
		.con5{
			top: 450px;
			left: 190px;
			z-index: 26;
		}
		.con6{
			top: 465px;
			left: 450px;
			z-index: 25;
		}
		.con7{
			top: 415px;
			left: 490px;
			z-index: 24;
		}
		.con8{
			top: 260px;
			left: 290px;
			z-index: 23;
		}
		.con31{
			top: 95px;
			left: 275px;
			z-index: 22;
		}
		.con32{
			top: 125px;
			left: 400px;
			z-index: 21;
		}
		.con33{
			top: 210px;
			left: 340px;
			z-index: 20;
		}
		.con34{
			top: 260px;
			left: 190px;
			z-index: 19;
		}
		.con35{
			top: 290px;
			left: 430px;
			z-index: 18;
		}
		.con36{
			top: 450px;
			left: 345px;
			z-index: 17;
		}
		.con37{
			top: 370px;
			left: 250px;
			z-index: 16;
		}
		.con38{
			top: 520px;
			left: 180px;
			z-index: 15;
		}
		.con39{
			top: 635px;
			left: 140px;
			z-index: 14;
		}

</style>

<body>
<div align="center">
<button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#myModal" >
  지도 열기
</button>
</div>


	<div class="modal" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<div class="locmap modal-body">
					<div>
						<img class="mapimg"
							src="resources/images/map/전국.png">
					</div>
					<a href="paldo.do?areacode=1"><div class="con1 c" ></div></a> <a
						href="paldo.do?areacode=2"><div class="con2 c" ></div></a> <a
						href="paldo.do?areacode=3"><div class="con3 c"></div></a> <a
						href="paldo.do?areacode=4"><div class="con4 c"></div></a> <a
						href="paldo.do?areacode=5"><div class="con5 c"></div></a> <a
						href="paldo.do?areacode=6"><div class="con6 c"></div></a> <a
						href="paldo.do?areacode=7"><div class="con7 c"></div></a> <a
						href="paldo.do?areacode=8"><div class="con8 c"></div></a> <a
						href="paldo.do?areacode=31"><div class="con31 c"></div></a> <a
						href="paldo.do?areacode=32"><div class="con32 c"></div></a> <a
						href="paldo.do?areacode=33"><div class="con33 c"></div></a> <a
						href="paldo.do?areacode=34"><div class="con34 c"></div></a> <a
						href="paldo.do?areacode=35"><div class="con35 c"></div></a> <a
						href="paldo.do?areacode=36"><div class="con36 c"></div></a> <a
						href="paldo.do?areacode=37"><div class="con37 c"></div></a> <a
						href="paldo.do?areacode=38"><div class="con38 c"></div></a> <a
						href="paldo.do?areacode=39"><div class="con39 c"></div></a>
				</div>

			</div>
		</div>
	</div>

<!-- 검색 
		<form action="paldo.do?areacode=${areacode}&keyword=${keyword}" method="get">
			<div class="form-wrap">
				<div class="search-wrap" style="text-align: -webkit-right;">
					<div class="input-group mb-3 w-50">
						<input type="hidden" name="areacode" value="${areachode}"> 
						<input type="text" name="keyword" class="w-75 form-control" placeholder="검색어를 입력해주세요." value="${keyword}">
						<button class="btn btn-outline-secondary" type="submit">검색</button>
					</div>
				</div>
			</div>
		</form>
-->

<style>
#card right-box{
	width: 80%;
	
}

</style>
	<div id="wrap2" class='right-box'>
	<div>총 ${cntt}개 검색 / ${areacode} 지역 검색중</div>
				<!-- Bootstrap Card  -->
		<div class="row g-4">
				<c:forEach items="${aList}" var="dto" varStatus="status">
					<div class="col-3">

						<a href=detail.do?list=paldo&contentid=${dto.contentid}>
							<div class="card" >
								<img src=${ dto.firstimage} class="card-img-top" alt="..." onerror="this.src='resources/images/noimg.png'" height=200px/>
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
		

	</div>
	<br>
   <!-- 페이징 -->
   <div class="pagelist text-center">
             <ul class="pagination justify-content-center" >
      <!-- 이전 출력 시작 -->
      <c:if test="${pv.startPage>1}">
         <a
            href="paldo.do?areacode=${aList[0].areacode}&currentPage=${pv.startPage-pv.blockPage}" class="page-link text-dark text-decoration-none" aria-label="Next">&laquo;</a>
      </c:if>
      <!-- 이전 출력 끝 -->

      <!-- 페이지 출력 시작 -->
      <c:forEach var="i" begin="${pv.startPage}" end="${pv.endPage}">
         <span> <c:url var="currPage" value="paldo.do?areacode=${aList[0].areacode}">
               <c:param name="currentPage" value="${i}" />
            </c:url> <c:choose>
               <c:when test="${i==pv.currentPage}">
                  <li class="page-item"><a href="${currPage}"class=" page-link text-primary text-decoration-none" >${i}</a></li>
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
         <a href="paldo.do?areacode=${aList[0].areacode}&currentPage=${pv.startPage+pv.blockPage}" class="page-link text-dark text-decoration-none" aria-label="Next">&raquo;</a>
      </c:if>
      <!-- 다음 출력 끝 -->
      </ul>
   </div>
   <!-- 페이징 -->

<script type="text/javascript">

$(document).ready(function(){
		$("#c").hover(function(){
			alert("확인");
		});
	
});




</script>

</body>

