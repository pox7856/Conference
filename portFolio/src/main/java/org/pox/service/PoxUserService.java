package org.pox.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.pox.dto.PoxUser;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("PoxUserService")
public class PoxUserService implements UserDetailsService {

	@Resource(name = "sqlSession-MYSQL")
	protected SqlSession session;

	@Transactional
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		Map<String, Object> user = session.selectOne("org.pox.mapper.memberMapper.userInfo", username);
		if (user == null) {
			System.out.println("  " + username + "  : 에 해당하는 정보가 DB상에 없습니다.");
			throw new UsernameNotFoundException(username);
		}
		List<GrantedAuthority> gas = new ArrayList<GrantedAuthority>();
		List<String> auth = session.selectList("org.pox.mapper.memberMapper.makeAuth", username);

		for (int i = 0; i < auth.size(); i++) {
			gas.add(new SimpleGrantedAuthority(auth.get(i)));
		}
		String DBusername = user.get("username").toString();
		String DBpassword = user.get("password").toString();
		String DBname = user.get("name").toString();
		String DBemail = user.get("email").toString();
		String DBgender = user.get("gender").toString();
		Date DBregdate = (Date) user.get("regdate");
		Date DBmodidate = (Date) user.get("modidate");
		boolean DBenabled = (user.get("enabled").equals(true)) ? true : false;

		return new PoxUser(DBusername, DBpassword, DBenabled, true, true, true, gas, DBname, DBemail, DBgender,
				DBregdate, DBmodidate);
	}

}
