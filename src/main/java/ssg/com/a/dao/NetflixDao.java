package ssg.com.a.dao;

import java.util.List;

import ssg.com.a.dto.FavoriteDto;
import ssg.com.a.dto.NetflixComment;
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

	// 넷플릭스 댓글달기
	int commentWrite(NetflixComment comment);
	
	// 넷플릭스 댓글리스트 불러오기
	List<NetflixComment> commentList(Long seq);
	
	// 컨텐츠 평균평점
	Double avg(Long seq);
	
	// 넷플릭스 댓글지우기
	int commentDelete(NetflixComment comment);
	
	// 넷플릭스 댓글달기
	int favorite(FavoriteDto dto);
	
	// 넷플릭스 관심 리스트 불러오기
	List<FavoriteDto> favoriteList(String id);
	
	// 관심목록 지우기
	int favoriteDelete(FavoriteDto dto);

}
