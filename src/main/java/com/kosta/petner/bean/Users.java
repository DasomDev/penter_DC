package com.kosta.petner.bean;

import java.util.Date;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Component
public class Users {
	private int user_no;
	private int user_type;
	private String id;
	private String nickname;
	private String email;
	private String password;
	private String name;
	private String joindate;
	private String gender;
	private String zipcode;
	private String addr;
	private String addr_detail;
	private String user_level;
	private int user_auth;
	private int file_no;
	private boolean useCookie;
	private String sessionkey;
	private Date sessionlimit;
	private MultipartFile imageFile;

}
	
	