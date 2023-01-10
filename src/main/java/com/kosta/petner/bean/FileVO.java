package com.kosta.petner.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FileVO {
	 private Integer file_no;
	 private Integer user_no;
	 private Integer board_no;
	 private String origin_filename;
	 private String server_filename;
}
