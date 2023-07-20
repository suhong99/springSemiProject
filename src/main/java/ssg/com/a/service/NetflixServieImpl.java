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
	public List<NetflixContentDto> getNetflixKoreanContent() {
		return dao.getNetflixKoreanContent();
	}

}
