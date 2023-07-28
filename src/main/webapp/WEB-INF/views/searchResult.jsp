<%@page import="ssg.com.a.util.NetflixUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ssg.com.a.dto.NetflixContentDto" %>
<%@ page import="ssg.com.a.dto.NetflixTvDto" %>
<%@ page import="java.util.List" %>
<%
	String query = (String)request.getAttribute("query");
	System.out.println(query);
	
	// 검색 결과 JSON (영화, TV)
	List<NetflixContentDto> movieJson = NetflixUtil.searchNetflixMovieJson(query);
	List<NetflixTvDto> tvJson = NetflixUtil.searchNetflixTvJson(query);
	
	//List<NetflixContentDto> searchlistTvJson = NetflixUtil.searchNetflixMovieJson(query);
	//System.out.println(movieJson.toString());
	//System.out.println(tvJson.toString());
	//System.out.println(searchlistTvJson);

%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Result</title>
    <link rel="stylesheet" type="text/css" href="./css/NetflixContent.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="./js/func.js"></script>
    
		<style type="text/css">
			/* 이미지 갖다대면 조금 더 확대 */
			div > a > img:hover {
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
		
		
		<!-- 검색결과 Movie JSON 컨트롤러에 넘겨주기 -->
        <script type="text/javascript">
        	let contentList = {"contentList": JSON.stringify(<%=movieJson%>)}
        	console.log(contentList);
	        $.ajax({
	            url : "insertNetflixcontent.do",
	            type : "POST",
	            data : contentList,
	            success : function(data) {
	            	//alert("movie JSON 보내기 성공 [home.jsp]");
	            },
	            
	            error : function(e) {
	            	//alert("movie 실패");
	            }
	         });
        </script>
        
    	<!-- 검색결과 TV JSON 컨트롤러에 넘겨주기 -->
        <script type="text/javascript">
        	let tvcontentList = {"tvcontentList": JSON.stringify(<%=tvJson%>)}
	        $.ajax({
	            url : "insertNetflixtvcontent.do",
	            type : "POST",
	            data : tvcontentList,
	            success : function(data) {
	            	//alert("TV JSON 보내기 성공 [home.jsp]");
	            },
	            
	            error : function(e) {
	            	//alert("TV 실패");
	            }
	         });
        </script>   
        
	    <!-- 영화 검색 결과 표시 -->
	    <br><br>
	    <div style="width: 1800px; height: auto">
		    <div>
		   		<h4>영화 검색 결과</h4>
		    </div>
	    
		    <div class="slider-container">
		    <% 
		        List<NetflixContentDto> movieList = (List<NetflixContentDto>) request.getAttribute("movieList");
		        if (movieList != null && !movieList.isEmpty()) {
		            for (NetflixContentDto movie : movieList) {
		    		%>
		                <div class="poster-container">
		                    <a href="netflixdetail.do?id=<%=movie.getId()%>">
		                    	<!-- 이미지 없을경우 로고 이미지로 -->
		                        <img onerror="this.onerror=null; this.src='./images/netflixreview.png'" src="https://image.tmdb.org/t/p/w500<%= movie.getPosterpath() %>">
		                    </a>
		                    <div class="poster-title">
		                        <%= movie.getTitle() %><span id="<%=movie.getId()%>"> </span> <!-- 제목, 평점 같이 표시 -->
		                    </div>
		                </div>
		                
		                <!-- 사이트 자체 평점 제목옆에 표시 -->
			            <script type="text/javascript">
					        $(document).ready(function () {
					            $.ajax({
					                url: "getAvgRating.do",
					                type: "get",
					                data: { id: <%=movie.getId()%> },
					                success: function (avg) {
					                	if(avg != null && avg !== ''){
					                		let avg2 = avg.toFixed(2) // 소수 두자리
					                		$("#"+<%=movie.getId()%>+"").text("⭐"+ avg2);
					                	}  
					                	else{
					                		$("#"+<%=movie.getId()%>+"").text("");
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
		        } 
		        
		        else {
		    		%>
		            <span style='font-weight: bold; color: gray;'>검색 결과가 없습니다.</span>
		    		<% 
		        } 
		    %>
		    </div>
		</div>
		
		<br><br><br>
		<div style="width: 1800px">
		
		    <!-- TV 프로그램 검색 결과 표시 -->
		    <div>
		    	<h4>TV 프로그램 검색 결과</h4>
		    </div>
	    
		    <div class="slider-container">
		    <% 
		        List<NetflixTvDto> tvList = (List<NetflixTvDto>) request.getAttribute("tvList");
		        if (tvList != null && !tvList.isEmpty()) {
		            for (NetflixTvDto tv : tvList) {
		    			%>
		                <div class="poster-container">
		                    <a href="netflixtvdetail.do?id=<%=tv.getId()%>">
		                        <img onerror="this.onerror=null; this.src='./images/netflixreview.png'" src="https://image.tmdb.org/t/p/w500<%= tv.getPosterpath() %>">
		                    </a>
		                    <div class="poster-title">
		                        <%= tv.getTitle() %><span id="<%=tv.getId()%>"> </span> <!-- 제목, 평점 같이 표시 -->
		                    </div>
		                </div>
		                
		                <!-- 사이트 자체 평점 제목옆에 표시 -->
			            <script type="text/javascript">
					        $(document).ready(function () {
					            $.ajax({
					                url: "getAvgRating.do",
					                type: "get",
					                data: { id: <%=tv.getId()%> },
					                success: function (avg) {
					                	if(avg != null && avg !== ''){
					                		let avg2 = avg.toFixed(2) // 소수 두자리
					                		$("#"+<%=tv.getId()%>+"").text("⭐"+ avg2);
					                	}  
					                	else{
					                		$("#"+<%=tv.getId()%>+"").text("");
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
		        } 
		        
		        else {
		    	%>
		            <span style='font-weight: bold; color: gray;'>검색 결과가 없습니다.</span>
		    	<% 
		        } 
		    %>
		    </div>
		</div>
		<br><br>

	</body>
</html>
