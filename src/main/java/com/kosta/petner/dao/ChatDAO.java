package com.kosta.petner.dao;


import java.util.List;

import com.kosta.petner.bean.ChatMessage;
import com.kosta.petner.bean.ChatRoom;


public interface ChatDAO {
	
	 //방번호로 채팅방보기
	  public ChatRoom selectChatRoom(String room_id);
	  
	  //메세지 저장
	  public int insertMessage(ChatMessage chatMessage);
	   
	  //메세지내용 출력
	  public List<ChatMessage> messageList(String room_id);
	 
	  //채팅 방 DB저장
	  public int createChat(ChatRoom room);
	 
	  //채팅방 찾기
	  public ChatRoom searchChatRoom(ChatRoom room);
	 
	  //채팅방 리스트 출력
	  public List<ChatRoom> chatRoomList(String user_id);
	    
	 //읽은 메세지 1으로바꾸기 
	  public int selectUnReadCount(ChatMessage message);
	 
	  //읽은 메세지 0으로 바꾸기
	  public int updateCount(ChatMessage message);
	  
	  public void deleteRoom(String room_id);
	 
	}

