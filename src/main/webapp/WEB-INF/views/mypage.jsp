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
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<style type="text/css">
			body {
				background-color: #0D0D0D;
				color: #F2F2F2;
			}
			/* 삭제 버튼 css */
			button {
		       padding: 5px 10px;
		       border: none;
		       background-color: #D91E1E;
		       color: #FFF;
		       font-weight: bold;
		       cursor: pointer;
		       margin-right: 10px;
		     }
		     
		     /* sweetalert창 배경색 */
	      	.swal2-popup {
		      background-color: #f2f2f2; 
		    }
		</style>
	</head>
	<body>
		<br>
		<h4 style='font-weight: bold; color: gray;'>마이페이지</h4>
		<br>
		<div style="width: 1800px; height: 600px;">
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
			<table style="width: 1106px;  margin: 0px;">
				<!-- Ajax로 id에 그냥 끼워넣기 -->
				<tbody id="tbody">
				</tbody>
			</table>
		</div>
		<%
			if(mem != null){
		%>
		<script type="text/javascript">
			$(document).ready(function() {
				$.ajax({
					url: "favoriteList.do",
					type: "get",
					data: { id: '<%=mem.getId()%>' }, 
					success: function(list) {

						$("#tbody").html(""); 
						
						// 불러온 게 아무것도 없을 경우
						if (list.length == 0) {
							let str = "<br>";
							str += "<span style='font-weight: bold; color: #F2F2F2;'>🔥관심 리스트가 없습니다.🔥</span><br><br>";
							$("#tbody").append(str); 
						}
						
						// jQuery each문
						$.each(list, function(i, item) {

							if (item.title.trim() !== "") {
								let str = "";
								str += "<div>";
								str += "<form action='favoriteDeleteAf.do' method='post'>"
								str += "<input type='hidden' name='id' value="+item.id+">"
								str += "<input type='hidden' name='content_id' value="+item.content_id+">"
								str += "</form>"
								str += "<button type='submit' class='deleteBtn"+i+"'> ❌삭제 </button>"
								str += "<span style='font-weight: bold; color: gray;'>"+item.title+"</span><br>";
								str += "</div>";
								$("#tbody").append(str+"<br>"); 
							}
						});

						// 삭제 버튼 클릭 이벤트 처리
						$.each(list, function(i, item) {
							$(".deleteBtn"+i).click(function(e) {
								e.preventDefault(); // 버튼의 기본 동작 방지 (페이지 이동 등)
								const form = $(this).prev('form'); // 해당 버튼의 바로 이전 form 요소를 찾음

								// SweetAlert를 통해 삭제 여부를 확인
								Swal.fire({
									title: '즐겨찾기를 삭제하시겠습니까?',
									icon: 'question',
									showCancelButton: true,
									confirmButtonColor: '#3085d6',
									cancelButtonColor: '#d33',
									confirmButtonText: '삭제',
									cancelButtonText: '취소'
								})
								.then((result) => {
									if (result.isConfirmed) {
										// 확인 버튼을 누르면 삭제 요청
										form.submit();
									}
								});
							});
						});
					},
					error: function() {
						alert("관심 리스트 불러오기 실패");
					}
				});
			});
		</script>
		<% 
			}
		
			else 
			{
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
