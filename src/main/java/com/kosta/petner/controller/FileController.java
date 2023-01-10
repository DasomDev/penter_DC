package com.kosta.petner.controller;

import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kosta.petner.service.MypageService;

@Controller
public class FileController {
	
	@Autowired
	ServletContext servletContext;
	
	@Autowired
	MypageService mypageService;
	
	// 마이페이지에 필요한 사진가져오기
	@RequestMapping(value = "/getImg/{fileNo}", method = RequestMethod.GET)
	public void viewImages(@PathVariable String fileNo, HttpServletResponse response) {
		String path = servletContext.getRealPath("/resources/upload/");
		FileInputStream fis = null;
		try {
			Integer file_no = Integer.parseInt(fileNo);
			String server_filename = mypageService.getFile(file_no);
			fis = new FileInputStream(path + server_filename);
			OutputStream out = response.getOutputStream();
			FileCopyUtils.copy(fis, out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(fis != null) {
				try {
					fis.close();
				} catch (Exception e) {} 
			}
		}
	}
}
