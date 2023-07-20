package ssg.com.a.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import ssg.com.a.service.NetflixService;

@Controller
public class NetflixController {
	
	@Autowired
	NetflixService service;
	
	
	
}	
