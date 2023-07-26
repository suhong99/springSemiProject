<%@page import="ssg.com.a.dto.MemberDto"%>
<%@page import="ssg.com.a.dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	BbsDto dto = (BbsDto)request.getAttribute("bbsdto");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답글</title>


<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<style type="text/css">
body {
	background-color: #F2F2F2;
	color: #F2F2F2;
}
.center{
	margin: auto;
	width: 800px;			
}
th{
	background: gray;
	color: white;
}
.container{
background: #F2F2F2;
	color: white;
	font-family: 50px;
	font-weight: 500;
}
tr {
   line-height: 20px;   
}
</style>
</head>
<body>

<div class="center">

<h2>기본글</h2>

<table class="table table-striped">
<col width="200"><col width="500">

<tr>
	<th style="text-align: center;">작성자</th>
	<td><%=dto.getId() %></td>
</tr>
<tr>
	<th style="text-align: center;">작성일</th>
	<td><%=dto.getWdate() %></td>
</tr>
<tr>
	<th style="text-align: center;">조회수</th>
	<td><%=dto.getReadcount() %></td>
</tr>
<tr>
	<th style="text-align: center;">제목</th>
	<td><%=dto.getTitle() %></td>
</tr>
<tr>
	<th style="text-align: center; vertical-align: middle;">내용</th>
	<td><%=dto.getContent() %></td>
</tr>
</table>

<%
	MemberDto login = (MemberDto)session.getAttribute("login");
%>

<h2>답글</h2>

<!-- <form action="bbsanswerAf.do" method="get"> -->
<form id="frm" method="get">
<input type="hidden" name="seq" value="<%=dto.getSeq() %>">

<table class="table table-bordered">
<col width="200"><col width="500">

<tr>
	<th style="text-align: center; vertical-align: middle;">아이디</th>
	<td>
		<input type="text" name="id" class="form-control" size="50" readonly="readonly" value="<%=login.getId() %>">
	</td>
</tr>
<tr>
	<th style="text-align: center; vertical-align: middle;">제목</th>
	<td>
		<input type="text" id="title" name="title" class="form-control" size="50">
	</td>
</tr>
<tr>
	<th style="text-align: center; center; vertical-align: middle;">내용</th>
	<td>
		<textarea rows="10" cols="50" id="content" name="content" class="form-control" ></textarea>
	</td>
</tr>
<tr>
	<td colspan="2">
		<button type="button" class="btn btn-dark">등록</button>
	</td>
</tr>
</table>


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
		
		$("#frm").attr("action", "bbsanswerAf.do").submit();		
	});
	
});
</script>


</body>
</html>