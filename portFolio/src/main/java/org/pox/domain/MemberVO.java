package org.pox.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {

	String username;
	String password;
	String name;
	String email;
	String gender;
	Date regdate;
	Date modidate;
	boolean enabled;

}
