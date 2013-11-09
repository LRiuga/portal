<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="gb2312"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	overflow: hidden;
}

.td_class {
	background-image: url(../images/main_69.gif);
}
</style>
</head>
<body>
	<%
	if(session!=null&&session.getAttribute("login")!=null){
		if(session.getAttribute("login").equals("ok")){
			out.println("<table width=\"100%\" height=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
			out.println("<tr>");
			out.println("<td width=\"8\" bgcolor=\"#353c44\">&nbsp;</td>");
			out.println("<td width=\"147\" valign=\"top\" class=\"td_class\"><iframe height=\"100%\" width=\"100%\" border=\"0\" frameborder=\"0\" src=\"menu.html\"></iframe></td>");
			out.println("<td width=\"10\" bgcolor=\"#add2da\">&nbsp;</td>");
			out.println("<td valign=\"top\"><iframe height=\"100%\" width=\"100%\" border=\"0\" frameborder=\"0\" name=\"iframe\"></iframe></td>");
			out.println("<td width=\"8\" bgcolor=\"#353c44\">&nbsp;</td>");
			out.println("</tr>");
			out.println("</table>");
		}
	}else{
		response.sendRedirect("Login.jsp");
	}
 %>
</body>
</html>
