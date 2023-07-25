package ssg.com.a.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import ssg.com.a.dto.NetflixComment;
import ssg.com.a.dto.NetflixContentDto;
import ssg.com.a.dto.NetflixTvDto;
import ssg.com.a.service.NetflixService;
import ssg.com.a.service.NetflixServieImpl;

@Controller
public class NetflixController {
	
	@Autowired
	NetflixService service;
	
	/* movie DB저장 */
	@RequestMapping(value="insertNetflixcontent.do", method = RequestMethod.POST)
	public String insertNetflixcontent(@RequestParam Map<String, Object> parameters) throws JsonMappingException, JsonProcessingException {
		System.out.println("NetflixController content() " + new Date());
		
		String json = parameters.get("contentList").toString();
		//System.out.println("확인용:."+json);
		
		ObjectMapper mapper = new ObjectMapper();
		List<NetflixContentDto> contentList = mapper.readValue(json, new TypeReference<List<NetflixContentDto>>() {});
		//	System.out.println("확인용:"+contentList.toString());
		
		service.insertNetflixcontent(contentList);
		return "home";
	}
	
	/* tv DB저장 */
	@RequestMapping(value="insertNetflixtvcontent.do", method = RequestMethod.POST)
	public String insertNetflixtvcontent(@RequestParam Map<String, Object> parameters) throws JsonMappingException, JsonProcessingException {
		System.out.println("NetflixController tvcontent() " + new Date());
		
		String json = parameters.get("tvcontentList").toString();
		//System.out.println("tv확인."+json);
		
		ObjectMapper mapper = new ObjectMapper();
		List<NetflixTvDto> contentList = mapper.readValue(json, new TypeReference<List<NetflixTvDto>>() {});
		
		//System.out.println("tv확인"+contentList.toString());
		service.insertNetflixtvcontent(contentList);
		return "home";
	}
	
	/* 영화 디테일창 */
	@GetMapping("netflixdetail.do") // <a>로 들어오므로 get
	public String netflixdetail(Long id, Model model) {
		System.out.println("NetflixController netflixdetail() " + new Date());
		
		NetflixContentDto dto = service.netflixdetail(id);
		model.addAttribute("netflixDto",dto); 
		
		// 평균 평점 넘겨주기
		Double avg = service.avg(id);
		model.addAttribute("avg", avg);
		
		return "netflixdetail";
	}
	
	/* TV 디테일창 */
	@GetMapping("netflixtvdetail.do") // <a>로 들어오므로 get
	public String netflixtvdetail(Long id, Model model) {
		System.out.println("NetflixController netflixtvdetail() " + new Date());
		
		NetflixTvDto dto = service.netflixtvdetail(id);
		model.addAttribute("netflixtvDto",dto); 
		
		// 평균 평점 넘겨주기
		Double avg = service.avg(id);
		model.addAttribute("avg", avg);
		
		return "netflixtvdetail";
	}
	
	/* 넷플릭스 디테일창 댓글 작성 */
	@PostMapping("commentWriteAf.do") 
	public String commentWriteAf(NetflixComment NetflixComment) {
		System.out.println("NetflixController commentWriteAf()" + new Date());
		boolean isS = service.commentWrite(NetflixComment);
		
		if (isS) {
			System.out.println("댓글 작성 성공");
		}
		else {
			System.out.println("댓글 작성 실패");
		}
		
		// redirect == sendRedirect --> 컨트롤러에서 컨트롤러로 보낼때
		return "redirect:/netflixdetail.do?id=" + NetflixComment.getSeq();
	}
	
	/* 넷플릭스 디테일창 TV 댓글 작성 */
	@PostMapping("commentTvWriteAf.do") 
	public String commentTvWriteAf(NetflixComment NetflixComment) {
		System.out.println("NetflixController commentWriteAf()" + new Date());
		boolean isS = service.commentWrite(NetflixComment);
		
		if (isS) {
			System.out.println("댓글 작성 성공");
		}
		else {
			System.out.println("댓글 작성 실패");
		}
		
		// redirect == sendRedirect --> 컨트롤러에서 컨트롤러로 보낼때
		return "redirect:/netflixtvdetail.do?id=" + NetflixComment.getSeq();
	}
	
	/* 디테일창 댓글 불러오기 */
	@ResponseBody // AJAX
	@GetMapping("commentList.do")
	public List<NetflixComment> commentList(Long seq){
		System.out.println("NetflixController commentList()" + new Date());
		
		return service.commentList(seq);
	}
	
}	
