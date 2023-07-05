<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:getAsString name="title" /></title>

<style>
* {
	margin: 0;
	padding: 0;
	font-family: '맑은 고딕', '돋움';
	font-size: 17px;
	color: #454545;
}

body{
	background-color: white;
}

a {
  color: #aaa;
  text-decoration: none;
}

ul,
ol {
  padding: 0;
  margin: 0;
  list-style-type: none;
}

li {
  float: left;
}

</style>

</head>
<body>
	<header>
		<tiles:insertAttribute name="admin_header" />
	</header>

	<section>
		<tiles:insertAttribute name="admin_body" />
	</section>

	<footer>
		<tiles:insertAttribute name="admin_footer" />
	</footer>

</body>
</html>