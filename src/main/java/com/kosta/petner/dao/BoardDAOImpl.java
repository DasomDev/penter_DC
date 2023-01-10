package com.kosta.petner.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosta.petner.bean.Board;
import com.kosta.petner.bean.BoardCommentVO;
import com.kosta.petner.bean.BoardPage;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int board_insert(Board board) {
		return sqlSession.insert("mapper.board.insert", board);
	}

	@Override
	public BoardPage board_list(BoardPage boardPage) {
		boardPage.setTotalList((Integer) sqlSession.selectOne("mapper.board.total", boardPage));
		boardPage.setList(sqlSession.selectList("mapper.board.list", boardPage));
		return boardPage;
	}

	@Override
	public Board board_detail(int id) {
		return sqlSession.selectOne("mapper.board.detail", id);
	}

	@Override
	public void board_read(int id) {
		sqlSession.update("mapper.board.read", id);
	}

	@Override
	public int board_update(Board board) {
		return sqlSession.update("mapper.board.update", board);
	}

	@Override
	public int board_delete(int id) {
		return sqlSession.delete("mapper.board.delete", id);
	}

	@Override
	public int board_comment_insert(BoardCommentVO boardVo) {
		return sqlSession.insert("mapper.board.comment_insert", boardVo);
	}

	@Override
	public List<BoardCommentVO> board_comment_list(int pid) {
		return sqlSession.selectList("mapper.board.comment_list", pid);
	}

	@Override
	public int board_comment_update(BoardCommentVO boardVo) {
		return sqlSession.update("mapper.board.comment_update", boardVo);
	}

	@Override
	public int board_comment_delete(int id) {
		return sqlSession.delete("mapper.board.comment_delete", id);
	}

	@Override
	public void delBoard(ArrayList<String> noArr) {
		Map<String, Object> map = new HashMap<String, Object>();
	    for(int i = 0; i < noArr.size() ; i++) {
			ArrayList<String> value = noArr;
			map.put("noArr", value );
		}
	    System.out.println("======="+map+"=======");
		sqlSession.delete("mapper.board.delBoard", map);
	}
	
	
}
