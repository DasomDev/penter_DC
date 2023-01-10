package com.kosta.petner.service;

import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import com.kosta.petner.bean.Users;

public interface UsersService {
	// 회원가입
	public void joinUsers(Users users) throws Exception;

	// 중복체크
	public boolean isDoubleId(String id) throws Exception;

	//로그인
	public Users login(Users users) throws Exception;
	
        // 자동로그인 체크한 경우에 사용자 테이블에 세션과 유효시간을 저장하기 위한 메서드
    public void keepLogin(String uid, String sessionId, Date next);
     
    // 이전에 로그인한 적이 있는지, 즉 유효시간이 넘지 않은 세션을 가지고 있는지 체크한다.
    public Users checkUserWithSessionKey(String sessionId);
	
	//아이디 찾기
	public Users findId(Users users);

	// 이메일발송
	public void sendEmail(Users users, String div) throws Exception;

	// 비밀번호찾기
	public void findPass(HttpServletResponse response,Users users) throws Exception;
	
	//비밀번호 체크
	public Users checkPass(Users users)throws Exception;

	//비밀번호 변경
	public void updatePass(String id, String password)throws Exception;

	// 카카오토큰받기
	public String getAccessToken(String authorize_code);

	// 카카오회원정보조회
	public Users getUserInfo(String access_Token);

	// user_no를 파라미터로 받아 유저의 모든 정보를 가져온다
	public Users getUserByUserNo(Integer user_no);

	// 아이디로 회원의 모든 정보 조회
	Users inquiryOfUserById(String id);

	// 아이디로 회원의 모든 정보 조회
	Users inquiryOfUserByUserNo(int userNo) throws Exception;

	// 유진 : 회원탈퇴
	void deleteUsers(Integer user_no) throws Exception;
	
	// 타입 업데이트
	void updateUserType(Users users);
}
