package com.kosta.petner.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Find {
	private String st_date;
	private String end_date;
	private String service;
	private String pet_kind;
	private String gender;
	private String day;
	private String zipcode;
	private String addr;
	

}
