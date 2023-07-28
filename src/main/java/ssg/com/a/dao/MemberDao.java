package ssg.com.a.dao;

import java.util.List;

import ssg.com.a.dto.MemberDto;
import ssg.com.a.dto.NetflixContentDto;

public interface MemberDao {

	int idcheck(String id);	
	int addmember(MemberDto dto);
	MemberDto login(MemberDto dto);
	
	MemberDto kakaoLogin(MemberDto dto);
	MemberDto kakaoAddmember(MemberDto dto);
	
	MemberDto findMember(MemberDto dto);
}
