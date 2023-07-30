<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<style type="text/css">

</style>
</head>
<body>
<div class="authContainer">
<section class="sec-100">

  <div class="container-fluid" >
		<h1 class="authHeader"> 비밀번호 찾기</h1>
   	    <%--    <jsp:include page='<%=content + ".jsp" %>' flush="false" />  		 --%>
      <form>
        <!-- ID input -->
        <div>
            <input class="authInput" type="text" id="findId" name="findId" placeholder="아이디" />            
        </div>

        <!-- Password input -->
        <div class="form-outline mb-3">
            <input class="authInput" type="text" id="findEmail" name="findEmail" placeholder="이메일" />            
        </div>

        <div>
            <button type="button" class="btn btn-primary btn-lg" style="background-color: #e50914; border: none; width: 100%" onclick="login()">아이디 확인</button>
            <br>
            <!-- 회원가입 및 로그인 돌아가기 버튼 -->
            <div style="display: flex; flex-direction:row; justify-content: space-around; align-items: flex-end;">
                <p class="small fw-bold mt-2 pt-1 mb-0">
                    <a href="#" class="link-danger" style="color: #b3b3b3; font-size: 13px;"  onclick="toggleForm('login')">로그인하기</a>
                </p>
                <p class="small fw-bold mt-2 pt-1 mb-0">
                    <a href="#" class="link-danger" style="color: #b3b3b3; font-size: 13px;"  onclick="toggleForm('regi')">회원가입</a>
                </p>
            </div>
          
        </div>
    </form>
        
  </div>  
</section>
</div>


<script type="text/javascript">
		function login(event) {
			// event.preventDefault();
		    // 폼 데이터 가져오기
		    const formData = {
		        id: $("#findId").val(),
		        pwd: $("#findEmail").val()
		    };
		    // Ajax로 서버에 POST 요청 보내기
		    $.ajax({
		        url: "findMember.do",
		        type: "post",
		        data: formData,
		        success: function(response) {
		        	console.log(response);
		        	 const findMember = response.trim();
		             if (findMember === "WRONG") {
		                 alert("아이디와 메일을 확인해 주십시오");
		             } else if (findMember === "FIND") {
		                 alert("메일 전송이 불가능합니다.");
		                 location.reload();
		             } else {
		                 alert("메일이 전송되었습니다.");
		             }
		        },
		        error: function() {
		            alert("서버와 통신 중 에러가 발생했습니다.");
		        }
		    });
		}



</script>

</body>
</html>