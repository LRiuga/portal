<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="gb2312"%>
<%@ page
	import="java.util.*,OAStat.*,java.util.Date,java.text.*,userStats.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
</head>
<body>
	<%
		if(session!=null&&session.getAttribute("login")!=null){
				if(session.getAttribute("login").equals("ok")){
			out.print("<div class=\"table\">");
			
			String monetid = request.getParameter("monetid");
			out.print("<h3>Customer:"+monetid+"</h3>");
			
			ArrayList<String> itemList = WeaponRest.getWeaponRestItem(monetid);
			
			out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
			out.print("<tr class=\"first\" width=\"177\">");
			
			out.print("<th>");
			out.print("id");
			out.print("</th>");
			out.print("<th>");
			out.print("item");
			out.print("</th>");
			out.print("</tr>");
			
			for(int i=0;i<itemList.size();i++){
				if(i%2 == 1){
					out.print("<tr >");
				}else{
					out.print("<tr class=\"bg\">");
				}

				out.print("<td>");
				out.print(i+1);
				out.print("</td>");
				out.print("<td class=\"last\">");
				out.print(itemList.get(i));
				out.print("</td>");
				out.print("</tr>");
			}
			
			out.print("</table>");
			out.print("</div>");
}
			}else{
				response.sendRedirect("index.jsp");

			}
		%>
</body>
</html>