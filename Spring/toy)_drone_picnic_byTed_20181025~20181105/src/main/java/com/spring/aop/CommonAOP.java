package com.spring.aop;

import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class CommonAOP {
	private static final Logger logger = LoggerFactory.getLogger(CommonAOP.class);
	
	@Around("execution(* com.spring.common.pagination.Criteria.*(..))")
	public Object timeLog(ProceedingJoinPoint pjp) throws Throwable{		
		long startTime = System.currentTimeMillis();
		logger.info("=start=============================");
		logger.info("Arrays.deepToString(pjp.getArgs()) = " + Arrays.deepToString(pjp.getArgs()));
		logger.info("==============================");
		 
		Object result = pjp.proceed();
		 
		long endTime = System.currentTimeMillis();
		logger.info("=end=============================");
		logger.info(" pjp.getSignature().getName() + \" : \" + (endTime - startTime)=" + pjp.getSignature().getName() + " : " + (endTime - startTime) );
		logger.info("=end=============================");
			 
		return result;
	}
}
