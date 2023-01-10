package com.kosta.petner.service;

import java.util.List;
import java.util.Map;

import com.kosta.petner.bean.PetInfo;
import com.kosta.petner.bean.SitterInfo;
import com.kosta.petner.bean.Users;


public interface MypageService {
	// 나의 기본정보
	Users getMyinfo(String id);	
	// 나의정보 수정
	int updateMyinfo(Users users);
	
	// 나의 시터정보 가져오기
	SitterInfo getMySitterinfo(int user_no);
	
	// 펫시터정보수정하기
	int updateMySitterInfo(SitterInfo sitterInfo);
		
	
	// 나의 반려동물 정보 가져오기
	List<PetInfo> getMyPetinfo(int user_no);
	
	// 마이페이지 ALL INFO
	Object getMyAllInfo(int user_no);

	// 카운트가져오기
	Map<String, Object> getCount(int user_no);
	
	// 파일 가져오기
	String getFile(Integer file_no);
	
	// 나의 반려동물 한마리 가져오기
	PetInfo getMyPetByPetNo(Map<String, Object> param);
	
	// 반려동물 정보수정하기
	int updateMyPetInfo(PetInfo petInfo);
	
	// 반려동물 삭제하기
	int deletePet(int pet_no);
	
	
} 
