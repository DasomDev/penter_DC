package com.kosta.petner.controller;

import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import com.kosta.petner.bean.CareService;
import com.kosta.petner.bean.Find;
import com.kosta.petner.bean.JSONResult;
import com.kosta.petner.bean.MypageSession;
import com.kosta.petner.bean.Users;
import com.kosta.petner.service.FileService;
import com.kosta.petner.service.SitterService;
import com.kosta.petner.service.UsersService;

@Controller
public class FindPetController {

	@Autowired
	ServletContext servletContext;

	@Autowired
	UsersService usersService;

	@Autowired
	FileService fileService;

	@Autowired
	SitterService sitterService;

	public int getLoginUserNo(HttpSession session) {
		MypageSession mypageSession = (MypageSession) session.getAttribute("mypageSession");
		int user_no = mypageSession.getUser_no();
		return user_no;
	}
	// 돌봐줄 동물 찾기 페이지
	@RequestMapping(value = "/findPet", method = { RequestMethod.POST, RequestMethod.GET })
	String findPet(Model model, @RequestParam(value = "zipcode", required = false, defaultValue = "1") String qszipcode,
			@RequestParam(value = "addr", required = false) String addr, Find findPetVO, HttpServletRequest request) {
		// user의 DB에 저장된 값 가져오기
		Users users = (Users) WebUtils.getSessionAttribute(request, "authUser");
		if (users == null) {
			System.out.println("findPet authUser null");
		} else {
			Integer user_no = users.getUser_no();
			Users userInfo = usersService.getUserByUserNo(user_no);
			model.addAttribute("userInfo", userInfo);
		}
		
		// viewForm에서 넘어온 값 확인
		System.out.println("*******findPet request.getParameter******");
		String st_date = request.getParameter("st_date");
		String end_date = request.getParameter("end_date");
		String service = request.getParameter("service");
		String pet_kind = request.getParameter("pet_kind");
		String gender = request.getParameter("gender");
		String zipcode = request.getParameter("zipcode");
		String addrP = request.getParameter("addrP");
		
		System.out.println("st_date:  "+st_date);
		System.out.println("end_date:  "+end_date);
		System.out.println("service:  "+service);
		System.out.println("pet_kind:  "+pet_kind);
		System.out.println("gender:  "+gender);
		System.out.println("zipcode:  "+zipcode);
		System.out.println("addrP:  "+addrP);
		System.out.println("**********************************************");
		

		model.addAttribute("qszipcode", qszipcode);
		model.addAttribute("qsaddrp", addr);
		model.addAttribute("title", "돌봐줄 동물 찾기");
		model.addAttribute("page", "main/find/findPet");
		return "/layout/main";
	}
	

	// 돌봐줄 동물 찾기 검색
	// 검색조건 : 날짜, 서비스, 동물종류, 보호자 성별, (현재위치), 펫이름
	@RequestMapping(value = "/findPet/viewForm/findPetSearch", method = RequestMethod.GET)
	public List<CareService> findPetSearch(Model model, HttpServletRequest request) {
		System.out.println("findPetSearch controller");
		List<CareService> petSearchList = null;
		try {
			System.out.println("======request.getParameter======");
			String st_date = request.getParameter("st_date");
			String end_date = request.getParameter("end_date");
			String service = request.getParameter("service");
			String pet_kind = request.getParameter("pet_kind");
			String gender = request.getParameter("gender");
			String zipcode = request.getParameter("zipcode");
			String addrP = request.getParameter("addrP");

			System.out.println("st_date:  " + st_date);
			System.out.println("end_date:  " + end_date);
			System.out.println("service:  " + service);
			System.out.println("pet_kind:  " + pet_kind);
			System.out.println("gender:  " + gender);
			System.out.println("zipcode:  " + zipcode);
			System.out.println("addrP:  " + addrP);
			System.out.println("=============================");

			// 리스트 불러오기
			Find findVO = new Find();
			findVO.setSt_date(st_date);
			findVO.setEnd_date(end_date);
			findVO.setService(service);
			findVO.setPet_kind(pet_kind);
			findVO.setGender(gender);
			findVO.setZipcode(zipcode);
			findVO.setAddr(addrP);
			System.out.println("findPetSearch controller findVO:  " + findVO);

			petSearchList = sitterService.findPetSearch(findVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return petSearchList;
	}
	
	//게시글 사진 화면에 띄우기
	@RequestMapping(value = "/findPet/{fileNo}", method = RequestMethod.GET)
	public void viewCareServiceImages(@PathVariable String fileNo, HttpServletResponse response) {
	String path = servletContext.getRealPath("/resources/upload/");
		FileInputStream fis = null;
		try {
			Integer file_no = Integer.parseInt(fileNo);
			String server_filename = fileService.getServerFilename(file_no);
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
		

	// 돌봐줄 동물 찾기 게시글에 따른 viewForm
	@RequestMapping(value = "/findPet/viewForm/{serviceNo}", method = RequestMethod.GET)
	String findPet(Model model, @PathVariable String serviceNo,
			@RequestParam(value = "zipcode", required = false) String zipcode,
			@RequestParam(value = "addr", required = false) String addr,
			@RequestParam(value = "st_date", required = false) String st_date,
			@RequestParam(value = "end_date", required = false) String end_date,
			@RequestParam(value = "service", required = false) String service,
			@RequestParam(value = "pet_kind", required = false) String pet_kind,
			@RequestParam(value = "gender", required = false) String gender) {

		CareService careService = new CareService();
		Integer service_no = Integer.parseInt(serviceNo);
		careService = sitterService.getViewForm(service_no);

		model.addAttribute("cs", careService);
		model.addAttribute("zipcode", zipcode);
		model.addAttribute("st_date", st_date);
		model.addAttribute("end_date", end_date);
		model.addAttribute("service", service);
		model.addAttribute("pet_kind", pet_kind);
		model.addAttribute("gender", gender);
		model.addAttribute("addr", addr);

		model.addAttribute("title", "돌봐줄 동물 찾기");
		model.addAttribute("page", "main/find/findPetViewForm");
		return "/layout/main";
	}

	// 동물찾기 테스트 조다솜 뷰 ajax로 해야함
	@RequestMapping(value = "/findPetTest", method = RequestMethod.GET)
	String findPettest(HttpSession session, HttpServletRequest request, Model model) {
		try {
			int user_no = getLoginUserNo(session);
			System.out.println("지금 보는 user_no" + user_no);
		} catch (Exception e) {
			// e.printStackTrace();
			System.out.println("null은 어떻게 해결하는게 좋을까");

		}
		model.addAttribute("title", "돌봐줄 동물 찾기");
		model.addAttribute("page", "main/find/findPettest");
		return "/layout/main";
	}

	@ResponseBody
	@RequestMapping("/findPetTest/getJsonData") // ajax로 뷰 렌더링할것임
	public JSONResult getPetJson(HttpSession session, Model model) {
		// @ModelAttribute CateVo cateVo, BindingResult result,
		// 보고있는 사람의 zipcode 필요 => 기본 지도 해놓을거라 실제로 DB를 가져오는 부분

		List<CareService> petList = sitterService.getAllPetServiceList();
		System.out.println("리스트나와라gg" + petList);
		// List cateList = blogService.getCateList(userNo);
		return JSONResult.success(petList);

	}

}
