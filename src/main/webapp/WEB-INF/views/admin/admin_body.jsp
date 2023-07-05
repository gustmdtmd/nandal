<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<head>
<meta charset="UTF-8">
<title>Nandal admin</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>

<style>
#indexbody {
	position : relative;
	margin-left:  200px;
	margin-right:  200px;
	height: 750px;
	text-align: center;
	
}

#indexbody>div a{
	text-decoration: none;
}


</style>
<body>
	<hr>
  <div id="indexbody">
  		<!--홈페이지 링크-->
	<div>
		<div class="btn btn-outline-secondary btn-sm"><a href="index.do">홈페이지로 돌아가기 링크</a></div>
	</div>
	<br>
  
    <div class="btn btn-outline-secondary btn-sm"><a href="admin_member.do">회원 목록</a></div>
    <div class="btn btn-outline-secondary btn-sm"><a href="nlist.do">공지게시판 글목록</a></div>
    <div class="btn btn-outline-secondary btn-sm"><a href="flist.do">자유게시판 글목록</a></div>
    <div class="btn btn-outline-secondary btn-sm"><a href="areview.do">리뷰게시판 글목록</a></div>
    <div class="btn btn-outline-secondary btn-sm"><a href="aqna.do">질문게시판 글목록</a></div>
  </div>
  <hr>
</body>
