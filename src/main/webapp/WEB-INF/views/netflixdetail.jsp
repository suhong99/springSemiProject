<%@page import="ssg.com.a.util.NetflixUtil"%>
<%@page import="ssg.com.a.dto.MemberDto"%>
<%@page import="ssg.com.a.dto.NetflixTvDto"%>
<%@page import="ssg.com.a.dto.NetflixContentDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	NetflixContentDto dto = (NetflixContentDto)request.getAttribute("netflixDto"); //moive
	Double avg = (Double)request.getAttribute("avg"); // 평균 평점
	if (avg == null){
		avg = 0.00;
	}
	MemberDto mem = (MemberDto)session.getAttribute("login");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" type="text/css" href="./css/detail.css">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	</head>
	<body>
		<div class="outside">
			
			<!-- 정보 표시창 -->
			<div class="container">
				<div class="image">
					<img src="https://image.tmdb.org/t/p/w500<%=dto.getPosterpath() %>"
					width="400px" height="575px">
				</div>
				<div class="text">
					<div class="title">
						<!-- 영화 제목과 개봉일 연도 표시 -->
						<span><%= dto.getTitle() %></span>&nbsp;
						<span style="color: gray;"><%=dto.getReleaseDate().substring(0, 4) %></span>
						<br><br>
					</div>
					<div class="score">
						<button class="btn">즐겨찾기 추가</button>
						<button class="btn">미정 버튼</button>
						<button class="btn">미정 버튼</button><br>
						<span style="color: gray; font-weight: bold; ">사이트 리뷰 평점: <%=NetflixUtil.round(avg) %></span>
						<br><br><br>	
					</div>
					<div class="content">	
						<span>줄거리</span><br>
						<p>
						<%
							if(dto.getOverview() == null || dto.getOverview().equals("")) {
								%>
								<span>특별한 줄거리 요약이 없습니다. 죄송합니다!</span><br><br>
								<% 
							}
							
							else{
								%>
								<span id="overviewSpan"><%= dto.getOverview() %></span><br><br>
								<% 
							}	

						%>
						</p>
						<b>현재 인기 점수: </b> <%= dto.getPopularity() %><br><br>
				        <b>개봉일:</b> <%= dto.getReleaseDate() %><br><br>
						
					</div>
					<div class="button">
						<button class="btn" onclick="back()">Back to home</button>
					</div>
				</div>
			</div>
			
			<!-- 댓글 파트 -->
			<div class="comment">
				<form action="commentWriteAf.do" method="post">
					<div class="commentwrite">
						<div>
							<input type="hidden" name="seq" value="<%=dto.getId()%>"> <!--글 아이디 값 보내줌 -->
							<input type="hidden" id="writer" name="id" value="<%=mem.getId()%>">  <!-- 로그인한 사람 (댓글 단 사람) -->		
							<span style="font-size: 20px; font-weight: bold; color: #F2F2F2;">댓글 작성</span>&nbsp;&nbsp;
							<span style="font-size: 20px; font-weight: bold; color: #F2F2F2;">평점 입력</span>
							<input type="number" name="rating" 
							min="0.0" max="10.0" step="0.1" height="30px"><br><br> <!-- 평점 -->
							<textarea name="content" placeholder="댓글을 입력하세요" spellcheck="false"></textarea>
						</div>
						<div style="padding-top: 50px; padding-left: 5px">
							<button type="submit" id="submitBtn">작성</button>
							<br><br>
						</div>
					</div>
				</form>	
				
				<!-- 댓글 리스트 -->
				<table style="width: 1106px; margin: 0px;">
					<!-- Ajax는 id에 그냥 끼워넣기 -->
					<tbody id="tbody">
					</tbody>
				</table>
				
					<script type="text/javascript">
						$(document).ready(function(){
							$.ajax({
								url: "commentList.do",
								type: "get",
								data: { seq: <%=dto.getId()%> }, // Long타입으로 변환
								success:function(list){
									//alert("댓글 불러오기 성공");
									
									$("#tbody").html(""); // 똑같은 댓글 계속 추가되므로 비워주기

									/* jquery for each문 */
									$.each(list, function(i, item){
										
										// 공백 댓글 빼고 넣어주기 (안전장치)
										if(item.content.trim() != ""){
											let str = "<div>";
											
											// 작성자와 댓글 작성자가 동일하면 (글쓴이) 추가
											if(item.id == $("#writer").val()){
												str += "<span style='font-weight: bold; color: #F2F2F2;'>작성자: "+ item.id + "(글쓴이) </span>";
											}
											else {
				                                str += "<span style='font-weight: bold; color: #F2F2F2;'>작성자: " + item.id + " </span>";
				                            }
											
											// 작성자까지 넣은 것
											let str_full = str
											
											+"<span style='font-weight: bold; color: #F2F2F2;'>작성일: "+ item.wdate + "</span>"
											+"</div>"
											
											+"<span style='font-weight: bold; color: #F2F2F2;'>평점: "+ item.rating + "</span>"
											+"</div>"
											
											+"<div>"
											+"<span style='font-weight: bold; color: #F2F2F2;'>" + item.content + "</span>"
											+"</div>"
												 
											// 댓글 간격
											+"<br><br>";
											//console.log(str_full);
											
											// tbody에 넣어주기
											$("#tbody").append(str_full); 
										}
									});
								},
								error:function(){
									alert("댓글 불러오기 실패");
								}
							});
						})
					</script>
				</div>

		</div>
		<!-- 한글자씩 줄거리 읽어주기 
	    <script type="text/javascript">
		    let overviewSpan = document.getElementById('overviewSpan');
		    let overviewText = '<%= dto.getOverview() %>'; // 줄거리 텍스트를 가져옵니다.
		    let currentIndex = 0;
		
		    function typeOverview() {
		      if (currentIndex < overviewText.length) {
		        overviewSpan.innerHTML += overviewText.charAt(currentIndex); // 한 글자씩 추가
		        currentIndex++;
		        setTimeout(typeOverview, 25); // 25ms마다 한 글자씩 출력
		      }
		    }
		
		    typeOverview(); // 함수 호출로 한 글자씩 출력 시작-->
	    </script>	
	   
		<script type="text/javascript">
			// 홈으로 돌아가기
			function back(){
				location.href = "home.do"; 
			}
		</script>
	</body>
</html>