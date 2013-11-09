<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="gb2312"%>
<%@ page
	import="java.util.*,OAStat.*,java.util.Date,java.text.*,login.*,org.apache.commons.configuration.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<%
	ResourceBundle languageType = ResourceBundle.getBundle("system");
		ResourceBundle enType = ResourceBundle.getBundle(languageType.getString("language"));
 %>
</head>
<h1>Login</h1>
<body>

	<form action="" method="post">
		<h3><%=enType.getString("user") %>:
		</h3>
		<input name="user" type="text" />
		<h3><%=enType.getString("password") %>:
		</h3>
		<input name="psw" type="password" /> <input name="yes" type="submit"
			value="login" required="required" />
	</form>
	<br/>

	<%
String limit = request.getParameter("limit");
String itemName = request.getParameter("Login");
if(session!=null && session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		response.sendRedirect("center.html");
	}
}else if(itemName!=null){
	if(itemName.equals("Success")){
		session.setAttribute("login","ok");
		session.setAttribute("limit",limit);
		response.sendRedirect("center.html");
	}else{
		response.sendRedirect("Login.jsp");
	}
}else{
	String user = request.getParameter("user");
	String psw = request.getParameter("psw");
	if(user==null||user==""){
		out.print("<h3>Insert account</h3>");
	}else if(psw==null||psw==""){         
		out.print("<h3>Insert password</h3>");
	}else{
		int status = Login.getLoginStatus(user,psw);
		if(status>=0){
			session.setAttribute("login","ok");
			session.setAttribute("limit",status);
			response.sendRedirect("center.html");
		}else{
			out.print("<h3>Username or password error : </h3>");		
		}
	}
}
%>
</body>
</html>