package com.kosta.petner.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosta.petner.bean.Qna;
import com.kosta.petner.bean.QnaPage;

@Repository
public class QnaDAOImpl implements QnaDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public void qna_insert(Qna qna) {
		sqlSession.insert("mapper.qna.insert", qna);
	}

	@Override
	public List<Qna> qna_list() {
		return sqlSession.selectList("mapper.qna.list");
	}

	@Override
	public Qna qna_detail(int id) {
		return sqlSession.selectOne("mapper.qna.detail", id);
	}

	@Override
	public void qna_update(Qna qna) {
		sqlSession.update("mapper.qna.update", qna);
	}

	@Override
	public void qna_delete(int id) {
		sqlSession.delete("mapper.qna.delete", id);
	}

	@Override
	public void qna_read(int id) {
		sqlSession.update("mapper.qna.read", id);
	}

	@Override
	public QnaPage qna_list(QnaPage qnaPage) {
		qnaPage.setTotalList((Integer) sqlSession.selectOne("mapper.qna.totalList", qnaPage));
		qnaPage.setList(sqlSession.selectList("mapper.qna.list", qnaPage));

		return qnaPage;
	}

	@Override
	public void qna_reply_insert(Qna qna) {
		sqlSession.insert("mapper.qna.reply_insert", qna);
	}

	@Override
	public void delQna(ArrayList<String> noArr) {
		Map<String, Object> map = new HashMap<String, Object>();
	    for(int i = 0; i < noArr.size() ; i++) {
			ArrayList<String> value = noArr;
			map.put("noArr", value );
		}
	    System.out.println("======="+map+"=======");
		sqlSession.delete("mapper.qna.delQna", map);
	}

}