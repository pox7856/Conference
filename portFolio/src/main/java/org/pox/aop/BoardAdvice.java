/*AOP 만들려다 실패... 그냥 인터셉터로 조회수를 쿠키로제어해서 해결했음.

package org.pox.aop;

import java.util.Arrays;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.pox.service.BoardService;
import org.pox.util.CookieUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletWebRequest;

*//**
 * @author pox
 *
 *//*
*//**
 * @author pox
 *
 *//*
@Component
@Aspect
public class BoardAdvice {

	private static final Logger logger = LoggerFactory.getLogger(BoardAdvice.class);

	@Inject
	private BoardService service;

	@Pointcut("execution(* org.pox.controller.BoardController*.view(..))")
	private void boardView() {
	}

	@Before(value = "boardView()")
	public void test(JoinPoint jp) {
		logger.info("test.............되냐??AOP??");
		logger.info("----------------------------");
		logger.info("----------------------------");
		logger.info(Arrays.toString(jp.getArgs()));
	}

	@Around("execution(* org.pox.controller.BoardController*.view(..)) && args(bno,..)")
	public Object BoardController(ProceedingJoinPoint pjp, Integer bno) throws Throwable {

		ServletWebRequest servletContainer = (ServletWebRequest) RequestContextHolder.getRequestAttributes();
		HttpServletRequest req = servletContainer.getRequest();
		HttpServletResponse res = servletContainer.getResponse();

		System.out.println(bno);
		String num = Integer.toString(bno);
		System.out.println(num);

		Cookie ck = CookieUtil.findCookie("viewCnt", req);
		// 로그인한 유저의 조회수 쿠키를 찾는다.
		if (ck.getValue() != num) {
			logger.info("---------------쿠키에 밸류가없으면 쿠키에 밸류값 추가해줌-----------");
			CookieUtil.addValue(ck.getValue(), num);
			res.addCookie(ck);
			service.updateViewCnt(Integer.parseInt(num));
		}

		long startTime = System.currentTimeMillis();
		logger.info(Arrays.toString(pjp.getArgs()));

		Object result = pjp.proceed();
		logger.info("=============================================");
		logger.info("=============================================");
		logger.info("=============================================");
		long endTime = System.currentTimeMillis();
		logger.info(pjp.getSignature().getName() + " : " + (endTime - startTime));
		logger.info("=============================================");
		logger.info("=============================================");
		logger.info("=============================================");

		return result;
	}

}
*/