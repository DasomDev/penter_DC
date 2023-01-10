package com.kosta.petner.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosta.petner.bean.Board;
import com.kosta.petner.bean.BoardCommentVO;
import com.kosta.petner.bean.BoardPage;
import com.kosta.petner.dao.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired BoardDAO boardDao;

	@Override
	public int board_insert(Board board) {
		return boardDao.board_insert(board);
	}

	@Override
	public BoardPage board_list(BoardPage boardPage) {
		return boardDao.board_list(boardPage);
	}

	@Override
	public Board board_detail(int id) {
		return boardDao.board_detail(id);
	}

	@Override
	public void board_read(int id) {
		boardDao.board_read(id);
	}

	@Override
	public int board_update(Board board) {
		return boardDao.board_update(board);
	}

	@Override
	public int board_delete(int id) {
		return boardDao.board_delete(id);
	}

	@Override
	public int board_comment_insert(BoardCommentVO boardVo) {
		return boardDao.board_comment_insert(boardVo);
	}

	@Override
	public List<BoardCommentVO> board_comment_list(int pid) {
		return boardDao.board_comment_list(pid);
	}

	@Override
	public int board_comment_update(BoardCommentVO boardVo) {
		return boardDao.board_comment_update(boardVo);
	}

	@Override
	public int board_comment_delete(int id) {
		return boardDao.board_comment_delete(id);
	}

	@Override
	public void delBoard(ArrayList<String> noArr) {
		boardDao.delBoard(noArr);
	}

}
