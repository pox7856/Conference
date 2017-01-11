package org.pox.service;

import java.util.List;

import javax.annotation.Resource;

import org.pox.domain.BoardVO;
import org.pox.domain.FileVO;
import org.pox.dto.SearchCriteria;
import org.pox.persistence.BoardDAO;
import org.pox.persistence.ReplyDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Resource(name = "boardDAO")
	private BoardDAO boardDAO;

	@Resource(name = "replyDAO")
	private ReplyDAO replyDAO;

	@Override
	public Integer regist(BoardVO board) throws Exception {
		return boardDAO.create(board);
	}

	@Override
	public BoardVO read(Integer bno) throws Exception {
		return boardDAO.read(bno);
	}

	@Override
	public void modify(BoardVO board) throws Exception {
		boardDAO.update(board);
	}

	@Transactional
	@Override
	public void remove(Integer bno) throws Exception {
		replyDAO.deleteAll(bno);
		boardDAO.deleteFile(bno);
		boardDAO.delete(bno);
	}

	@Override
	public List<BoardVO> listSearchCriteria(SearchCriteria cri) throws Exception {
		return boardDAO.listSearch(cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return boardDAO.listSearchCount(cri);
	}

	@Override
	public void registFile(FileVO file) throws Exception {
		boardDAO.registFile(file);
	}

	@Override
	public List<String> getFile(Integer bno) throws Exception {
		return boardDAO.getFile(bno);
	}

	@Override
	public void replaceFile(String fileName, Integer bno) throws Exception {
		boardDAO.replaceFile(fileName, bno);
	}

	@Override
	public void deleteFile(Integer bno) throws Exception {
		boardDAO.deleteFile(bno);
	}

}
