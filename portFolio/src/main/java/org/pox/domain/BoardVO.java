package org.pox.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {

	private Integer bno;
	private String title;
	private String content;
	private String username;
	private Date regdate;
	private Date modidate;
	private Integer filecnt;
	private Integer viewcnt;
	private int replycnt;

}
