package ssg.com.a.controller;

import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mysql.cj.Session;

import ssg.com.a.dto.MemberDto;
import ssg.com.a.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	MemberService service;
		
	@RequestMapping(value = "login.do")
	public String login() {
		System.out.println("MemberController login() " + new Date());
		return "login";
	}
	
	@GetMapping("regi.do")
	public String regi() {
		System.out.println("MemberController regi() " + new Date());
		return "regi";
	}
	@GetMapping("findPW.do")
	public String findPW() {
		System.out.println("MemberController findPW() " + new Date());
		return "findPW";
	}
	
	@ResponseBody
	@PostMapping("idcheck.do")
	public String idcheck(String id) {
		System.out.println("MemberController idcheck() " + new Date());
		
		boolean isS = service.idcheck(id);
		String msg = "YES";
		if(isS == true) {
			msg = "NO";
		}
		
		return msg;
	}
	
	@ResponseBody
	@PostMapping("regiAf.do")
	public String regiAf(MemberDto mem) {
		System.out.println("MemberController regiAf() " + new Date());
		System.out.println("회원가입에서 mem"+ mem);
		boolean isS = service.addmember(mem);
		String regimsg = "MEMBER_YES";
		if(isS == false) {
			regimsg = "MEMBER_NO";
		}
		
		return regimsg;
	}	
	
	@ResponseBody
	@PostMapping("loginAf.do")
	public String login(MemberDto mem, HttpServletRequest request) {
		System.out.println("MemberController login() " + new Date());
		
		MemberDto dto = service.login(mem);
		String loginmsg = "LOGIN_NO";
		if(dto != null) {
			request.getSession().setAttribute("login", dto);	// session에 저장			
			loginmsg = "LOGIN_YES";
		}
		
		return loginmsg;
	}
	
	@ResponseBody
	@RequestMapping(value = "logout.do")
	public void logout(HttpServletRequest request) {
		System.out.println("MemberController logout() " + new Date());		
		request.getSession().removeAttribute("login");		
	}
	
	@ResponseBody
	@PostMapping("kakaoLogin.do")
	public String kakaoLogin(MemberDto mem, HttpServletRequest request) {
		System.out.println("MemberController kakaoLogin() " + new Date());
		
		MemberDto dto = service.kakaoLogin(mem);
		String kakaomsg = "LOGIN_NO";
		if(dto != null) {
			request.getSession().setAttribute("login", dto);	// session에 저장			
			kakaomsg = "LOGIN_YES";
		}	else if(dto==null){
			dto = service.kakaoAddmember(mem);
			kakaomsg = "MEMBER_NO";
			if(dto != null) {
				request.getSession().setAttribute("login", dto);			
				kakaomsg = "MEMBER_YES";
			}
		}
		
		return kakaomsg;
	}
	
	
}













