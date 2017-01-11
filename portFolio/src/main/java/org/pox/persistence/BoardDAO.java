package org.pox.persistence;

import java.util.List;

import org.pox.domain.BoardVO;
import org.pox.domain.FileVO;
import org.pox.dto.SearchCriteria;

public interface BoardDAO {

	public Integer create(BoardVO vo) throws Exception;

	public BoardVO read(Integer bno) throws Exception;

	public void update(BoardVO vo) throws Exception;

	public void delete(Integer bno) throws Exception;

	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception;

	public int listSearchCount(SearchCriteria cri) throws Exception;

	public void updateReplyCnt(Integer bno, int amount) throws Exception;

	public void updateViewCnt(Integer bno) throws Exception;

	// 파일

	public void registFile(FileVO file) throws Exception;

	public List<String> getFile(Integer bno) throws Exception;

	public void replaceFile(String fullName, Integer bno) throws Exception;

	public void deleteFile(Integer bno) throws Exception;

}
