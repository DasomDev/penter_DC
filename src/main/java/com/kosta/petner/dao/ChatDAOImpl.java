package com.kosta.petner.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosta.petner.bean.ChatMessage;
import com.kosta.petner.bean.ChatRoom;


@Repository
public class ChatDAOImpl implements ChatDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public ChatRoom selectChatRoom(String room_id) {
		return sqlSession.selectOne("mapper.chat.selectChatRoom", room_id);
	}

	@Override
	public int insertMessage(ChatMessage chatMessage) {
        return sqlSession.insert("mapper.chat.insertMessage", chatMessage);
    }
    
	@Override
    public List<ChatMessage> messageList(String room_id) {
        return sqlSession.selectList("mapper.chat.messageList", room_id);
    }
 
	@Override
    public int createChat(ChatRoom room) {
        return sqlSession.insert("mapper.chat.createChat", room);
    }
 
	@Override
    public ChatRoom searchChatRoom(ChatRoom room) {
        return sqlSession.selectOne("mapper.chat.searchChatRoom", room);
    }
	
	@Override
    public List<ChatRoom> chatRoomList(String user_id) {
        return sqlSession.selectList("mapper.chat.chatRoomList", user_id);
    }
 
	@Override
    public int selectUnReadCount(ChatMessage message) {
        return sqlSession.selectOne("mapper.chat.selectUnReadCount",message);
    }
 
	@Override
    public int updateCount(ChatMessage message) {
        return sqlSession.update("mapper.chat.updateCount", message);
    }

	@Override
	public void deleteRoom(String room_id) {
		sqlSession.delete("mapper.chat.deleteRoom", room_id);
	}
	
	
	

}


	
	

	

