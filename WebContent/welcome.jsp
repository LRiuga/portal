<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="gb2312"%>
<%@ page import="java.util.*,OAStat.*,java.util.Date,java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<%
		ResourceBundle languageType = ResourceBundle.getBundle("system");
		ResourceBundle enType = ResourceBundle.getBundle(languageType.getString("language"));
 %>
</head>
<body>
	<%=enType.getString("notice.welcome") %>
</body>
</html>