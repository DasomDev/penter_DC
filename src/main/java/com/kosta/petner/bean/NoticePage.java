package com.kosta.petner.bean;

import java.util.List;

import org.springframework.stereotype.Component;


@Component
public class NoticePage extends PageVO {
	private List<Notice> list;

	public List<Notice> getList() {
		return list;
	}

	public void setList(List<Notice> list) {
		this.list = list;
	}
	
	
}
