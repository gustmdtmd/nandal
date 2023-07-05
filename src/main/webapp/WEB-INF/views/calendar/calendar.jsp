<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

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
.ui-widget-header { border: none !important; background-color: transparent !important; }

.ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default, .ui-button, html .ui-button.ui-state-disabled:hover, html .ui-button.ui-state-disabled:active {
    border: 1px solid #fff !important;
    background: #fff !important;
    font-weight: normal !important;
    color: #454545 !important;
    text-align: center !important;
    font-size: 28px;
}

.ui-widget.ui-widget-content {
    width: 385px;
}

.ui-datepicker .ui-datepicker-title {
    font-size: 23px;
}

.ui-datepicker .ui-datepicker-header {
    width: 100%;
}

.ui-datepicker th {
    font-size: 21px;
    padding: 0.7em !important;
}

.ui-datepicker-calendar th:first-child {
	color: #ff0000 !important;
}

.ui-datepicker-calendar th:nth-last-child(1) {
	color: #0d47a1 !important;
}

.ui-datepicker-calendar tr td:first-child a {
	color: #ff0000 !important;
}

.ui-datepicker-calendar tr td:nth-last-child(1) a {
	color: #0d47a1 !important;
}
#calendarbody{
	margin-left:  200px;
	margin-right:  200px;
}

</style>


 
<body>
<div id="calendarbody">
	<div class="calendarsearch" align="center">
		<br>
	    <p>조회기간 선택해주세요 
	        <input type="text" id="sdate">
	        <input type="text" id="edate">
	        <span id="findfestival"  class="btn btn-secondary" ><a id="calender_date" herf="calendar.do">검색</a></span>
	    </p>
	    
	   
	</div>
<hr>
	<!-- 검색결과 -->
	<div id="wrap2" class='right-box'>

		<div class="row g-4">

				<c:forEach items="${aList}" var="dto" varStatus="status">
					<div class="col-3">

						<a href=detail.do?list=calendar&contentid=${dto.contentid}>
							<div class="card">
								<img src=${ dto.firstimage} class="card-img-top" alt="..." onerror="this.src='resources/images/noimg.png'" height=300px/>
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
         <a href="calendar.do?sdate=${aList[0].eventstartdate}&edate=${aList[0].eventenddate}&currentPage=${pv.startPage-pv.blockPage}" class="page-link text-dark text-decoration-none" aria-label="Next">&laquo;</a>
      </c:if>
      <!-- 이전 출력 끝 -->

      <!-- 페이지 출력 시작 -->
      <c:forEach var="i" begin="${pv.startPage}" end="${pv.endPage}">
         <span> <c:url var="currPage" value="calendar.do?sdate=${sdate}&edate=${edate}">
               <c:param name="currentPage" value="${i}" />
            </c:url> <c:choose>
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
         <a href="calendar.do?sdate=${sdate}&edate=${edate}&currentPage=${pv.startPage+pv.blockPage}" class="page-link text-dark text-decoration-none" aria-label="Next">&raquo;</a>
      </c:if>
      <!-- 다음 출력 끝 -->
      </ul>
   </div>
   <!-- 페이징 -->





</div>
</body>

<script>
$(document).ready(function () {
    $.datepicker.regional['ko'] = {
        closeText: '닫기',
        prevText: '이전달',
        nextText: '다음달',
        currentText: '오늘',
        monthNames: ['1월(JAN)','2월(FEB)','3월(MAR)','4월(APR)','5월(MAY)','6월(JUN)',
        '7월(JUL)','8월(AUG)','9월(SEP)','10월(OCT)','11월(NOV)','12월(DEC)'],
        monthNamesShort: ['1월','2월','3월','4월','5월','6월',
        '7월','8월','9월','10월','11월','12월'],
        dayNames: ['일','월','화','수','목','금','토'],
        dayNamesShort: ['일','월','화','수','목','금','토'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        weekHeader: 'Wk',
        dateFormat: 'yymmdd',
        firstDay: 0,
        isRTL: false,
        showMonthAfterYear: true,
        yearSuffix: '',
        showOn: 'both',
        buttonText: "달력",
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        yearRange: 'c-99:c+99',
    };
    $.datepicker.setDefaults($.datepicker.regional['ko']);

    $('#sdate').datepicker();
    $('#sdate').datepicker("option", "maxDate", $("#edate").val());
    $('#sdate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#edate").datepicker( "option", "minDate", selectedDate );
    });

    $('#edate').datepicker();
    $('#edate').datepicker("option", "minDate", $("#sdate").val());
    $('#edate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#sdate").datepicker( "option", "maxDate", selectedDate );
    });
});


$(document).ready(function () {
	$('#findfestival').on('click', find);
});

function find() {
	var sd = $("#sdate").val();
	var ed = $("#edate").val();
	document.getElementById("calender_date").href="calendar.do?sdate="+sd+"&edate="+ed;
}

</script>

