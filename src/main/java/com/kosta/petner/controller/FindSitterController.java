package com.kosta.petner.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import com.kosta.petner.bean.FindArr;
import com.kosta.petner.bean.Users;
import com.kosta.petner.service.OwnerService;
import com.kosta.petner.service.UsersService;

@Controller
public class FindSitterController {
	// 메인화면 => 펫시터 찾기 관련 컨트롤러 
	
	@Autowired
	OwnerService ownerService;
	
	@Autowired
	UsersService usersService;
	
	//펫시터찾기
	@RequestMapping(value = "/findSitter", method = RequestMethod.GET)
	String findSitter(Model model, HttpServletRequest request){
		//user의 DB에 저장된 값 가져오기 22.12.05김혜경
		Users users = (Users) WebUtils.getSessionAttribute(request, "authUser");
		if(users == null) {
			System.out.println("null");
		}else {
			Integer user_no = users.getUser_no();
			Users userInfo = usersService.getUserByUserNo(user_no);
			model.addAttribute("userInfo", userInfo);
		}
		model.addAttribute("title", "펫시터찾기");
		model.addAttribute("page", "main/find/findSitter");
		return "/layout/main";
	}
	
	
	//돌봐줄 동물 찾기 검색
	//검색조건 : 성별, 서비스, 동물종류, 요일
	@ResponseBody
	@RequestMapping(value = "/findSitter/findSitterSearch", method= RequestMethod.POST)
	public List<Map<String, Object>> findSitterSearch(Model model, @RequestBody FindArr findVO) {
		List<Map<String, Object>> sitterSearchList = null;
		try {
			//리스트 불러오기
			sitterSearchList = ownerService.findSitterSearch(findVO);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sitterSearchList;
		
	}
	
	
}
