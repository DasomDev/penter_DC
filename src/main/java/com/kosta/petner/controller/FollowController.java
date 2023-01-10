package com.kosta.petner.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.kosta.petner.bean.Follow;
import com.kosta.petner.bean.Users;
import com.kosta.petner.service.IFollowService;
import com.kosta.petner.service.UsersService;

@RestController
public class FollowController {
	
	 private static final Logger logger = LoggerFactory.getLogger(UsersController.class);
	 
	 @Autowired
	 private IFollowService followService;
	 
	 @Autowired
	 private UsersService usersService;
	 
	 //팔로우 요청
	 @RequestMapping(value = "/follow/{id}", method = {RequestMethod.POST})
	 public String follow(@PathVariable String id, HttpSession session, Model model)throws Exception{
		 
		 logger.info("/follow/" + id + " : 팔로우 요청");
		 
		 Object object = session.getAttribute("login");
		 Users activeUser = (Users)object;
		 Users passiveUser = usersService.inquiryOfUserById(id);
		 
		 Follow follow = new Follow();
		 follow.setActiveUser(activeUser.getUser_no());
		 follow.setPassiveUser(passiveUser.getUser_no());
		 
		 followService.follow(follow);
		 
		 
		 return "FollowOK";
	 }
	 
	 //언팔로우 요청
	 @RequestMapping(value = "/unfollow/{id}", method = {RequestMethod.POST})
	 public String unfollow(@PathVariable String id, HttpSession session, Model model)throws Exception{
		 
		 logger.info("/unfollow/"+id+":언팔로우 요청");
		 
		 Object object = session.getAttribute("login");
		 Users activeUser = (Users)object;
		 Users passiveUser = usersService.inquiryOfUserById(id);
		 
		 Follow follow = new Follow();
		 follow.setActiveUser(activeUser.getUser_no());
		 follow.setPassiveUser(passiveUser.getUser_no());
		 
		 followService.unfollow(follow);
		 
		 return "UnFollowOK";
	 }
	 
}
