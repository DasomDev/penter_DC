package com.kosta.petner.bean;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Follow {
	
	private int followNo;	//팔로우번호
	private int activeUser;	//팔로우 건 유저
	private int passiveUser;	//팔로우 당한 유저
	private Date regDate;	//팔로우 등록 날짜
	
	private String activeUserId;	//팔로우 건 유저 id
	private String passiveUserId;	//팔로우 당한 유저 id
	
	private String profileName;	//팔로우 리스트 확인할 유저의 아이디와 프사를 보이기 위한 필드

}
