<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="gb2312"%>
<%@ page
	import="java.util.*,OAStat.*,java.util.Date,java.text.*,toolStat.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
</head>
<body>

	<br>
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
	<%
if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		out.print("<table>");
		String itemName = request.getParameter("itemName");
		String fromTimestr = request.getParameter("fromTime");
		Date fromTime = OAStatUtil.convertDate(fromTimestr);

		if(itemName==null||itemName==""||fromTime==null){
			out.print("Error!");
		}else{
			out.print(enType.getString("item")+" =("+itemName + ")    " );
			out.print(enType.getString("date")+" =("+fromTime + ")    " );
			out.print("<br>");
			out.print("<br>");

			out.print("</table>");
			
			java.util.Map<String, Object> stocksDetail = new java.util.HashMap<String, Object>();
			stocksDetail = Stocks.getStocksDetail(itemName,fromTime);

			{
				SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
				DecimalFormat df = new DecimalFormat("0.00");
				DecimalFormat sf = new DecimalFormat("0.0");
				out.print("<div class=\"table\">");
				out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");

				out.print("<tr>");
				Set<String> stocksSet = stocksDetail.keySet();
				for(String item:stocksSet){
					out.print("<th>");
					out.print(item);
					out.print("</th>");
				}
				out.print("</tr>");
				
				out.print("<tr>");
				for(String item:stocksSet){
					out.print("<td>");
					out.print(stocksDetail.get(item));
					out.print("</td>");
				}
				out.print("</tr>");
				
				out.print("</table>");
				out.print("</div>");
			}
		}
	}
}else{
	response.sendRedirect("index.jsp");
}
%>
</body>
</html>