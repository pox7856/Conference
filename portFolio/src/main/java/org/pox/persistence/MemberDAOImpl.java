package org.pox.persistence;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.pox.domain.MemberVO;
import org.pox.dto.SearchCriteria;
import org.springframework.stereotype.Repository;

@Repository("memberDAO")
public class MemberDAOImpl implements MemberDAO {

	@Resource(name = "sqlSession-MYSQL")
	protected SqlSession session;

	private final static String NAME = "org.pox.mapper.memberMapper";

	@Override
	public void create(MemberVO vo) throws Exception {
		session.insert(NAME + ".create", vo);
	}

	@Override
	public void createAuth(MemberVO vo) throws Exception {
		session.insert(NAME + ".createAuth", vo);
	}

	@Override
	public MemberVO read(String username) throws Exception {
		return session.selectOne(NAME + ".read", username);
	}

	@Override
	public void update(MemberVO vo) throws Exception {
		session.update(NAME + ".update", vo);
	}

	@Override
	public void deleteAuth(String username) throws Exception {
		session.delete(NAME + ".deleteAuth", username);
	}

	@Override
	public void delete(String username) throws Exception {
		session.delete(NAME + ".delete", username);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return session.selectOne(NAME + ".listSearchCount", cri);
	}

	@Override
	public List<MemberVO> listSearch(SearchCriteria cri) throws Exception {
		return session.selectList(NAME + ".listSearch", cri);
	}

	@Override
	public boolean loginCheck(String userid) throws Exception {
		String login = session.selectOne(NAME + ".loginCheck", userid);
		if (login != null) {
			return true;
		} else {
			return false;
		}

	}

}
