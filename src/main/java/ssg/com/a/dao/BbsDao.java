package ssg.com.a.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import ssg.com.a.dto.BbsDto;
import ssg.com.a.dto.BbsParam;
import ssg.com.a.dto.NetflixComment;
import ssg.com.a.dto.BbsComment;

public interface BbsDao {
	List<BbsDto> bbslist(BbsParam param);		// 게시판
	int getAllBbs(BbsParam param);
	
	int bbswrite(BbsDto dto);					// 글쓰기
	
	BbsDto bbsdetail(int seq);					// 상세글보기
	
					
	int bbsupdate(BbsDto dto) throws Exception;	// 글수정
	int bbsdelete(int seq) throws Exception;	// 글삭제
	
	void BbsAnswerUpdate(BbsDto dto);			// 답글
	int BbsAnswerInsert(BbsDto dto);
		
	int commentWrite(BbsComment comment);		// 댓글
	List<BbsComment> commentList(Long seq);		// 댓글리스트
	int commentDelete(BbsComment comment);		// 댓글 삭제
	
	int readcount(int seq);
	int readcountSelect(BbsDto dto);					// 조회수
	int readcountInsert(BbsDto dto);			
	
	void commnetcount(							// 댓글 수 추가- 보류
			@Param("seq") int seq,
			@Param("amount") int amount);
}
