package com.kosta.petner.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosta.petner.bean.CareService;
import com.kosta.petner.bean.Find;
import com.kosta.petner.bean.SitterInfo;

@Repository
public class SitterDAOImpl implements SitterDAO {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public void regist(SitterInfo sitterInfo) {
		sqlSession.insert("mapper.sitter.regist", sitterInfo);
	}

	@Override //221114-DSC 시터정보가져오기
	public SitterInfo getSitterInfo(int user_no) {
		return sqlSession.selectOne("mapper.sitter.getSitterInfo", user_no);		
	}
	@Override // 펫시터정보 업데이트 1125DSC
	public int updateSitterInfo(SitterInfo sitterInfo) {
		return sqlSession.update("mapper.sitter.updateSitterInfo", sitterInfo);
	}

	/* 날짜:22.11.22
	 * 작성자: 김혜경
	 * 내용: service_no에 맞는 돌봐줄 동물 찾기 viewForm(디테일페이지)
	 */
	@Override
	public CareService getViewForm(Integer service_no) {
		return sqlSession.selectOne("mapper.sitter.getViewForm", service_no);
	}

	/* 날짜:22.11.30
	 * 작성자: 김혜경
	 * 내용: 펫시터 정보등록시 프로필 사진 users테이블에 update
	 */
	@Override
	public void updateFileNoToUsers(SitterInfo sitterInfo) {
		sqlSession.update("mapper.sitter.updateFileNoToUsers", sitterInfo);
	}

	/* 날짜:22.12.16
	 * 작성자: 김혜경
	 * 내용: 돌봐줄 동물 찾기 검색
	 */
	@Override
	public List<CareService> findPetSearch(Find findVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		//st_date
		if(findVO.getSt_date() != null && !findVO.getSt_date().equals("")) {
			map.put("st_date",findVO.getSt_date());
		}else {
			System.out.println("st_date null입니다.");
		}
		//end_date
		if(findVO.getEnd_date() != null && !findVO.getEnd_date().equals("")) {
			map.put("end_date",findVO.getEnd_date());
		}else {
			System.out.println("end_date null입니다.");
		}
		//service
		if(findVO.getService() != null && !findVO.getService().equals("")) {
			for(int i = 0; i < findVO.getService().length() ; i++) {
				String[] value = findVO.getService().split(",");
				map.put("serviceArray", value );
			}
		}else {
			System.out.println("서비스 null입니다.");
		}
		//pet_kind
		if(findVO.getPet_kind() != null && !findVO.getPet_kind().equals("")) {
			for(int i = 0; i < findVO.getPet_kind().length() ; i++) {
				String[] value = findVO.getPet_kind().split(",");
				map.put("petKindArray", value );
			}
		}else {
			System.out.println("동물종류 null입니다.");
		}
		//gender
		if(findVO.getGender() != null && !findVO.getGender().equals("")) {
			for(int i = 0; i < findVO.getGender().length() ; i++) {
				String[] value = findVO.getGender().split(",");
				map.put("genderArray", value );
			}
		}else {
			System.out.println("성별 null입니다.");
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

		return sqlSession.selectList("mapper.sitter.findPetSearch", map);
	}

	/* 날짜:22.11.30
	 * 작성자: 김혜경
	 * 내용: 검색조건에 따른 게시글 수
	 */
	@Override
	public int findPetSearchCount(Find findVO) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		//st_date
		if(findVO.getSt_date() != null && !findVO.getSt_date().equals("")) {
			map.put("st_date",findVO.getSt_date());
		}else {
			System.out.println("st_date null입니다.");
		}
		//end_date
		if(findVO.getEnd_date() != null && !findVO.getEnd_date().equals("")) {
			map.put("end_date",findVO.getEnd_date());
		}else {
			System.out.println("st_date null입니다.");
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
		//gender
		if(findVO.getGender() != null && !findVO.getGender().equals("")) {
			map.put("genderArray",findVO.getGender());
		}else {
			System.out.println("성별 null입니다.");
		}
		//zipcode(우편번호)
		if(findVO.getZipcode() != null && !findVO.getZipcode().equals("")) {
			//앞의 2자리는 특별시 및 광역시·도, 세 번째 자리는 시·군·구를 나타내기 때문에 우편번호 앞3자리로 검색
			String zipcode = findVO.getZipcode();
			String subZipcode = zipcode.substring(2);
			map.put("zipcode",subZipcode);
		}else {
			System.out.println("우편번호 null입니다.");
		}
		
		return sqlSession.selectOne("mapper.sitter.findPetSearchCount", map);
	}

	@Override
	public List<CareService> getAllPetServiceList() {
		return sqlSession.selectList("mapper.sitter.getAllPetServiceList");
	}

	

}
