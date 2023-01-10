package com.kosta.petner.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosta.petner.bean.Follow;
import com.kosta.petner.dao.IFollowDAO;

@Service
public class IFollowServiceImpl implements IFollowService{

	@Autowired
	IFollowDAO followDAO;
	
	@Override
	public void follow(Follow follow) {
		followDAO.follow(follow);
	}

	@Override
	public void unfollow(Follow follow) {
		followDAO.unfollow(follow);		
	}

	@Override
	public int isFollow(Follow follow) {
		return followDAO.isFollow(follow);
	}

	@Override
	public List<Follow> selectActiveUserList(int activeUser) {
		return followDAO.selectActiveUserList(activeUser);
	}

	@Override
	public List<Follow> selectPassiveUserList(int passiveUser) {
		return followDAO.selectPassiveUserList(passiveUser);
	}

}
