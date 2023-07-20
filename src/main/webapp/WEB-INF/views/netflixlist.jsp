<%@page import="ssg.com.a.dto.NetflixContentDto"%>
<%@page import="java.util.List"%>
<%@page import="ssg.com.a.util.NetflixUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- c:foreach를 사용하기위해 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	List<NetflixContentDto> list = NetflixUtil.getNetflixContent();
	//String imgUrl = "https://image.tmdb.org/t/p/w500" + list.get(0).getPosterUrl();
	//System.out.println("https://image.tmdb.org/t/p/w500"+list.get(0).getPosterUrl());
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style type="text/css">
			/* 전체 배경색 검정 글자색 하얀색 */
			body {
	            background-color: #0D0D0D;
	            color: #F2F2F2;
	        }
	        
			/* 스크롤바 스타일 수정 */
	        .slider-container::-webkit-scrollbar {
	            width: 3px; 
	        }
	
	        .slider-container::-webkit-scrollbar-thumb {
	            background-color: #D91E1E; /* 스크롤바 색상 */
	            border-radius: 5px; 
	        }
	
	        .slider-container::-webkit-scrollbar-thumb:hover {
	            background-color: darkred; /* 스크롤바 호버시 색상 */
	        }
	        
	        /* 슬라이더 컨테이너 */
	        .slider-container {
	            display: flex;
	            overflow-x: auto;
	            width: 100%;
	            scroll-behavior: smooth;

	            background-color: black; /* 배경색 검정으로 */ 
	        }
	        
	        .poster-container {
	            width: 300px;
	            margin-left: 5px;
	            margin-right 5px;
	            flex-shrink: 0;
	            text-align: center; /* 텍스트 중앙정렬 */
	            font-size: 20px;
	            font-weight: bold;
	        }
	        
	        .poster-container img {
	            width: 300px;
	            height: 400px;
	        }
	        
	        .poster-title {
	        	width: 300px;
	        	
	        }
		</style>
	</head>
	<body>
		<h1>여기는 test용 netflix 콘텐츠 슬라이더 표기입니다.</h1>
	    
	    <div>
	    	<h1>현재 인기 영화 TOP20</h1>
	    </div>
	    
        <div class="slider-container">
        	<% 
	    		for (NetflixContentDto content : list) { 
		    	%>
		        	<div class="poster-container">
		        		<a href=""> <!-- 클릭시 이동할 페이지 -->
		        			<img src="https://image.tmdb.org/t/p/w500<%= content.getPosterUrl() %>">
		        		</a>
		        		<div class="poster-title">
		        			<%= content.getTitle() %>
		        		</div>
		            </div>
		            <!-- 
		            <p><a>제목: <%= content.getTitle() %></a></p>
		            <p>요약: <%= content.getOverview() %></p>
		            <p>개봉일: <%= content.getReleaseDate() %></p> -->
	            <% 
		    	} 
	    	%>
        </div>

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