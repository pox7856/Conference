package org.pox.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.pox.domain.ReplyVO;
import org.pox.dto.Criteria;
import org.springframework.stereotype.Repository;

@Repository("replyDAO")
public class ReplyDAOImpl implements ReplyDAO {

	@Resource(name = "sqlSession-MYSQL")
	private SqlSession session;

	private final static String NAME = "org.pox.mapper.ReplyMapper";

	@Override
	public List<ReplyVO> list(Integer bno) throws Exception {

		return session.selectList(NAME + ".list", bno);
	}

	@Override
	public void create(ReplyVO vo) throws Exception {

		session.insert(NAME + ".create", vo);
	}

	@Override
	public void update(ReplyVO vo) throws Exception {

		session.update(NAME + ".update", vo);
	}

	@Override
	public void delete(Integer rno) throws Exception {

		session.update(NAME + ".delete", rno);
	}

	@Override
	public void deleteAll(Integer bno) throws Exception {
		session.delete(NAME + ".deleteAll", bno);
	}

	@Override
	public List<ReplyVO> listPage(Integer bno, Criteria cri) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("bno", bno);
		paramMap.put("cri", cri);

		return session.selectList(NAME + ".listPage", paramMap);
	}

	@Override
	public int count(Integer bno) throws Exception {

		return session.selectOne(NAME + ".count", bno);

	}

	@Override
	public int getBno(Integer rno) throws Exception {
		return session.selectOne(NAME + ".getBno", rno);
	}

}
