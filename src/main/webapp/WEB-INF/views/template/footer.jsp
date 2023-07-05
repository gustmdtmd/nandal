<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
footer {
	position : relative;
	text-align: center;
	height: 105px;

	background: #f2f2f2;
  	
	transform: translatY(-100%);
	
}

footer div{
    display: inline-block;
    vertical-align: middle;
}

.footertable {

}

footer table {
	padding: 10px;
}
</style>    
	<c:if test="${user.usergrade==2}">
		<li><a href="admin.do">Admin</a></li>
	</c:if>
	<div class="fbox"><a href="index.do"><img src="resources/images/logo/logo.png" /></a></div>
	
	<div class="fbox">
		<table>
			<tr>
				<th>Copyright ⓒ 프로젝트 난달</th>
			</tr>
			<tr>
				<td>임호진, 김민지, 윤솔, 이순호, 이준혁, 이현승</td>
			</tr>
		</table>
	</div>
	<span>            </span>
	<div class="fbox">
		<a id="logo" href="#"> <img src="resources/images/logo/tourapiLogo.png" /></a>
		<a id="logo" href="#"> <img src="resources/images/logo/datalab_logo.png" /></a>
	</div>
