package com.kosta.petner.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosta.petner.bean.CareService;
import com.kosta.petner.bean.Find;
import com.kosta.petner.bean.SitterInfo;
import com.kosta.petner.dao.OwnerDAO;
import com.kosta.petner.dao.SitterDAO;

@Service
public class SitterServiceImpl implements SitterService {

	@Autowired
	SitterDAO sitterDAO;

	@Autowired
	OwnerDAO ownerDAO;

	@Override
	public void regist(SitterInfo sitterInfo) {
		sitterDAO.regist(sitterInfo);
	}

	/* 날짜:22.11.22
	 * 작성자: 김혜경
	 * 내용: service_no에 맞는 돌봐줄 동물 찾기 viewForm(디테일페이지)
	 */
	@Override
	public CareService getViewForm(Integer service_no) {
		return sitterDAO.getViewForm(service_no);
	}

	/* 날짜:22.11.22
	 * 작성자: 김혜경
	 * 내용: 돌봐줄 동물 찾기 검색
	 */
	@Override
	public List<CareService> findPetSearch(Find findVO) {
		return sitterDAO.findPetSearch(findVO);
	}

	/* 날짜:22.11.30
	 * 작성자: 김혜경
	 * 내용: 펫시터 정보등록시 프로필 사진 users테이블에 update
	 */
	@Override
	public void updateFileNoToUsers(SitterInfo sitterInfo) {
		sitterDAO.updateFileNoToUsers(sitterInfo);
	}

	public List<CareService> getAllPetServiceList() {
		return sitterDAO.getAllPetServiceList();
	}
}
