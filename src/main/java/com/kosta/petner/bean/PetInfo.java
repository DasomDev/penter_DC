package com.kosta.petner.bean;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PetInfo {

	private Integer pet_no;
	private Integer user_no;
	private Integer file_no;
	private String pet_kind;
	private String pet_specie;
	private String pet_name;
	private Integer pet_age;
	private Integer pet_weight;
	private String pet_gender;
	private String pet_neutral;
	private String pet_info;
	
	private String server_filename;
	
	private MultipartFile imageFile;
	
}
