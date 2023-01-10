package com.kosta.petner.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosta.petner.bean.Qna;
import com.kosta.petner.bean.QnaPage;
import com.kosta.petner.dao.QnaDAO;

@Service
public class QnaServiceImpl implements QnaService {
	@Autowired
	QnaDAO qnaDAO;

	@Override
	public void qna_insert(Qna qna) {
		qnaDAO.qna_insert(qna);
	}

	@Override
	public List<Qna> qna_list() {
		return qnaDAO.qna_list();
	}

	@Override
	public Qna qna_detail(int id) {
		return qnaDAO.qna_detail(id);
	}

	@Override
	public void qna_update(Qna qna) {
		qnaDAO.qna_update(qna);
	}

	@Override
	public void qna_delete(int id) {
		qnaDAO.qna_delete(id);
	}

	@Override
	public void qna_read(int id) {
		qnaDAO.qna_read(id);
	}

	@Override
	public QnaPage qna_list(QnaPage qnaPage) {
		return qnaDAO.qna_list(qnaPage);
	}

	@Override
	public void qna_reply_insert(Qna qna) {
		qnaDAO.qna_reply_insert(qna);
	}

	@Override
	public void delQna(ArrayList<String> noArr) {
		qnaDAO.delQna(noArr);
	}

}
