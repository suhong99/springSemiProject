package ssg.com.a.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ssg.com.a.dto.BbsDto;
import ssg.com.a.dto.BbsParam;
import ssg.com.a.dto.MemberDto;
import ssg.com.a.dto.BbsComment;
import ssg.com.a.service.BbsService;

@Controller
public class BbsController {
	private static final BbsDto BbsDto = null;
	@Autowired
	BbsService service;
	
	@GetMapping(value="bbslist.do")
	public String bbslist(BbsParam param, Model model) {
		System.out.println("BbsController bbslist() " + new Date());
		System.out.println(param.toString());
		
		if(param == null || param.getSearch() == null || param.getChoice() == null) {
			param =  new BbsParam("","",0);
		}
		
		List<BbsDto> list = service.bbslist(param);
		// 글의 총수
		int count = service.getAllBbs(param);	// 23page
		// 페이지를 계산
		int pageBbs = count / 10;		// -> 2page
		if((count % 10)>0) {
			pageBbs = pageBbs + 1;		// -> 3page
		}
		
		model.addAttribute("bbslist", list);
		model.addAttribute("pageBbs", pageBbs);
		model.addAttribute("param", param);
		
	//	model.addAttribute("content", "bbs/bbslist");
		return "bbslist";
	}
	
	@GetMapping("bbswrite.do")
	public String bbswrite() {
		System.out.println("BbsController bbswrite() " + new Date());
		return "bbswrite";
	}
	
	@PostMapping("bbswriteAf.do")
	public String bbswriteAf(BbsDto dto, Model model) {		
		System.out.println("BbsController bbswriteAf() " + new Date());
		
		boolean isS = service.bbswrite(dto);
				
		String bbswrite = "BBS_ADD_OK";
		if(isS == false) {
			bbswrite = "BBS_ADD_NO";	
		}
		model.addAttribute("bbswrite", bbswrite);
		return "message";
	}
	/*
	// 상세글보기
	@GetMapping("bbsdetail.do")
	public String bbsdetail(int seq, Model model) {
		System.out.println("BbsController bbsdetail() " + new Date());
		
		service.readcount(seq);		// 조회수 
		BbsDto dto= service.bbsdetail(seq);
		
		model.addAttribute("bbsdto", dto);
		return "bbsdetail";
	}*/
	
	//조회수 중복 방지

	@GetMapping("bbsdetail.do")
	public String bbsdetail(int seq, Model model) {
		System.out.println("BbsController bbsdetail() " + new Date());
		
		//service.readcount(seq);		// 조회수 
		BbsDto dto= service.bbsdetail(seq);
		
		model.addAttribute("bbsdto", dto);
		return "bbsdetail";
	}
	
	private void readcount(Long id, HttpServletRequest request, HttpServletResponse response) {

    Cookie oldCookie = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("postView")) {
                oldCookie = cookie;
            }
        }
    }

    if (oldCookie != null) {
        if (!oldCookie.getValue().contains("[" + id.toString() + "]")) {
            service.readcount(id);
            oldCookie.setValue(oldCookie.getValue() + "_[" + id + "]");
            oldCookie.setPath("/");
            oldCookie.setMaxAge(60 * 60 * 24);
            response.addCookie(oldCookie);
        }
    } else {
        service.readcount(id);
        Cookie newCookie = new Cookie("postView","[" + id + "]");
        newCookie.setPath("/");
        newCookie.setMaxAge(60 * 60 * 24);
        response.addCookie(newCookie);
    }
}
	 
	
	
	
	/*
	@GetMapping("/detail/{boardCode}/{boardNo}")
	public String boardDetail( @PathVariable("boardCode") int boardCode, 
	                           @PathVariable("boardNo") int boardNo,
	                           @RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
	                           Model model ,
	                           HttpSession session,
	                           HttpServletRequest req,
	                           HttpServletResponse resp  ) {
	    //게시글 상세 조회 서비스 호출
	    BoardDetail detail = service.selectBoardDetail(boardNo);

	    // @ModelAttribute 는 별도의 required 속성이 없어서 무조건 필수 !! 
	    //         --> 세션에 loginMember 가 없으면 예외 발생
	    // 해결방법 : HttpSession  이용 

	    //   상세 조회 성공시
	    // 쿠키를 이용한 조회수 중복 증가 방지 코드 + 본인의 글은 조회수 증가 X 

	    if ( detail != null ) {   //  상세조회를 했을경우

	        Member loginMember = (Member) session.getAttribute("loginMember");  // 로그인멤버 찾아서

	        int memberNo = 0;   // 현재 로그인한멤버와, 글쓴멤버가 같은지 체크 하기위한 변수초기화

	        if ( loginMember != null ) {          // 로그인했으면 ???
	            memberNo = loginMember.getMemberNo();    
	        }
	        if ( detail.getMemberNo() != memberNo ) {  // 글쓴이와 로그인한 사람이 같지 않은경우 조회수증가
	            Cookie cookie = null ;               // 기존에 존재하던 쿠키를 저장하는 변수
	            Cookie[] cookies = req.getCookies(); // 저장되있는 쿠키 싹 다 얻어오기

	            if ( cookies != null && cookies.length > 0 ) {    // 얻어온쿠키가 있을 경우
	                // 얻어온 쿠키중 이름이 "readBoardNo" 가 있으면 얻어오기.
	                for ( Cookie c : cookies) {
	                    if ( c.getName().equals("readBoardNo")) {
	                        cookie = c;
	                    }
	                }
	            }
	            int result=0;

	            if ( cookie == null ) {      // "readBoardNo" 쿠키가 없을 경우
	                cookie = new Cookie("readBoardNo",boardNo+"");  
	                result = service.updateReadCount(boardNo);   // 조회수증가 서비스호출

	            }else {            // 기존에 "readBoardNo" 쿠키가 있을 경우
	                //--> 쿠키에 저장된 값 뒤쪽에 현재 조회된 게시글 번호를 추가 
	                // 단, 기존 쿠키값에 중복되는 번호가 없어야한다 !!!

	                String[] temp = cookie.getValue().split("/");
	                // "readBoardNo"  :  "1/2/11/10/20/300/1000"  == [1,2,11,20,300,1000]
	                List<String> list = Arrays.asList(temp);   //  배열 --> List 변환

	                // List.indexOf(Object) 
	                // -- List에서 Object 와 일치하는 부분의 인덱스 반환,  없으면 -1 

	                if ( list.indexOf( boardNo+"") == -1 ) {  // 기존값에 같은글번호가 없다면 추가
	                    cookie.setValue( cookie.getValue() +"/"+ boardNo );
	                    result = service.updateReadCount(boardNo);   // 조회수증가 서비스호출
	                }
	            }
	            if ( result > 0 ) {   // 결과값 이용한 DB 동기화
	                detail.setReadCount(detail.getReadCount()+1);   // 이미 조회된 데이터 DB동기화
	                cookie.setPath(req.getContextPath());
	                cookie.setMaxAge(60 * 60 * 1);
	                resp.addCookie(cookie);
	            }
	        }
	    }
	    model.addAttribute("detail",detail);
	    return "board/boardDetail";
	}*/
	
	/* 1번 작동된다.
	 @GetMapping("bbsdetail.do")
	public String bbsdetail(int seq, Model model) {
		System.out.println("BbsController bbsdetail() " + new Date());
		
		service.readcount(seq);		// 조회수 
		BbsDto dto= service.bbsdetail(seq);
		
		model.addAttribute("bbsdto", dto);
		return "bbsdetail";
	} 
	  
	 */
	// 글수정
	/*  1번
	 * @GetMapping("bbsupdate.do") public String bbsupdate(int seq, Model model)
	 * throws Exception { System.out.println("BbsController bbsupdate() " + new
	 * Date());
	 * 
	 * BbsDto dto = service.bbsdetail(seq); 
	 * model.addAttribute("bbsdto", dto);
	 * return "bbsupdate"; }
	 */
	
	
	 @GetMapping("bbsupdate.do") 
	 public String bbsupdate(int seq, Model model)	 throws Exception {
		 System.out.println("BbsController bbsupdate() " + new  Date());
	 
	     BbsDto dto = service.bbsdetail(seq); 
		 model.addAttribute("bbsdto", dto);
		 return "bbsupdate"; 
	 }
	 
	@GetMapping("bbsupdateAf.do")
	public String bbsupdateAf(BbsDto dto, Model model) throws Exception {
		
		service.bbsdetail(dto.getSeq());
	boolean isS = service.bbsupdate(dto);

	String bbsupdate = "BBS_UPDATE_OK";
	if(isS == false) {
		bbsupdate = "BBS_UPDATE_NO";		
	}
	
	model.addAttribute("bbsupdate", bbsupdate);
	//return "bbsdetil";
	return "redirect:/bbsdetail.do?seq=" + dto.getSeq();
	}

	 // 글삭제
	  @GetMapping("bbsdelete.do") 
	  public String bbsdelete(int seq) throws Exception {
		  System.out.println("BbsController bbsdelete() " + new Date());
		  
		  Integer delr = service.bbsdelete(seq);
			if(delr > 0)
				return "redirect:/bbslist.do";
			else
				return "error";
						
	  }
	  
	// 답글
	  @GetMapping("bbsanswer.do")
		public String bbsanswer(int seq, Model model) {
			System.out.println("BbsController bbsdetail() " + new Date());
			
			BbsDto dto = service.bbsdetail(seq);		
			model.addAttribute("bbsdto", dto);
			
			return "bbsanswer";
		}
		
		@GetMapping("bbsanswerAf.do")
		public String bbsanswerAf(BbsDto dto, Model model) {
			System.out.println("BbsController bbsanswerAf() " + new Date());
			
			boolean isS = service.BbsAnswer(dto);
			String bbsanswer = "BBS_ANSWER_OK";
			if(isS == false) {
				bbsanswer = "BBS_ANSWER_NO";
			}
			model.addAttribute("bbsanswer", bbsanswer);
			model.addAttribute("seq", dto.getSeq());
			
			return "redirect:/bbsdetail.do?seq=" + dto.getSeq();
		}
	 
	// 댓글
	@PostMapping("commentWriteAfBoard.do")
	public String commentWriteAf(BbsComment bbsComment) {
		System.out.println("BbsController commentWriteAfBoard " + new Date());
		boolean isS = service.commentWrite(bbsComment);
		if(isS) {
			System.out.println("댓글 작성에 성공했습니다");
		}else {
			System.out.println("댓글 작성에 실패했습니다");
		}
		// 컨트롤러에서 컨트롤러로 가야한다! [return "bbsdetail.do"; -> 이렇게 쓰면 안된다!!]
		// redirect == SendRedirect
		return "redirect:/bbsdetail.do?seq=" + bbsComment.getSeq();
	}
	
	// 댓글용 리스트 뿌리기! Ajax로 해주자!
	@ResponseBody
	@GetMapping("commentListBoard.do")
	public List<BbsComment> commentList(int seq){
		System.out.println("BbsController commentListBoard "+ new Date());
		return service.commentList(seq);
	}
	
	
}
