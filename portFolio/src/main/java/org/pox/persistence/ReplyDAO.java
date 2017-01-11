package org.pox.persistence;

import java.util.List;

import org.pox.domain.ReplyVO;
import org.pox.dto.Criteria;

public interface ReplyDAO {

	public List<ReplyVO> list(Integer bno) throws Exception;

	public void create(ReplyVO vo) throws Exception;

	public void update(ReplyVO vo) throws Exception;

	public void delete(Integer rno) throws Exception;

	public void deleteAll(Integer bno) throws Exception;

	public List<ReplyVO> listPage(Integer bno, Criteria cri) throws Exception;

	public int count(Integer bno) throws Exception;

	public int getBno(Integer rno) throws Exception;

}
