<%@page import="ssg.com.a.dto.BbsDto"%>
<%@page import="ssg.com.a.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	MemberDto login = (MemberDto)session.getAttribute("login");
	BbsDto dto = (BbsDto)request.getAttribute("bbsdto");
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<style type="text/css">
/* body {
	background-color: #0D0D0D;
	color: #F2F2F2;
	        } */
	        
* {
    margin: 0;
    padding: 0;
      }   
.center{
	margin: auto;
	width: 1000px;
	text-align: center;
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

<br>

<div class="center">
<span style = 'font-weight: bold; color:#F2F2F2; font-size:25px;'>😀<%=login.getId() %>님 좋은하루되세요😀</span>
<br/><br/>
<!-- <form action="bbsupdateAf.do" method="get"> -->
<form id="frm" method="get" action="bbsupdateAf.do">
<input type="hidden" name="seq" value="<%=dto.getSeq() %>">

<table class="table table-hover">
<col width="200"><col width="500">
<tr>
	<th style="text-align:center; vertical-align: middle;">작성자</th>
	<td>
	<input type="text" name="id" class="form-control" value="<%=dto.getId() %>" readonly="readonly">
	</td>
</tr>
<tr>
	<th style="text-align:center; vertical-align: middle;">제목</th>
	<td>
		<input type="text" size="60" id="title" class="form-control" name="title" value="<%=dto.getTitle() %>">
	</td>
</tr>
<tr>
	<th style="text-align: center; vertical-align: middle;">내용</th>
	<td>
		<textarea rows="15" cols="60" id="content" class="form-control" name="content"><%=dto.getContent()%></textarea>
	</td>
</tr>
<tr>	
	<th style="text-align:center; vertical-align: middle;">등록일</th>
	<td>
		<input type="text" size="60" class="form-control" value="<%=dto.getWdate() %>" readonly="readonly">
	</td>
</tr>

<tr>
	<td colspan="2">
		<button type="button" class="btn btn-dark">수정완료</button>
		<input type=button value="취소" class="btn btn-dark"
              onclick="javascript:history.back()">
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
		
		$("#frm").attr("action", "bbsupdateAf.do").submit();		
	});
	
});
</script>



</body>
</html>