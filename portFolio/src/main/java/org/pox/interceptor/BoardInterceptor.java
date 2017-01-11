package org.pox.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.pox.persistence.BoardDAO;
import org.pox.util.CookieUtil;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class BoardInterceptor extends HandlerInterceptorAdapter {

	@Resource(name = "boardDAO")
	private BoardDAO boardDAO;

	@Override
	public void postHandle(HttpServletRequest req, HttpServletResponse res, Object handler, ModelAndView mv)
			throws Exception {

		String bno = req.getParameter("bno");
		Cookie findCookie = CookieUtil.findCookie("boardView", req);

		if (findCookie == null) {
			Cookie boardView = new Cookie("boardView", "|" + bno + "|");// 조회수용
			boardView.setMaxAge(60 * 60 * 24);
			res.addCookie(boardView);
			boardDAO.updateViewCnt(Integer.parseInt(bno));
			return;
		}
		String value = findCookie.getValue();
		if (value.indexOf("|" + bno + "|") < 0) {
			value = value + "|" + bno + "|";
			findCookie.setValue(value);
			res.addCookie(findCookie);
			boardDAO.updateViewCnt(Integer.parseInt(bno));
		} else {
		}

	}

}
