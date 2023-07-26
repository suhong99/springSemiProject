
<%@page import="ssg.com.a.dto.BbsDto"%>
<%@page import="ssg.com.a.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
	MemberDto login = (MemberDto)session.getAttribute("login");
	if(login == null || login.getId().equals("")){
	%>  
		<script>
		alert("로그인 해 주십시오");
		location.href = "login.do";
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
<title>상세 글보기</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript"></script>


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

<p></p>


<div class="center">
 
<% if(login != null){ %>
<table class="table table-striped">
<col width="150"><col width="200"><col width="150"><col width="200">

<tr>
	<th style="text-align: center;">제 목</th>
	<td colspan="3"><%=dto.getTitle() %></td>
</tr>
<tr>
	<th style="text-align: center;">아이디</th>
	<td><%=dto.getId() %></td>
	<th style="text-align: center;">조회수</th>
	<td><%=dto.getReadcount() %></td>	
</tr>
<tr>	
	<th style="text-align: center;">등록일</th>
	<td><%=dto.getWdate() %></td>
	<th style="text-align: center;">마지막 수정시간</th>
	<% if(dto.getMdate() != null ){ %>
	<td><%=dto.getMdate() %></td>	
	<% } %>
</tr>	

<tr>
	<th style="text-align: center ; vertical-align: middle;">내용</th>
	<td colspan="4" style="height: 300px; font-size: 120%">
		<textarea rows="12" readonly style="background-color: #ffffff; font-size: 18px" 
cols="20" class="form-control" ><%=dto.getContent() %></textarea>
	</td>
</tr>
</table>
<% } %>
<br>

<%-- <button type="button" onclick="answerBbs(<%=dto.getSeq() %>)">답글</button> --%>
<button type="button" class="btn btn-dark" onclick ="detailBbs(<%=dto.getSeq() %>)">목록</button>
<button type="button" class="btn btn-dark" onclick="answerBbs(<%=dto.getSeq() %>)">답글</button>
<%
if(login != null && login.getId().equals(dto.getId()) || login.getAuth()==1){
	%>
	<button type="button" class="btn btn-dark" onclick="updateBbs(<%=dto.getSeq() %>)">글수정</button>
	
	<button type="button" class="btn btn-dark" onclick="deleteBbs(<%=dto.getSeq() %>)">글삭제</button>
	<%
}
%>


</div>

<br><br>

<script type="text/javascript">
function answerBbs( seq ) {
	location.href = "bbsanswer.do?seq=" + seq;
}
function detailBbs( seq ) {
	location.href = "bbslist.do";	
}
function updateBbs( seq ) {
	location.href = "bbsupdate.do?seq=" + seq;
}
function deleteBbs( seq ) {
	location.href = "bbsdelete.do?seq=" + seq;
}
</script>

<br><br>
<%-- 댓글 --%>
<div id="app" class="container">

<form action="commentWriteAfBoard.do" method="post">
<input type="hidden" name="seq" value="<%=dto.getSeq() %>"> <!-- 글에 대한 정보 -->
<input type="hidden" name="id" value="<%=login.getId() %>"> <!-- 세션에 로그인한 사람 정보 -->

<table class="table table-hover">
<col width="1000px"><col width="150px">
<tr>
	<td><b>Comment</b></td>
</tr>
<tr>
	<td>
		<textarea rows="3" class="form-control" name="content"></textarea>
	</td>
	<td style="padding-left: 30px">
		<button type="submit" class="btn btn-dark btn-block p-4">등록</button>
	</td>
</tr>
</table>

</form>

<table class="table table-bordered">
<col width="400"><col width="400">

<tbody id="tbody">

<!-- Ajax는 비어있는 공간에 끼워넣기의 개념이다 -->
</tbody>

</table>

<script type="text/javascript">
$(document).ready(function(){	
	$.ajax({
		url:"commentListBoard.do",
		type:"get",
		data:{ seq:<%=dto.getSeq() %> },
		success:function( list ){
	
			$("#tbody").html("");			
			$.each(list, function(i, item){
				let str = 	"<tr class='table-light'>"	
					+		"<td>아이디: " + item.id + "</td>"
					+		"<td>: " + item.wdate + "</td>"
					+	"</tr>"
					+	"<tr>"
					+		"<td colspan='2'>" + item.content + "</td>"								
					+	"</tr>";
				$("#tbody").append(str);
			}); 	 /*append사용으로  윗줄에 $("#tbody").html(""); 이 코드가 필요하다 */	
		},
		error:function(){
			alert('error');
		}
	});
})
</script>

</div>

</body>
</html>