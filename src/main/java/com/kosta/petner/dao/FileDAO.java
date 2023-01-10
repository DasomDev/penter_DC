package com.kosta.petner.dao;

import com.kosta.petner.bean.FileVO;

public interface FileDAO {

	void insertFile(FileVO fileVO);

	Integer getFileNo(String server_filename);

	String getServerFilename(Integer file_no);

	void updateFileInfo(FileVO fileVo);

}
