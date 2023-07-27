# 7/25 
0. MVC 모델 2 복습
https://min-it.tistory.com/7

1. 영화, TV시리즈 DB 필요하다고 생각
--> DB, DTO 추가 작업

2. 데이터 파싱 https://velog.io/@boo_choo/TMDB-API%EB%A1%9C-%EC%A0%95%EB%B3%B4-%EB%B6%88%EB%9F%AC%EC%98%A4%EA%B8%B0
--> simple Json 라이브러리 이용, JSON 파일 list로 

2. 폼으로 리스트 넘기려니까 힘들어서 AJAX로 JSON 넘기자고 생각 https://goguj.netlify.app/Spring/ajax_json/
--> JSON으로 파싱해서 AJAX로 DB에 top20 데이터들 넘겨주기
   
4. JSON  key값이랑 dto 파라미터 매칭안되서 annotation추가 

5. mybatis mySQL db저장시 중복 막기위해 on duplicate

6. 디테일 작업 textarea크기 고정

7. ajax를 두개 불러올려고하니문제가 생기는것같다
--> 두개따로 dto, detail 만들어줌 

8. popularity 파싱하는  과정에서 오류남 --> parse로 바꿔줌 

9. 팀원들 git 도와주기

10. input number 화살표 없애기 --> input[type='number']::-webkit-outer-spin-button,
input[type='number']::-webkit-inner-spin-button {
	  -webkit-appearance: none;
	  margin: 0;
}

11.  평점 안남길때 오류 창 작업 하기 , 0점 댓글 제출 불가능 하게 막기 --> disable 자바스크립트로 해결

12. 삭제버튼 활성화 다시 원래페이지로 redirect--> commet_id로 삭제, seq로 redirect 

13. 삭제 alert 창 --> sweetalert로 삭제 여부 묻기

14. 기능 똑같은데 넘겨주는 창만 다르게 redirect --> 컨트롤러에서 댓글 작성, 삭제 페이지 넘겨줄때 다르게 만들어서 각각 만들기 

15. 로그인 안되었을때 댓글 작성 못하게 --> mem + 스크립트로 구현 

16. 비속어와 댓글 익명성 줄거리 읽어주기 추가 --> 자바 스크립트로 구현 

17. 로그인 안되었을때 댓글 작성 못하고 바로 로그인 으로 --> 수홍님이 짠 모달창으로 바로 넘어가게 스크립트 내가 수정 mem ==null이면 보이게 

# 7/27
18.  검색결과 json db넣으려는데 the method is undefined for the type 오류 --> servers --> server options --> serve modules without publishing --> 해결! ajax로 그리고 보내주기 
