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
			height: 180px;
			display: flex;
		    flex-direction: row;
		    align-items: flex-end;
		    justify-content: space-between;
		    padding-right: 2%;
		}
		.headerLogin{	
			text-align:right;
			font-size: 24px;
			padding-bottom: 20px;
		 	font-weight: 900;				
		}
		.headerLogin a {
		  color: white;
		}
		
		.headerLogin a:hover {
			color: #F28888;
			text-decoration: none;
			font-size: 26px;
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
	<div>
		<% 	if(login == null){ %>	<!-- 로그인이 안된 경우 -->
			<div class="headerLogin">
				<a href="#" id="loginBtn">로그인</a>		
			</div>
		<% }else{ %>	<!-- 로그인이 된 경우 -->
			
			<div class="headerLogin">
			 	<a href="#" id="logoutBtn">로그아웃</a>		
			</div> 
		<%	} %>
	</div>
</div>

<script>
	const logoutBtn = document.getElementById("logoutBtn");
	if (logoutBtn) {
	 	 //로그아웃
	    document.getElementById("logoutBtn").addEventListener("click", function(e) {
	        e.preventDefault();
	        $.ajax({
		        url: "logout.do",
		        type: "get",
		        success: function() {
		           alert("로그아웃 되었습니다.");
		           location.reload();
		        },
		        error: function() {
		            alert("서버와 통신 중 에러가 발생했습니다.");
		        }
		    });
	    });
 	 }
</script>

</body>
</html>