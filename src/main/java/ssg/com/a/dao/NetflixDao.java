package ssg.com.a.dao;

import java.util.List;

import ssg.com.a.dto.NetflixContentDto;
import ssg.com.a.dto.NetflixTvDto;

public interface NetflixDao {
	
	// 넷플릭스 api movie, tv 데이터 db 넣기
	void insertNetflixcontent(List<NetflixContentDto> contentList);
	void insertNetflixtvcontent(List<NetflixTvDto> contentList);
	
	// 넷플릭스 디테일 (movie)
	NetflixContentDto netflixdetail(Long id);
	
	// 넷플릭스 tv 디테일
	NetflixTvDto netflixtvdetail(Long id);

	
}
