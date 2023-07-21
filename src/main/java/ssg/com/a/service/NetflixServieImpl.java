package ssg.com.a.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ssg.com.a.dao.NetflixDao;
import ssg.com.a.dto.NetflixContentDto;

@Service
public class NetflixServieImpl implements NetflixService{
	
	@Autowired
	NetflixDao dao;

	@Override
	public void insertNetflixcontent(List<NetflixContentDto> contentList) {
		dao.insertNetflixcontent(contentList);
	}

	@Override
	public NetflixContentDto netflixdetail(Long id) {
		System.out.println(dao.netflixdetail(id));
		return dao.netflixdetail(id);
	}

	
}
