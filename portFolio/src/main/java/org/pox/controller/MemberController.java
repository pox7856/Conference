package org.pox.controller;

import javax.annotation.Resource;

import org.pox.domain.MemberVO;
import org.pox.dto.PageMaker;
import org.pox.dto.SearchCriteria;
import org.pox.service.MemberService;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Resource(name = "memberService")
	private MemberService service;

	@RequestMapping(value = "/id_check", method = RequestMethod.POST)
	public @ResponseBody boolean id_check(String username) throws Exception {
		return service.loginCheck(username);
	}

	@GetMapping("/register")
	public void register() {
	}

	@PostMapping("/registerPOST")
	public String registerPOST(MemberVO member, RedirectAttributes rttr) throws Exception {
		log.info("REGISTER POST" + member);
		service.regist(member);
		rttr.addFlashAttribute("msg", "REGISTSUCCESS");
		return "redirect:/users/login";
	}

	@GetMapping("/view")
	public void view(@RequestParam("username") String username, Model model) throws Exception {
		model.addAttribute("view", service.view(username));
	}

	@GetMapping("/modify")
	public void modify(@RequestParam("username") String username, Model model) throws Exception {
		model.addAttribute("modify", service.view(username));
	}

	@PostMapping("/modify")
	public String modifyPagingPOST(MemberVO member, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		System.out.println(member);
		service.update(member);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/index";
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("username") String username, SearchCriteria cri, RedirectAttributes rttr)
			throws Exception {
		service.remove(username);
		log.info("삭제완료 : " + username);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/member/list";
	}

	@Secured("ROLE_ADMIN")
	@GetMapping("/list")
	public void list(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		log.info(cri.toString());
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		model.addAttribute("list", service.listSearch(cri));
		pageMaker.setTotalCount(service.listSearchCount(cri));
		model.addAttribute("pageMaker", pageMaker);
	}

}
