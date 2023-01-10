package com.kosta.petner.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosta.petner.bean.Notice;
import com.kosta.petner.bean.NoticePage;
import com.kosta.petner.dao.NoticeDAO;


@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	NoticeDAO noticeDao;
	
	@Override
	public void notice_insert(Notice notice) {
		noticeDao.notice_insert(notice);
	}

	@Override
	public List<Notice> notice_list() {
		return noticeDao.notice_list();
	}

	@Override
	public Notice notice_detail(int id) {
		return noticeDao.notice_detail(id);
	}

	@Override
	public void notice_update(Notice notice) {
		noticeDao.notice_update(notice);
	}

	@Override
	public void notice_delete(int id) {
		noticeDao.notice_delete(id);
	}

	@Override
	public void notice_read(int id) {
		noticeDao.notice_read(id);
	}

	@Override
	public NoticePage notice_list(NoticePage noticePage) {
		return noticeDao.notice_list(noticePage);
	}

	@Override
	public void notice_reply_insert(Notice notice) {
		noticeDao.notice_reply_insert(notice);
	}

	//공지사항 다중삭제 2022.12.21 김혜경
	@Override
	public void delNotice(ArrayList<String> noArr) {
		noticeDao.delNotice(noArr);
	}
}