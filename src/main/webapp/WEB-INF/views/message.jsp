<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String message = (String)request.getAttribute("message");
if(message != null && message.equals("") == false){
	if(message.equals("MEMBER_YES")){
		%>
		<script>
		alert("성공적으로 가입되었습니다");
		location.href = "login.do";
		</script>
		<%	
	}else{
		%>
		<script>
		alert("가입되지 않았습니다. 다시 가입해 주세요");
		location.href = "regi.do";
		</script>
		<%
	}	
}
String login = (String)request.getAttribute("loginmsg");
if(login != null && login.equals("") == false){
	if(login.equals("LOGIN_NO")){
		%>
		<script>
		alert("아이디나 비밀번호를 확인해 주십시오");
		location.href = "login.do";
		</script>
		<%	
	}else{
		%>
		<script>
		alert("로그인되었습니다");
		location.href = "bbslist.do";
		</script>
		<%
	}
}

String bbswrite = (String)request.getAttribute("bbswrite");
if(bbswrite != null && !bbswrite.equals("")){
	if(bbswrite.equals("BBS_ADD_OK")){
		%>
		<script type="text/javascript">
		alert("성공적으로 작성되었습니다");
		location.href = "bbslist.do";
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		alert("다시 작성해 주십시오");
		location.href = "bbswrite.do";
		</script>
		<%
	}
}

String answer = (String)request.getAttribute("answer");
if(answer != null && !answer.equals("")){
	if(answer.equals("BBS_ANSWER_OK")){
		%>
		<script type="text/javascript">
		alert("답글이 성공적으로 작성되었습니다");
		location.href = "bbs?param=bbslist";
		</script>
		<%
	}
	else{
		int seq = (Integer)request.getAttribute("seq");
		%>
		<script type="text/javascript">
		alert("답글을 다시 작성해 주십시오");
		let seq = "<%=seq %>";		
		location.href = "bbs?param=answer&seq=" + seq;
		</script>
		<%
	}	
}

String bbsupdate = (String)request.getAttribute("bbsupdate");
if(bbsupdate != null && !bbsupdate.equals("")){
	if(bbsupdate.equals("BBS_UPDATE_OK")){
		%>
		<script type="text/javascript">
		alert("성공적으로 수정되었습니다");
		location.href = "bbslist.do";
		</script>
		<%
	}
	else{
		int seq = (Integer)request.getAttribute("seq");
		%>
		<script type="text/javascript">
		alert("다시 작성해 주십시오");
		let seq = "<%=seq %>";		
		location.href = "bbsupdate.do?seq=" + seq;
		</script>
		<%
	}	
}

String bbsdelete = (String)request.getAttribute("bbsdelete");
if(bbsdelete != null && !bbsdelete.equals("")){
	if(bbsdelete.equals("BBS_DELETE_OK")){
		%>
		<script type="text/javascript">
		alert("성공적으로 삭제되었습니다");
		location.href = "bbslist.do";
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		alert("삭제되지 않았습니다");		
		location.href = "bbsdetail.do";
		</script>
		<%
	}	
}

String calwrite = (String)request.getAttribute("calwrite");
if(calwrite != null && !calwrite.equals("")){
	if(calwrite.equals("CAL_WRITE_OK")){
		%>
		<script type="text/javascript">
		alert("성공적으로 추가되었습니다");
		location.href = "calendar?param=calendarList";
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		alert("추가되지 않았습니다");		
		location.href = "calendar?param=calendarList";
		</script>
		<%
	}	
}

String calupdate = (String)request.getAttribute("calupdate");
if(calupdate != null && !calupdate.equals("")){
	if(calupdate.equals("CAL_UPDATE_OK")){
		%>
		<script type="text/javascript">
		alert("성공적으로 수정되었습니다");
		location.href = "calendar?param=calendarList";
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		alert("수정되지 않았습니다");		
		location.href = "calendar?param=calendarList";
		</script>
		<%
	}	
}

String caldelete = (String)request.getAttribute("caldelete");
if(caldelete != null && !caldelete.equals("")){
	if(caldelete.equals("CAL_DELETE_OK")){
		%>
		<script type="text/javascript">
		alert("성공적으로 삭제되었습니다");
		location.href = "calendar?param=calendarList";
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		alert("삭제되지 않았습니다");		
		location.href = "calendar?param=calendarList";
		</script>
		<%
	}	
}
%>