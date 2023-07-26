
<%@page import="ssg.com.a.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	MemberDto mem = (MemberDto)session.getAttribute("login");
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

/* body {
	background-color: #0D0D0D;
	color: #F2F2F2; */
	        }
.center{
	margin: auto;
	width: 800px;
	text-align: center;		
}
th{
	background: gray;
	color: white;
}
tr {
   line-height: 20px;   
}
</style>
</head>
<body>

<h1></h1>
<br>

<div class="center">

<form id="frm" method="post">

<table class="table table-bordered">
<col width="200"><col width="500">

<tr>
	<th>아이디</th>
	<td>
		<input type="text" name="id" class="form-control" value="<%=mem.getId() %>" readonly="readonly">
	</td>
</tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" id="title" name="title" class="form-control" placeholder="제목을 기입">
	</td>
</tr>

<tr>
	<th>내용</th>
	<td>
		<textarea rows="15" cols="50" class="form-control" id="content" name="content" placeholder="내용을 기입"></textarea>
	</td>
</tr>

</table>
<br>

<button type="button" class="btn btn-dark">글쓰기</button>

</form>
</div>

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