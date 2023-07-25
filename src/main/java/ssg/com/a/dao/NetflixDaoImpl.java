package ssg.com.a.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ssg.com.a.dto.NetflixComment;
import ssg.com.a.dto.NetflixContentDto;
import ssg.com.a.dto.NetflixTvDto;

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
	public void insertNetflixtvcontent(List<NetflixTvDto> contentList) {
		session.insert(ns+"insertNetflixtvcontent", contentList);
	}

	@Override
	public NetflixContentDto netflixdetail(Long id) {
		return session.selectOne(ns+"netflixdetail", id);
	}

	@Override
	public NetflixTvDto netflixtvdetail(Long id) {
		return session.selectOne(ns+"netflixtvdetail", id);
	}

	@Override
	public int commentWrite(NetflixComment comment) {
		return session.insert(ns + "commentWrite", comment);
	}

	@Override
	public List<NetflixComment> commentList(Long seq) {
		return session.selectList(ns +"commentList", seq);
	}

	@Override
	public Double avg(Long seq) {
		return session.selectOne(ns + "avg", seq);
	}

	
	
}
