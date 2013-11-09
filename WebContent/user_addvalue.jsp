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
				ResourceBundle languageType = ResourceBundle.getBundle("system");
				ResourceBundle enType = ResourceBundle.getBundle(languageType.getString("language"));
				out.print("<div class=\"table\">");
			
				String monetid = request.getParameter("monetid");
				String ftime = request.getParameter("ftime");
				String ttime = request.getParameter("ttime");
			
				out.print("<h3>"+enType.getString("customer")+":"+monetid);
				out.print(","+enType.getString("from")+" : "+ftime);
				out.print(" "+enType.getString("to")+" "+ttime+"</h3>");
			
				if(monetid!=null&&ftime!=null&&ttime!=null){
					Date fromTime = OAStatUtil.convertDate(ftime);
					Date toTime = OAStatUtil.convertDate(ttime);
			
					ArrayList<Integer> moneyList = UserInfo.GetAddValueMoneyList(monetid,fromTime,toTime);
					ArrayList<Date> timeList = UserInfo.GetAddValueTimeList(monetid,fromTime,toTime);
			
					out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
			
					out.print("<th>");
					out.print(enType.getString("index"));
					out.print("</th>");
					out.print("<th>");
					out.print(enType.getString("money"));
					out.print("</th>");
					out.print("<th>");
					out.print(enType.getString("time"));
					out.print("</th>");
					out.print("</tr>");
			
					for(int i=0;i<moneyList.size();i++){
						if(i%2 == 1){
							out.print("<tr >");
						}else{
							out.print("<tr class=\"bg\">");
						}

						out.print("<td>");
						out.print(i+1);
						out.print("</td>");
						out.print("<td>");
						out.print(moneyList.get(i));
						out.print("</td>");
						out.print("<td class=\"last\">");
						out.print(timeList.get(i));
						out.print("</td>");
						out.print("</tr>");
					}
			
					out.print("</table>");
					out.print("</div>");
				}
			}
		}else{
			response.sendRedirect("index.jsp");
		}
		%>
</body>
</html>