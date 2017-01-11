package org.pox.domain;

import java.util.Date;

import lombok.Data;

@Data
public class FileVO {
	Integer fno;
	Integer bno;
	String originName;
	String uuidName;
	Date regdate;
	Date modidate;

	public FileVO() {
	}

	public FileVO(Integer bno, String originName, String uuidName) {

		this.bno = bno;
		this.originName = originName;
		this.uuidName = uuidName;
	}

}
