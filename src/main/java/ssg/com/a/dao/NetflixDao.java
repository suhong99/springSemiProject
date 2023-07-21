package ssg.com.a.dao;

import java.util.List;

import ssg.com.a.dto.NetflixContentDto;

public interface NetflixDao {
	
	// 넷플릭스 api movie 데이터 db 넣기
	void insertNetflixcontent(List<NetflixContentDto> contentList);
	
	// 넷플릭스 디테일
	NetflixContentDto netflixdetail(Long id);
}
