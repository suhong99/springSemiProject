<%@page import="ssg.com.a.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	MemberDto login = (MemberDto)session.getAttribute("login");
%>

<html>
	<head>
		<style type="text/css">
		.header {
			background: none;
			background-color: black;
			margin: 0;
			color: white;
			height: 160px;
		}
		.headerLogin{	
			text-align:right;
			height: 60px;	
			font-size: 24px;		
		}
		.headerLogin a:hover {
			color: white;
			text-decoration: none;
		}
		#logo{
			width: auto;
			height: 140px;
		}
		</style>
	</head>

	<body>
	<div class="header">
		<div>
			<img alt="로고입니다" src="./images/netflixreview.png" id="logo">
		</div>
		<div style="height: 220px;" class="center">
				<% 	if(login == null){ %>	<!-- 로그인이 안된 경우 -->
					<div class="headerLogin">
						<a href="./login.do">login</a>		
					</div>
				<% }else{ %>	<!-- 로그인이 된 경우 -->
					<div class="headerLogin">
					 	<a href="./logout.do">logout</a>		
					</div>
				<%	} %>
		</div>
	</div>
	</body>
</html>