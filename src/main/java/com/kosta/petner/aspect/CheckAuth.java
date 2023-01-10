package com.kosta.petner.aspect;


import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.kosta.petner.bean.MypageSession;
import com.kosta.petner.bean.Users;
import com.kosta.petner.service.MypageService;


@Aspect
@Component
public class CheckAuth {

	// 로그인이 되었다면 세션에서 ID 값으로 각각의 컨트롤러에서 공통적으로 필요한 정보를 묶어서 담아보내준다
	// 마이페이지의 경우
	
	@Autowired
	MypageService mypageService;
	
	@Around(  "execution(* com.kosta.petner.controller.MyPageController.*(..)) || "
			+ "execution(* com.kosta.petner.controller.OwnerController.*(..)) ")
	// ("execution(public * com.pamyferret.test.controller.*.*(..)")
	public Object execute(ProceedingJoinPoint joinPoint) throws Throwable {
		System.out.println("====CheckAuth 시작====");
		
		HttpSession session = ((ServletRequestAttributes)(RequestContextHolder.currentRequestAttributes())).getRequest().getSession();
		
		Users sessionVO = (Users) session.getAttribute("authUser");
		//System.out.println("세션정보=>"+sessionVO);
		
		if(sessionVO != null) {
			//마이페이지에서 필요한 정보 만들거야
			/* 닉네임, 팔로잉수, 나의 프로필 이미지 
			 * 유저타입 , 팔로워수, 유저레벨등
			 * 여러 테이블을 조인한 정보 필요함
			 * bean => MypageSession.java에 필드값 추가
			 * xml => users.xml에 getMyAllInfo 수정
			 */
			int user_no = sessionVO.getUser_no();
			MypageSession mypageSessionInfo = (MypageSession) mypageService.getMyAllInfo(user_no);
			
			session.setAttribute("mypageSession", mypageSessionInfo);
			System.out.println("mypageSession: "+session.getAttribute("mypageSession"));
			
		}else {
			System.out.print("로그인필요함");
			return "redirect:/gologin";
		}

		return joinPoint.proceed();

	}
	
	
}
