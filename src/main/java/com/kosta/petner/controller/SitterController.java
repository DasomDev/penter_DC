package com.kosta.petner.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.ServletContext;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kosta.petner.bean.FileVO;
import com.kosta.petner.bean.SitterInfo;
import com.kosta.petner.service.FileService;
import com.kosta.petner.service.SitterService;

@Controller
public class SitterController {

	@Autowired
	ServletContext servletContext;
	
	@Autowired
	FileService fileService;
	
	@Autowired
	SitterService sitterService;

	//펫시터 정보등록 페이지 혜경
	@RequestMapping(value = "/sitterForm", method = RequestMethod.GET)
	String sitterForm(Model model) {
		model.addAttribute("title", "시터정보등록");
		model.addAttribute("page", "mypage/sitterForm");
		return "/layout/mypage_default";
	}
	
	//DB insert 혜경
	@RequestMapping(value = "/sitterForm/register", method = RequestMethod.POST)
	public ModelAndView register(Model model, @ModelAttribute SitterInfo sitterInfo) {
		ModelAndView mav = new ModelAndView();
		try {
			// 파일
			MultipartFile file = sitterInfo.getImageFile(); //파일 자체를 가져옴
			// 서버에 올라갈 랜덤한 파일 이름을 만든다
			String generatedString = RandomStringUtils.randomAlphanumeric(10);
			String filename = file.getOriginalFilename();
			int idx = filename.lastIndexOf(".");//확장자 위치
			String ext = filename.substring(filename.lastIndexOf("."));
			String real_filename = filename.substring(0, idx);//확장자분리
			String server_filename = real_filename + generatedString + ext;
			if(!file.isEmpty()) {
				//1.폴더생성
				FileVO fileVO = new FileVO();
				String path = servletContext.getRealPath("/resources/upload/");//업로드 할 폴더 경로
				File fileLocation = new File(path);
				File destFile = new File(path+server_filename);
				System.out.println(destFile);
				if (fileLocation.exists()) {
					System.out.println("이미 폴더가 생성되어 있습니다.");
					file.transferTo(destFile);
			    }else {
			    	try{
			    		Path directoryPath = Paths.get(path);
						System.out.println(directoryPath);
						Files.createDirectory(directoryPath);//폴더생성
						System.out.println("폴더가 생성되었습니다.");
						file.transferTo(destFile);
					}catch(Exception e){
					    e.getStackTrace();
					}        
				}
					
				//2. 파일정보 파일테이블에 넣기
				fileVO.setUser_no(sitterInfo.getUser_no());
				fileVO.setBoard_no(5);
				fileVO.setOrigin_filename(filename);//파일의 이름을 넣어주기위해 따로 설정
				fileVO.setServer_filename(server_filename);
				fileService.insertFile(fileVO);
				
				//3-1. server_filname에 맞는 file_no가져오기
				Integer file_no = fileService.getFileNo(server_filename);
				sitterInfo.setFile_no(file_no);
				//3-2. users테이블 file_no컬럼에 해당 file_no update
				sitterService.updateFileNoToUsers(sitterInfo);
				//3-3.sitter_info테이블에 정보넣기
				sitterService.regist(sitterInfo);
				
				mav.setViewName("redirect:/");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
}
