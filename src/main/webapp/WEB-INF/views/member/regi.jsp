<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
 -->
 <style type="text/css">
 
 /* 비활성화된 버튼에 대한 스타일 투명+ 클릭방지 표시 */
#regiButton[disabled] {
    opacity: 0.3; 
    cursor: not-allowed;
}

.authCheckMsg {
	display: flex; align-items: center; justify-content: center;
	height: 15px;
}
</style>
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
				<div class="authCheckMsg">
					<p id="idcheck" style="font-size: 12px"></p>		
				</div>
				
		
				<input class="authInput" type="password" name="regiPwd" id="regiPwd"  placeholder="비밀번호">
				<div class="authCheckMsg">
					<p id="pwdcheck" style="font-size: 12px"></p>		
				</div>
				<input class="authInput" type="password" name="regiPwdChk" id="regiPwdChk" type="password" placeholder="비밀번호확인">
				<div class="authCheckMsg">
					<p id="pwdChkcheck" style="font-size: 12px"></p>		
				</div>
				<input class="authInput" type="text" name="regiName" id="regiName" placeholder="이름">
				<div class="authCheckMsg">
					<p style="font-size: 12px"></p>		
				</div>
				<input class="authInput" type="text" name="regiEmail" id="regiEmail" placeholder="이메일">
				<div class="authCheckMsg">
					<p id="emailcheck" style="font-size: 12px"></p>		
				</div>
			
				<button id="regiButton" type="button" class="btn btn-primary btn-lg" style="background-color: #e50914; border: none; width: 100%" onclick="regi()" disabled>회원가입</button>
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
const regiId =  document.getElementById("regiId");
const regiPwd = document.getElementById("regiPwd");
const regiName = document.getElementById("regiName");
const regiEmail = document.getElementById("regiEmail");
const regiPwdChk = document.getElementById("regiPwdChk"); 
let idChecked = false;

//입력 필드에 이벤트 리스너 추가
regiId.addEventListener("input", onIdChange);
regiPwd.addEventListener("input", onPwdChange);
regiPwdChk.addEventListener("input", onPwdChkChange);
regiEmail.addEventListener("input", onEmailChange);

// 버튼 비활성화
function enableRegiButton(value) {
    const regiIdValue = regiId.value.trim();
    const regiPwdValue = regiPwd.value.trim();
    const regiPwdChkValue = regiPwdChk.value.trim();
    const regiEmailValue = regiEmail.value.trim();
    
    // 아이디 입력조건 정규식
    // 이메일 형식 
    const regEmail =
        /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/;
      
     // 영어와 숫자를 포함하고, 특수문자는 $@!#&가 가능하며, 길이가 8글자 이상   
    const regPassword =
        /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@!#&])?[A-Za-z\d$@$!%*#?&]{8,}$/;
    
    // 정규식 검사
    const isValidEmail = regEmail.test(regiEmailValue);
    const isValidPassword = regPassword.test(regiPwdValue);
	// 비밀번호 틀릴시 유효성 문구
    if(value==="regiPwd"&& regiPwdValue!==""){
    	if(isValidPassword){
			$("#pwdcheck").css("color", "#ffffff");
			$("#pwdcheck").text("사용할 수 있는 비밀번호입니다");
		}else{
			$("#pwdcheck").css("color", "#D91E1E");
			$("#pwdcheck").text("영어와 숫자를 포함하고, 특수문자는 $@!#&가 가능하며, 길이가 8글자 이상  ");
		}	
    }
	// 비번확인
    if(value==="regiPwdChk"|| value==="regiPwd" && regiPwdChkValue!==""){
    	if(regiPwdChkValue===regiPwdValue){
			$("#pwdChkcheck").css("color", "#ffffff");
			$("#pwdChkcheck").text("비밀번호가 일치합니다.");
		}else{
			$("#pwdChkcheck").css("color", "#D91E1E");
			$("#pwdChkcheck").text("일치하지 않는 비밀번호 입니다.");
		}	
    }
	
 // 이메일  형식 유효성 문구
    if(value==="regiEmail"&& regiEmailValue!==""){
    	if(isValidEmail){
			$("#emailcheck").css("color", "#ffffff");
			$("#emailcheck").text("");
		}else{
			$("#emailcheck").css("color", "#D91E1E");
			$("#emailcheck").text("이메일 형식이 아닙니다.");
		}	
    }
	
    // 중복 확인 됐고, Id가 빈값이 아니며, email 및 비밀번호확인이 됐꼬, 비밀번호와 비밀번호 확인이 일치할 때,
    if (idChecked && regiIdValue !== "" && isValidEmail && isValidPassword && regiPwdValue === regiPwdChkValue) {
        regiButton.disabled = false;
    } else {
        regiButton.disabled = true;
    }
}
// 아이디 변경시 중복확인 초기화
function onIdChange() {
    // 아이디 입력 값이 변경되었으므로 중복확인 상태를 초기화합니다.
    idChecked = false;
    enableRegiButton();
}
// 비밀번호변경시
function onPwdChange() {
    enableRegiButton("regiPwd");
}

//비밀번호확인변경시
function onPwdChkChange() {
    enableRegiButton("regiPwdChk");
}
//비밀번호확인변경시
function onEmailChange() {
    enableRegiButton("regiEmail");
}

//회원가입
function regi() {    
    
    const formData = {
        id: regiId.value,
        pwd: regiPwd.value,
        name: regiName.value,
        email: regiEmail.value,
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
					$("#idcheck").css("color", "#ffffff");
					$("#idcheck").text("사용할 수 있는 아이디입니다");
					idChecked = true;
				    enableRegiButton();
				}else{
					$("#idcheck").css("color", "#D91E1E");
					$("#idcheck").text("사용할 수 없는 아이디입니다");
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










