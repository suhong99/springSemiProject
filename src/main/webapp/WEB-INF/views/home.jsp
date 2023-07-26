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
		<style type="text/css">
			/* 이미지 갖다대면 조금 더 확대 */
			div > a > img:hover {
				transform: scale(1.2);
				/* transition: all 0.1s linear; */
			}
		</style>
	</head>
	<body>
		<div style="display: flex; justify-content: flex-end;"> <!-- 우측 정렬 -->
            <input type="text" class="input" placeholder="검색어를 입력하세요.">
            <button id="searchBtn" onclick="searchMovies()">검색</button>
        </div>
        
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
			        			<img src="https://image.tmdb.org/t/p/w500<%= content.getPosterpath() %>">
			        		</a>
			        		<div class="poster-title">
			        			<%= content.getTitle() %> <!-- 제목 표시 -->
			        		</div>
			            </div>
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
			        			<img src="https://image.tmdb.org/t/p/w500<%= content.getPosterpath() %>">
			        		</a>
			        		<div class="poster-title">
			        			<%= content.getTitle() %>
			        		</div>
			            </div>
			            
		            <% 
			    	} 
		    	%>
	        </div>
		</div>
		<br><br>
	    <!-- slider 스크립트 -->
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