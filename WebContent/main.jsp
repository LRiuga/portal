<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="gb2312"%>
<%
	if(session!=null&&session.getAttribute("login")!=null){
		if(session.getAttribute("login").equals("ok")){
			response.sendRedirect("center.html");
		}
	}else{
		response.sendRedirect("Login.jsp");
	}
 %>
