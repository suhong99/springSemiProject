<%@page import="java.awt.event.ItemEvent"%>
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
		avg = 0.00; // 평점 기록이 없을경우 0점으로 넘기기 
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
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>
		<style>
			/* 스핀 버튼 없애기 */
		    input[type="number"]::-webkit-inner-spin-button,
		    input[type="number"]::-webkit-outer-spin-button {
		        appearance: none; 
		    }
		    
		    /* input number 클릭시 focus 효과 없애기 */
			input[type="number"]:focus {
			  outline: none; 
			}
			
			/* 삭제 버튼 css */
			.delete-btn
		     {
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
		    
		    .swal2-confirm {
        		border: none;
        	}
		</style>
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
						<span style="color: gray;">(<%=dto.getReleaseDate().substring(0, 4) %>)</span>
						<br><br>
					</div>
					<div class="score">
						<button class="btn">즐겨찾기 추가</button>
						<button class="btn">미정 버튼</button>
						<button class="btn">미정 버튼</button><br><br>
						<!-- 별점 8점 이상일때 인기, 3점 이하일때 최악 넣기 -->
					    <% 
					    	if (avg >= 7.0) { 
						    	%>
						        <span style="font-size: 24px; color: #FF4500;">🔥인기🔥</span>
						    	<% 
					    	}
					    	else if (avg <= 3.0 && avg != 0){
					    		%>
						        <span style="font-size: 24px; color: green;">🤮최악🤮</span>
						    	<%	
					    	}
					    %>
						<span style="color: gray; font-weight: bold;">사이트 리뷰 평점: <%=NetflixUtil.round(avg) %></span>	
					</div>
					<div class="content">
						<br>	
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
							<%
								// 로그인 있으면 
								if (mem != null) {
									%>
									<input type="hidden" id="writer" name="id" value="<%=mem.getId()%>">  <!-- 로그인한 사람 (댓글 단 사람) -->
									<%
								}
							%>
							<span style="font-size: 20px; font-weight: bold; color: #F2F2F2;">댓글 작성</span>&nbsp;&nbsp;&nbsp;
							<span style="font-size: 20px; font-weight: bold; color: #F2F2F2;">평점 입력</span>
							<input type="number" id="rating" name="rating" min="0.0" max="10.0" 
							step="0.1" style="margin-bottom: 3px;"><br>
							<textarea id="content" name="content" placeholder="댓글을 입력하세요" spellcheck="false"></textarea>
						</div>
						<div style="padding-top: 32px; padding-left: 5px">
							<button type="submit" id="submitBtn" style="height: 85px;" >작성</button>
							<br><br>
						</div>
					</div>
					
					<!-- 빈 댓글, 평점 제출 못하게 만들기 -->
					<script type="text/javascript">
						/* 빈 댓글, 평점은 폼 제출 못하게 */
						$(document).ready(function(){
							$("#submitBtn").prop("disabled", true); // 처음에는 공백이므로 댓글 제출 못하도록
							$("#submitBtn").css("background-color", "#F28888"); // 제출 못할때는 색 연하게 
							

							$('#content, #rating').on('input', function() {
								let content = $("#content").val();
								let rating = $("#rating").val();
								
								// 공백이면 제출 x
								if (content.trim() == "" || rating.trim() === ""){ 
									$("#submitBtn").prop("disabled", true);
									$("#submitBtn").css("background-color", "#F28888"); 
								}
								
								else{
									$("#submitBtn").prop("disabled", false);
									$("#submitBtn").css("background-color", "#D91E1E");
								}
							});
						});
						
						// 로그인 안되어있으면 제출 막고 홈으로 
						$("form").on("submit", function(e) {
				            <%
				            	if(mem == null){
				            		%>
				            			e.preventDefault();
					            		Swal.fire({
					                        title: '로그인이 필요합니다!',
					                        icon: 'error',
					                        showConfirmButton: true,
					                        confirmButtonColor: '#D91E1E',
					                        confirmButtonText: '확인'
					                    }).then(function() {
					                        location.href = "home.do"; 
					                    });
						                
				            		<%
				            	}
				            %>
				        });
					</script>
				</form>	
				
				<!-- 댓글 리스트 불러오기 -->
				<table style="width: 1106px; margin: 0px;">
					<!-- Ajax로 id에 그냥 끼워넣기 -->
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
									$("#tbody").html(""); // 똑같은 댓글 계속 추가되므로 비워주기
									
									// 불러온게 아무것도 없을경우
									if (list.length == 0){
										let str = "<div>";
										str += "<span style='font-weight: bold; color: #F2F2F2;'>🔥아직 댓글이 없습니다.🔥</span><br><br>";
										str += "<span style='font-weight: bold; color: #F2F2F2;'>🔥첫 댓글을 남겨주세요!🔥</span></div><br><br>";
										$("#tbody").append(str); 
									}

									/* jquery for each문 */
									$.each(list, function(i, item){
										
										
										// 공백 댓글 빼고 넣어주기 (안전장치)
										if(item.content.trim() != ""){
											let str = "<hr>"+"<div>";
											
											// 작성자와 댓글 작성자가 동일하면 (글쓴이) 추가
											if(item.id == $("#writer").val()){
												str += "<span style='font-weight: bold; color: #F2F2F2;'>"+ item.id + "(글쓴이) </span><br>";
											}
											else {
				                                str += "<span style='font-weight: bold; color: #F2F2F2;'>" + item.id + " </span><br>";
				                            }
											
											// 매긴 점수에 따라 이모지 추가
											if(item.rating >= 7){
												str += "<span style='font-weight: bold; color: #F2F2F2;'>평점 : "+ item.rating + " </span>"
												str += "<span style='font-weight: bold; color: red;'>🔥추천해요🔥 </span>"
											}
											
											else if (item.rating <= 3){
												str += "<span style='font-weight: bold; color: #F2F2F2;'>평점 : "+ item.rating + " </span>"
												str += "<span style='font-weight: bold; color: green;'>🤮별로에요🤮 </span>" 
											}
											
											else{
												str += "<span style='font-weight: bold; color: #F2F2F2;'>평점 : "+ item.rating + " </span>"
												str += "<span style='font-weight: bold; color: yellow;'>😐평범해요😐 </span>"
												
											}

											// 내용 + 날짜
											str += "<br><br><div>"
											str += "<span style='font-weight: bold; color: #F2F2F2;'>" + item.content + "</span><br><br>"
											str += "<span style='font-weight: bold; color: gray;'>"+ item.wdate + " </span>"
											str += "</div>"
											
											/* 삭제버튼 (작성자만 삭제 버튼 활성화) */
											if(item.id == $("#writer").val()){
												str += "<form action='commentDeleteAf.do' method='post'>"
												str += "<input type='hidden' name='seq' value="+item.seq+">"
												str += "<input type='hidden' name='comment_id' value="+item.comment_id+">"
												str += "<button type='submit' class='delete-btn'> ❌삭제</button>"
												str += "</form>"
												str += "</div>"
											}
											else{
												str += "</div>"
											}	 
											
											// 댓글 간격
											str += "<hr><br><br>";
											
											// tbody에 넣어주기
											$("#tbody").append(str); 
										}
									});
								},
								error:function(){
									alert("댓글 불러오기 실패");
								}
							});
							
							/* 삭제 버튼 클릭 시 SweetAlert를 통해 확인 후 삭제 요청 */
							// 나도 잘모름 챗 gpt 활용
					        $(document).on('click', '.delete-btn', function(e) {
					            e.preventDefault(); // 버튼의 기본 동작 방지 (페이지 이동 등)
					            const form = $(this).closest('form'); // 가장 가까운 form 요소를 찾음

					            // SweetAlert를 통해 삭제 여부를 확인
					            Swal.fire({
					                title: '댓글을 삭제하시겠습니까?',
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