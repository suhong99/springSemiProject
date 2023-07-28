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

import ssg.com.a.dto.FavoriteDto;
import ssg.com.a.dto.NetflixComment;
import ssg.com.a.dto.NetflixContentDto;
import ssg.com.a.dto.NetflixTvDto;
import ssg.com.a.service.NetflixService;
import ssg.com.a.service.NetflixServieImpl;
import ssg.com.a.util.NetflixUtil;

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
	// 위랑 똑같은데 넘겨주는 창만 다르게 
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
	
	/* 넷플릭스 디테일창 댓글 삭제 */
	@PostMapping("commentDeleteAf.do") 
	public String commentDeleteAf(NetflixComment comment) {
		System.out.println("NetflixController commentDeleteAf()" + new Date());
		System.out.println(comment);
		boolean isS = service.commentDelete(comment);

		if (isS) {
			System.out.println("댓글 삭제 성공");
		}
		else {
			System.out.println("댓글 삭제 실패");
		}
		
		// redirect == sendRedirect --> 컨트롤러에서 컨트롤러로 보낼때
		return "redirect:/netflixdetail.do?id=" + comment.getSeq();
	}
	
	/* 넷플릭스 디테일창 TV 댓글 삭제 */
	// 위랑 똑같은데 넘겨주는 창만 다르게
	@PostMapping("commentTvDeleteAf.do") 
	public String commentTvDeleteAf(NetflixComment comment) {
		System.out.println("NetflixController commentTvDeleteAf()" + new Date());
		System.out.println(comment);
		boolean isS = service.commentDelete(comment);

		if (isS) {
			System.out.println("댓글 삭제 성공");
		}
		else {
			System.out.println("댓글 삭제 실패");
		}
		
		// redirect == sendRedirect --> 컨트롤러에서 컨트롤러로 보낼때
		return "redirect:/netflixtvdetail.do?id=" + comment.getSeq();
	}
	
	/* 검색결과 */
	@GetMapping("searchNetflix.do")
	public String searchNetflix(@RequestParam(name = "query") String query, Model model) {
	    try {
	        List<NetflixContentDto> movieList = NetflixUtil.searchNetflixMovie(query);
	        List<NetflixTvDto> tvList = NetflixUtil.searchNetflixTV(query);
	        
	        model.addAttribute("movieList", movieList);
	        model.addAttribute("tvList", tvList);
	        model.addAttribute("query", query);
	        
	        model.addAttribute("content", "searchResult");
	        
	        return "main"; // 검색 결과를 보여줄 JSP 페이지 이름
	    } catch (Exception e) {
	        e.printStackTrace();
	        // 에러 처리 (예를 들어, 에러 페이지로 이동하거나 오류 메시지를 표시하는 등의 방법)
	        return "errorPage"; // 에러 페이지를 보여줄 JSP 페이지 이름
	    }
	}
	
	/* 마이페이지 */
	@GetMapping("mypage.do")
	public String mypage(Model model) {
		System.out.println("HomeController mypage() " + new Date());
		
		model.addAttribute("content", "mypage");
		return "main";
	}
	
	
	/* movie 관심 컨텐츠 등록 */
	@GetMapping("favoriteAf.do") 
	public String favoriteAf(FavoriteDto dto) {
		System.out.println("NetflixController favoriteAf()" + new Date());
		boolean isS = service.favorite(dto);
		
		if (isS) {
			System.out.println("즐겨찾기 성공");
		}
		else {
			System.out.println("즐겨찾기 실패");
		}
		
		// redirect == sendRedirect --> 컨트롤러에서 컨트롤러로 보낼때
		return "redirect:/netflixdetail.do?id=" + dto.getContent_id();
	}
	
	/* TV 관심 컨텐츠 등록 */
	@GetMapping("favoriteTvAf.do") 
	public String favoriteTvAf(FavoriteDto dto) {
		System.out.println("NetflixController favoriteTvAf()" + new Date());
		boolean isS = service.favorite(dto);
		
		if (isS) {
			System.out.println("즐겨찾기 성공");
		}
		else {
			System.out.println("즐겨찾기 실패");
		}
		
		// redirect == sendRedirect --> 컨트롤러에서 컨트롤러로 보낼때
		return "redirect:/netflixtvdetail.do?id=" + dto.getContent_id();
	}
	
	/* 관심 컨텐츠 불러오기 */
	@ResponseBody // AJAX
	@GetMapping("favoriteList.do")
	public List<FavoriteDto> favoriteList(String id){
		System.out.println("NetflixController favoriteList()" + new Date());
		
		return service.favoriteList(id);
	}
	
	/* 평점만 불러오기 */
	@ResponseBody
	@GetMapping("getAvgRating.do")
	public Double getAvgRating(Long id) {
		System.out.println("NetflixController getAvgRating()" + new Date());
	    Double avg = service.avg(id);
	    return avg;
	}
	
	/* TV 평점만 불러오기 */
	@ResponseBody
	@GetMapping("getAvgTvRating.do")
	public Double getAvgTvRating(Long id) {
		System.out.println("NetflixController getAvgTvRating()" + new Date());
	    Double avg = service.avg(id);
	    return avg;
	}
	
	/* 관심목록 삭제 */
	@PostMapping("favoriteDeleteAf.do") 
	public String favoriteDeleteAf(FavoriteDto dto) {
		System.out.println("NetflixController favoriteDeleteAf()" + new Date());
		boolean isS = service.favoriteDelete(dto);

		if (isS) {
			System.out.println("관심 목록 삭제 성공");
		}
		else {
			System.out.println("관심 목록 삭제 실패");
		}
		
		// redirect == sendRedirect --> 컨트롤러에서 컨트롤러로 보낼때
		return "redirect:/mypage.do";
	}
}	
