<%@page import="ssg.com.a.dto.NetflixContentDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	NetflixContentDto dto = (NetflixContentDto)request.getAttribute("netflixDto");
	//System.out.println(dto.getOverview());
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<h1>여기는 netflix 콘텐츠 디테일 페이지입니다.</h1>
		<p> 
			<img src="https://image.tmdb.org/t/p/w500<%= dto.getPosterpath() %>"
			width="300px" height="400px"><br>
			
			<b>제목:</b> <%= dto.getTitle() %><br>
			<%
				if(dto.getOverview() == null || dto.getOverview().equals("")) {
					%>
					<b>개요: 특별한 개요사항이 없습니다.</b> <br>
					<% 
				}
				
				else{
					%>
					<b>개요:</b> <%= dto.getOverview() %><br>
					<% 
				}
			%>
	        <b>인기도:</b> <%= dto.getPopularity() %><br>
	        <b>개봉일:</b> <%= dto.getReleaseDate() %><br>
		</p>
		<button onclick="back()" style="height: 50px; width: 200px;">Back to home</button>
			
		<script type="text/javascript">
			// 홈으로 돌아가기
			function back(){
				location.href = "home.do"; 
			}
		</script>
	</body>
</html>