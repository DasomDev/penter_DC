package com.kosta.petner.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.kosta.petner.bean.Follow;

@Repository
public class IFollowDAOImpl implements IFollowDAO{

	@Override
	public void follow(Follow follow) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void unfollow(Follow follow) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int isFollow(Follow follow) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Follow> selectActiveUserList(int activeUser) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Follow> selectPassiveUserList(int passiveUser) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteUserAllFollow(int activeUser) {
		// TODO Auto-generated method stub
		
	}

}
