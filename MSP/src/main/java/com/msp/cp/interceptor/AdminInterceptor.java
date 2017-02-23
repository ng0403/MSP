package com.msp.cp.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminInterceptor extends HandlerInterceptorAdapter {
	 
	 @Override
	 public boolean preHandle(HttpServletRequest request,
	        HttpServletResponse response,
	        Object handler) throws Exception {
	 
	  boolean masterFlag = false;
	 
	  System.out.println("Login Interceptor");
	  
	  if(request.getSession().getAttribute("user_id") != null &&
	    (Integer)request.getSession().getAttribute("SGRADE") == 3  ){
	               // 세션 ID (SID)가 존재하고, 등급(SGEADE)이 3 이라면
	         
	    System.out.println("admin인증!!!");      // admin 인증
	    masterFlag = true;
	       
	  } else {     // 세션 ID가 존재치 않거나, 등급이 3이 아니라면
	          
	    System.out.println("admin 미인증!");     // admin 미인증
	    response.sendRedirect(request.getContextPath()+"/");  
	                                            // 해당 페이지로 보내기
	    masterFlag = false;
	  }
	 
	  return masterFlag;
	 }
	 
	 @Override
	 public void postHandle(HttpServletRequest request, 
	                        HttpServletResponse response,
	                        Object handler, 
	                        ModelAndView modelAndView) throws Exception {
	       
	    super.postHandle(request, response, handler, modelAndView);
	 }
	 
	 @Override
	 public void afterCompletion(HttpServletRequest request, 
	                             HttpServletResponse response, 
	                             Object handler, 
	                             Exception ex) throws Exception {
	    super.afterCompletion(request, response, handler, ex);
	 } 
	} 