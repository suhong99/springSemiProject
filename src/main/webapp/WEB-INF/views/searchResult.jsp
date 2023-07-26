<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ssg.com.a.dto.NetflixContentDto" %>
<%@ page import="ssg.com.a.dto.NetflixTvDto" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Result</title>
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
    <h2>검색 결과</h2>

    <!-- 영화 검색 결과 표시 -->
    <h3>영화 검색 결과</h3>
    <div class="slider-container">
    <% 
        List<NetflixContentDto> movieList = (List<NetflixContentDto>) request.getAttribute("movieList");
        if (movieList != null && !movieList.isEmpty()) {
            for (NetflixContentDto movie : movieList) {
    %>
                <div class="poster-container">
                    <a href="netflixdetail.do?id=<%=movie.getId()%>">
                        <img src="https://image.tmdb.org/t/p/w500<%= movie.getPosterpath() %>">
                    </a>
                    <div class="poster-title">
                        <%= movie.getTitle() %>
                    </div>
                </div>
    <% 
            }
        } else {
    %>
            <p>검색 결과가 없습니다.</p>
    <% 
        } 
    %>
    </div>

    <!-- TV 프로그램 검색 결과 표시 -->
    <h3>TV 프로그램 검색 결과</h3>
    <div class="slider-container">
    <% 
        List<NetflixTvDto> tvList = (List<NetflixTvDto>) request.getAttribute("tvList");
        if (tvList != null && !tvList.isEmpty()) {
            for (NetflixTvDto tv : tvList) {
    %>
                <div class="poster-container">
                    <a href="netflixtvdetail.do?id=<%=tv.getId()%>">
                        <img src="https://image.tmdb.org/t/p/w500<%= tv.getPosterpath() %>">
                    </a>
                    <div class="poster-title">
                        <%= tv.getTitle() %>
                    </div>
                </div>
    <% 
            }
        } else {
    %>
            <p>검색 결과가 없습니다.</p>
    <% 
        } 
    %>
    </div>

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
