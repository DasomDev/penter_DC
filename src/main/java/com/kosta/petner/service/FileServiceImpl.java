package com.kosta.petner.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosta.petner.bean.FileVO;
import com.kosta.petner.dao.FileDAO;

@Service
public class FileServiceImpl implements FileService {

	@Autowired
	FileDAO fileDAO;
	
	@Override
	public void insertFile(FileVO fileVO) {
		fileDAO.insertFile(fileVO);
	}

	@Override
	public Integer getFileNo(String server_filename) {
		return fileDAO.getFileNo(server_filename);
	}

	@Override
	public String getServerFilename(Integer file_no) {
		return fileDAO.getServerFilename(file_no);
	}
	
	
	// 파일테이블 업데이트 파일번호로
	@Override
	public void updateFileInfo(FileVO fileVo) {
		fileDAO.updateFileInfo(fileVo);
	}

}
