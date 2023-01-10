package com.kosta.petner.bean;

import lombok.Data;

@Data
public class Member {
	int userNo;
	int userType;
	String id;
	String nickname;
	String email;
	String password;
	String name;
	String joindate;
	String gender;
	String address;
}
