package com.kosta.petner.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.kosta.petner.bean.CareService;
import com.kosta.petner.bean.Find;
import com.kosta.petner.bean.FindArr;
import com.kosta.petner.bean.PetInfo;
import com.kosta.petner.bean.SitterInfo;

public interface OwnerDAO {

	void regist(PetInfo petInfo)throws Exception;
	
	// 메인 => 펫시터찾기 221130 DSC
	List<Map<String, Object>> getAllAvailSitter();

	//user_no에 맞는 pet정보를 가져옴
	List<PetInfo> getPetByUserNo(Integer user_no);

	PetInfo getPetByPetNo(Integer pet_no);

	String getFileByPetNo(Integer pet_no);

	void insertRequireServiceFrom(CareService careService);

	//List<CareService> getServiceList(Integer user_no);
	//페이징+리스트
	List<CareService> getServiceList(@Param("user_no") Integer user_no, @Param("row") Integer row);
	
	//user_no가 조건으로 들어간 리스트 수
	Integer csListCount(Integer user_no);

	//전체 care_service 게시글 수
	int csListAllCount();
	
	// 동물 한마리 정보 가져오기 221130DSC
	PetInfo getMyPetByPetNo(Map<String, Object> param);

	/* 날짜:22.12.05
	 * 작성자: 김혜경
	 * 내용: 펫시터 찾기 ajax검색
	 */
	List<Map<String, Object>> findSitterSearch(FindArr findVO);
	
	// 마이펫정보 업데이트
	int updateMyPetInfo(PetInfo petInfo);
	
	// 
	int deletePet(int pet_no);
	
	
	

}
