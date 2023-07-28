
<%@page import="ssg.com.a.dto.BbsDto"%>
<%@page import="ssg.com.a.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	MemberDto login = (MemberDto)session.getAttribute("login");

%> <%
 	if(login == null || login.getId().equals("")){
	%>  
	<script>
		document.addEventListener("DOMContentLoaded", function () {
		const modal = document.getElementById("modal");
		modal.classList.add("show-modal");
		alert("로그인 해 주십시오");
		});
	</script>
	<%
	}
	%>  
	
	<%	
		BbsDto dto = (BbsDto)request.getAttribute("bbsdto");
	%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<style type="text/css">

* {
    margin: 0;
    padding: 0;
      }   
.center{
	margin: auto;
	width: 1000px;
	text-align: center;
	font-size : 18px;
}
th{
	background-color: #0D0D0D;
	color: white;
} 
tr {
   line-height: 20px;   
}
</style>
</head>
<body>
 <div style="width: 1800px; height: auto">

<br/><br/>

<div class="center">


<% if(login != null){
if(login == null || login.getId()!=null || login.getAuth()==1){
	%>
<span style = 'font-weight: bold; color:#F2F2F2; font-size:25px;'>😀<%=login.getId() %>님 좋은하루되세요😀</span>	
	
<br><br><br>
	
<%-- <%if(dto != null){ %> --%>
<form id="frm" method="post" action="bbswrite.do">

<table class="table table-hover">
<col width="200"><col width="500">

<tr>
	<th style="text-align: center; vertical-align: middle;">아이디</th>
	<td>
		<input type="text" name="id" class="form-control" value="<%=login.getId() %>" readonly="readonly">
	</td>
</tr>
<tr>
	<th style="text-align: center; vertical-align: middle">제목</th>
	<td>
		<input type="text" id="title" name="title" class="form-control" placeholder="제목을 입력하세요">
	</td>
</tr>

<tr>
	<th style="text-align: center; vertical-align: middle">내용</th>
	<td>
		<textarea rows="15" cols="50" class="form-control" 
		id="content" name="content" placeholder="내용을 입력하세요"></textarea>
	</td>
</tr>

</table>
<br>

<button type="button" class="btn btn-dark">등록</button>
<input type=button value="취소" class="btn btn-dark"
              onclick="javascript:history.back()">
</form>

<% }} %>
</div>
</div>
<br/>
<script type="text/javascript">
$(document).ready(function(){
	
	$("button").click(function(){
		// 제목이 비었는지?
		if( $("#title").val().trim() == ""){
			alert("제목을 기입해 주십시오");
			return;
		}				
		// 내용이 비었는지?
		if( $("#content").val().trim() == "" ){
			alert("내용을 기입해 주십시오");
			return;
		}
		
		$("#frm").attr("action", "bbswriteAf.do").submit();		
	});
	
});
</script>







</body>
</html>