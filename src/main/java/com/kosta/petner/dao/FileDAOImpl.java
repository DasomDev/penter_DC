package com.kosta.petner.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosta.petner.bean.FileVO;

@Repository
public class FileDAOImpl implements FileDAO {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public void insertFile(FileVO fileVO) {
		sqlSession.insert("mapper.file.insertFile",fileVO);
	}

	@Override
	public Integer getFileNo(String server_filename) {
		return sqlSession.selectOne("mapper.file.getFileNo", server_filename);
	}

	@Override
	public String getServerFilename(Integer file_no) {
		return sqlSession.selectOne("mapper.file.getServerFilename", file_no);
	}
	
	// 파일테이블 업데이트 
	@Override
	public void updateFileInfo(FileVO fileVo) {
		sqlSession.update("mapper.file.updateFileInfoByFileNo", fileVo);
		
	}

	

}
