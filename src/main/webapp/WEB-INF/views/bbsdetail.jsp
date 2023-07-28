<%@page import="ssg.com.a.dto.BbsDto"%> <%@page
import="ssg.com.a.dto.MemberDto"%> <%@ page language="java"
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <% MemberDto login
= (MemberDto)session.getAttribute("login");%> <%-- if(login == null ||
login.getId().equals("")){ %>
<script>
  alert("로그인 해 주십시오");
  location.href = "home.do";
</script>
<% } %> --%> <% BbsDto dto = (BbsDto)request.getAttribute("bbsdto"); %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>상세 글보기</title>

    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
    />
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

    <script
      src="http://lab.alexcican.com/set_cookies/cookie.js"
      type="text/javascript"
    ></script>
    <% if(login == null || login.getId().equals("")){ %>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        const modal = document.getElementById("modal");
        modal.classList.add("show-modal");
        alert("로그인 해 주십시오");
      });
    </script>
    <% } %>
    <style type="text/css">
      /* body {
	background-color: #F2F2F2;
	color: #F2F2F2;
} */
      * {
        margin: 0;
        padding: 0;
      }
      .center {
        margin: auto;
        width: 1000px;
      }

      th {
        background: #0d0d0d;
        color: white;
      }

      tr {
        line-height: 20px;
      }
    </style>
  </head>
  <body>
    <p></p>

    <div class="center">
      <%if(login != null){ %>
      <span style="font-weight: bold; color: #0d0d0d; font-size: 25px"
        ><%=login.getId() %>님 환영합니다</span
      >

      <% } %>

      <br /><br /><br />

      <%if(dto != null){ %>
      <table class="table table-striped">
        <col width="150" />
        <col width="200" />
        <col width="150" />
        <col width="200" />

        <tr>
          <th style="text-align: center">제 목</th>
          <td colspan="3"><%=dto.getTitle() %></td>
        </tr>
        <tr>
          <th style="text-align: center">아이디</th>
          <td><%=dto.getId() %></td>
          <th style="text-align: center">조회수</th>
          <td><%=dto.getReadcount() %></td>
        </tr>
        <tr>
          <th style="text-align: center">등록일</th>
          <td><%=dto.getWdate() %></td>
          <th style="text-align: center">마지막 수정시간</th>
          <% if(dto.getMdate() != null ){ %>
          <td><%=dto.getMdate() %></td>
          <% } %>
        </tr>

        <tr>
          <th style="text-align: center; vertical-align: middle">내용</th>
          <td colspan="4" style="height: 300px; font-size: 120%">
            <textarea
              rows="12"
              readonly
              style="background-color: #ffffff; font-size: 18px"
              cols="20"
              class="form-control"
            >
<%=dto.getContent() %></textarea
            >
          </td>
        </tr>
      </table>

      <br />

      <button
        type="button"
        class="btn btn-dark"
        onclick="detailBbs(<%=dto.getSeq() %>)"
      >
        목록
      </button>

      <% if(login != null ){ %>

      <button
        type="button"
        class="btn btn-dark"
        onclick="answerBbs(<%=dto.getSeq() %>)"
      >
        답글
      </button>
      <% } %> <%if(login != null){ if( login== null ||
      login.getId().equals(dto.getId()) || login.getAuth()==1 ){ %>
      <button
        type="button"
        class="btn btn-dark"
        onclick="updateBbs(<%=dto.getSeq() %>)"
      >
        글수정
      </button>

      <button
        type="button"
        class="btn btn-dark"
        onclick="deleteBbs(<%=dto.getSeq() %>)"
      >
        글삭제
      </button>
      <% } %> <% } %> <% } %>
    </div>

    <br /><br />

    <script type="text/javascript">
      function answerBbs(seq) {
        location.href = "bbsanswer.do?seq=" + seq;
      }
      function detailBbs(seq) {
        location.href = "bbslist.do";
      }
      function updateBbs(seq) {
        location.href = "bbsupdate.do?seq=" + seq;
      }
      function deleteBbs(seq) {
        location.href = "bbsdelete.do?seq=" + seq;
      }
    </script>

    <br /><br />

    <!-- 댓글 -->
    <div class="comment">
      <form action="commentWriteAfBoard.do" method="post">
        <!--  -->
        <div class="commentwrite">
          <div>
            <input type="hidden" name="seq" value="<%=dto.getId() %>" />
            <!-- 글에 대한 정보 -->
            <% // 로그인 있으면 if (login != null) { %>

            <input
              type="hidden"
              id="writer"
              name="id"
              value="<%=login.getId() %>"
            />
            <!-- 세션에 로그인한 사람 정보 -->
            <% } %>
          </div>
        </div>

        <div>
          <table class="table table-hover">
            <col width="1000px" />
            <col width="150px" />
            <tr>
              <td><b>Comment</b></td>
            </tr>
            <tr>
              <td>
                <textarea
                  rows="3"
                  class="form-control"
                  id="content"
                  name="content"
                  placeholder="댓글을 입력하세요"
                  spellcheck="false"
                ></textarea>
              </td>
              <td style="padding-left: 30px">
                <button
                  type="submit"
                  id="submitBtn"
                  class="btn btn-dark btn-block p-4"
                >
                  등록
                </button>
              </td>
            </tr>
          </table>
        </div>

        <!-- 빈 댓글, 평점 제출 못하게 만들기 -->
        <script type="text/javascript">
          		/* 빈 댓글, 평점은 폼 제출 못하게 */
          		$(document).ready(function(){
          			$("#submitBtn").prop("disabled", true); // 처음에는 공백이므로 댓글 제출 못하도록
          			$("#submitBtn").css("background-color", "#F28888"); // 제출 못할때는 색 연하게


          			$("#content").on("input", function() {
          			let content = $("#content").val();


          		// 공백이면 제출 x
          		if (content.trim() == ""){
          			$("#submitBtn").prop("disabled", true);
          			$("#submitBtn").css("background-color", "#F28888");
          		}

          		else{
          			$("#submitBtn").prop("disabled", false);
          			$("#submitBtn").css("background-color", "#D91E1E");
          		}
          	});
          });

          		// 로그인 안되어있으면 제출 막고 모달창으로
          			$("form").on("submit", function(e) {
          		<%
          		 if(login == null){
          		%>
          		e.preventDefault();
          		<%
          		}
          		else{
                    	%>
          		$("form").submit();
                		<%
                    	}
                     %>
                  });
        </script>
      </form>

      <!-- 댓글 리스트 불러오기 -->
      <table style="width: 1106px; margin: 0px">
        <col width="400" />
        <col width="400" />

        <tbody id="tbody">
          <!-- Ajax는 비어있는 공간에 끼워넣기의 개념이다 -->
        </tbody>
      </table>
    </div>
    <script type="text/javascript">
      $(document).ready(function(){
       $.ajax({
      	 url: "commentListBoard.do",
        type: "get",
        data: { seq: <%=dto.getId() %> },
        success: function(list) {
            $("#tbody").html("");

           //
       			/* jquery for each문 */
       			$.each(list, function(i, item){
       					// 공백 댓글 빼고 넣어주기 (안전장치)
       					if(item.content.trim() != ""){
       						let str = "<hr>"+"<div>";
       					// 작성자와 댓글 작성자가 동일하면 (내 댓글) 추가
       					if(item.id == $("#writer").val()){
       						str += "<span style='font-weight: bold; color: #F2F2F2;'>"+ star(item.id) + "</span>";
       						str += "<span style='font-weight: bold; color: #3085d6;'>(내 댓글)</span><br>";
       					}
       					else {
                               str += "<span style='font-weight: bold; color: #F2F2F2;'>" + star(item.id) + " </span><br>";
                           }

       					// 내용 + 날짜
       					str += "<br><br><div>"
       					str += hasBadword(item.content)
       					str += "<span style='font-weight: bold; color: gray;'>"+ item.wdate + " </span>"
       					str += "</div>"




       					/* 삭제버튼 (작성자만 삭제 버튼 활성화) */
       					if(item.id == $("#writer").val()){
       						str += "<form action='commentDeleteAfBoard.do' method='post'>"
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

       					$("#tbody").append(str);
       					}
       				}); 	 /*append사용으로  윗줄에 $("#tbody").html(""); 이 코드가 필요하다 */
        },
        error: function() {
            alert('error');
        }
      	});

      });
    </script>
  </body>
</html>
