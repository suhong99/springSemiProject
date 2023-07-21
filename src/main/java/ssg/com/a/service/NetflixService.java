package ssg.com.a.service;

import java.util.List;

import ssg.com.a.dto.NetflixContentDto;

public interface NetflixService {
	
	void insertNetflixcontent(List<NetflixContentDto> contentList);
	NetflixContentDto netflixdetail(Long id);
}
