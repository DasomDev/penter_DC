package com.kosta.petner.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosta.petner.bean.CareService;
import com.kosta.petner.bean.Find;
import com.kosta.petner.bean.FindArr;
import com.kosta.petner.bean.PetInfo;

@Repository
public class OwnerDAOImpl implements OwnerDAO {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public void regist(PetInfo petInfo) throws Exception {
		sqlSession.insert("mapper.owner.regist", petInfo);

	}

	
	
	// 메인 => 펫시터찾기 221130 DSC
	@Override
	public List<Map<String, Object>> getAllAvailSitter() {
		return sqlSession.selectList("mapper.owner.getAllAvailSitter");
	}
	
	//user_no에 맞는 pet정보를 가져옴
	@Override
	public List<PetInfo> getPetByUserNo(Integer user_no) {
		return sqlSession.selectList("mapper.owner.getPetByUserNo", user_no);
	}

	@Override
	public PetInfo getPetByPetNo(Integer pet_no) {
		return sqlSession.selectOne("mapper.owner.getPetByPetNo", pet_no);
	}

	@Override
	public String getFileByPetNo(Integer pet_no) {
		return sqlSession.selectOne("mapper.owner.getFileByPetNo", pet_no);
	}

	@Override
	public void insertRequireServiceFrom(CareService careService) {
		sqlSession.insert("mapper.owner.insertRequireServiceFrom", careService);
	}

	@Override
	public List<CareService> getServiceList(Integer user_no, Integer row) {
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("user_no", user_no);
		map.put("row", row);
		return sqlSession.selectList("mapper.owner.getServiceList", map);
	}

	@Override
	public Integer csListCount(Integer user_no) {
		return sqlSession.selectOne("mapper.owner.csListCount", user_no);
	}

	@Override
	public int csListAllCount() {
		return sqlSession.selectOne("mapper.owner.csListAllCount");
	}
	
	// 동물 한마리 정보 가져오기 221130DSC 
	@Override
	public PetInfo getMyPetByPetNo(Map<String, Object> param) {
		return sqlSession.selectOne("mapper.owner.getMyPetByPetNo", param);
	}
	
	// 마이펫 정보 수정
	@Override
	public int updateMyPetInfo(PetInfo petInfo) {
		return sqlSession.update("mapper.owner.updateMyPetInfo", petInfo);
	}
	
	// 동물삭제
	@Override
	public int deletePet(int pet_no) {
		return sqlSession.delete("mapper.owner.deletePet", pet_no);
	}


	/* 날짜:22.12.05
	 * 작성자: 김혜경
	 * 내용: 펫시터 찾기 ajax검색(성별, 서비스, 동물종류, 요일)
	 */
	@Override
	public List<Map<String, Object>> findSitterSearch(FindArr findVO) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		//gender
		if(findVO.getGender() != null && !findVO.getGender().equals("")) {
			map.put("genderArray",findVO.getGender());
		}else {
			System.out.println("성별 null입니다.");
		}
		//service
		if(findVO.getService() != null && !findVO.getService().equals("")) {
			map.put("serviceArray",findVO.getService());
		}else {
			System.out.println("서비스 null입니다.");
		}
		//pet_kind
		if(findVO.getPet_kind() != null && !findVO.getPet_kind().equals("")) {
			map.put("petKindArray",findVO.getPet_kind());
		}else {
			System.out.println("동물종류 null입니다.");
		}
		//day
		if(findVO.getDay() != null && !findVO.getDay().equals("")) {
			map.put("dayArray",findVO.getDay());
		}else {
			System.out.println("가능한 요일 null입니다.");
		}
		//zipcode(우편번호)
		if(findVO.getZipcode() != null && !findVO.getZipcode().equals("")) {
			//앞의 2자리는 특별시 및 광역시·도, 세 번째 자리는 시·군·구를 나타내기 때문에 우편번호 앞3자리로 검색
			String zipcode = findVO.getZipcode();
			String subZipcode = zipcode.substring(0,3);
			map.put("zipcode",subZipcode);
		}else {
			System.out.println("우편번호 null입니다.");
		}
		return sqlSession.selectList("mapper.owner.findSitterSearch", map);
	}
	

}
