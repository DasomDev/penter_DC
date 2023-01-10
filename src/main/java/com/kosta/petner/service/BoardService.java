package com.kosta.petner.service;

import java.util.ArrayList;
import java.util.List;

import com.kosta.petner.bean.Board;
import com.kosta.petner.bean.BoardCommentVO;
import com.kosta.petner.bean.BoardPage;

public interface BoardService {
	//CRUD
	int board_insert(Board vo);
	BoardPage board_list(BoardPage page);
	Board board_detail(int id);
	void board_read(int id);
	int board_update(Board vo);
	int board_delete(int id);
	
	// 댓글
	int board_comment_insert(BoardCommentVO vo);
	List<BoardCommentVO> board_comment_list(int pid);
	int board_comment_update(BoardCommentVO vo);
	int board_comment_delete(int id);
	
	//board 다중삭제
	void delBoard(ArrayList<String> noArr);
}