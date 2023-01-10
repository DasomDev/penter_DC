package com.kosta.petner.bean;

import java.util.List;

import org.springframework.stereotype.Component;



@Component
public class QnaPage extends PageVO {
	private List<Qna> list;

	public List<Qna> getList() {
		return list;
	}

	public void setList(List<Qna> list) {
		this.list = list;
	}
}