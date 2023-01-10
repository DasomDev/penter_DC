package com.kosta.petner.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosta.petner.bean.Users;
import com.kosta.petner.dao.NoticeDAO;
import com.kosta.petner.dao.QnaDAO;
import com.kosta.petner.dao.UsersDAO;

@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	UsersDAO usersDAO;
	
	@Autowired
	NoticeDAO noticeDAO;
	
	@Autowired
	QnaDAO qnaDAO;
	

	// 기본정보
	@Override
	public Users getAdminInfo(String id) {
		return usersDAO.getMyinfo(id);
	}
		
	@Override
	public Object getAdminAllInfo(int user_no) {
		return usersDAO.getMyAllInfo(user_no);
	}
	
//	@Override
//	public void resistNotice(Notice notice) throws Exception {
//		Integer noticeNum = noticeDAO.selectMaxNoticeNum();
//		if(noticeNum==null) noticeNum = 1;
//		else noticeNum = noticeNum+1; 
//		notice.setNotice_no(noticeNum);
//		notice.setNotice_re_ref(noticeNum);
//		notice.setNotice_re_lev(0);
//		notice.setNotice_re_seq(0);
//		notice.setNotice_hit(0);
//		noticeDAO.insertNotice(notice);
//	}
//	@Override
//	public List<Notice> getNoticeList(int page, PageInfo pageInfo) throws Exception {
//		int listCount = noticeDAO.selectNoticeCount();  // 전체 게시글 수
//		int maxPage = (int)Math.ceil((double)listCount/10);  //전체 페이지 수, 올림처리
//		int startPage = page/10 * 10 + 1; //현재 페이지에 보여줄 시작 페이지 버튼(1,11,21 등...) 
//		int endPage = startPage + 10 - 1; //현제 페이지에 보여줄 마지막 페이지 버튼(10,20,30 등...) 
//		if(endPage>maxPage) endPage = maxPage;
//		
//		pageInfo.setPage(page);
//		pageInfo.setListCount(listCount);
//		pageInfo.setMaxPage(maxPage);
//		pageInfo.setStartPage(startPage);
//		pageInfo.setEndPage(endPage);
//		
//		int row = (page-1)*10+1;		
//		return noticeDAO.selectNoticeList(row);
//	}
//	@Override
//	public Notice getNotice(Integer noticeNum) throws Exception {
//		return noticeDAO.selectNotice(noticeNum);
//	}
//	@Override
//	public void modifyNotice(Notice notice) throws Exception {
//		String password = noticeDAO.selectNotice(notice.getNotice_no()).getNotice_pass();
//		if(!password.equals(notice.getNotice_pass())) {
//			throw new Exception("수정 권한 없음");
//		}
//		noticeDAO.updateNotice(notice);
//	}
//	@Override
//	public void noticeReply(Notice notice) throws Exception {
//		Notice srcNotice = getNotice(notice.getNotice_no());  //원글정보
//		noticeDAO.updateNoticeReReq(srcNotice);
//		Integer noticeNum = noticeDAO.selectMaxNoticeNum()+1;
//		notice.setNotice_no(noticeNum);
//		notice.setNotice_re_ref(srcNotice.getNotice_re_ref());
//		notice.setNotice_re_lev(srcNotice.getNotice_re_lev()+1);
//		notice.setNotice_re_seq(srcNotice.getNotice_re_seq()+1);
//		noticeDAO.insertNotice(notice);
//	}
//	@Override
//	public void deleteNotice(Integer noticeNum) throws Exception {
//		Notice notice = getNotice(noticeNum);
//		System.out.println("Service:"+noticeNum);
//		System.out.println("Service:"+notice);
//		noticeDAO.deleteNotice(noticeNum);
//	}
	
	// 조회수 증가
//	@Override
//	public void notice_read(int notice_id) throws Exception {
//		noticeDAO.notice_read(notice_id);
//	}
	
//	@Override
//	public void deleteQna(Integer qnaNum) throws Exception {
//		Qna qna = getQna(qnaNum);
//		System.out.println("Service:"+qnaNum);
//		System.out.println("Service:"+qna);
//		qnaDAO.deleteQna(qnaNum);
//	}

//	private Qna getQna(Integer qnaNum) {
//		// TODO Auto-generated method stub
//		return null;
//	}
//
//	@Override
//	public void resistNotice(Notice notice) throws Exception {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public List<Notice> getNoticeList(int page, PageInfo pageInfo) throws Exception {
//		// TODO Auto-generated method stub
//		return null;
//	}
//
//	@Override
//	public Notice getNotice(Integer noticeNum) throws Exception {
//		// TODO Auto-generated method stub
//		return null;
//	}
//
//	@Override
//	public void modifyNotice(Notice notice) throws Exception {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public void noticeReply(Notice notice) throws Exception {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public void deleteNotice(Integer noticeNum) throws Exception {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public void deleteQna(Integer QnaNum) throws Exception {
//		// TODO Auto-generated method stub
//		
//	}
}
