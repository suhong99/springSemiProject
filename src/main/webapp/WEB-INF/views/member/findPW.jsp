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
		        id: $("#loginId").val(),
		        pwd: $("#loginPwd").val()
		    };
		    // Ajax로 서버에 POST 요청 보내기
		    $.ajax({
		        url: "loginAf.do",
		        type: "post",
		        data: formData,
		        success: function(response) {
		        	console.log(response);
		        	 const loginMsg = response.trim();
		             if (loginMsg === "LOGIN_NO") {
		                 alert("아이디나 비밀번호를 확인해 주십시오");
		             } else if (loginMsg === "LOGIN_YES") {
		                 alert("로그인 되었습니다.");
		                 location.reload();
		             } else {
		                 alert("로그인 처리 중 에러가 발생했습니다.");
		             }
		        },
		        error: function() {
		            alert("서버와 통신 중 에러가 발생했습니다.");
		        }
		    });
		}



/*
	session : server에 저장. login 정보.	Object
	cookie : client에 저장. id를 저장. pw 저장	String 
*/

let user_id = $.cookie("user_id");
if(user_id != null){	// 저장한 아이디가 있음
	$("#loginId").val( user_id );
	$("#chk_save_id").prop("checked", true);	// 첵크박스에 첵크가 되게 해준다
}

$("#chk_save_id").click(function(){
	// alert('click');
	// alert( $("#chk_save_id").is(":checked") );
	
	if( $("#chk_save_id").is(":checked") == true ){	// id를 저장 -> cookie
		
		if( $("#loginId").val().trim() == "" ){	// 빈문자열이었을 경우
			alert('id를 입력해 주십시오');
			$("#chk_save_id").prop("checked", false);
		}else{	
			// cookie 저장
			$.cookie("user_id", $("#loginId").val().trim(), { expires:7, path:'./' });
		}		
		
	}else{	// cookie에 저장하지 않음(삭제)
		
		$.removeCookie("user_id", { path:'./' });
	}	
});

</script>

</body>
</html>