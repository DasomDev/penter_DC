package com.kosta.petner.controller;

import java.io.File;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kosta.petner.bean.Board;
import com.kosta.petner.bean.BoardCommentVO;
import com.kosta.petner.bean.BoardPage;
import com.kosta.petner.bean.Users;
import com.kosta.petner.service.BoardService;
import com.kosta.petner.service.CommonService;

@Controller
public class BoardController {
	@Autowired
	BoardService boardService;
	@Autowired
	BoardPage boardPage;
	@Autowired
	CommonService common;

	// 방명록 목록 화면 요청================================================================
	@RequestMapping("/list_board")
	public String list_board(HttpSession session, Model model, @RequestParam(defaultValue = "1") int curPage, String search,
			String keyword, @RequestParam(defaultValue = "10") int pageList,
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
			model.addAttribute("page", "board/list");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("err", e.getMessage());
			model.addAttribute("/notice/err");
		}

		return "/layout/main";
	} // list()

	// 방명록 신규 화면 요청================================================================
	@RequestMapping("/new_board")
	public String new_board(Model model) {
		// 방명록 글쓰기 화면으로 연결
		model.addAttribute("page", "board/new");
		return "/layout/main";
	} // board()

	// 신규 방명록 저장 처리
	// 요청================================================================
	@RequestMapping(value = "/insert_board", method = { RequestMethod.GET, RequestMethod.POST })
	public String insert_board(Board vo, MultipartFile file, HttpSession session) {
		// 화면에서 입력한 정보를 DB에 저장한 후 목록 화면으로 연결
		if (!file.isEmpty()) {
			vo.setFilename(file.getOriginalFilename());
			vo.setFilepath(common.upload("board", file, session));
		}
		vo.setWriter(((Users) session.getAttribute("authUser")).getId());
		boardService.board_insert(vo);
		return "redirect:list_board";
	} // insert()

	// 방명록 상세 화면
	// 요청====================================================================
	@RequestMapping("/detail_board")
	public String detail_board(int id, Model model) {
		try {
			// 선택한 방명록 글을 DB에서 조회해와 상세 화면에 출력
			boardService.board_read(id);
			model.addAttribute("vo", boardService.board_detail(id));
			model.addAttribute("crlf", "\r\n");
			model.addAttribute("board", boardPage);
			model.addAttribute("page", "board/detail");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("err", e.getMessage());
			model.addAttribute("/notice/err");
		}
		return "/layout/main";
	} // detail()

	// 방명록 상세 화면
	// 요청====================================================================
	@ResponseBody
	@RequestMapping("/download_board")
	public void download_board(int id, HttpSession session, HttpServletResponse response) {
		// 해당 글의 첨부 파일 정보를 조회해와 다운로드한다.
		Board vo = boardService.board_detail(id);
		common.download(vo.getFilename(), vo.getFilepath(), session, response);
	} // download()

	// 방명록 수정 화면
	// 요청====================================================================
	@RequestMapping("/modify_board")
	public String modify_board(int id, Model model) {
		// 선택한 방명록 글의 정보를 DB에서 조회해와 수정 화면에 출력
		model.addAttribute("vo", boardService.board_detail(id));
		model.addAttribute("page", "board/modify");
		return "/layout/main";
	} // modify()

	// 방명록 수정 화면
	// 요청====================================================================
	@RequestMapping("/update_board")
	public String update_board(Board vo, MultipartFile file, HttpSession session, String attach, Model model) {
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
//		model.addAttribute("url", "detail_board");
		model.addAttribute("url", "redirect:detail_board?id=\" + vo.getId()");
		model.addAttribute("id", vo.getId());
		return "redirect:/detail_board?id+ vo.getId()";
	} // update()

	// 방명록 수정 화면
	// 요청====================================================================
	@RequestMapping("/delete_board")
	public String delete_board(int id, Model model) {
		// 선택한 글을 DB에서 삭제한 후 목록 화면으로 연결
		boardService.board_delete(id);
		model.addAttribute("url", "list_board");
		model.addAttribute("id", id);
		model.addAttribute("board", boardPage);
		model.addAttribute("page", "board/redirect");
		return "/layout/main";
	} // delete()

	// 댓글 저장 처리
	// 요청====================================================================
	@ResponseBody
	@RequestMapping("/board/comment/insert")
	public boolean comment_insert(BoardCommentVO vo, HttpSession session) {
		// 화면에서 입력한 정보를 DB에 저장한다.
		vo.setWriter(((Users) session.getAttribute("authUser")).getId());
		return boardService.board_comment_insert(vo) > 0 ? true : false;
	} // comment_insert()

	// 댓글 목록 조회
	// 요청====================================================================
	@RequestMapping("/board/comment/{pid}")
	public String comment_list(@PathVariable int pid, Model model) {
		// DB에서 댓글 목록을 조회해와 댓글 목록 화면에 출력
		model.addAttribute("list", boardService.board_comment_list(pid));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("lf", "\n"); // lf의 형태로 라인피드가 저장될 수도 있어서 윗라인이 적용이 안될경우 이 코드도 작성한다.

		return "board/comment/list";
	} // comment_list()

	// 댓글 변경 저장 처리 요청
	@ResponseBody
	@RequestMapping(value = "/board/comment/update", produces = "application/text; charset=utf-8")
	public String comment_update(@RequestBody BoardCommentVO vo) {
		return boardService.board_comment_update(vo) > 0 ? "성공" : "실패";
	} // comment_update()

	// 댓글 삭제 처리 요청
	// ResponseBody : 화면(jsp)으로 연결이 아니라 호출한쪽으로 돌아갈때 사용하는 어노테이션
	@ResponseBody
	@RequestMapping("/board/comment/delete/{id}")
	public void comment_delete(@PathVariable int id) {
		boardService.board_comment_delete(id);
	} // comment_delete()
} // class