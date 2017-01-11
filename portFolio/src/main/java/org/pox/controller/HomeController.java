package org.pox.controller;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class HomeController {

	@GetMapping("/*")
	public String HOME(HttpSession session) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		session.setAttribute("username", auth.getName().trim());
		session.setAttribute("auth", auth.getAuthorities());
		return "/index";
	}

	@GetMapping("/users/login")
	public void login() {

	}

	@PostMapping("/users/logout")
	public void logout() {
	}
}
