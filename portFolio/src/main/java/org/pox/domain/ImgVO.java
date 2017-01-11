package org.pox.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ImgVO {
	// photo_uploader.html페이지의 form태그내에 존재하는 file 태그의 name명과 일치시켜줌
	private MultipartFile Filedata;
	// callback URL
	private String callback;
	// 콜백함수??
	private String callback_func;

}
