package com.kosta.petner.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosta.petner.bean.Users;

@Repository
public class UsersDAOImpl implements UsersDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}
	//회원가입
	@Override
	public void insertUsers(Users users) throws Exception {
		sqlSession.insert("mapper.users.insertUsers", users);
		
	}
	//아이디 중복체크
	@Override
	public Users selectId(String id) {
		return sqlSession.selectOne("mapper.users.selectId", id);
	}
	//로그인
	@Override
	public Users loginById(Users users) {
		Users vo = sqlSession.selectOne("mapper.users.loginById", users);
		//로그인시 고유의 채널룸을 만든다??
		
		return vo;
	}
	
	// 자동로그인 체크한 경우에 사용자 테이블에 세션과 유효시간을 저장하기 위한 메서드
	@Override
	public void keepLogin(String uid, String sessionId, Date next) {
		   Map<String, Object> map = new HashMap<String,Object>();
	        map.put("id", uid);
	        map.put("sessionId", sessionId);
	        map.put("next", next);
	        sqlSession.update("mapper.users.keepLogin",map);
		
	}
	
	// 이전에 로그인한 적이 있는지, 즉 유효시간이 넘지 않은 세션을 가지고 있는지 체크한다.
	@Override
	public Users checkUserWithSessionKey(String sessionId) {
		 return sqlSession.selectOne("mapper.users.checkUserWithSessionKey",sessionId);
	}
	
	//아이디찾기
	@Override
	public Users getId(String name, String email) {
		Map<String,String> map = new HashMap<String, String>();
		map.put("name", name);
		map.put("email", email);
		Users users = sqlSession.selectOne("mapper.users.getId",map);
		
		return users;
	}
	//임시비밀번호발급
	@Override
	public void updatePw(Users users) {
		 sqlSession.selectOne("mapper.users.updateTmp", users);		
	}
	//비밀번호 확인
	@Override
	public Users checkPass(String id,String password)throws Exception{
		Map<String,String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("password", password);
		return sqlSession.selectOne("mapper.users.checkPass", map);
	}
	
	//비밀번호 수정
	@Override
	public void updatePass(String id, String password) throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("password", password);
		sqlSession.update("mapper.users.updatePass", map);
		
	}
	
	// 카카오 정보 저장
	public void kakaoinsert(HashMap<String, Object> userInfo) {
		sqlSession.insert("mapper.users.kakaoInsert",userInfo);
	}

	// 카카오 정보 확인
	public Users findkakao(HashMap<String, Object> userInfo) {
		System.out.println("RN:"+userInfo.get("nickname"));
		System.out.println("RE:"+userInfo.get("email"));
		return sqlSession.selectOne("mapper.users.findKakao", userInfo);
	}
	
	
	
	
	// user정보 가져오기 221113-조다솜
	public Users getMyinfo(String id){		
		return sqlSession.selectOne("mapper.users.getMyinfo", id);
	}
	@Override
	public int updateMyinfo(Users users) {
		return sqlSession.update("mapper.users.updateMyinfo", users);
	}
	
	
	//user_no를 파라미터로 받아 유저의 모든 정보를 가져온다
	@Override
	public Users getUserByUserNo(Integer user_no) {
		return sqlSession.selectOne("mapper.users.getUserByUserNo", user_no);
	}
	
	// 마이페이지에서 물고 다녀야 하는 모든 정보 221116-DSC
	@Override
	public Object getMyAllInfo(int user_no) {
		return sqlSession.selectOne("mapper.users.getMyAllInfo", user_no);
	}
	
	// users 의 전체 정보
	@Override
	public List<Users> selectAllUsers() throws Exception {
		return sqlSession.selectList("mapper.users.selectAllUsers");
	}
	
	
	// 내 아이디로 등록된 시터정보나 동물정보가 있는지 체크 221121-DSC
	@Override
	public Map<String, Object> getCount(int user_no) {
		return sqlSession.selectOne("mapper.users.getCount", user_no);
	}
	//id로 회원정보 전체조회
	@Override
	public Users inquiryOfUserById(String id){
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.users.selectId");
	}
	
	//userNo로 회원정보 전체조회
	@Override
	public Users inquiryOfUserByUserNo(int userNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.users.getUserByUserNo");
	}
	
	// 유진 : 회원탈퇴
	@Override
	public void deleteUsers(Integer user_no) throws Exception {
		sqlSession.update("mapper.users.deleteUsers", user_no);
		
	}
	@Override
	public void updateUserType(Users users) {
		sqlSession.update("mapper.users.updateUserType", users);
		
	}


	
	
	

}


	
	

	

