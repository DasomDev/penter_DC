package com.kosta.petner.dao;

import java.util.ArrayList;
import java.util.List;

import com.kosta.petner.bean.Qna;
import com.kosta.petner.bean.QnaPage;


public interface QnaDAO {

	void qna_insert(Qna qna);
	
	List<Qna> qna_list();

	Qna qna_detail(int id);

	void qna_update(Qna qna);

	void qna_delete(int id);

	void qna_read(int id);

	QnaPage qna_list(QnaPage qnaPage);

	void qna_reply_insert(Qna qna);
	
	//qna 다중삭제
	void delQna(ArrayList<String> noArr);
		
}
