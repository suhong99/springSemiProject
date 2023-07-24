package ssg.com.a.service;

import java.util.List;

import ssg.com.a.dto.NetflixContentDto;
import ssg.com.a.dto.NetflixTvDto;

public interface NetflixService {
	
	void insertNetflixcontent(List<NetflixContentDto> contentList);
	void insertNetflixtvcontent(List<NetflixTvDto> contentList);
	NetflixContentDto netflixdetail(Long id);
	NetflixTvDto netflixtvdetail(Long id);
}
