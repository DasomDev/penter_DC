package com.kosta.petner.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.kosta.petner.bean.CareService;
import com.kosta.petner.bean.FileVO;
import com.kosta.petner.bean.PageInfo;
import com.kosta.petner.bean.PetInfo;
import com.kosta.petner.bean.Users;
import com.kosta.petner.service.FileService;
import com.kosta.petner.service.OwnerService;
import com.kosta.petner.service.UsersService;

//서비스신청 / 펫시터찾기
//클라이언트 : 반려동물보호자
@Controller
public class OwnerController {

	@Autowired
	ServletContext servletContext;
	
	@Autowired
	FileService fileService;
	
	@Autowired
	OwnerService ownerService;
	
	@Autowired
	UsersService usersService;
	
	//펫 정보등록 페이지
	public @RequestMapping(value = "/petForm", method = RequestMethod.GET)
	String petForm(Model model) {
		model.addAttribute("title", "펫정보등록");
		model.addAttribute("page", "mypage/petForm");
		return "/layout/mypage_default";
	}
	
	//DB insert
	@RequestMapping(value = "/petForm/register", method = RequestMethod.POST)
	public ModelAndView register(Model model, @ModelAttribute PetInfo petInfo) {
		ModelAndView mav = new ModelAndView();
		try {
			// 파일
			MultipartFile file = petInfo.getImageFile(); //파일 자체를 가져옴
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
				fileVO.setUser_no(petInfo.getUser_no());
				fileVO.setBoard_no(4);
				fileVO.setOrigin_filename(filename);//파일의 이름을 넣어주기위해 따로 설정
				fileVO.setServer_filename(server_filename);
				fileService.insertFile(fileVO);
				
				//3. pet_info테이블에 정보 넣기
				//3-1. server_filname에 맞는 file_no가져오기
				Integer file_no = fileService.getFileNo(server_filename);
				petInfo.setFile_no(file_no);

				ownerService.regist(petInfo);
				mav.setViewName("redirect:/mypage/myPetInfo");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	//펫케어 서비스 신청 화면
	@RequestMapping(value = "/mypage/myService/requireService", method = RequestMethod.GET)
	String requireService(Model model, HttpServletRequest request) {
		//1. user_no가져오기
		Users users = (Users) WebUtils.getSessionAttribute(request, "authUser");
		Integer user_no = users.getUser_no();
		
		//2. 지역 가져오기
		Users userInfo = usersService.getUserByUserNo(user_no);
		model.addAttribute("userInfo", userInfo);
		
		//3. 펫정보
		List<PetInfo> petInfo = ownerService.getPetByUserNo(user_no);
		model.addAttribute("petInfo", petInfo);
		model.addAttribute("title", "펫케어 서비스 신청");
		model.addAttribute("page", "mypage/myService/requireService");
		return "/layout/mypage_default";
	}
	
	//펫정보(이름, 성별, 종류, 체중, 중성화, 특이사항) 가져오기 ajax
	@ResponseBody
	@RequestMapping(value = "/getPetInfo", method = RequestMethod.POST)
	public PetInfo getPetInfo(@RequestBody PetInfo petInfo) throws Exception{
		try {
			Integer pet_no = petInfo.getPet_no();
			petInfo = ownerService.getPetByPetNo(pet_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return petInfo;
	}
	
	//펫 이미지 파일 화면에 띄우기
	@RequestMapping(value = "/{petNo}", method = RequestMethod.GET)
	public void viewImages(@PathVariable String petNo, HttpServletResponse response) {
		String path = servletContext.getRealPath("/resources/upload/");
		FileInputStream fis = null;
		try {
			Integer pet_no = Integer.parseInt(petNo);
			String server_filename = ownerService.getFileByPetNo(pet_no);
			fis = new FileInputStream(path + server_filename);
			OutputStream out = response.getOutputStream();
			FileCopyUtils.copy(fis, out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(fis != null) {
				try {
					fis.close();
				} catch (Exception e) {} 
			}
		}
	}
	
	//펫케어 서비스 신청 insert
	@RequestMapping(value = "/mypage/myService/requireServiceForm", method = RequestMethod.POST)
	public ModelAndView requireServiceFrom(@ModelAttribute CareService careService, Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			//user_no셋팅
			Users users = (Users) WebUtils.getSessionAttribute(request, "authUser");
			Integer user_no = users.getUser_no();
			careService.setUser_no(user_no);
			
			// 파일
			MultipartFile file = careService.getImageFile(); //파일 자체를 가져옴
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
				fileVO.setUser_no(user_no);
				fileVO.setBoard_no(5);
				fileVO.setOrigin_filename(filename);//파일의 이름을 넣어주기위해 따로 설정
				fileVO.setServer_filename(server_filename);
				fileService.insertFile(fileVO);
				
				//3. care_service테이블에 정보 넣기
				//3-1. server_filname에 맞는 file_no가져오기
				Integer file_no = fileService.getFileNo(server_filename);
				careService.setFile_no(file_no);
				ownerService.insertRequireServiceFrom(careService);
				mav.setViewName("redirect:/mypage");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
		
	}
	
	//요청한 서비스 보기 화면
	@RequestMapping(value = "/mypage/myService/requireServiceList",  method= {RequestMethod.POST, RequestMethod.GET})
	String requireServiceList(CareService careService, Model model, HttpServletRequest request
							 ,@RequestParam(value="page", required=false, defaultValue ="1") Integer page) {
		Users users = (Users) WebUtils.getSessionAttribute(request, "authUser");
		Integer user_no = users.getUser_no();
		
		//페이징
		PageInfo pageInfo = new PageInfo();
				
		//care_service테이블에서 데이터 가져오기
		List<CareService> csList = ownerService.getServiceList(user_no, page, pageInfo);
		
		//게시판 수
		Integer csListCount = ownerService.csListCount(user_no);
		
		model.addAttribute("csListCount", csListCount);
		model.addAttribute("csList", csList);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("title", "요청한 서비스 보기");
		model.addAttribute("page", "mypage/myService/requireServiceList");
		return "/layout/mypage_default";
	}
}
