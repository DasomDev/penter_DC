package com.kosta.petner.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosta.petner.bean.PetInfo;
import com.kosta.petner.bean.SitterInfo;
import com.kosta.petner.bean.Users;
import com.kosta.petner.dao.FileDAO;
import com.kosta.petner.dao.OwnerDAO;
import com.kosta.petner.dao.SitterDAO;
import com.kosta.petner.dao.UsersDAO;

@Service
public class MypageServiceImpl implements MypageService {
	
	@Autowired
	UsersDAO usersDAO;
	
	@Autowired
	SitterDAO sitterDAO;
	
	@Autowired
	OwnerDAO ownerDAO;
	
	@Autowired
	FileDAO fileDAO;
	
	// 기본정보
	@Override
	public Users getMyinfo(String id) {
		return usersDAO.getMyinfo(id);
	}
	@Override
	public int updateMyinfo(Users users) {
		return usersDAO.updateMyinfo(users);
	}
	
	// 펫시터 관련
	@Override
	public SitterInfo getMySitterinfo(int user_no) {
		return sitterDAO.getSitterInfo(user_no);
	}
	
	@Override
	public int updateMySitterInfo(SitterInfo sitterInfo) {
		return sitterDAO.updateSitterInfo(sitterInfo);
	}
	
	// 보호자 관련
	@Override
	public List<PetInfo> getMyPetinfo(int user_no) {
		return ownerDAO.getPetByUserNo(user_no);
	}
	
	
	// 마이페이지 세션에 필요한 정보
	@Override
	public Object getMyAllInfo(int user_no) {
		// 마이페이지에서 물고 다녀야 하는 모든 정보
		return usersDAO.getMyAllInfo(user_no);
	}

	@Override // 시터정보 동물정보 카운트
	public Map<String, Object> getCount(int user_no) {
		// TODO Auto-generated method stub
		return usersDAO.getCount(user_no);
	}
	
	//마이페이지 필요할 파일이름
	@Override
	public String getFile(Integer fileNo) {
		return fileDAO.getServerFilename(fileNo);
	}
	
	// 특정펫정보가져오기
	@Override
	public PetInfo getMyPetByPetNo(Map<String, Object> param) {
		return ownerDAO.getMyPetByPetNo(param);
	}
	
	// 마이펫정보 수정
	@Override
	public int updateMyPetInfo(PetInfo petInfo) {
		return ownerDAO.updateMyPetInfo(petInfo);
	}
	@Override
	public int deletePet(int pet_no) {
		return ownerDAO.deletePet(pet_no);
	}
	
	




	



	

}
