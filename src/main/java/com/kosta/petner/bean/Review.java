package com.kosta.petner.bean;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Review {
	

	private int reviewNo;			//리뷰글 번호
	private int reviewActiveUser;	//리뷰 쓴 유저
	private int reviewPassiveUser;	//리뷰 받은 유저
	private String title;			//제목
	private String content;			//내용
	private String rating;			//별점
	private Date reviewDate;		//리뷰 작성 날짜

	
	private String reviewActiveUserId;	//리뷰 쓴 유저 id
	private String reviewPassiveUserId;	//리뷰 받은 유저 id
	
	private String profileName;	//리뷰 리스트 확인할 유저의 아이디와 프사를 보이기 위한 필드


}
