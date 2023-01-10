package com.kosta.petner.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

//인덱스/ 공지사항 / 메인화면 시터 오너 제외 기능
@Controller
public class MainController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	String main(Model model) {
		return "/main/index_main";
	}
	
	
	
}
