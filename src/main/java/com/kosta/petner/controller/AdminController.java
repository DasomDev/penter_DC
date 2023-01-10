package com.kosta.petner.controller;

import java.io.File;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kosta.petner.bean.Board;
import com.kosta.petner.bean.BoardCommentVO;
import com.kosta.petner.bean.BoardPage;
import com.kosta.petner.bean.Notice;
import com.kosta.petner.bean.NoticePage;
import com.kosta.petner.bean.Qna;
import com.kosta.petner.bean.QnaPage;
import com.kosta.petner.bean.Users;
import com.kosta.petner.dao.UsersDAO;
import com.kosta.petner.service.AdminService;
import com.kosta.petner.service.BoardService;
import com.kosta.petner.service.CommonService;
import com.kosta.petner.service.FileService;
import com.kosta.petner.service.MypageService;
import com.kosta.petner.service.NoticeService;
import com.kosta.petner.service.QnaService;
import com.kosta.petner.service.UsersService;

@Controller
public class AdminController {

	@Autowired
	QnaPage qnaPage;

	@Autowired
	NoticePage noticePage;

	@Autowired
	BoardPage boardPage;

	@Autowired
	CommonService common;

	@Autowired
	AdminService adminService;

	@Autowired
	QnaService qnaService;

	@Autowired
	NoticeService noticeService;

	@Autowired
	BoardService boardService;

	@Autowired
	UsersService usersService;

	@Autowired
	ServletContext servletContext;

	@Autowired
	MypageService mypageService;

	@Autowired
	UsersDAO usersDAO;

	@Autowired
	HttpSession session;

	@Autowired
	FileService fileService;

	// ******* 관리자 메인화면
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	String main(Model model, HttpSession session, @RequestParam(defaultValue = "1") int curPage, String search,
			String keyword) {

		noticePage.setCurPage(curPage);
		noticePage.setSearch(search);
		noticePage.setKeyword(keyword);
		model.addAttribute("notice", noticeService.notice_list(noticePage));

		boardPage.setCurPage(curPage);
		boardPage.setSearch(search);
		boardPage.setKeyword(keyword);
		model.addAttribute("board", boardService.board_list(boardPage));

		qnaPage.setCurPage(curPage);
		qnaPage.setSearch(search);
		qnaPage.setKeyword(keyword);
		model.addAttribute("qna", qnaService.qna_list(qnaPage));

		model.addAttribute("page", "admin/ad_main");
		model.addAttribute("title", "관리자 메인 페이지");
		return "/layout/admin_main";
	}

	// 관리자페이지 회원정보 관리 화면
	@RequestMapping(value = "/admin_user", method = RequestMethod.GET)
	String admin_user(HttpSession session, Model model) {

		try {

			List list = usersDAO.selectAllUsers();
			model.addAttribute("list", list);
			model.addAttribute("page", "admin/ad_user");
			model.addAttribute("title", "회원정보 관리");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("err", "전체 회원정보 조회 실패");
			model.addAttribute("page", "err");
		}
		return "/layout/admin_main";
	}

	// 관리자페이지 black 회원정보 관리 화면
	@RequestMapping(value = "/black_user", method = RequestMethod.GET)
	String black_user(HttpSession session, Model model) {

		try {

			List list = usersDAO.selectAllUsers();
			model.addAttribute("list", list);
			model.addAttribute("page", "admin/ad_user_black");
			model.addAttribute("title", "회원정보 관리");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("err", "전체 회원정보 조회 실패");
			model.addAttribute("page", "err");
		}
		return "/layout/admin_main";
	}

	// 관리자 유저 디테일 화면조회 이동
	@RequestMapping(value = "/ad_detailForm", method = RequestMethod.GET)
	public String ad_authorityForm(@RequestParam("user_no") Integer user_no, Model model) throws Exception {
		// user_no 로 회원의 상세 정보 전부 조회
		Users users = usersService.getUserByUserNo(user_no);
		model.addAttribute("users", users);
		model.addAttribute("page", "admin/ad_detail");
		return "/layout/admin_main";
	}

	// 관리자 유저 서비스 정보 화면 이동 (펫시터, 보호자일경우 펫등록정보등등 )
//		@RequestMapping(value = "/ad_ServiceForm", method = RequestMethod.GET)
//		public String ad_ServiceForm(@RequestParam("user_no") Integer user_no, Model model) throws Exception {
//			// user_no 로 회원의 상세 정보 전부 조회
//			Users users = usersService.getUserByUserNo(user_no);
//			model.addAttribute("users", users);
//			model.addAttribute("page", "admin/ad_detail");
//			return "/layout/admin_main";
//		}

	// 관리자 유저 타입 업데이트 요청
	@RequestMapping(value = "/ad_userupdate")
	public String ad_userupdate(Users users, Model model) {
		usersService.updateUserType(users);
//			model.addAttribute("users", users);
//			model.addAttribute("page", "admin/ad_detail");
		return "redirect:/admin_user";
		// return "redirect:ad_detailForm?user_no=" + users.getUser_no();
	}

	// 관리자 회원탈퇴
	@RequestMapping(value = "/ad_usersdelete", method = RequestMethod.POST)
	public ModelAndView ad_usersdelete(@RequestParam("user_no") Integer user_no) {
		System.out.println("Controller:" + user_no);
		ModelAndView mav = new ModelAndView();
		try {
			// 회원 탈퇴 시키기
			usersService.deleteUsers(user_no);
			mav.setViewName("redirect:/admin_user");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("/notice/err");
		}
		return mav;
	}

	/////////////////////// ******* notice *******///////////////////////

	// 공지사항 목록화면 요청
	@RequestMapping("/ad_list_notice")
	public String ad_list_notice(Model model, HttpSession session, @RequestParam(defaultValue = "1") int curPage,
			String search, String keyword) {
		try {
			// 공지사항 클릭 하면 admin으로 자동 로그인
			HashMap<String, String> map = new HashMap<String, String>();
			// HashMap : 데이터를 담을 자료 구조
			// map.put("id", "admin");
			// map.put("pw", "1234");
			// session.setAttribute("login_info", users.login(map));
			session.setAttribute("category", "no");
			// DB에서 공지 글 목록을 조회해와 목록 화면에 출력
			noticePage.setCurPage(curPage);
			noticePage.setSearch(search);
			noticePage.setKeyword(keyword);
			model.addAttribute("notice", noticeService.notice_list(noticePage));
			model.addAttribute("page", "admin/notice/list");

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("err", e.getMessage());
			model.addAttribute("/notice/err");
		}

		return "/layout/admin_main";
	}

	// 신규 공지 글 작성 화면 요청
	@RequestMapping("/ad_new_notice")
	public String ad_new_notice(Model model) {
		model.addAttribute("page", "admin/notice/new");
		return "/layout/admin_main";
	}

	// 신규 공지 글 저장 처리 요청
	@RequestMapping("/ad_insert_notice")
	public String ad_insert_notice(MultipartFile file, Notice vo, HttpSession session) {
		// 첨부한 파일을 서버 시스템에 업로드하는 처리
		if (!file.isEmpty()) {
			vo.setFilepath(common.upload("notice", file, session));
			vo.setFilename(file.getOriginalFilename());
		}

		vo.setWriter(((Users) session.getAttribute("authUser")).getId());
		// 화면에서 입력한 정보를 DB에 저장한 후
		noticeService.notice_insert(vo);
		// 목록 화면으로 연결
		return "redirect:ad_list_notice";
	}

	// 저장된 이미지 보여주기
	public @RequestMapping(value = "/admin/{ad_notice_filepath}", method = RequestMethod.GET) UrlResource ad_notice_showImage(
			int id, MultipartFile file, @PathVariable String filepath, HttpServletResponse response)
			throws MalformedURLException {
		Notice vo = noticeService.notice_detail(id);

		return new UrlResource("file:" + vo.getFilepath());

	}

	// 공지글 상세 화면 요청
	@RequestMapping("/ad_detail_notice")
	public String ad_detail_notice(int id, Model model) {
		try {
			// 선택한 공지글에 대한 조회수 증가 처리
			noticeService.notice_read(id);

			// 선택한 공지글 정보를 DB에서 조회해와 상세 화면에 출력
			model.addAttribute("vo", noticeService.notice_detail(id));
			model.addAttribute("crlf", "\r\n");
			model.addAttribute("notice", noticePage);
			model.addAttribute("page", "admin/notice/detail");

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("err", e.getMessage());
			model.addAttribute("/notice/err");
		}

		return "/layout/admin_main";
	} // detail()

	// 첨부파일 다운로드 요청
	@ResponseBody
	@RequestMapping("/ad_download_notice")
	public void ad_download_notice(int id, HttpSession session, HttpServletResponse response) {
		Notice vo = noticeService.notice_detail(id);
		common.download(vo.getFilename(), vo.getFilepath(), session, response);
	} // download()

	// 공지글 삭제 처리 요청
//	@RequestMapping("/ad_delete_notice")
//	public String ad_delete_notice(int id, HttpSession session) {
//		// 선택한 공지글에 첨부된 파일이 있다면 서버의 물리적 영역에서 해당 파일도 삭제한다
//		Notice vo = noticeService.notice_detail(id);
//		if (vo.getFilepath() != null) {
//			File file = new File(session.getServletContext().getRealPath("resources") + vo.getFilepath());
//			if (file.exists()) {
//				file.delete();
//			}
//		}
//		// 선택한 공지글을 DB에서 삭제한 후 목록 화면으로 연결
//		noticeService.notice_delete(id);
//		return "redirect:ad_list_notice";
//	} // delete()

	// 공지사항 다중삭제 2022.12.21 김혜경
	@ResponseBody
	@RequestMapping(value = "/delNotice", method = RequestMethod.POST)
	public void delNotice(@RequestParam(value = "noArr[]") ArrayList<String> noArr, Notice notice) {
		noticeService.delNotice(noArr);
		// 선택한 공지글에 첨부된 파일이 있다면 서버의 물리적 영역에서 해당 파일도 삭제한다
		if (notice.getFilepath() != null) {
			File file = new File(session.getServletContext().getRealPath("resources") + notice.getFilepath());
			if (file.exists()) {
				file.delete();
			}
		}
	}

	@ResponseBody
	@RequestMapping(value = "/delQna", method = RequestMethod.POST)
	public void delQna(@RequestParam(value = "noArr[]") ArrayList<String> noArr, Qna qna) {
		qnaService.delQna(noArr);
		if (qna.getFilepath() != null) {
			File file = new File(session.getServletContext().getRealPath("resources") + qna.getFilepath());
			if (file.exists()) {
				file.delete();
			}
		}
	}

	@ResponseBody
	@RequestMapping(value = "/delBoard", method = RequestMethod.POST)
	public void delBoard(@RequestParam(value = "noArr[]") ArrayList<String> noArr, Board board) {
		boardService.delBoard(noArr);
		if (board.getFilepath() != null) {
			File file = new File(session.getServletContext().getRealPath("resources") + board.getFilepath());
			if (file.exists()) {
				file.delete();
			}
		}
	}

	// 공지글 수정 화면 요청
	@RequestMapping("/ad_modify_notice")
	public String ad_modify_notice(int id, Model model) {
		// 선택한 공지글 정보를 DB에서 조회해와 수정화면에 출력
		model.addAttribute("vo", noticeService.notice_detail(id));
		model.addAttribute("page", "admin/notice/modify");
		return "/layout/admin_main";
	} // modify()

	// 공지글 수정 처리 요청
	@RequestMapping("/ad_update_notice")
	public String ad_update_notice(Notice vo, MultipartFile file, HttpSession session, String attach) {
		// 원래 공지글의 첨부 파일 관련 정보를 조회
		Notice notice = noticeService.notice_detail(vo.getId());
		String uuid = session.getServletContext().getRealPath("resources") + notice.getFilepath();

		// 파일을 첨부한 경우 - 없었는데 첨부 / 있던 파일을 바꿔서 첨부
		if (!file.isEmpty()) {
			vo.setFilename(file.getOriginalFilename());
			vo.setFilepath(common.upload("notice", file, session));

			// 원래 있던 첨부 파일은 서버에서 삭제
			if (notice.getFilename() != null) {
				File f = new File(uuid);
				if (f.exists()) {
					f.delete();
				}
			}

		} else {
			// 원래 있던 첨부 파일을 삭제됐거나 원래부터 첨부 파일이 없었던 경우
			if (attach.isEmpty()) {
				// 원래 있던 첨부 파일은 서버에서 삭제
				if (notice.getFilename() != null) {
					File f = new File(uuid);
					if (f.exists()) {
						f.delete();
					}
				}
				// 원래 있던 첨부 파일을 그대로 사용하는 경우
			} else {
				vo.setFilename(notice.getFilename());
				vo.setFilepath(notice.getFilepath());
			}
		}

		// 화면에서 변경한 정보를 DB에 저장한 후 상세 화면으로 연결
		noticeService.notice_update(vo);

		return "redirect:ad_detail_notice?id=" + vo.getId();
	} // update()

	// 공지글 답글 쓰기 화면
	// 요청
	@RequestMapping("/ad_reply_notice")
	public String ad_reply_notice(Model model, int id) {
		// 원글의 정보를 답글 쓰기 화면에서 알 수 있도록 한다.
		model.addAttribute("vo", noticeService.notice_detail(id));
		model.addAttribute("page", "admin/notice/reply");
		return "/layout/admin_main";
	} // reply()

	// 공지글 신규 답글 저장 처리
	// 요청
	@RequestMapping("/ad_reply_insert_notice")
	public String ad_reply_insert_notice(Notice vo, HttpSession session, MultipartFile file) {
		if (!file.isEmpty()) {
			vo.setFilename(file.getOriginalFilename());
			vo.setFilepath(common.upload("notice", file, session));
		}
		vo.setWriter(((Users) session.getAttribute("authUser")).getId());

		// 화면에서 입력한 정보를 DB에 저장한 후 목록화면으로 연결
		noticeService.notice_reply_insert(vo);
		return "redirect:ad_list_notice";
	} // reply_insert()

///////////////////////******* board *******///////////////////////

	// 방명록 목록 화면 요청
	@RequestMapping("/ad_list_board")
	public String ad_list_board(HttpSession session, Model model, @RequestParam(defaultValue = "1") int curPage,
			String search, String keyword, @RequestParam(defaultValue = "10") int pageList,
			@RequestParam(defaultValue = "list") String viewType) {
		try {
			// DB에서 방명록 정보를 조회해와 목록 화면에 출력
			session.setAttribute("category", "bo");
			boardPage.setCurPage(curPage);
			boardPage.setSearch(search);
			boardPage.setKeyword(keyword);
			boardPage.setPageList(pageList);
			boardPage.setViewType(viewType);
			model.addAttribute("board", boardService.board_list(boardPage));
			model.addAttribute("page", "admin/board/list");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("err", e.getMessage());
			model.addAttribute("/notice/err");
		}

		return "/layout/admin_main";
	} // list()

	// 방명록 신규 화면 요청
	@RequestMapping("/ad_new_board")
	public String ad_new_board(Model model) {
		// 방명록 글쓰기 화면으로 연결
		model.addAttribute("page", "admin/board/new");
		return "/layout/admin_main";
	} // board()

	// 신규 방명록 저장 처리
	// 요청
	@RequestMapping(value = "/ad_insert_board", method = { RequestMethod.GET, RequestMethod.POST })
	public String ad_insert_board(Board vo, MultipartFile file, HttpSession session) {
		// 화면에서 입력한 정보를 DB에 저장한 후 목록 화면으로 연결
		if (!file.isEmpty()) {
			vo.setFilename(file.getOriginalFilename());
			vo.setFilepath(common.upload("board", file, session));
		}
		vo.setWriter(((Users) session.getAttribute("authUser")).getId());
		boardService.board_insert(vo);
		return "redirect:ad_list_board";
	} // insert()

	// 방명록 상세 화면
	// 요청
	@RequestMapping("/ad_detail_board")
	public String ad_detail_board(int id, Model model) {
		try {
			// 선택한 방명록 글을 DB에서 조회해와 상세 화면에 출력
			boardService.board_read(id);
			model.addAttribute("vo", boardService.board_detail(id));
			model.addAttribute("crlf", "\r\n");
			model.addAttribute("board", boardPage);
			model.addAttribute("page", "admin/board/detail");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("err", e.getMessage());
			model.addAttribute("/notice/err");
		}
		return "/layout/admin_main";
	} // detail()

	// 방명록 상세 화면
	// 요청
	@ResponseBody
	@RequestMapping("/ad_download_board")
	public void ad_download_board(int id, HttpSession session, HttpServletResponse response) {
		// 해당 글의 첨부 파일 정보를 조회해와 다운로드한다.
		Board vo = boardService.board_detail(id);
		common.download(vo.getFilename(), vo.getFilepath(), session, response);
	} // download()

	// 방명록 수정 화면
	// 요청
	@RequestMapping("/ad_modify_board")
	public String ad_modify_board(int id, Model model) {
		// 선택한 방명록 글의 정보를 DB에서 조회해와 수정 화면에 출력
		model.addAttribute("vo", boardService.board_detail(id));
		model.addAttribute("page", "admin/board/modify");
		return "/layout/admin_main";
	} // modify()

	// 방명록 수정 화면
	// 요청
	@RequestMapping("/ad_update_board")
	public String ad_update_board(Board vo, MultipartFile file, HttpSession session, String attach, Model model) {
		// 화면에서 입력한 정보를 DB에 변경, 저장한 후 상세 화면으로 연결
		Board board = boardService.board_detail(vo.getId());
		String uuid = session.getServletContext().getRealPath("resources") + board.getFilepath();

		// 파일을 첨부한 경우 - 없었는데 새로 첨부, 있었는데 바꿔 첨부
		if (!file.isEmpty()) {
			vo.setFilename(file.getOriginalFilename());
			vo.setFilepath(common.upload("board", file, session));

			if (board.getFilename() != null) {
				File f = new File(uuid);
				if ((f.exists())) {
					f.delete();
				}
			}
		} else {
			// 파일 첨부가 없는 경우 - if 없었고, else 있었는데 그대로 사용하는 경우
			if (attach.isEmpty()) {
				File f = new File(uuid);
				if ((f.exists())) {
					f.delete();
				}
			} else {
				vo.setFilename(board.getFilename());
				vo.setFilepath(board.getFilepath());
			}
		}
		boardService.board_update(vo);

		// 기존 방법
		// return "redirect:detail.bo?id=" + vo.getId();

		// 다른 방법
//			model.addAttribute("url", "detail_board");
		model.addAttribute("url", "redirect:ad_detail_board?id=\" + vo.getId()");
		model.addAttribute("id", vo.getId());
		return "redirect:/ad_detail_board?id+ vo.getId()";
	} // update()

	// 방명록 수정 화면
	// 요청
	@RequestMapping("/ad_delete_board")
	public String ad_delete_board(int id, Model model) {
		// 선택한 글을 DB에서 삭제한 후 목록 화면으로 연결
		boardService.board_delete(id);
		model.addAttribute("url", "list_board");
		model.addAttribute("id", id);
		model.addAttribute("board", boardPage);
		model.addAttribute("page", "admin/board/redirect");
		return "/layout/admin_main";
	} // delete()

	// 댓글 저장 처리
	// 요청
	@ResponseBody
	@RequestMapping("/ad_board/comment/insert")
	public boolean ad_comment_insert(BoardCommentVO vo, HttpSession session) {
		// 화면에서 입력한 정보를 DB에 저장한다.
		vo.setWriter(((Users) session.getAttribute("authUser")).getId());
		return boardService.board_comment_insert(vo) > 0 ? true : false;
	} // comment_insert()

	// 댓글 목록 조회
	// 요청
	@RequestMapping("/ad_board/comment/{pid}")
	public String ad_comment_list(@PathVariable int pid, Model model) {
		// DB에서 댓글 목록을 조회해와 댓글 목록 화면에 출력
		model.addAttribute("list", boardService.board_comment_list(pid));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("lf", "\n"); // lf의 형태로 라인피드가 저장될 수도 있어서 윗라인이 적용이 안될경우 이 코드도 작성한다.

		return "board/comment/list";
	} // comment_list()

	// 댓글 변경 저장 처리 요청
	@ResponseBody
	@RequestMapping(value = "/ad_board/comment/update", produces = "application/text; charset=utf-8")
	public String ad_comment_update(@RequestBody BoardCommentVO vo) {
		return boardService.board_comment_update(vo) > 0 ? "성공" : "실패";
	} // comment_update()

	// 댓글 삭제 처리 요청
	// ResponseBody : 화면(jsp)으로 연결이 아니라 호출한쪽으로 돌아갈때 사용하는 어노테이션
	@ResponseBody
	@RequestMapping("/ad_board/comment/delete/{id}")
	public void ad_comment_delete(@PathVariable int id) {
		boardService.board_comment_delete(id);
	} // comment_delete()

///////////////////////******* qna *******///////////////////////

	// qna 목록화면 요청
	@RequestMapping("/ad_list_qna")
	public String list(Model model, HttpSession session, @RequestParam(defaultValue = "1") int curPage, String search,
			String keyword) {
		try {
			HashMap<String, String> map = new HashMap<String, String>();
			session.setAttribute("category", "no");
			// DB에서 공지 글 목록을 조회해와 목록 화면에 출력
			qnaPage.setCurPage(curPage);
			qnaPage.setSearch(search);
			qnaPage.setKeyword(keyword);
			model.addAttribute("qna", qnaService.qna_list(qnaPage));
			model.addAttribute("page", "admin/qna/list");

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("err", e.getMessage());
			model.addAttribute("/notice/err");
		}
		return "/layout/admin_main";
	}

	// 신규 qna 글 작성 화면 요청
	@RequestMapping("/ad_new_qna")
	public String ad_new_qna(Model model) {
		model.addAttribute("page", "admin/qna/new");
		return "/layout/admin_main";
	}

	// 신규 qna 글 저장 처리 요청
	@RequestMapping("/ad_insert_qna")
	public String insert(MultipartFile file, Qna vo, HttpSession session) {
		// 첨부한 파일을 서버 시스템에 업로드하는 처리
		if (!file.isEmpty()) {
			vo.setFilepath(common.upload("qna", file, session));
			vo.setFilename(file.getOriginalFilename());
		}

		vo.setWriter(((Users) session.getAttribute("authUser")).getId());
		// 화면에서 입력한 정보를 DB에 저장한 후
		qnaService.qna_insert(vo);
		// 목록 화면으로 연결
		return "redirect:ad_list_qna";
	}

	// 저장된 이미지 보여주기
	public @RequestMapping(value = "/resources/qna/{ad_qna_filepath}", method = RequestMethod.GET) UrlResource ad_qna_showImage(
			int id, MultipartFile file, @PathVariable String filepath, HttpServletResponse response)
			throws MalformedURLException {
		Qna vo = qnaService.qna_detail(id);
		return new UrlResource("file:" + vo.getFilepath());

	}

	// qna 상세 화면 요청
	@RequestMapping("/ad_detail_qna")
	public String ad_detail_qna(int id, Model model) {
		try {
			// 선택한 공지글에 대한 조회수 증가 처리
			qnaService.qna_read(id);

			// 선택한 공지글 정보를 DB에서 조회해와 상세 화면에 출력
			model.addAttribute("vo", qnaService.qna_detail(id));
			model.addAttribute("crlf", "\r\n");
			model.addAttribute("qna", qnaPage);
			model.addAttribute("page", "admin/qna/detail");

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("err", e.getMessage());
			model.addAttribute("/notice/err");
		}
		return "/layout/admin_main";
	} // detail()

	// 첨부파일 다운로드 요청
	@ResponseBody
	@RequestMapping("/ad_download_qna")
	public void ad_download_qna(int id, HttpSession session, HttpServletResponse response) {
		Qna vo = qnaService.qna_detail(id);
		common.download(vo.getFilename(), vo.getFilepath(), session, response);
	} // download()

	// qna 삭제 처리 요청
	@RequestMapping("/ad_delete_qna")
	public String delete(int id, HttpSession session) {
		// 선택한 공지글에 첨부된 파일이 있다면 서버의 물리적 영역에서 해당 파일도 삭제한다
		Qna vo = qnaService.qna_detail(id);
		if (vo.getFilepath() != null) {
			File file = new File(session.getServletContext().getRealPath("resources") + vo.getFilepath());
			if (file.exists()) {
				file.delete();
			}
		}
		qnaService.qna_delete(id);

		return "redirect:ad_list_qna";
	} // delete()

	// qna 수정 화면 요청
	@RequestMapping("/ad_modify_qna")
	public String ad_modify_qna(int id, Model model) {
		// 선택한 공지글 정보를 DB에서 조회해와 수정화면에 출력
		model.addAttribute("vo", qnaService.qna_detail(id));
		model.addAttribute("page", "admin/qna/modify");
		return "/layout/admin_main";
	} // modify()

	// 공지글 수정 처리 요청
	@RequestMapping("/ad_update_qna")
	public String ad_update_qna(Qna vo, MultipartFile file, HttpSession session, String attach) {
		// 원래 공지글의 첨부 파일 관련 정보를 조회
		Qna qna = qnaService.qna_detail(vo.getId());
		String uuid = session.getServletContext().getRealPath("resources") + qna.getFilepath();

		// 파일을 첨부한 경우 - 없었는데 첨부 / 있던 파일을 바꿔서 첨부
		if (!file.isEmpty()) {
			vo.setFilename(file.getOriginalFilename());
			vo.setFilepath(common.upload("qna", file, session));

			// 원래 있던 첨부 파일은 서버에서 삭제
			if (qna.getFilename() != null) {
				File f = new File(uuid);
				if (f.exists()) {
					f.delete();
				}
			}

		} else {
			// 원래 있던 첨부 파일을 삭제됐거나 원래부터 첨부 파일이 없었던 경우
			if (attach.isEmpty()) {
				// 원래 있던 첨부 파일은 서버에서 삭제
				if (qna.getFilename() != null) {
					File f = new File(uuid);
					if (f.exists()) {
						f.delete();
					}
				}

				// 원래 있던 첨부 파일을 그대로 사용하는 경우
			} else {
				vo.setFilename(qna.getFilename());
				vo.setFilepath(qna.getFilepath());
			}

		}

		// 화면에서 변경한 정보를 DB에 저장한 후 상세 화면으로 연결
		qnaService.qna_update(vo);

		return "redirect:ad_detail_qna?id=" + vo.getId();
	} // update()

	// 공지글 답글 쓰기 화면
	// 요청
	@RequestMapping("/ad_reply_qna")
	public String ad_reply_qna(Model model, int id) {
		// 원글의 정보를 답글 쓰기 화면에서 알 수 있도록 한다.
		model.addAttribute("vo", qnaService.qna_detail(id));
		model.addAttribute("page", "admin/qna/reply");
		return "/layout/admin_main";
	} // reply()

	// 공지글 신규 답글 저장 처리
	// 요청
	@RequestMapping("/ad_reply_insert_qna")
	public String ad_reply_insert_qna(Qna vo, HttpSession session, MultipartFile file) {
		if (!file.isEmpty()) {
			vo.setFilename(file.getOriginalFilename());
			vo.setFilepath(common.upload("qna", file, session));
		}
		vo.setWriter(((Users) session.getAttribute("authUser")).getId());

		// 화면에서 입력한 정보를 DB에 저장한 후 목록화면으로 연결
		qnaService.qna_reply_insert(vo);
		return "redirect:ad_list_qna";
	} // reply_insert()

//	// 관리자 notice 공지사항 삭제
//	@RequestMapping(value = "/ad_noticedelete", method = RequestMethod.POST)
//	public ModelAndView ad_noticedelete(@RequestParam("notice_no") Integer noticeNum,
////				@RequestParam(value="board_pass") String password,
//			@RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
//		System.out.println("Controller:" + noticeNum);
//		ModelAndView mav = new ModelAndView();
//		try {
////				boardService.deleteBoard(boardNum, password);
//			adminService.deleteNotice(noticeNum);
//			mav.addObject("page", page);
//			mav.setViewName("redirect:/ad_noticeList");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mav.addObject("err", e.getMessage());
//			mav.setViewName("/notice/err");
//		}
//		return mav;
//	}

	/////////////////////// qna ///////////////////////

//	// qna_글쓰기 화면 이동
//	@RequestMapping(value = "/ad_qnawriteform", method = RequestMethod.GET)
//	public String qnawriteform(Model model) {
//
//		model.addAttribute("page", ".admin/qna/writeform");
//		model.addAttribute("title", "글쓰기");
//		return "/layout/admin_main";
//	}

//
//	// 관리자 qna 삭제
//	@RequestMapping(value = "/ad_qnadelete", method = RequestMethod.POST)
//	public ModelAndView ad_qnadelete(@RequestParam("qna_no") Integer qnaNum,
//			@RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
//		System.out.println("Controller:" + qnaNum);
//		ModelAndView mav = new ModelAndView();
//		try {
//			adminService.deleteQna(qnaNum);
//			mav.addObject("page", page);
//			mav.setViewName("redirect:/ad_qnaList");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mav.addObject("err", e.getMessage());
//			mav.setViewName("/notice/err");
//		}
//		return mav;
//	}
//
//	/////////////////////// qna.end

}
