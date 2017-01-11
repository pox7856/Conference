package org.pox.controller;

import java.util.List;

import javax.annotation.Resource;

import org.pox.domain.BoardVO;
import org.pox.domain.FileVO;
import org.pox.dto.PageMaker;
import org.pox.dto.SearchCriteria;
import org.pox.service.BoardService;
import org.pox.util.UploadFileUtils;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Resource(name = "boardService")
	private BoardService service;
 

	@Resource(name = "uploadPath")
	private String uploadPath;

	@Secured({ "ROLE_MEMBER", "ROLE_MANAGER", "ROLE_ADMIN" })
	@GetMapping("/register")
	public void register() {
		log.info("REGISTER GET"); 
	}

	@PostMapping("/register")
	public String register(RedirectAttributes rttr, @ModelAttribute BoardVO board,
			@RequestPart(required = false, value = "file") MultipartFile file) throws Exception {
		Integer bno = service.regist(board);
		System.out.println(board);
		if (file.getSize() != 0) {
			String originName = file.getOriginalFilename();
			String uuidName = UploadFileUtils.uploadFile(uploadPath, originName, file.getBytes());
			service.registFile(new FileVO(bno, originName, uuidName));
			log.info("UPLOADED NAME:" + uuidName);
		}

		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/board/list";
	}

	@GetMapping("/view")
	public void view(@RequestParam("bno") Integer bno, Model model) throws Exception {
		model.addAttribute("view", service.read(bno));
	}

	@GetMapping("/modify")
	public void modify(@RequestParam("bno") Integer bno, @ModelAttribute("cri") SearchCriteria cri, Model model)
			throws Exception {
		model.addAttribute("modify", service.read(bno));
	}

	@PostMapping("/modify")
	public String modifyPOST(BoardVO board, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		log.info("modify POST 페이지...." + board);
		service.modify(board);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/board/list";
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Integer bno, SearchCriteria cri, RedirectAttributes rttr)
			throws Exception {
		service.remove(bno);
		log.info("삭제완료 : " + bno);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/board/list";
	}

	@GetMapping("/list")
	public void list(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		model.addAttribute("list", service.listSearchCriteria(cri));
		pageMaker.setTotalCount(service.listSearchCount(cri));
		model.addAttribute("pageMaker", pageMaker);
	}

	@RequestMapping("/getFile/{bno}")
	@ResponseBody
	public List<String> getAttach(@PathVariable("bno") Integer bno) throws Exception {
		return service.getFile(bno);
	}

}
