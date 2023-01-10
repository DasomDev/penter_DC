package com.kosta.petner.dao;

import java.util.List;

import com.kosta.petner.bean.Follow;

public interface IFollowDAO {
	
	//팔로우하기
	void follow(Follow follow);
	
	//언팔로우하기
	void unfollow(Follow follow);
	
	//팔로우 유무
	int isFollow(Follow follow);
	
	//팔로우 리스트 조회
	List<Follow> selectActiveUserList(int activeUser);
	
	//팔로우 리스트 조회
	List<Follow> selectPassiveUserList(int passiveUser);
	
	//탈퇴시 팔로우 삭제
	void deleteUserAllFollow(int activeUser);

}
