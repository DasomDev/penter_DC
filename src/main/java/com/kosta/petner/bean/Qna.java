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
public class Qna {
private int id, readcnt, no, root, step, indent;
	
	private Integer file_no;

	private String title, content, writer, filename, filepath, name;
	
	private Date writedate;
	
	private String server_filename;
	
	private MultipartFile imageFile;
	
}
