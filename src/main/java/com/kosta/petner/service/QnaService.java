package com.kosta.petner.service;

import java.util.ArrayList;
import java.util.List;

import com.kosta.petner.bean.Qna;
import com.kosta.petner.bean.QnaPage;

public interface QnaService {
	//CRUD : Create, Read, Update, Delete
		void qna_insert(Qna qna);	//공지글 저장
		List<Qna> qna_list();	//공지글 목록 조회
		QnaPage qna_list(QnaPage qnaPage);	//페이지 처리 된 공지글 목록 조회
		Qna qna_detail(int id); //공지글 상세 조회
		void qna_update(Qna qna); //공지글 변경 저장
		void qna_delete(int id); //공지글 삭제
		void qna_read(int id); //조회수 증가 처리
		void qna_reply_insert(Qna qna); //답글 저장
		
		//qna 다중삭제
		void delQna(ArrayList<String> noArr);
}
