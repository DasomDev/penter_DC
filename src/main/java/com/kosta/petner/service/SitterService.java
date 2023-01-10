package com.kosta.petner.service;

import java.util.List;
import java.util.Map;

import com.kosta.petner.bean.CareService;
import com.kosta.petner.bean.Find;
import com.kosta.petner.bean.SitterInfo;

public interface SitterService {

	void regist(SitterInfo sitterInfo);
	
	/* 날짜:22.11.22
	 * 작성자: 김혜경
	 * 내용: service_no에 맞는 돌봐줄 동물 찾기 viewForm(디테일페이지)
	 */
	CareService getViewForm(Integer service_no);

	/* 날짜:22.11.30
	 * 작성자: 김혜경
	 * 내용: 펫시터 정보등록시 프로필 사진 users테이블에 update
	 */
	void updateFileNoToUsers(SitterInfo sitterInfo);

	/* 날짜:22.11.30
	 * 작성자: 김혜경
	 * 내용: 돌봐줄 동물 찾기 검색
	 */
	List<CareService> findPetSearch(Find findVO);
	// ajax 구현중
	List<CareService> getAllPetServiceList();
}
