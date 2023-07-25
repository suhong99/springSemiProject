<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
 -->
</head>
<body>

<div class="authContainer">
	<section class="sec-100">
	  <div class="container-fluid" >
			<h1 class="authHeader">회원가입</h1>
		<form>
			
				<div style="position: relative; display: flex; align-items: center;">
					<input class="authInput" type="text" id="regiId" name="regiId" placeholder="아이디" />            
					<input type="button" id="id_chk_btn" value="중복확인" style="position: absolute; right: 10px; bottom : 33px; border:none; background-color: transparent; color :#F28888">
				</div>
				<div style="display: flex; align-items: center; justify-content: center;">
					<p id="idcheck" style="font-size: 12px"></p>		
				</div>
				
		
				<input class="authInput" type="text" name="regiPwd" id="regiPwd" placeholder="비밀번호">
			
				<input class="authInput" type="text" name="regiName" id="regiName" placeholder="이름">
			
				<input class="authInput" type="text" name="regiEmail" id="regiEmail" placeholder="이메일">
			
			
				<button  class="btn btn-primary btn-lg" style="background-color: #e50914; border: none; width: 100%" onclick="regi()">회원가입</button>
				<div style="display: flex; align-items: center; justify-content: center;">
					<p class="small fw-bold mt-2 pt-1 mb-0">
		                <a href="#" class="link-danger" style="color: #b3b3b3; font-size: 13px;"  onclick="toggleForm('login')">로그인하기</a>		     
                    </p>
                </div>	
			</form>
		</div>
	</section>
</div>
<script type="text/javascript">
//회원가입
function regi() {
    // 폼 데이터 가져오기
    const formData = {
        id: $("#regiId").val(),
        pwd: $("#regiPwd").val(),
        name: $("#regiName").val(),
        email: $("#regiEmail").val(),
    };
     $.ajax({
        url: "regiAf.do",
        type: "post",
        data: formData,
        success: function(response) {
        	 const regiMsg = response.trim();
             if (regiMsg === "MEMBER_NO") {
                 alert("회원가입 조건을 확인해주세요.");
             } else if (regiMsg === "MEMBER_YES") {
                 alert("회원가입되었습니다.");
                 location.reload();
             } else {
                 alert("회원가입 처리 중 에러가 발생했습니다.");
             }
        },
        error: function() {
            alert("서버와 통신 중 에러가 발생했습니다.");
        }
    }); 
}

$(document).ready(function(){
		// 아이디 중복확인
		$("#id_chk_btn").click(function(){
		// id의 규칙: 대소문자 + 특수문자 포함
		// id 글자의 갯수
		// id가 사용할 수있는지 없는지 -ajax
		$.ajax({
			url:"idcheck.do",
			type:"post",
			data:{ "id":$("#regiId").val() },
			success:function( answer ){
				// alert("success");
				// alert(JSON.stringify(answer));
				
				if(answer == "YES"){
					$("#idcheck").css("color", "#0000ff");
					$("#idcheck").text("사용할 수 없는 아이디입니다");
				}else{
					$("#idcheck").css("color", "#ff0000");
					$("#idcheck").text("사용중인 아이디입니다");
					$("#regiId").val("");
				}				
			},
			error:function(){
				alert('error');
			}
		});
	});
	
});
</script>




</body>
</html>










