package com.kosta.petner.service;

import java.util.List;
import java.util.Map;

import com.kosta.petner.bean.CareService;
import com.kosta.petner.bean.Find;
import com.kosta.petner.bean.FindArr;
import com.kosta.petner.bean.PageInfo;
import com.kosta.petner.bean.PetInfo;
import com.kosta.petner.bean.SitterInfo;

public interface OwnerService {

	void regist(PetInfo petInfo)throws Exception;
	
	/* 작성자: 김혜경
	 * 내용: user_no에 맞는 pet정보를 가져옴
	 */
	List<PetInfo> getPetByUserNo(Integer user_no);

	PetInfo getPetByPetNo(Integer pet_no);

	String getFileByPetNo(Integer pet_no);

	
	/* 날짜:22.11.16
	 * 작성자: 김혜경
	 * 내용: 펫시팅 서비스 신청
	 */
	void insertRequireServiceFrom(CareService careService);

	/* 날짜:22.11.18
	 * 작성자: 김혜경
	 * 내용: 시터 서비스 신청 list 가져오기 - 페이징
	 */
	List<CareService> getServiceList(Integer user_no, Integer page, PageInfo pageInfo);
	
	/* 날짜:22.11.17
	 * 작성자: 김혜경
	 * 내용: 시터 서비스 신청 list 수 가져오기
	 */
	Integer csListCount(Integer user_no);
	
	
	/* 날짜:22.11.30
	 * 작성자 : 조다솜
	 * 내용:펫시터 찾기 활동가능한시터 모두 불러오기
	*/
	List<Map<String, Object>> getAllAvailSitter();

	/* 날짜:22.12.05
	 * 작성자: 김혜경
	 * 내용: 펫시터 찾기 ajax검색
	 */
	List<Map<String, Object>> findSitterSearch(FindArr findVO);

	
	
}
