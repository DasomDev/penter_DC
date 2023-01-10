package com.kosta.petner.service;

import java.util.ArrayList;
import java.util.List;

import com.kosta.petner.bean.ChatMessage;
import com.kosta.petner.bean.ChatRoom;
import com.kosta.petner.bean.Users;


public interface ChatService {
	

	 /**
     * 방 번호를 선택하는 메소드
     * @param room_id
     * @return
     */
    ChatRoom selectChatRoom(String room_id);
 
    /**
     * 채팅 메세지 DB 저장
     * @param chatMessage
     * @return 
     */
    int insertMessage(ChatMessage chatMessage);
 
    /**
     * 메세지 내용 리스트 출력
     * @param room_id
     * @return
     */
    List<ChatMessage> messageList(String room_id);
 
    /**
     * 채팅 방 DB 저장
     * @param room
     * @return
     */
    int createChat(ChatRoom room);
 
    /**
     * DB에 채팅 방이 있는지 확인
     * @param room
     * @return
     */
    ChatRoom searchChatRoom(ChatRoom room);
 
    /**
     * 채팅 방 리스트 출력
     * @param user_id
     * @return
     */
    List<ChatRoom> chatRoomList(String user_id);
 
    /**
     * 채팅 읽지 않은 메세지 수 출력
     * @param message
     * @return
     */
    int selectUnReadCount(ChatMessage message);
 
    /**
     * 읽은 메세지 숫자 0으로 바꾸기
     * @param message
     * @return
     */
    int updateCount(ChatMessage message);
    
    //방, 메세지삭제
    void deleteRoom(String room_id);
 
}
