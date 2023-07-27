<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<%  
	request.setCharacterEncoding("utf-8"); 
	
	String content= (String)request.getAttribute("content"); 
	
	if(content == null){ 
		content ="home"; 
		} 
%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css"
      integrity="sha256-+N4/V/SbAFiW1MPBCXnfnP9QSN3+Keu+NlB+0ev/YKQ="
      crossorigin="anonymous"
    />
    <title>main</title>
    <link rel="stylesheet" type="text/css" href="./css/Modal.css" />
	<link rel="stylesheet" type="text/css" href="./css/NetflixContent.css?after">
	
    
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
    />
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

    <style type="text/css">
      * {
        margin: 0;
        padding: 0;
      }
      .center {
        margin: auto;
        width: 1000px;
        text-align: center;
      }
    </style>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    />
  </head>
  <body>
    <div align="center">
      <table
        style="
          width: 100%;
          display: flex;
          justify-content: center;
          align-items: center;
        "
      >
        <tr>
          <td>
            <jsp:include page="header.jsp" flush="false" />
          </td>
        </tr>
        <tr>
          <td>
            <jsp:include page="menu.jsp" flush="false" />
          </td>
        </tr>
        <tr>
          <td>
            <jsp:include page='<%=content + ".jsp" %>' flush="false" />
          </td>
        </tr>
        <tr>
          <td>
            <jsp:include page="footer.jsp" flush="false" />
          </td>
        </tr>
      </table>
    </div>

    <!-- Modal -->
    <div class="modal-container" id="modal">
      <div id="modalContent">
        <div id="loginForm">
          <jsp:include page="member/login.jsp" flush="false" />
        </div>
        <div id="regiForm" style="display: none">
          <jsp:include page="member/regi.jsp" flush="false" />
        </div>
        <div id="findPWForm" style="display: none">
          <jsp:include page="member/findPW.jsp" flush="false" />
        </div>
      </div>
    </div>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        const modal = document.getElementById("modal");
        const loginBtn = document.getElementById("loginBtn");

        if (loginBtn) {
          document
            .getElementById("loginBtn")
            .addEventListener("click", function () {
              modal.classList.add("show-modal");
            });
        }

        // 외부 클릭 시 모달 숨기기
        window.addEventListener("click", function (event) {
          if (event.target === modal) {
            modal.classList.remove("show-modal");
            // 로그인화면으로 돌아가기
            document.getElementById("loginForm").style.display = "block";
            document.getElementById("regiForm").style.display = "none";
            document.getElementById("findPWForm").style.display = "none";

            // 회원가입 p태그 비우기
            $("#idcheck").text("");
          }
        });
      });

      // 로그인 및 회원가입 폼 이동
      function toggleForm(formName) {
        if (formName === "login") {
          document.getElementById("loginForm").style.display = "block";
          document.getElementById("regiForm").style.display = "none";
          document.getElementById("findPWForm").style.display = "none";

        } else if (formName === "regi") {
          document.getElementById("loginForm").style.display = "none";
          document.getElementById("regiForm").style.display = "block";
          document.getElementById("findPWForm").style.display = "none";
        } else if (formName === "findPW") {
            document.getElementById("loginForm").style.display = "none";
            document.getElementById("regiForm").style.display = "none";
            document.getElementById("findPWForm").style.display = "block";
          } 
      }
    </script>
  </body>
</html>
