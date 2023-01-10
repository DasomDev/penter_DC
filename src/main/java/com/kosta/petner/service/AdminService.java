package com.kosta.petner.service;

import com.kosta.petner.bean.Users;

public interface AdminService {
	// admin ALL INFO
		Object getAdminAllInfo(int user_no);
		// 나의 기본정보
		Users getAdminInfo(String id);	
		
//		void resistNotice(Notice notice) throws Exception;
//		List<Notice> getNoticeList(int page, PageInfo pageInfo) throws Exception;
//		Notice getNotice(Integer noticeNum) throws Exception;
//		void modifyNotice(Notice notice) throws Exception;
//		void noticeReply(Notice notice) throws Exception;
//		void deleteNotice(Integer noticeNum) throws Exception;
//		void deleteQna(Integer QnaNum) throws Exception;
//		void notice_read(int notice_id) throws Exception; // 조회수 증가
//		
		
}
