<%@page import="ssg.com.a.dto.NetflixContentDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	NetflixContentDto dto = (NetflixContentDto)request.getAttribute("netflixDto");
	//System.out.println(dto.getOverview());
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style type="text/css">
			body{
				margin: 0px;
			}
			
			.outside{
				background-color: #0D0D0D;
				
			}
			
			.container{
				padding: 200px;
				color: #F2F2F2;
			
				display: flex; /* 컨테이너 안의 div들 좌우정렬 */
				justify-content: flex-start; /* 중앙 정렬 */
			}
		
			.image{
				
			}
			.text{
				padding-left: 40px;
			}
			
			/* 제목 부분 */
			.title > span{
				font-size: 40px;
				font-weight: bold;
			}
			
			/* 줄거리 */
			.content {
				font-size: 18px;
			}
			
			.content > span{
				font-size: 25px;
				margin-bottom: 5px;
				font-weight: bold;
			}
			
			/* 목록 버튼*/
			#back{
				height: 50px; 
				width: 200px;
				border-radius: 5px;
				color: #F2F2F2;
				font-weight: bold;
				font-size: 15px;
				background: #D91E1E;
				border: none;
			}
			
			#back:hover{
				cursor: pointer;
			}
		</style>
	</head>
	<body>
		<div class="outside">
			<div class="container">
				<div class="image">
					<img src="https://image.tmdb.org/t/p/w500<%= dto.getPosterpath() %>"
					width="400px" height="auto">
				</div>
				<div class="text">
					<div class="title">
						<!-- 영화 제목과 개봉일 연도 표시 -->
						<span><%= dto.getTitle() %></span>&nbsp;
						<span style="color: gray;">(<%=dto.getReleaseDate().substring(0, 4) %>)</span>
					</div>
					<div class="score">
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
						<b>인기도:</b> <%= dto.getPopularity() %><br>
				        <b>개봉일:</b> <%= dto.getReleaseDate() %><br><br>
						<button id="back" onclick="back()">Back to home</button>
					</div>
				</div>
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
		
		    typeOverview(); // 함수 호출로 한 글자씩 출력 시작
	    </script>	-->
	   
		<script type="text/javascript">
			// 홈으로 돌아가기
			function back(){
				location.href = "home.do"; 
			}
		</script>
	</body>
</html>