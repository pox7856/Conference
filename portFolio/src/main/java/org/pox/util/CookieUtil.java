package org.pox.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

public class CookieUtil {
	// 기존 쿠키/ //추가하려는 데이터.
	public static String addValue(String before, String data) {

		if (before.indexOf(data) >= 0) {
			return before;
		}
		return before + data;
	}// end addValue

	public static Cookie findCookie(String name, HttpServletRequest req) throws Exception {

		Cookie[] arr = req.getCookies();

		if (arr == null || arr.length == 0) {
			return null;
		}
		for (Cookie cookie : arr) {

			if (cookie.getName().equals(name)) {
				return cookie;
			}
		}
		return null;
	}// end findCookie

}// end class
