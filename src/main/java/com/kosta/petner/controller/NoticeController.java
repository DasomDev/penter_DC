package com.kosta.petner.controller;

import java.io.File;
import java.net.MalformedURLException;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kosta.petner.bean.Notice;
import com.kosta.petner.bean.NoticePage;
import com.kosta.petner.bean.Users;
import com.kosta.petner.service.CommonService;
import com.kosta.petner.service.FileService;
import com.kosta.petner.service.NoticeService;
import com.kosta.petner.service.UsersService;

@Controller
public class NoticeController {
	@Autowired
	ServletContext servletContext;
	@Autowired
	FileService fileService;
	@Autowired
	NoticeService noticeService;
	@Autowired
	UsersService usersService;
	@Autowired
	CommonService common;
	@Autowired
	NoticePage noticePage;

	// 공지사항 목록화면 요청//////////////////////////////////////////////////////
	@RequestMapping("/list_notice")
	public String list(Model model, HttpSession session, @RequestParam(defaultValue = "1") int curPage, String search,
			String keyword) {
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
			model.addAttribute("page", "notice/list");

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("err", e.getMessage());
			model.addAttribute("/notice/err");
		}

		return "/layout/main";
	}

	// 신규 공지 글 작성 화면 요청//////////////////////////////////////////////////////
	@RequestMapping("/new_notice")
	public String notice(Model model) {
		model.addAttribute("page", "notice/new");
		return "/layout/main";
	}

//	//신규 공지 글 저장 처리 요청//////////////////////////////////////////////////////
	@RequestMapping("/insert_notice")
	public String insert(MultipartFile file, Notice vo, HttpSession session) {
		//첨부한 파일을 서버 시스템에 업로드하는 처리
		if( !file.isEmpty() ) {
			vo.setFilepath(common.upload("notice", file, session));
			vo.setFilename(file.getOriginalFilename());
		}
		
		vo.setWriter( ((Users) session.getAttribute("authUser")).getId() );
		//화면에서 입력한 정보를 DB에 저장한 후
		noticeService.notice_insert(vo);
		//목록 화면으로 연결
		return "redirect:list_notice";
	}
	
	// 저장된 이미지 보여주기
	public @RequestMapping(value = "/resources/notice/{notice_filepath}", method = RequestMethod.GET)
	UrlResource showImage(int id,MultipartFile file,@PathVariable String filepath,HttpServletResponse response) throws
	MalformedURLException {
		Notice vo = noticeService.notice_detail(id);
		
	 	return new UrlResource("file:" + vo.getFilepath());
	 	
	 }


	// 공지글 상세 화면 요청//////////////////////////////////////////////////////
	@RequestMapping("/detail_notice")
	public String detail(int id, Model model) {
		try {
			// 선택한 공지글에 대한 조회수 증가 처리
			noticeService.notice_read(id);

			// 선택한 공지글 정보를 DB에서 조회해와 상세 화면에 출력
			model.addAttribute("vo", noticeService.notice_detail(id));
			model.addAttribute("crlf", "\r\n");
			model.addAttribute("notice", noticePage);
			model.addAttribute("page", "notice/detail");

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("err", e.getMessage());
			model.addAttribute("/notice/err");
		}

		return "/layout/main";
	} // detail()

	// 첨부파일 다운로드 요청//////////////////////////////////////////////////////
	@ResponseBody
	@RequestMapping("/download_notice")
	public void download(int id, HttpSession session, HttpServletResponse response) {
		Notice vo = noticeService.notice_detail(id);
		common.download(vo.getFilename(), vo.getFilepath(), session, response);
	} // download()

	// 공지글 삭제 처리 요청//////////////////////////////////////////////////////
	@RequestMapping("/delete_notice")
	public String delete(int id, HttpSession session) {
		// 선택한 공지글에 첨부된 파일이 있다면 서버의 물리적 영역에서 해당 파일도 삭제한다
		Notice vo = noticeService.notice_detail(id);
		if (vo.getFilepath() != null) {
			File file = new File(session.getServletContext().getRealPath("resources") + vo.getFilepath());
			if (file.exists()) {
				file.delete();
			}
		}

		// 선택한 공지글을 DB에서 삭제한 후 목록 화면으로 연결
		noticeService.notice_delete(id);

		return "redirect:list_notice";
	} // delete()

	// 공지글 수정 화면 요청//////////////////////////////////////////////////////
	@RequestMapping("/modify_notice")
	public String modify(int id, Model model) {
		// 선택한 공지글 정보를 DB에서 조회해와 수정화면에 출력
		model.addAttribute("vo", noticeService.notice_detail(id));
		model.addAttribute("page", "notice/modify");
		return "/layout/main";
	} // modify()

	// 공지글 수정 처리 요청//////////////////////////////////////////////////////
	@RequestMapping("/update_notice")
	public String update(Notice vo, MultipartFile file, HttpSession session, String attach) {
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

		return "redirect:detail_notice?id=" + vo.getId();
	} // update()

	// 공지글 답글 쓰기 화면
	// 요청=============================================================================================
	@RequestMapping("/reply_notice")
	public String reply(Model model, int id) {
		// 원글의 정보를 답글 쓰기 화면에서 알 수 있도록 한다.
		model.addAttribute("vo", noticeService.notice_detail(id));
		model.addAttribute("page", "notice/reply");
		return "/layout/main";
	} // reply()

	// 공지글 신규 답글 저장 처리
	// 요청=============================================================================================
	@RequestMapping("/reply_insert_notice")
	public String reply_insert(Notice vo, HttpSession session, MultipartFile file) {
		if (!file.isEmpty()) {
			vo.setFilename(file.getOriginalFilename());
			vo.setFilepath(common.upload("notice", file, session));
		}
		vo.setWriter(((Users) session.getAttribute("authUser")).getId());

		// 화면에서 입력한 정보를 DB에 저장한 후 목록화면으로 연결
		noticeService.notice_reply_insert(vo);
		return "redirect:list_notice";
	} // reply_insert()
}
