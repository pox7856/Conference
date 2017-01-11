package org.pox.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.pox.domain.MemberVO;
import org.pox.persistence.MemberDAO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/config/dataSource-context.xml" })
public class MemberTester {

	@Resource(name = "memberDAO")
	MemberDAO memberDAO;

	@Resource(name = "sqlSession-MYSQL")
	protected SqlSession session;

	@Test
	public void updateTEST() throws Exception {
		MemberVO vo = new MemberVO();
		vo.setUsername("aetb");
		vo.setPassword("test22");
		vo.setEmail("test");
		memberDAO.update(vo);
	}

	@Test
	public void userTEST() throws Exception {
		String username = "admin";
		Map<String, Object> user = session.selectOne("org.pox.mapper.memberMapper.userInfo", username);
		List<GrantedAuthority> gas = session.selectList("org.pox.mapper.memberMapper.makeAuth", username);
		List<String> auth = session.selectList("org.pox.mapper.memberMapper.makeAuth", username);
		System.out.println(user.toString());
		System.out.println(gas);
		System.out.println(auth);
		System.out.println(gas.equals(auth));
	}

	@Test
	public void test() throws Exception {
		String username = "admin";
		List<String> auth = session.selectList("org.pox.mapper.memberMapper.makeAuth", username);
		for (int i = 0; i < auth.size(); i++) {
			System.out.println(auth.get(i));
		}

	}

	@Test
	public void test2() throws Exception {
		Map<String, Object> user = session.selectOne("org.pox.mapper.memberMapper.makeUser", "aetb");

		String username = user.get("username").toString();
		String password = user.get("password").toString();
		String name = user.get("name").toString();
		String email = user.get("email").toString();
		String gender = user.get("gender").toString();
		String regdate = user.get("regdate").toString();
		String modidate = user.get("modidate").toString();
		String enabled = user.get("enabled").toString();
		System.out.println(user.toString());
		System.out.println(user.size());
		System.out.println(username);
		System.out.println(password);
		System.out.println(name);
		System.out.println(email);
		System.out.println(gender);
		System.out.println(regdate);
		System.out.println(modidate);
		System.out.println(enabled);

		int result = (user.get("enabled").equals(true)) ? 1 : 0;

		System.out.println("result의 값은:::" + result);

	}

}
