<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<style>
	#recommandtitle {
		 font-weight: 1000;
	}
	
	
	</style>
<body>
	<hr>
	<div class ="recommandtitle" align="center"><h3>데이터로 알아보는 관광지역</h3></div>
	<hr>
	<div align="center">
		가장 많이 방문한 곳은 <a href="paldo.do?areacode=${locnum }">${loc}</a>이고 
		<br>
		연령대는 ${age} , 방문자 수는 ${vcount} 입니다.
	</div>
	<br>
	<hr>
	<br>
	<div align="center">
		<table border="1" >
			<tr>
				<td><button>알파</button></td>
				<td><button>베타</button></td>
			</tr>
		</table>
	</div>
	<br>
	<br>
	<div style="text-align: center">
		<img src="resources/data/graph/age.png" width="700px" height="300px" />
	</div>
	<br>
	<br>
	<hr>
	<br>








</body>
