package com.kosta.petner.bean;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Component
public class ChatRoom {

	    
	    private String room_id;        // 방 번호
	    
	    private String user_id;    // 사용자 아이디
	    private String user_nickname;    // 사용자 이름
	    private int user_pic;        // 사용자 사진
	    
	    private String another_id; // 상대방 아이디
	    private String another_nickname;    // 상대방 이름
	    private int another_pic;    // 상대방 사진
	    
	
	    private int unReadCount;    // 안 읽은 메세지 수
	    
	 
	}
