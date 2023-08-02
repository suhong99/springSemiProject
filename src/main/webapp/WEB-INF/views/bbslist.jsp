<%@page import="ssg.com.a.util.BbsUtil"%> 
<%@page import="ssg.com.a.dto.MemberDto"%> <%@page import="ssg.com.a.dto.BbsParam"%>
<%@page import="ssg.com.a.dto.BbsDto"%> <%@page import="java.util.List"%> 
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

<%
	List<BbsDto> list = (List)request.getAttribute("bbslist"); 
	int pageBbs = (Integer)request.getAttribute("pageBbs"); 
	BbsParam param = (BbsParam)request.getAttribute("param"); 
	
	int pageNumber = param.getPageNumber(); 
	String choice = param.getChoice(); 
	String search = param.getSearch(); 
	
	MemberDto login = (MemberDto)session.getAttribute("login");
	BbsDto dto = (BbsDto)request.getAttribute("bbsdto"); 
  
  %>

  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="UTF-8" />
      <title>게시판목록</title>

      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"/>
      <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

      <script type="text/javascript" src="JQuery/jquery.twbsPagination.min.js"></script>

      <style type="text/css">

        /* 전체 배경색 검정 글자색 하얀색 */

        * {
          margin: 0;
          padding: 0;
        }

        .center {
          margin: auto;
          width: 1000px;
          text-align: center;
        }

        th {
          background-color: #0D0D0D;
          color: white;
        }

        tr {
          line-height: 20px;
        }

        /* a 태그 */
        a {
          color: #F2F2F2;
          font-weight: bold;
          font-size: 20px;
          align:right;

        }
      </style>
    </head>

    <body>
      <div style="width: 1800px; height: auto;">
        <br/><br/>
        <div class="center">
          <%if(login != null){ %>
          <span style="font-weight: bold; color: #F2F2F2; font-size: 25px">
            😀<%=login.getId() %>님😀 반가워요!</span>

          <% } %><br/>
          <div align="right">
          <a href="bbswrite.do" id="submitBtn">
          <button type="button" class="btn btn-dark">🌠글쓰기</button></a>
          </div>
          <table class="table table-hover" style="background-color: #343a40">
            <col width="70"/><col width="500"/><col width="100"/><col width="200" />
            <thead>
              <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>작성일</th>
              </tr>
            </thead>

            <tbody>
              <% if(list==null || list.size()==0){ %>
              <tr>
                <td colspan="4">작성된 글이 없습니다</td>
               </tr>
              <% }else{ for(int i=0;i < list.size(); i++){ 
            	  BbsDto bbs=list.get(i); %>
              <tr>
                <td>
                  <font style="font-weight: bold; color: #f2f2f2"><%=i + 1 %></font>                  
                </td>

                <% if(bbs.getDel()==0){ %>
                <td style="text-align: left">
                  <a href="bbsdetail.do?seq=<%= bbs.getSeq() %>">
                    <%= BbsUtil.arrow(bbs.getDepth()) %> 
                    <%= BbsUtil.titleDot(bbs.getTitle()) %>
                  </a>
                  
                  <a href="bbsdetail.do?seq=<%= bbs.getSeq() %>"></a>
                </td>
                <% }else{ %>
                <td style="text-align: left">
                  <%-- <%=BbsUtil.arrow(bbs.getDepth()) %> --%>
                  <font style="font-weight: bold; color: #d91e1e">
                    ****** 이 글은 작성자에 의해서 삭제되었습니다</font>    
                </td>
                <% } %>
                <td>
                  <font style="font-weight: bold; color: gray"><%=bbs.getId() %></font>
                </td>
                <td>
                  <font style="font-weight: bold; color: gray"><%=bbs.getReadcount() %></font>
                </td>
                <td>
				  <font style="font-weight: bold; color: gray"><%=bbs.getWdate() %></font>
				</td>
              </tr>
              <% } } %>
            </tbody>
          </table>
          <br/>

			<!-- 페이지네이션 -->
          <div class="container">
            <nav aria-label="Page navigation">
              <ul
                class="pagination"
                id="pagination"
                style="justify-content: center"></ul>
            </nav>
          </div>

          <br/><br/>
          
			<!-- 검색창 -->
          <div class="form-row align-items-center d-flex justify-content-center align-items-center container">
            <select id="choice" class="form-control" style="width: auto">
              <option value="start">검색</option>
              <option value="title">제목</option>
              <option value="content">내용</option>
              <option value="writer">작성자</option>
            </select>

            <div class="col-sm-3 my-1" style="width: auto">
              <input type="text" id="search" class="form-control" value="<%=search %>"/>
            </div>

            <button type="button" onclick="searchBtn()" class="btn btn-dark">검색</button>
          </div>

          <br/>
          
        </div>
      </div>
      <br><br>

      <!-- 글쓰기 눌렀을 때 로그인하라고 하기 -->
      <form> <!-- form이 없어도 실행이됩니다 -->
        <script type="text/javascript">

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

      <script type="text/javascript">
           // Java -> JavaScript
           let search = "<%=search %>"; 	// 문자열 일 경우

           if (search != "") {
             let obj = document.getElementById("choice");
             obj.value = "<%=choice %>";
             obj.setAttribute("selected", "selected");
           }

           function searchBtn() {
             let choice = document.getElementById("choice").value;
             //	let choice = $("#choice").val();
             let search = document.getElementById("search").value;
             /*
             if(choice.trim() == ""){
               alert("카테고리를 선택해 주십시오");
               return;
             }
             if(search.trim() == ""){
               alert("검색어를 입력해 주십시오");
               return;
             }
             */
             location.href = "bbslist.do?choice=" + choice + "&search=" + search;
           }
           /*
           function goPage( pageNum ) {
             let choice = $("#choice").val();
             let search = $("#search").val();

             location.href = "bbslist.do?&choice=" + choice + "&search=" + search + "&pageNumber=" + pageNum;
           }*/

           $("#pagination").twbsPagination({
             startPage:<%=pageNumber+ 1 %>,
             totalPages:<%=pageBbs %>,
             visiblePages: 10,  // 글이 1000개라고 가정한다면, 한 화면에 페이지수를 10개를 보여줘라.
             first: '<span srid-hidden="true">«First</span>',  // 처음 페이지로 이동 «
             prev: "이전",
             next: "다음",
             last: '<span srid-hidden="true">»Last</span>', 	// 마지막 페이지로 이동 »
             initiateStartPageClick: false,				// 첫번째 자동실행이 되지 않도록 하는 함수
             onPageClick: function (event, page) {			// 페이지 번호를 클릭했을 때, 실행되는 함수
               //	alert(page);
               let choice = $("#choice").val();
               let search = $("#search").val();

               location.href = "bbslist.do?&choice=" + choice + "&search=" + search + "&pageNumber=" + (page - 1);
             }
        });
      </script>   
    </body>
  </html>