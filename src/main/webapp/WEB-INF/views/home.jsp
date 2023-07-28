<%@page import="ssg.com.a.dto.MemberDto"%>
<%@page import="ssg.com.a.dto.NetflixTvDto"%>
<%@page import="ssg.com.a.dto.NetflixContentDto"%>
<%@page import="java.util.List"%>
<%@page import="ssg.com.a.util.NetflixUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	List<NetflixContentDto> list = NetflixUtil.getNetflixMovie();
	List<NetflixTvDto> list2 = NetflixUtil.getNetflixTv();
	List<NetflixContentDto> listMovieJson = NetflixUtil.getNetflixMovieJson();
	List<NetflixTvDto> listTvJson = NetflixUtil.getNetflixTvJson();
	
	MemberDto mem = (MemberDto)session.getAttribute("login");
	
	//System.out.println("json: "+listTvJson);
	//System.out.println("json: "+listMovieJson);
	//String imgUrl = "https://image.tmdb.org/t/p/w500" + list.get(0).getPosterUrl();
	//System.out.println("https://image.tmdb.org/t/p/w500"+list.get(0).getPosterUrl());
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" type="text/css" href="./css/NetflixContent.css">
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
		<script src="./js/func.js"></script>
		
		<style type="text/css">
			/* 이미지 갖다대면 조금 더 확대 */
			.poster-container > a > img:hover {
				transform: scale(1.2);
				/* transition: all 0.1s linear; */
			}
		</style>
	</head>
	<body>
	<form action="searchNetflix.do" method="get" style="display: flex; justify-content: flex-end;">
	    <input type="text" class="input" placeholder="검색어를 입력하세요." id="searchInput" name="query">
	    <button id="searchBtn" type="submit">검색</button>
	</form>
		
		<!-- 검색 결과를 표시할 영역 -->
		<div id="searchResults"></div>

        <!-- TOP20 Movie JSON 컨트롤러에 넘겨주기 -->
        <script type="text/javascript">
        	let contentList = {"contentList": JSON.stringify(<%=listMovieJson%>)}
	        $.ajax({
	            url : "insertNetflixcontent.do",
	            type : "POST",
	            data : contentList,
	            success : function(data) {
	            	// alert("movie JSON 보내기 성공 [home.jsp]");
	            },
	            
	            error : function(e) {
	            	alert("movie 실패");
	            }
	         });
        </script>
        
        <!-- TOP20 TV JSON 컨트롤러에 넘겨주기 -->
        <script type="text/javascript">
        	let tvcontentList = {"tvcontentList": JSON.stringify(<%=listTvJson%>)}
	        $.ajax({
	            url : "insertNetflixtvcontent.do",
	            type : "POST",
	            data : tvcontentList,
	            success : function(data) {
	            	// alert("TV JSON 보내기 성공 [home.jsp]");
	            },
	            
	            error : function(e) {
	            	alert("TV 실패");
	            	//console.log(tvcontentList);
	            }
	         });
        </script> 
		
		<br><br>
	    <div style="width: 1800px; height:500px;">
		    <div>
		    	<h4>현재 인기 영화 TOP20</h4>
		    </div>
	        <div class="slider-container">
	        	<% 
		    		for (NetflixContentDto content : list) { 
			    	%>
			        	<div class="poster-container">	        		
	        				<a href="netflixdetail.do?id=<%=content.getId()%>"> <!-- 클릭시 이동할 페이지 -->
	        					<!-- 없을 경우 로고  -->
			        			<img onerror="this.onerror=null; this.src='./images/netflixreview.png'" 
			        			src="https://image.tmdb.org/t/p/w500<%= content.getPosterpath() %>">
			        		</a>
			        		<div class="poster-title">
			        			<%= content.getTitle() %><span id="<%=content.getId()%>"> </span> <!-- 제목, 평점 같이 표시 -->
			        		</div>
			            </div>
			            
			            <!-- 사이트 자체 평점 제목옆에 표시 -->
			            <script type="text/javascript">
					        $(document).ready(function () {
					            $.ajax({
					                url: "getAvgRating.do",
					                type: "get",
					                data: { id: <%=content.getId()%> },
					                success: function (avg) {
					                	if(avg != null && avg !== ''){
					                		let avg2 = avg.toFixed(2) // 소수 두자리
					                		$("#"+<%=content.getId()%>+"").text("⭐"+ avg2);
					                	}  
					                	else{
					                		$("#"+<%=content.getId()%>+"").text("");
					                	}
					                },
					                error: function () {
					                    alert("평균 평점 불러오기 실패");
					                }
					            });
					        });
					    </script>
		            <% 
			    	} 
		    	%>
	        </div>
		</div>
		
		
		<br><br><br>
		<div style="width: 1800px">
		    <div>
		    	<h4>현재 인기 TV시리즈 TOP20</h4>
		    </div>
	        <div class="slider-container">
	        	<% 
		    		for (NetflixTvDto content : list2) { 
			    	%>
			        	<div class="poster-container">
			        		<a href="netflixtvdetail.do?id=<%=content.getId()%>"> <!-- 클릭시 이동할 페이지 -->
			        			<!-- 없을 경우 로고 -->
			        			<img onerror="this.onerror=null; this.src='./images/netflixreview.png'"
			        			src="https://image.tmdb.org/t/p/w500<%= content.getPosterpath() %>">
			        		</a>
			        		<div class="poster-title">
			        			<%= content.getTitle() %><span id="<%=content.getId()%>"> </span> <!-- 제목, 평점 같이 표시 -->
			        		</div>
			            </div>
			            
			            <script type="text/javascript">
					        $(document).ready(function () {
					            $.ajax({
					                url: "getAvgTvRating.do",
					                type: "get",
					                data: { id: <%=content.getId()%> },
					                success: function (avg) {
					                	if(avg != null && avg !== ''){
					                		let avg2 = avg.toFixed(2) // 소수 두자리
					                		$("#"+<%=content.getId()%>+"").text("⭐"+ avg2);
					                	}  
					                	else{
					                		$("#"+<%=content.getId()%>+"").text("");
					                	}
					                },
					                error: function () {
					                    alert("평균 평점 불러오기 실패");
					                }
					            });
					        });
					    </script>
		            <% 
			    	} 
		    	%>
	        </div>
		</div>
		<br><br>
	</body>
</html>