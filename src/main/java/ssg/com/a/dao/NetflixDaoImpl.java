package ssg.com.a.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ssg.com.a.dto.NetflixContentDto;

@Repository
public class NetflixDaoImpl implements NetflixDao{
	
	@Autowired
	SqlSession session;
	
	String ns = "Netflix.";

	@Override
	public void insertNetflixcontent(List<NetflixContentDto> contentList) {
		session.insert(ns+"insertNetflixcontent", contentList);
	}

	@Override
	public NetflixContentDto netflixdetail(Long id) {
		return session.selectOne(ns+"netflixdetail", id);
	}

	
	
}
