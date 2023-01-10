package com.kosta.petner.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kosta.petner.bean.Notice;
import com.kosta.petner.bean.PetInfo;
import com.kosta.petner.bean.Users;

public interface UsersDAO {

	// 회원가입
	void insertUsers(Users users) throws Exception;

	// 아이디 중복체크
	Users selectId(String id) throws Exception;

	// 아이디+비번으로 로그인하기
	Users loginById(Users users) throws Exception;
	
	  // 자동로그인 체크한 경우에 사용자 테이블에 세션과 유효시간을 저장하기 위한 메서드
    public void keepLogin(String uid, String sessionId, Date next);
     
    // 이전에 로그인한 적이 있는지, 즉 유효시간이 넘지 않은 세션을 가지고 있는지 체크한다.
    public Users checkUserWithSessionKey(String sessionId);
     
	
	//이름+이메일로 아이디 찾기
	Users getId(String name, String email);

	// 임시비밀번호수정
	void updatePw(Users users) throws Exception;
	
	//비밀번호 확인
	Users checkPass(String id, String password)throws Exception;
	
	//비밀번호 변경
	public void updatePass(String id, String password)throws Exception;

	// 유저정보가져오기
	Users getMyinfo(String id);

	// 유저정보업데이트
	int updateMyinfo(Users users);

	// 카카오유저 정보 저장
	void kakaoinsert(HashMap<String, Object> userInfo);

	// 카카오유저 정보확인
	Users findkakao(HashMap<String, Object> userInfo);

	// user_no를 파라미터로 받아 유저의 모든 정보를 가져온다
	Users getUserByUserNo(Integer user_no);

	// 마이페이지에서 물고 다녀야 하는 모든 정보 221116-DSC
	Object getMyAllInfo(int user_no);

	// users 의 전체 정보
	List<Users> selectAllUsers() throws Exception;
	
	// 내 아이디로 등록된 시터정보나 동물정보가 있는지 체크 221121-DSC
	Map<String, Object> getCount(int user_no);

	
	
	

	// 아이디로 회원의 모든 정보 조회
	Users inquiryOfUserById(String id);

	// 유저번호로 회원의 모든 정보 조회
	Users inquiryOfUserByUserNo(int userNo) throws Exception;

	// 유진 : 회원탈퇴
	void deleteUsers(Integer user_no) throws Exception;
	
	// 타입 업데이트
	void updateUserType(Users users);
	
	
}
