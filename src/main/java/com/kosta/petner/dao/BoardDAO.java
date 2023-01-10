package com.kosta.petner.dao;

import java.util.ArrayList;
import java.util.List;

import com.kosta.petner.bean.Board;
import com.kosta.petner.bean.BoardCommentVO;
import com.kosta.petner.bean.BoardPage;

public interface BoardDAO {

	int board_insert(Board board);

	BoardPage board_list(BoardPage boardPage);

	Board board_detail(int id);

	void board_read(int id);

	int board_update(Board board);

	int board_delete(int id);

	int board_comment_insert(BoardCommentVO boardVo);

	List<BoardCommentVO> board_comment_list(int pid);

	int board_comment_update(BoardCommentVO boardVo);

	int board_comment_delete(int id);
	
	//board 다중삭제
	void delBoard(ArrayList<String> noArr);
}