package com.kosta.petner.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosta.petner.bean.CareService;
import com.kosta.petner.bean.Find;
import com.kosta.petner.bean.FindArr;
import com.kosta.petner.bean.PageInfo;
import com.kosta.petner.bean.PetInfo;
import com.kosta.petner.bean.SitterInfo;
import com.kosta.petner.dao.OwnerDAO;

@Service
public class OwnerServiceImpl implements OwnerService {

	@Autowired
	OwnerDAO ownerDAO;
	
	//김혜경
	@Override
	public void regist(PetInfo petInfo) throws Exception {
		ownerDAO.regist(petInfo);
	}

	//김혜경
	//user_no에 맞는 pet정보를 가져옴
	@Override
	public List<PetInfo> getPetByUserNo(Integer user_no) {
		return ownerDAO.getPetByUserNo(user_no);
	}

	//김혜경
	@Override
	public PetInfo getPetByPetNo(Integer pet_no) {
		return ownerDAO.getPetByPetNo(pet_no);
	}

	//김혜경
	@Override
	public String getFileByPetNo(Integer pet_no) {
		return ownerDAO.getFileByPetNo(pet_no);
	}

	/* 날짜:22.11.16
	 * 작성자: 김혜경
	 * 내용: 펫시팅 서비스 신청
	 */
	@Override
	public void insertRequireServiceFrom(CareService careService) {
		ownerDAO.insertRequireServiceFrom(careService);
	}

	/* 날짜:22.11.18
	 * 작성자: 김혜경
	 * 내용: 시터 서비스 신청 list 가져오기 - 페이징
	 */
	@Override
	public List<CareService> getServiceList(Integer user_no, Integer page, PageInfo pageInfo) {
		int listCount = ownerDAO.csListCount(user_no); //전체 게시글 수
		int maxPage = (int)Math.ceil((double)listCount/10); //전체 페이지 수, 올림 처리
		int startPage = page/10 * 10 + 1;         //현재 페이지 보여줄 시작 페이지 버튼(1,11,21, 등...)
		int endPage = startPage +10 -1;           //현재 페이지에 보여줄 마지막 페이지 버튼(10, 20, 30, 등..)
		if(endPage > maxPage) endPage = maxPage;
		
		pageInfo.setPage(page);
		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		
		Integer row = (page-1)*10+1;
		return ownerDAO.getServiceList(user_no, row);
	}

	/* 날짜:22.11.17
	 * 작성자: 김혜경
	 * 내용: 시터 서비스 신청 list 수 가져오기
	 */
	@Override
	public Integer csListCount(Integer user_no) {
		return ownerDAO.csListCount(user_no);
	}
	
	/* 날짜:22.11.30
	 * 작성자 : 조다솜
	 * 내용:펫시터 찾기 활동가능한시터 모두 불러오기
	 */
	@Override
	public List<Map<String, Object>> getAllAvailSitter() {
		// TODO Auto-generated method stub
		return ownerDAO.getAllAvailSitter();
	}

	/* 날짜:22.12.05
	 * 작성자: 김혜경
	 * 내용: 펫시터 찾기 ajax검색
	 */
	@Override
	public List<Map<String, Object>> findSitterSearch(FindArr findVO) {
		return ownerDAO.findSitterSearch(findVO);
	}


}
