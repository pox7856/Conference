package org.pox.persistence;

import java.util.List;

import org.pox.domain.MemberVO;
import org.pox.dto.SearchCriteria;

public interface MemberDAO {

	public void create(MemberVO vo) throws Exception;

	public void createAuth(MemberVO vo) throws Exception;

	public MemberVO read(String key) throws Exception;

	public void update(MemberVO vo) throws Exception;

	public void deleteAuth(String username) throws Exception;

	public void delete(String key) throws Exception;

	public int listSearchCount(SearchCriteria cri) throws Exception;

	public List<MemberVO> listSearch(SearchCriteria cri) throws Exception;

	///////// 미처리//////////////////////////////////////////////////////
	public boolean loginCheck(String username) throws Exception;

}
