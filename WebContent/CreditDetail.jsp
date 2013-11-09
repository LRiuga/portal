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
			out.print(enType.getString("item")+" =("+itemName + ")  " );
			out.print(enType.getString("date")+" =("+fromTime + ")  " );
			out.print("<br>");
			out.print("<br>");

			out.print("</table>");
			
			java.util.Map<String, Object> creditDetail = new java.util.HashMap<String, Object>();
			java.util.Map<String, Integer> itemPrice = new java.util.HashMap<String, Integer>();

			creditDetail = CreditDetail.getCreditDetail(itemName,fromTime);
			
			itemPrice = OAStatistic.getNamePrice();

			SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
			DecimalFormat df = new DecimalFormat("0.00");
			DecimalFormat sf = new DecimalFormat("0.0");
			
			out.print("<div class=\"table\">");
			out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");

			out.print("<tr>");
			out.print("<th>");
			out.print(enType.getString("item"));
			out.print("</th>");
			
			out.print("<th>");
			out.print(enType.getString("sales"));
			out.print("</th>");
			out.print("<th>");
			out.print(enType.getString("customer"));
			out.print("</th>");
			out.print("<th>");
			out.print(enType.getString("average"));
			out.print("</th>");
			out.print("<th>");
			out.print(enType.getString("maximum"));
			out.print("</th>");
			out.print("<th>");
			out.print(enType.getString("minimum"));
			out.print("</th>");
			out.print("<th>");
			out.print(enType.getString("price"));
			out.print("</th>");
			out.print("<th>");
			out.print(enType.getString("sales"));
			out.print("</th>");
			out.print("<th>");
			out.print(enType.getString("date"));
			out.print("</th>");
			out.print("</tr>");
			
			out.print("<tr>");
			out.print("<td>");
			out.print(creditDetail.get("iname"));
			out.print("</td>");
			out.print("<td>");
			out.print(creditDetail.get("amount"));
			out.print("</td>");
			out.print("<td>");
			out.print(creditDetail.get("totalUser"));
			out.print("</td>");
			out.print("<td>");
			out.print(sf.format(creditDetail.get("average")));
			out.print("</td>");
			out.print("<td>");
			out.print(creditDetail.get("maxUser"));
			out.print("</td>");
			out.print("<td>");
			out.print(creditDetail.get("minUser"));
			out.print("</td>");
			out.print("<td>");
			out.print(itemPrice.get(creditDetail.get("iname")));
			out.print("</td>");
			out.print("<td>");
			out.print(df.format(itemPrice.get(creditDetail.get("iname"))*Integer.parseInt(creditDetail.get("amount").toString())));
			out.print("</td>");
			out.print("<td>");
			out.print(sdf.format((Date)creditDetail.get("stime")));
			out.print("</td>");
			out.print("</tr>");
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