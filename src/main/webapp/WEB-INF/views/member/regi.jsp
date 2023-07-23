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


<form action="regiAf.do" method="post">

<h2>회원가입</h2>
<p>환영합니다</p>
<table border="1">
<tr>
	<th>아이디</th>
	<td>
		<input type="text" name="regiId" id="regiId" size="20" placeholder="아이디">
		<input type="button" id="id_chk_btn" value="id확인"><br>
		<p id="idcheck" style="font-size: 8px"></p>		
	</td>
</tr>
<tr>
	<th>패스워드</th>
	<td>
		<input type="text" name="regiPwd" id="regiPwd" size="20">
	</td>
</tr>
<tr>
	<th>이름</th>
	<td>
		<input type="text" name="regiName" id="regiName" size="20">
	</td>
</tr>
<tr>
	<th>이메일</th>
	<td>
		<input type="text" name="regiEmail" id="regiEmail" size="20">
	</td>
</tr>
<tr>
	<td align="center">
		<button onclick="regi()">회원가입</button>
	</td>
	<td>
		<p class="small fw-bold mt-2 pt-1 mb-0">
                    <a href="#" class="link-danger" style="color: #b3b3b3; font-size: 13px;"  onclick="toggleForm('login')">로그인하기</a>
                </p>
	</td>
</tr>
</table>

</form>

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
	console.log(formData.id+ "폼데이터 regi.jsp");

	console.log(formData);
	alert(formData);
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
					$("#idcheck").text("사용할 수 있는 아이디입니다");
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










