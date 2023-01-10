package com.kosta.petner.bean;

import java.sql.Date;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Component
public class Board {
	private int id, readcnt, no;
	private String title, content, writer, name, filename, filepath;
	private Date writedate;
	
	private MultipartFile imageFile;
}
