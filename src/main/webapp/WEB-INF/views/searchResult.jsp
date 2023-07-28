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
    
		<style type="text/css">
			/* 이미지 갖다대면 조금 더 확대 */
			div > a > img:hover {
				transform: scale(1.2);
				/* transition: all 0.1s linear; */
			}
		</style>
</head>
<body>
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
		                        <%= movie.getTitle() %>
		                    </div>
		                </div>
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
		                        <%= tv.getTitle() %>
		                    </div>
		                </div>
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
		
	    <!-- slider 스크립트 -->
	    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	    <script>
		        const sliderContainer = document.querySelector('.slider-container');
		        const posters = document.querySelectorAll('.poster-container');
		
		        let isDragging = false;
		        let startPosition = 0;
		        let currentTranslate = 0;
		        let prevTranslate = 0;
		        let animationID = 0;
		
		        posters.forEach((poster, index) => {
		            poster.addEventListener('dragstart', (e) => e.preventDefault());
		    
		            // Touch events
		            poster.addEventListener('touchstart', touchStart(index));
		            poster.addEventListener('touchend', touchEnd);
		            poster.addEventListener('touchmove', touchMove);
		    
		            // Mouse events
		            poster.addEventListener('mousedown', touchStart(index));
		            poster.addEventListener('mouseup', touchEnd);
		            poster.addEventListener('mouseleave', touchEnd);
		            poster.addEventListener('mousemove', touchMove);
		        });
		
		        function touchStart(index) {
		            return function (event) {
		                isDragging = true;
		                startPosition = getPositionX(event);
		                currentTranslate = prevTranslate;
		                animationID = requestAnimationFrame(animation);
		                sliderContainer.classList.add('grabbing');
		            };
		        }
		
		        function touchEnd() {
		            isDragging = false;
		            cancelAnimationFrame(animationID);
		            const movedBy = currentTranslate - prevTranslate;
		            if (movedBy < -100) {
		                // Swipe right
		                prevTranslate = currentTranslate - 300;
		            } else if (movedBy > 100) {
		                // Swipe left
		                prevTranslate = currentTranslate + 300;
		            }
		            sliderContainer.classList.remove('grabbing');
		            setSliderPositionByIndex();
		        }
		
		        function touchMove(event) {
		            if (isDragging) {
		                const currentPosition = getPositionX(event);
		                currentTranslate = prevTranslate + currentPosition - startPosition;
		            }
		        }
		
		        function getPositionX(event) {
		            return event.type.includes('mouse') ? event.pageX : event.touches[0].clientX;
		        }
		
		        function animation() {
		            setSliderPositionByIndex();
		            if (isDragging) requestAnimationFrame(animation);
		        }
		
		        function setSliderPositionByIndex() {
		            sliderContainer.style.transform = `translateX(${prevTranslate}px)`;
		        }
		    </script>

	</body>
</html>
