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
</style>
</head>

<body>
<div class="header">
	<div style="height: 220px;" >
	<h1>header</h1><br><br><br><br><br><br>
		<% 	if(login == null){ %>	<!-- 로그인이 안된 경우 -->
			<div class="headerLogin">
				<a href="#" id="loginBtn">login</a>		
			</div>
		<% }else{ %>	<!-- 로그인이 된 경우 -->
			
			<div class="headerLogin">
			 	<a href="#" id="logoutBtn">logout</a>		
			</div> 
		<%	} %>
	</div>
</div>

<script>
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
</script>
</body>
</html>