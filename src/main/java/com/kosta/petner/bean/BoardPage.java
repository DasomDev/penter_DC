package com.kosta.petner.bean;

import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class BoardPage extends PageVO {
	private List<Board> list;
	
	public List<Board> getList() {
		return list;
	}
	
	public void setList(List<Board> list) {
		this.list = list;
	}

}

