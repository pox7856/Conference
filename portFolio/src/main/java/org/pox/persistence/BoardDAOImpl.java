package org.pox.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.pox.domain.BoardVO;
import org.pox.domain.FileVO;
import org.pox.dto.SearchCriteria;
import org.springframework.stereotype.Repository;

@Repository("boardDAO")
public class BoardDAOImpl implements BoardDAO {

	@Resource(name = "sqlSession-MYSQL")
	protected SqlSession session;

	private final static String NAME = "org.pox.mapper.boardMapper";

	@Override
	public Integer create(BoardVO vo) throws Exception {
		session.insert(NAME + ".create", vo);
		return vo.getBno();
	}

	@Override
	public BoardVO read(Integer bno) throws Exception {
		return session.selectOne(NAME + ".read", bno);
	}

	@Override
	public void update(BoardVO vo) throws Exception {
		session.update(NAME + ".update", vo);
	}

	@Override
	public void delete(Integer bno) throws Exception {
		session.delete(NAME + ".delete", bno);
	}

	@Override
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception {
		return session.selectList(NAME + ".listSearch", cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return session.selectOne(NAME + ".listSearchCount", cri);
	}

	@Override
	public void updateReplyCnt(Integer bno, int amount) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bno", bno);
		paramMap.put("amount", amount);
		session.update(NAME + ".updateReplyCnt", paramMap);
	}

	@Override
	public void updateViewCnt(Integer bno) throws Exception {
		session.update(NAME + ".updateViewCnt", bno);
	}

	@Override
	public void registFile(FileVO file) throws Exception {
		session.insert(NAME + ".registFile", file);
	}

	@Override
	public List<String> getFile(Integer bno) throws Exception {
		return session.selectList(NAME + ".getFile", bno);
	}

	@Override
	public void replaceFile(String fullName, Integer bno) throws Exception { 
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bno", bno);
		paramMap.put("fullName", fullName);
		session.insert(NAME + ".replaceFile", paramMap);
	}

	@Override
	public void deleteFile(Integer bno) throws Exception {
		session.delete(NAME + ".deleteFile", bno);
	}

}
