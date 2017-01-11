package org.pox.interceptor;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

public class UserLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler
		implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest req, HttpServletResponse res, Authentication auth)
			throws IOException, ServletException {
		System.out.println(auth.getName());
		System.out.println(auth.getAuthorities().toString());
		System.out.println(auth.getDetails().toString());
		System.out.println(auth.getPrincipal().toString());

		Cookie loginCookie = new Cookie("login", auth.getName());
		loginCookie.setMaxAge(60 * 60 * 24);
		res.addCookie(loginCookie);

		super.onAuthenticationSuccess(req, res, auth);
	}

}
