package com.kosta.petner.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AdminSession {
	
	// 마이페이지에서 필요한 정보를 JOIN 한 값 객체
	private int user_no;
	private int user_type;
	private String id;
	private String nickname;
	private int user_auth;
	private int file_no;
	
	
	

}
	
	