package org.pox.service;

import java.util.List;

import org.pox.domain.BoardVO;
import org.pox.domain.FileVO;
import org.pox.dto.SearchCriteria;

public interface BoardService {

	public Integer regist(BoardVO board) throws Exception;

	public BoardVO read(Integer bno) throws Exception;

	public void modify(BoardVO board) throws Exception;

	public void remove(Integer bno) throws Exception;

	public List<BoardVO> listSearchCriteria(SearchCriteria cri) throws Exception;

	public int listSearchCount(SearchCriteria cri) throws Exception;

	public void registFile(FileVO vo) throws Exception;

	public List<String> getFile(Integer bno) throws Exception;

	public void replaceFile(String fileName, Integer bno) throws Exception;

	public void deleteFile(Integer bno) throws Exception;

}
