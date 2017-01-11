package org.pox.service;

import java.util.List;

import org.pox.domain.ReplyVO;
import org.pox.dto.Criteria;

public interface ReplyService {

	public void addReply(ReplyVO vo) throws Exception;

	public List<ReplyVO> listReply(Integer bno) throws Exception;

	public void modifyReply(ReplyVO vo) throws Exception;

	public void removeReply(Integer rno) throws Exception;

	public List<ReplyVO> listReplyPage(Integer bno, Criteria cri) throws Exception;

	public int count(Integer bno) throws Exception;
}
