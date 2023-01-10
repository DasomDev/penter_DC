package com.kosta.petner.bean;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SitterInfo {
	private Integer user_no;
	private Integer file_no;
	private String pet_kind;
	private String pet_specie;
	private String work_day;
	private String service;
	private String zipcode;
	private String addr;
	private String addr_detail;
	private String sitter_info;
	
	private MultipartFile imageFile;
}
