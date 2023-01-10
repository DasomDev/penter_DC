package com.kosta.petner.controller;



import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

//import com.kosta.petner.bean.ChatSession;
import com.kosta.petner.bean.Users;
import com.kosta.petner.dao.UsersDAO;
import com.kosta.petner.service.UsersService;



@Controller
public class UsersController {
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;

	@Inject
	UsersService usersService;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	UsersDAO usersDAO;
	
	/* Chat session _ 홍시원 추가 _ 2022.11.11 */
	@Autowired
	//private ChatSession cSession;
	
	

	
		
	//회원가입 이동
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	String joinForm() {
		return "users/join/joinForm";
	}
	
	//회원가입 
	@RequestMapping(value = "/joinpet", method = RequestMethod.POST)
	String join(@ModelAttribute Users users, Model model) {
		  System.out.println("암호화 전 : " + users);	
		try{		
			String passBcrypt = bcryptPasswordEncoder.encode(users.getPassword());
			   users.setPassword(passBcrypt);
			   usersService.joinUsers(users);
			   System.out.println("암호화 후 : " + users);
			
			
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("err", "회원가입 오류");
			model.addAttribute("page", "err");
		}
		
		return "users/join/joinSuccess";
	}
	
		
	//중복체크
	@ResponseBody 
	@RequestMapping(value = "/checkId", method = RequestMethod.POST)
	   String checkId(@RequestParam("id") String id, Model model) {
		try {
			if(usersService.isDoubleId(id)) return "true";
		}catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("page","err");
		}
	      return "false";
	}
	
	
		// 로그인화면 이동
		@RequestMapping(value = "/gologin", method = RequestMethod.GET)
		String main(Model model) {
			model.addAttribute("page", "users/login/loginForm");
			model.addAttribute("title", "로그인");
			return "/layout/main";
		}
		
		
		
		//로그인
		@RequestMapping(value="/login", method=RequestMethod.POST)
			public String login(Users users, Model model, HttpServletResponse response) throws Exception {
				String returnURL = "";
			
				if ( session.getAttribute("authUser") != null ){
		            // 기존에 login이란 세션 값이 존재한다면
		            session.removeAttribute("authUser"); // 기존값을 제거해 준다.
		        }
				
				//ID 비밀번호와 대조해서 로그인성공 (암호화 된 비밀번호랑 대조)
				Users authUser = usersService.login(users);
				
				if(authUser != null && bcryptPasswordEncoder.matches(users.getPassword(), authUser.getPassword())) {
					//System.out.println(authUser);
					session.setAttribute("authUser", authUser);
					session.setAttribute("uid", users.getId());
					
					returnURL = "redirect:/";
					
		            // 1. 로그인이 성공하면, 그 다음으로 로그인 폼에서 쿠키가 체크된 상태로 로그인 요청이 왔는지를 확인한다.
					if(users.isUseCookie() ){ // users 클래스 안에 useCookie 항목에 폼에서 넘어온 쿠키사용 여부(true/false)가 들어있을 것임
		                // 쿠키 사용한다는게 체크되어 있으면...
		                // 쿠키를 생성하고 현재 로그인되어 있을 때 생성되었던 세션의 id를 쿠키에 저장한다.
		                Cookie cookie = new Cookie("loginCookie", session.getId());
		                // 쿠키를 찾을 경로를 컨텍스트 경로로 변경해 주고...
		                cookie.setPath("/");
		                int amount = 60 * 60 * 24 * 7;
		                cookie.setMaxAge(amount); // 단위는 (초)임으로 7일정도로 유효시간을 설정해 준다.
		                // 쿠키를 적용해 준다.
		                response.addCookie(cookie); 
		                
		                // currentTimeMills()가 1/1000초 단위임으로 1000곱해서 더해야함 
		                Date sessionlimit = new Date(System.currentTimeMillis() + (1000*amount));
		                // 현재 세션 id와 유효시간을 사용자 테이블에 저장한다.
		                usersService.keepLogin(authUser.getId(), session.getId(), sessionlimit);
		                
		                System.out.println("Cookie:" +"Cookie 있음, "+ "로그인 유지시간:" +sessionlimit);
		            }
				
				}else { // 로그인에 실패한 경우
		            model.addAttribute("check", 1);
					model.addAttribute("message", "아이디와 비밀번호를 확인해주세요.");
					model.addAttribute("page", "users/login/loginForm");
					returnURL = "/layout/main"; // 로그인 폼으로 다시 가도록 함
		        }
		         
		        return returnURL; // 위에서 설정한 returnURL 을 반환해서 이동시킴
		    }
		
		//로그아웃
		@RequestMapping(value="/logout",method = RequestMethod.GET)
		public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
	         
	        Object obj = session.getAttribute("authUser");
	        if ( obj != null ){
	            Users users = (Users)obj;
	            // null이 아닐 경우 제거
	            session.removeAttribute("authUser");
	            session.invalidate(); // 세션 전체를 날려버림
	            //쿠키를 가져와보고
	            Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
	            if ( loginCookie != null ){
	                // null이 아니면 
	                loginCookie.setPath("/");
	                // 쿠키는 없앨 때 유효시간을 0으로 설정하는 것 !!! invalidate같은거 없음.
	                loginCookie.setMaxAge(0);
	                // 쿠키 설정을 적용한다.
	                response.addCookie(loginCookie);
	                 
	                // 사용자 테이블에서도 유효기간을 현재시간으로 다시 세팅해줘야함.
	                Date date = new Date(System.currentTimeMillis());
	                usersService.keepLogin(users.getId(), session.getId(), date);
	            }
	        }
	        return "redirect:/"; // 로그아웃 후 메인으로 이동하도록...함
	    }
		
		//아이디 찾기로 이동
		@RequestMapping(value = "/findId", method = RequestMethod.GET)
		String findId() {
			return "users/login/findId";
		}
		
		//아이디 찾기
		@RequestMapping(value="/findId",method = RequestMethod.POST)              
		public String findId(@ModelAttribute Users users, Model model) throws Exception {				

			System.out.println("users.getName():    "+ users.getName());
			System.out.println("users.getEmail():    "+ users.getEmail());
		
			Users searchId = usersService.findId(users);

			if(searchId ==null) {
				System.out.println("아이디찾기 실패");
				model.addAttribute("result", "fail");
				return "users/login/resultId";	
			}		
			model.addAttribute("searchId", searchId);
			System.out.println(searchId);
			return "users/login/resultId";
			}
		
		//비밀번호 찾기로 이동
		@RequestMapping(value = "/findPass", method = RequestMethod.GET)
		String findPass() {
			return "users/login/findPass";
		}
			
		//이메일로 비밀번호 찾기
		@RequestMapping(value = "/findPass", method = RequestMethod.POST)
				public void findPwPOST(@ModelAttribute Users users, HttpServletResponse response) throws Exception{
					System.out.println("id:" + users.getId());
					System.out.println("Email:" + users.getEmail());
					
					usersService.findPass(response, users);
				}

			 
		
		
		//비밀번호변경으로이동
		@RequestMapping(value="/checkPass", method=RequestMethod.GET)
		String moidifyPass(){
			return "/users/login/checkPass";
		}
		
		//비밀번호 확인
		@RequestMapping(value="/checkPass", method=RequestMethod.POST)
		public String checkPass(@ModelAttribute Users users, Model model) throws Exception {				

		try {	Users searchPass =  usersService.login(users);
			boolean result = bcryptPasswordEncoder.matches(users.getPassword(), searchPass.getPassword());

			if(searchPass !=null && result == true) {
				model.addAttribute("searchPass", searchPass);
				System.out.println(searchPass);
			}
			
		}catch(Exception e){
			System.out.println("회원정보 불일치");
			model.addAttribute("result", "fail");
			}
		return "users/login/modifyPass";
		}
		
		//비밀번호수정
		@RequestMapping(value="/modifyPass" , method=RequestMethod.POST)
		public String pwUpdate(Users users,String id,String password)throws Exception{
			if(users.getId() != null)
			System.out.println("비밀번호 수정성공");
			String passBcrypt = bcryptPasswordEncoder.encode(users.getPassword());
			   users.setPassword(passBcrypt);
			usersService.updatePass(id, passBcrypt);
			session.invalidate();
			
			return "users/login/modifySuccess";
		}
	
		
		
		
		//카카오 로그인 토큰받기
		@RequestMapping(value="/kakaoLogin", method=RequestMethod.GET)
		public String kakaoLogin(@RequestParam(value = "code", required = false) String code) throws Exception {
			System.out.println("#########" + code);
			String access_Token = usersService.getAccessToken(code);
			Users authUser = usersService.getUserInfo(access_Token);
			
			System.out.println("###access_Token#### : " + access_Token);
			
			// 아래 코드가 추가되는 내용
			session.invalidate();
			// 위 코드는 session객체에 담긴 정보를 초기화 하는 코드.
			session.setAttribute("authUser", authUser);
			//session.setAttribute("kakaoN", userInfo);
			//session.setAttribute("kakaoE", userInfo.getK_email());
			// 위 2개의 코드는 닉네임과 이메일을 session객체에 담는 코드
			// jsp에서 ${sessionScope.kakaoN} 이런 형식으로 사용할 수 있다.
 
			return "redirect:/";
		}
		
	
	
	}
	

