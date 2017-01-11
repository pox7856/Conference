package org.pox.service;

import java.util.List;

import org.pox.domain.MemberVO;
import org.pox.dto.SearchCriteria;

public interface MemberService {

	public boolean loginCheck(String username) throws Exception;

	public void regist(MemberVO vo) throws Exception;

	public MemberVO view(String username) throws Exception;

	public void update(MemberVO vo) throws Exception;

	public void remove(String username) throws Exception;

	public int listSearchCount(SearchCriteria cri) throws Exception;

	public List<MemberVO> listSearch(SearchCriteria cri) throws Exception;

}
