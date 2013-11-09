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
if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		ResourceBundle languageType = ResourceBundle.getBundle("system");
		ResourceBundle enType = ResourceBundle.getBundle(languageType.getString("language"));
	
		out.print("<table>");
		String itemName = request.getParameter("itemName");
		String fromTimestr = request.getParameter("fromTime");
		String type = request.getParameter("type");
		Date fromTime = OAStatUtil.convertDate(fromTimestr);

		if(itemName==null||itemName==""||fromTime==null){
			out.print("Error!");
		}else{

			out.print(enType.getString("item")+" =("+itemName + ")    " );
			out.print(enType.getString("date")+" =("+fromTime + ")    " );
			out.print("<br>");
			out.print("<br>");
			
			out.print("</table>");
			java.util.Map<String, Object> useDetail = new java.util.HashMap<String, Object>();
			useDetail = CreditDetail.getUsingDetail(itemName,fromTime,type);
			{
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
				out.print(enType.getString("amount"));
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
				out.print(enType.getString("date"));
				out.print("</th>");
				out.print("</tr>");
				
				out.print("<tr>");
				out.print("<td>");
				out.print(useDetail.get("iname"));
				out.print("</td>");
				out.print("<td>");
				out.print(useDetail.get("amount"));
				out.print("</td>");
				out.print("<td>");
				out.print(useDetail.get("totalUser"));
				out.print("</td>");
				out.print("<td>");
				out.print(sf.format(Double.parseDouble(useDetail.get("amount").toString())/Double.parseDouble(useDetail.get("totalUser").toString())));
				out.print("</td>");
				out.print("<td>");
				out.print(useDetail.get("maxUser"));
				out.print("</td>");
				out.print("<td>");
				out.print(sdf.format((Date)useDetail.get("utime")));
				out.print("</td>");
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