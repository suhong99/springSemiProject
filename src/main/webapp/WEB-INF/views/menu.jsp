<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<html>
	<head>
		<style type="text/css">
		.navbar-nav > li > a { padding-top:15px; padding-bottom: 15px; font-size: 20px }
		.nav-link > li > a { color:#F2F2F2; font-size: 24px; font-weight: bold;}
		.bg-company-blue {	background-color: #D91E1E; }
		.nav-link > li > a:hover { color: yellow; text-decoration: none; }
		.centered {	 margin: auto;	}	/* navbar에 ul을 중앙배치함. 왼쪽 배치시에는 <-이 부분 삭제 */
		.nav-item { padding-left: 30px; padding-right: 30px}  /* ul의 컬럼간에 간격 */ 
		</style>
	</head>
	<body>
	 
	<nav class="navbar navbar-expand-md navbar-dark bg-company-blue sticky-top">
		<div class="container">
		
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-content" aria-controls="navbar-content" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
	    
		<div class="collapse navbar-collapse" id="navbar-content">
	       <ul class="navbar-nav mr-auto centered">       
	          <li class="nav-item" class="nav-link">
	            <a href="./netflixlist.do" class="nav-link">넷플릭스 컨텐츠</a>
	          </li>
	          
	          <li class="nav-item" class="nav-link">
	            <a href="./bbslist.do" class="nav-link">자유게시판</a>
	          </li>   
	          
	          <li class="nav-item" class="nav-link">
	            <a href="" class="nav-link">즐겨찾기</a>
	          </li>     
			</ul>
		</div>
		
		</div>
	</nav>
	 
	</body>
</html>