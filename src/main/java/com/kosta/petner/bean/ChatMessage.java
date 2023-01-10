package com.kosta.petner.bean;



import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Component
public class ChatMessage {
	
	    
	    private String room_id;            // 방 번호
	    private String message_id;        // 메세지 번호
	    private String message;            // 메세지 내용
	    private String user_nickname;            // 보낸이 이름
	    private String user_id;            // 보낸이 이메일
	    private int unReadCount;        // 안 읽은 메세지 수
	    private int sessionCount;        // 현재 세션 수
	    
}



