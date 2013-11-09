<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="gb2312"%>
<%
	if(session!=null&&session.getAttribute("login")!=null){
		if(session.getAttribute("login").equals("ok")){
			out.println("<html>");
			out.println("<head>");
			out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
			out.println("<title>OA</title>");
			out.println("</head>");
			out.println("<frameset rows=\"90,*\">");
			out.println(" <frame name=\"header\" scrolling=\"no\" noresize=\"noresize\" target=\"iframe\" src=\"menu2.html\">");
			out.println(" <frame name=\"iframe\" src=\"dailyReport.jsp\">");
			out.println(" <noframes>");
			out.println(" <body>");
			out.println("</body>");
			out.println("</noframes>");
			out.println("</html>");
		}
	}else{
		response.sendRedirect("Login.jsp");
	}
 %>
