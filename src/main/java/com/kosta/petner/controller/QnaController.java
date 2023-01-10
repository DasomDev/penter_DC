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

import com.kosta.petner.bean.Qna;
import com.kosta.petner.bean.QnaPage;
import com.kosta.petner.bean.Users;
import com.kosta.petner.service.CommonService;
import com.kosta.petner.service.FileService;
import com.kosta.petner.service.MypageService;
import com.kosta.petner.service.QnaService;

@Controller
public class QnaController {

	@Autowired
	CommonService common;

	@Autowired
	FileService fileService;

	@Autowired
	MypageService mypageService;

	@Autowired
	QnaService qnaService;
	
	@Autowired
	QnaPage qnaPage;

	@Autowired
	ServletContext servletContext;

	// qna 목록화면 요청//////////////////////////////////////////////////////
		@RequestMapping("/list_qna")
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
				model.addAttribute("page", "qna/list");

			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("err", e.getMessage());
				model.addAttribute("/notice/err");
			}
			return "/layout/main";
		}

		// 신규 qna 글 작성 화면 요청//////////////////////////////////////////////////////
		@RequestMapping("/new_qna")
		public String qna(Model model) {
			model.addAttribute("page", "qna/new");
			return "/layout/main";
		}

		//신규 qna 글 저장 처리 요청//////////////////////////////////////////////////////
		@RequestMapping("/insert_qna")
		public String insert(MultipartFile file, Qna vo, HttpSession session) {
			//첨부한 파일을 서버 시스템에 업로드하는 처리
			if( !file.isEmpty() ) {
				vo.setFilepath(common.upload("qna", file, session));
				vo.setFilename(file.getOriginalFilename());
			}
			
			vo.setWriter( ((Users) session.getAttribute("authUser")).getId() );
			//화면에서 입력한 정보를 DB에 저장한 후
			qnaService.qna_insert(vo);
			//목록 화면으로 연결
			return "redirect:list_qna";
		}
		
		// 저장된 이미지 보여주기
		public @RequestMapping(value = "/resources/qna/{qna_filepath}", method = RequestMethod.GET)
		UrlResource showImage(int id,MultipartFile file,@PathVariable String filepath,HttpServletResponse response) throws
		MalformedURLException {
			Qna vo = qnaService.qna_detail(id);
		 	return new UrlResource("file:" + vo.getFilepath());
		 	
		 }

		// qna 상세 화면 요청//////////////////////////////////////////////////////
		@RequestMapping("/detail_qna")
		public String detail(int id, Model model) {
			try {
				// 선택한 공지글에 대한 조회수 증가 처리
				qnaService.qna_read(id);

				// 선택한 공지글 정보를 DB에서 조회해와 상세 화면에 출력
				model.addAttribute("vo", qnaService.qna_detail(id));
				model.addAttribute("crlf", "\r\n");
				model.addAttribute("qna", qnaPage);
				model.addAttribute("page", "qna/detail");

			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("err", e.getMessage());
				model.addAttribute("/notice/err");
			}
			return "/layout/main";
		} // detail()

		// 첨부파일 다운로드 요청//////////////////////////////////////////////////////
		@ResponseBody
		@RequestMapping("/download_qna")
		public void download(int id, HttpSession session, HttpServletResponse response) {
			Qna vo = qnaService.qna_detail(id);
			common.download(vo.getFilename(), vo.getFilepath(), session, response);
		} // download()

		// qna 삭제 처리 요청//////////////////////////////////////////////////////
		@RequestMapping("/delete_qna")
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

			return "redirect:list_qna";
		} // delete()

		// qna 수정 화면 요청//////////////////////////////////////////////////////
		@RequestMapping("/modify_qna")
		public String modify(int id, Model model) {
			// 선택한 공지글 정보를 DB에서 조회해와 수정화면에 출력
			model.addAttribute("vo", qnaService.qna_detail(id));
			model.addAttribute("page", "qna/modify");
			return "/layout/main";
		} // modify()

		// 공지글 수정 처리 요청//////////////////////////////////////////////////////
		@RequestMapping("/update_qna")
		public String update(Qna vo, MultipartFile file, HttpSession session, String attach) {
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

			return "redirect:detail_qna?id=" + vo.getId();
		} // update()

		// 공지글 답글 쓰기 화면
		// 요청=============================================================================================
		@RequestMapping("/reply_qna")
		public String reply(Model model, int id) {
			// 원글의 정보를 답글 쓰기 화면에서 알 수 있도록 한다.
			model.addAttribute("vo", qnaService.qna_detail(id));
			model.addAttribute("page", "qna/reply");
			return "/layout/main";
		} // reply()

		// 공지글 신규 답글 저장 처리
		// 요청=============================================================================================
		@RequestMapping("/reply_insert_qna")
		public String reply_insert(Qna vo, HttpSession session, MultipartFile file) {
			if (!file.isEmpty()) {
				vo.setFilename(file.getOriginalFilename());
				vo.setFilepath(common.upload("qna", file, session));
			}
			vo.setWriter(((Users) session.getAttribute("authUser")).getId());

			// 화면에서 입력한 정보를 DB에 저장한 후 목록화면으로 연결
			qnaService.qna_reply_insert(vo);
			return "redirect:list_qna";
		} // reply_insert()
}
