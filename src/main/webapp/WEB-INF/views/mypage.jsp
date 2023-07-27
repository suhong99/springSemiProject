<%@page import="ssg.com.a.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	MemberDto mem = (MemberDto)session.getAttribute("login");

	//System.out.println(mem.toString());
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<style type="text/css">
			body {
				background-color: #0D0D0D;
				color: #F2F2F2;
			}
		</style>
		
	</head>
	
	<body>
		<br>
		<h4 style='font-weight: bold; color: gray;'>마이페이지</h4>
		<br>
		<div style="width: 1800px; height:500px;">
			<h5 style='font-weight: bold; color: #F2F2F2;'>내 정보</h5><br>
			
			<div>
			<%
				// 로그인시 정보 
				if(mem != null){
					%>
					<span style='font-weight: bold; color: gray;'>이름 : <%=mem.getName() %></span><br>
					<span style='font-weight: bold; color: gray;'>아이디 : <%=mem.getId() %></span><br>
					<span style='font-weight: bold; color: gray;'>이메일 : <%=mem.getEmail() %></span><br><br>
					<% 
				}
				else{
					%>
					<span style='font-weight: bold; color: gray;'>로그인이 필요합니다.</span><br><br>
					<%
				}
			%>
			</div>
			
			<h5 style='font-weight: bold; color: #F2F2F2;'>내가 좋아하는 영화</h5><br>
			<!-- 관심 리스트 불러오기 -->
			<table style="width: 1106px; margin: 0px;">
				<!-- Ajax로 id에 그냥 끼워넣기 -->
				<tbody id="tbody">
				</tbody>
			</table>
		</div>
		<%
			if(mem != null){
				%>
				<script type="text/javascript">
				$(document).ready(function(){
					$.ajax({
						url: "favoriteList.do",
						type: "get",
						data: { id: '<%=mem.getId()%>' }, 
						success:function(list){
							
							$("#tbody").html(""); // 똑같은 댓글 계속 추가되므로 비워주기
							// 불러온게 아무것도 없을경우
							if (list.length == 0){
								let str = "<br>";
								str += "<span style='font-weight: bold; color: #F2F2F2;'>🔥관심 리스트가 없습니다.🔥</span><br><br>";
								$("#tbody").append(str); 
							}
							
							/* jquery for each문 */
							$.each(list, function(i, item){
								
								// 공백 댓글 빼고 넣어주기 (안전장치)
								if(item.title.trim() != ""){
									let str = "";
									str += "<span style='font-weight: bold; color: gray;'>"+item.title+"</span><br>";
									$("#tbody").append(str); 
								}
							});
						},
						error:function(){
							alert("관심 리스트 실패");
						}
					});
				});
			</script>
			<% 
			}
			else{
				%>
				<script type="text/javascript">
					let str = "";
					str += "<span style='font-weight: bold; color: gray;'>🔥관심 리스트가 없습니다.🔥</span><br><br>";
					$("#tbody").append(str); 
				</script>
				<% 
			}
		%>	
	</body>
</html>
