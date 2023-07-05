<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>   
#bodywrap{
  width:80%;
  margin:10px auto;
}

#bodywrap table,tr,th,td{
   border:1px solid black;
   border-collapse: collapse;
   text-align: center;
}


 .pagelist a{
    text-decoration: none;
    color:black;
 }
 
 .pagelist a:hover, .pagelist .pagecolor{
   text-decoration: underline;
   color:red
 }
</style>

 <div id="bodywrap">
   <table>
     <tr>

       <th width="5%">회원번호</th>
       <th width="5%">회원등급</th>
       <th width="5%">회원명</th>
       <th width="5%">닉네임</th>
       <th width="5%">출생년도</th>
       <th width="5%">성별</th>
       <th width="5%">거주지역</th>
       <th width="5%">프로필 링크</th>
       <th width="5%">유저 정보 수정</th>
       <th width="5%">작성 리뷰 보기</th>
       <th width="5%">작성 질문 보기</th>
     </tr>
     
     <c:forEach items="${aList}" var="dto">
       <tr>

         <td>${dto.usercode}</td>
			<td>         
         <c:choose>
         	<c:when test="${dto.usergrade==0}">
         		탈퇴 회원	
         	</c:when>
         	<c:when test="${dto.usergrade==1}">
         		일반 회원	
         	</c:when>
         	<c:when test="${dto.usergrade==2}">
         		관리자	
         	</c:when>
         </c:choose>
         </td>
         
         
  		<td>${dto.id}</td>
  		<td>${dto.nickname}</td>
  		<td>${dto.birth}</td>
  		<td>${dto.gender}</td>
  		<td>${dto.loc}</td>
  		<td><img src="resources/images/profile/${dto.img}" width="100%" height="100%"/></td>
  		<td><a href="usermodify.do?list=admin_member&usercode=${dto.usercode}"> 정보 수정</a></td>
  		<td><a href="userreview.do?list=admin_member&usercode=${dto.usercode}">작성한 리뷰</a></td>
  		<td><a href="userqna.do?list=admin_member&usercode=${dto.usercode}">작성한 질문</a></td>
       </tr>     
     </c:forEach>
   </table> 
   
   <div class="pagelist">
     <!-- 이전 출력 시작 -->
       <c:if test="${pv.startPage>1}">
          <a href="list.do?currentPage=${pv.startPage-pv.blockPage}">이전</a>
       </c:if>
     <!-- 이전 출력 끝 -->
     
      <!-- 페이지 출력 시작 -->
       <c:forEach var="i" begin="${pv.startPage}"  end="${pv.endPage}">
         <span>
          <c:url var="currPage" value="list.do">
              <c:param name="currentPage" value="${i}" />
           </c:url>  
           <c:choose>
              <c:when test="${i==pv.currentPage}">
                <a href="${currPage}" class="pagecolor">${i}</a>
              </c:when>
              <c:otherwise>
              <a href="${currPage}">${i}</a>
              </c:otherwise>
            </c:choose>
         </span>
       </c:forEach>
      <!-- 페이지 출력 끝 -->
      
      <!-- 다음 출력 시작 -->
       <c:if test="${pv.endPage<pv.totalPage}">
          <a href="list.do?currentPage=${pv.startPage+pv.blockPage}">다음</a>
       </c:if>
     <!-- 다음 출력 끝 -->
      
   </div>
 </div>