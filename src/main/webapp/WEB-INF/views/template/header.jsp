<%@page import="dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<head>
<meta charset="UTF-8">
<link href="resources/css/header.css" type="text/css" rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>

<style type="text/css">
header{
	width: 1920px;
	position:static;

}

style>ul, ol {
	padding: 0;
	margin: 0;
}

.ibx {
	width: 100%;
	margin: 0 auto;
	background: #f2f2f2;
}

#main_menu li {
	float: left;
	margin-top: 35px;
}

#navbar {
	background: #f2f2f2;
	height: 100px;
	margin: auto;
	width: 700px;
	display: flex;
	justify-content: center;
}

#main_menu li a {
	background: #f2f2f2;
	text-decoration: none;
	padding: 10px 0 10px 30px;
	font-weight: 1000;
	color: black;
}

.pbx {
	margin-right: 200px;
	margin: 0 0 0 150px;
	float: left;
	height: 100%;
	padding: 10px;
	/*박스가 패딩때문에 커지는 것을 막아준다*/
	box-sizing: border-box;
}


/*상단*/
.top {
	position: static;
	height: 110px;
	z-index: 999; /*가장 위로 배치*/
}

.top1 {
	width: 30%
	text-align: center;
	background: #f2f2f2;
}

.top2 {
	width: 40%;
	text-align: center;
}

.top3 {
	width: 20%;
	text-align: center;
	background: #f2f2f2;
	padding: 10px 0 10px 30px;
}

#top_menu li {
	margin-top: 35px;
}

#top_menu li a {
	padding: 10px 0 10px 30px;
	text-decoration: none;
	text-align: center;
	color: black;
}
</style>

<!--header-->
<header class="ibx top">
	<!--로고-->
	<div class="pbx top1" id="logo">
		<a id="logo" href="index.do"> <img src="resources/images/logo/logo.png" />
		</a>
	</div>
	<!-- 메뉴바 -->
	<nav class="pbx top2" id="navbar">
		<ul id="main_menu">
			<li><a href="recommand.do">Big-Data</a></li>
			<li><a href="paldo.do">Map</a></li>
			<li><a href="calendar.do">Calendar</a></li>
			<li><a href="bookmarklist.do">Favorites</a></li>
			<li><a href="flist.do">FreeBoard</a></li>
		</ul>
	</nav>
	<!--상단 메뉴-->
	<div class="pbx top3">
		<ul id="top_menu">
			<li><a href="nlist.do">Notice</a></li>
			<c:if test="${empty user}">
				<li class="login"><a href="login.do">Login</a></li>
				<li><a href="terms.do">Join</a></li>
			</c:if>
			<c:if test="${!empty user}">
				<li class="logout"><a href="logout.do">Log Out</a></li>
				<li><a href="user.do">Profile</a></li>
			</c:if>
		</ul>
	</div>
</header>