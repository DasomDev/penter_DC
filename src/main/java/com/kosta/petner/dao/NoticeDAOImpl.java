package com.kosta.petner.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosta.petner.bean.Notice;
import com.kosta.petner.bean.NoticePage;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public void notice_insert(Notice notice) {
		sqlSession.insert("mapper.notice.insert", notice);
	}

	@Override
	public List<Notice> notice_list() {
		return sqlSession.selectList("mapper.notice.list");
	}

	@Override
	public Notice notice_detail(int id) {
		return sqlSession.selectOne("mapper.notice.detail",id);
	}

	@Override
	public void notice_update(Notice notice) {
		sqlSession.update("mapper.notice.update", notice);
	}

	@Override
	public void notice_delete(int id) {
		sqlSession.delete("mapper.notice.delete", id);
	}

	@Override
	public void notice_read(int id) {
		sqlSession.update("mapper.notice.read", id);
	}

	@Override
	public NoticePage notice_list(NoticePage noticePage) {
		noticePage.setTotalList((Integer) sqlSession.selectOne("mapper.notice.totalList", noticePage));
		noticePage.setList(sqlSession.selectList("mapper.notice.list", noticePage));
		
		return noticePage;
	}

	@Override
	public void notice_reply_insert(Notice notice) {
		sqlSession.insert("mapper.notice.reply_insert", notice);
	}

	@Override
	public void delNotice(ArrayList<String> noArr) {
		Map<String, Object> map = new HashMap<String, Object>();
	    for(int i = 0; i < noArr.size() ; i++) {
			ArrayList<String> value = noArr;
			map.put("noArr", value );
		}
	    System.out.println("======="+map+"=======");
		sqlSession.delete("mapper.notice.delNotice", map);
	}

}
