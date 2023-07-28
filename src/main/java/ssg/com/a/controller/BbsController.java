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
import ssg.com.a.dto.NetflixComment;
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
		
		model.addAttribute("content", "bbslist");
	
		return "main";
	}
	
	@GetMapping("bbswrite.do")
	public String bbswrite(Model model) {
		System.out.println("BbsController bbswrite() " + new Date());
		
		model.addAttribute("content", "bbswrite");
		return "main";
	}
	
	@PostMapping("bbswriteAf.do")
	public String bbswriteAf(BbsDto dto, Model model) {		
		System.out.println("BbsController bbswriteAf() " + new Date());
		
		boolean isS = service.bbswrite(dto);
				
		String bbswrite = "BBS_ADD_OK";
		if(isS == false) {
			bbswrite = "BBS_ADD_NO";	
		}
	//	model.addAttribute("content", "bbswrite");
		model.addAttribute("bbswrite", bbswrite);
		
		 return "message";
		
	}
	
	@GetMapping("readcount.do")
	public String readcount(BbsDto dto, Model model) {
		System.out.println("BbsController readcount() " + new Date());
		
		
		model.addAttribute("bbsdto", dto);
		return "bbslist";
	}
		
		
	// 상세글보기
	@GetMapping("bbsdetail.do")
	public String bbsdetail(int seq, Model model, HttpServletRequest request) {
		System.out.println("BbsController bbsdetail() " + new Date());
		
		MemberDto login =(MemberDto)request.getSession().getAttribute("login");
		
		String id="";
		if(login != null) {
			id=login.getId();
		}
		
		int count = service.readcountSelect(new BbsDto(seq, id, seq, seq, seq, null, null, null, null, seq, seq, seq) );
		
		if(count ==0 && login != null) {
			service.readcountInsert(new BbsDto(seq, id, seq, seq, seq, null, null, null, null, seq, seq, seq));
			service.readcount(seq);
		}
		
		BbsDto dto= service.bbsdetail(seq);
		
		model.addAttribute("content", "bbsdetail");
		model.addAttribute("bbsdto", dto);
		// return "bbsdetail";
		 return "main";
	}
	

  	 
	
	
	
	
	
	/* 1번 작동된다.
	 @GetMapping("bbsdetail.do")
	public String bbsdetail(int seq, Model model) {
		System.out.println("BbsController bbsdetail() " + new Date());
		
		service.readcount(seq);		// 조회수 
		BbsDto dto= service.bbsdetail(seq);
		
		model.addAttribute("bbsdto", dto);
		return "bbsdetail";
	} */
	  
	
	
	// 글수정
	 @GetMapping("bbsupdate.do") 
	 public String bbsupdate(int seq, Model model)	 throws Exception {
		 System.out.println("BbsController bbsupdate() " + new  Date());
	 
	     BbsDto dto = service.bbsdetail(seq); 
		 model.addAttribute("bbsdto", dto);
		 
		 model.addAttribute("content", "bbsupdate");
		 return "main"; 
	 }
	 
	@GetMapping("bbsupdateAf.do")
	public String bbsupdateAf(BbsDto dto, Model model) throws Exception {
		
		service.bbsdetail(dto.getSeq());
	boolean isS = service.bbsupdate(dto);

	String bbsupdate = "BBS_UPDATE_OK";
	if(isS == false) {
		bbsupdate = "BBS_UPDATE_NO";		
	}
	model.addAttribute("content", "bbsupdate");
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
			
			model.addAttribute("content", "bbsanswer");
			return "main";
		
		}
		
		@PostMapping("bbsanswerAf.do")
		public String bbsanswerAf(BbsDto dto, Model model) {
			System.out.println("BbsController bbsanswerAf() " + new Date());
			
			boolean isS = service.BbsAnswer(dto);
			String bbsanswer = "BBS_ANSWER_OK";
			if(isS == false) {
				bbsanswer = "BBS_ANSWER_NO";
			}
			model.addAttribute("content", "bbsanswer");
			model.addAttribute("bbsanswer", bbsanswer);
			model.addAttribute("seq", dto.getSeq());
			
			
		//	return "redirect:/bbsdetail.do?seq=" + dto.getSeq();
			return "message";
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
		return "redirect:/bbsdetail.do?id=" + bbsComment.getSeq();
	}
	
	// 댓글용 리스트 뿌리기! Ajax로 해주자!
	@ResponseBody
	@GetMapping("commentListBoard.do")
	public List<BbsComment> commentList(Long seq){
		System.out.println("BbsController commentListBoard "+ new Date());
		return service.commentList(seq);
	}
	
	@PostMapping("commentDeleteAfBoard.do") 
	public String commentDeleteAf(BbsComment comment) {
		System.out.println("BBsController commentDeleteAfBoard()" + new Date());
		System.out.println(comment);
		boolean isS = service.commentDelete(comment);

		if (isS) {
			System.out.println("댓글 삭제에 성공하셨습니다");
		}
		else {
			System.out.println("댓글 삭제에 실패하셨습니다");
		}
		// 컨트롤러에서 컨트롤러로 가야한다! [return "bbsdetail.do"; -> 이렇게 쓰면 안된다!!]
		// redirect == SendRedirect
		return "redirect:/bbsdetail.do?id=" + comment.getSeq();
	}
	
}
