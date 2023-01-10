package com.kosta.petner.service;

import java.util.ArrayList;
import java.util.List;

import com.kosta.petner.bean.Notice;
import com.kosta.petner.bean.NoticePage;


public interface NoticeService {
	//CRUD : Create, Read, Update, Delete
	void notice_insert(Notice notice);	//공지글 저장
	List<Notice> notice_list();	//공지글 목록 조회
	NoticePage notice_list(NoticePage noticePage);	//페이지 처리 된 공지글 목록 조회
	Notice notice_detail(int id); //공지글 상세 조회
	void notice_update(Notice notice); //공지글 변경 저장
	void notice_delete(int id); //공지글 삭제
	void notice_read(int id); //조회수 증가 처리
	void notice_reply_insert(Notice notice); //답글 저장
	//공지사항 다중삭제 2022.12.21 김혜경
	void delNotice(ArrayList<String> noArr);
}