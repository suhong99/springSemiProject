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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import ssg.com.a.dto.NetflixContentDto;
import ssg.com.a.service.NetflixService;
import ssg.com.a.service.NetflixServieImpl;

@Controller
public class NetflixController {
	
	@Autowired
	NetflixService service;
	
	@RequestMapping(value="insertNetflixcontent.do", method = RequestMethod.POST)
	public String insertNetflixcontent(@RequestParam Map<String, Object> parameters) throws JsonMappingException, JsonProcessingException {
		System.out.println("NetflixController content() " + new Date());
		
		String json = parameters.get("contentList").toString();
		//System.out.println(json);
		
		ObjectMapper mapper = new ObjectMapper();
		List<NetflixContentDto> contentList = mapper.readValue(json, new TypeReference<List<NetflixContentDto>>() {});
		
		//System.out.println(contentList.toString());
		service.insertNetflixcontent(contentList);
		return "home";
	}
	
	@GetMapping("netflixdetail.do") // <a>로 들어오므로 get
	public String netflixdetail(Long id, Model model) {
		System.out.println("NetflixController netflixdetail() " + new Date());
		
		NetflixContentDto dto = service.netflixdetail(id);
		
		model.addAttribute("netflixDto",dto); 
		
		return "netflixdetail";
	}
	
}	
