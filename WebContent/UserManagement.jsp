<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="gb2312"%>
<%@ page import="java.util.*,OAStat.*,java.util.Date,java.text.*,util.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
</head>
<body>
	<%
		ResourceBundle languageType = ResourceBundle.getBundle("system");
		ResourceBundle enType = ResourceBundle.getBundle(languageType.getString("language"));
		String limitString = session.getAttribute("limit").toString();
		if(limitString!=null){
			if(limitString.equals("3")){
				enType = ResourceBundle.getBundle("English");
			}
		}
 %>

	<h1><%=enType.getString("title.portal_manage") %></h1>
	<a href="UserManagement.jsp?Action=Quit"><%=enType.getString("logout") %></a>
	<br>
	<br>
	<%
if(session!=null&&session.getAttribute("login")!=null){
	String quit = request.getParameter("Action");
	if(quit!=null&&quit.equals("Quit")){
		session.removeAttribute("login");
		session.removeAttribute("limit");
		response.sendRedirect("index.jsp");
	}else{
		if(session.getAttribute("login").equals("ok")&&(session.getAttribute("limit").toString().equals("1")||session.getAttribute("limit").toString().equals("0"))){
			out.print("<form action=\"\" method=\"post\">");
			out.print(enType.getString("user")+":<input name=\"addUserName\" type=\"text\" required=\"required\"/> ");
			out.print(enType.getString("password")+":<input name=\"psw\" type=\"text\" required=\"required\"/> ");
			out.print(enType.getString("notice.PermissionDesc")+":<input name=\"limit\" type=\"text\" required=\"required\"/> ");
			out.print("<input name=\"yes\" type=\"submit\" value=\"Add\" />");
			out.print("</form>");
			
			out.print("<br>");
			String deleteUserName = request.getParameter("userName");
			if(deleteUserName!=null){
				UserManagement.deleteUser(deleteUserName);
			}
			
			String addUserName = request.getParameter("addUserName");
			String psw = request.getParameter("psw");
			limitString = request.getParameter("limit");
			if(limitString!=null){
				if(limitString.equals("1")||limitString.equals("2")){
					if(addUserName!=null&&psw!=null){
						UserManagement.addUser(addUserName,psw,Integer.parseInt(limitString));
					}
				}
			}
		
			ArrayList<UserManagement> userList = UserManagement.getAllUser();
		
			out.print("<div class=\"table\">");
			out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
			
			out.print("<tr class=\"first\" width=\"177\">");
			out.print("<th colspan=1>");
			out.print(enType.getString("index"));
			out.print("</th>");
			out.print("<th colspan=1>");
			out.print(enType.getString("user"));
			out.print("</th>");
			out.print("<th colspan=1>");
			out.print(enType.getString("permission"));
			out.print("</th>");
			
			out.print("<th colspan=1>");
			out.print(enType.getString("delete"));
			out.print("</th>");
			out.print("</tr>");	
	
			for(int i=0;i<userList.size();i++){
				out.print("<tr>");	
				out.print("<td colspan=1>");
				out.print(i+1);
				out.print("</td>");
				out.print("<td colspan=1>");
				out.print(userList.get(i).getUserNmae());
				out.print("</td>");
				out.print("<td colspan=1>");
				if(userList.get(i).getLimit()==1){
					out.print("admin");				
				}else{
					out.print("normal");	
				}
				out.print("</td>");
				
				out.print("<td colspan=1>");
				out.print("<a href = \"UserManagement.jsp?userName=" + userList.get(i).getUserNmae() +  "\">" + enType.getString("delete") + "</a>" );
				out.print("</td>");
				out.print("</tr>");	
			}
			out.print("</table>");
			out.print("</div>");
		}else{
			out.print(enType.getString("notice.not_enough_Permission"));
		}
	}
}else{
	response.sendRedirect("index.jsp");
}
%>
</body>
</html>