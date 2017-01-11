package org.pox.web;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.pox.domain.BoardVO;
import org.pox.domain.FileVO;
import org.pox.dto.SearchCriteria;
import org.pox.persistence.BoardDAO;
import org.pox.service.BoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/config/dataSource-context.xml" })
public class BoardTester {

	@Resource(name = "boardDAO")
	BoardDAO boardDAO;
	@Resource(name = "boardService")
	private BoardService service;

	final static Logger logger = LoggerFactory.getLogger(BoardTester.class);

	@Test
	public void registFileTEST() throws Exception {
		service.registFile(new FileVO(1, "test", "testsetset"));
	}

	@Test
	public void testURI2() throws Exception {

		UriComponents uriComponents = UriComponentsBuilder.newInstance().path("/{module}/{page}").queryParam("bno", 12)
				.queryParam("perPageNum", 20).build().expand("board", "read").encode();

		logger.info("/board/read?bno=12&perPageNum=20");
		logger.info(uriComponents.toString());
	}

	@Test
	public void testDynamic1() throws Exception {

		SearchCriteria cri = new SearchCriteria();
		cri.setPage(1);
		cri.setKeyword("글");
		cri.setSearchType("t");

		logger.info("=====================================");

		List<BoardVO> list = boardDAO.listSearch(cri);

		for (BoardVO boardVO : list) {
			logger.info(boardVO.getBno() + ": " + boardVO.getTitle());
		}

		logger.info("=====================================");

		logger.info("COUNT: " + boardDAO.listSearchCount(cri));
	}
}
