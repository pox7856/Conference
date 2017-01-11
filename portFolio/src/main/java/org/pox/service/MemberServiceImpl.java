package org.pox.service;

import java.util.List;

import javax.annotation.Resource;

import org.pox.domain.MemberVO;
import org.pox.dto.SearchCriteria;
import org.pox.persistence.MemberDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("memberService")
public class MemberServiceImpl implements MemberService {

	@Resource(name = "memberDAO")
	MemberDAO MemberDAO;

	@Override
	public boolean loginCheck(String username) throws Exception {
		return MemberDAO.loginCheck(username);
	}

	@Transactional
	@Override
	public void regist(MemberVO vo) throws Exception {
		MemberDAO.create(vo);
		MemberDAO.createAuth(vo);
	}

	@Override
	public MemberVO view(String username) throws Exception {
		return MemberDAO.read(username);
	}

	@Override
	public void update(MemberVO vo) throws Exception {
		MemberDAO.update(vo);
	}

	@Transactional
	@Override
	public void remove(String username) throws Exception {
		MemberDAO.deleteAuth(username);
		MemberDAO.delete(username);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return MemberDAO.listSearchCount(cri);
	}

	@Override
	public List<MemberVO> listSearch(SearchCriteria cri) throws Exception {
		return MemberDAO.listSearch(cri);
	}

}
