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

out.print("<table>");
String itemName = request.getParameter("itemName");
String fromTimestr = request.getParameter("fromTime");
Date fromTime = OAStatUtil.convertDate(fromTimestr);

if(itemName==null||itemName==""||fromTime==null){
	out.print("Error!");
}else{

out.print("道具名 =("+itemName + ")    " );
out.print("时间 =("+fromTime + ")    " );
out.print("<br>");
out.print("<br>");

out.print("</table>");


			
			java.util.Map<String, Object> goldDetail = new java.util.HashMap<String, Object>();
			
			//保存道具价格_creadit
			java.util.Map<String, Double> itemPrice = new java.util.HashMap<String, Double>();
			if(itemName.contains("%20")){
				itemName = itemName.replace("%20"," ");
			}
			goldDetail = CreditDetail.getGoldDetail(itemName,fromTime);


			{
				SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
				DecimalFormat df = new DecimalFormat("0.00");
				DecimalFormat sf = new DecimalFormat("0.0");
				out.print("<div class=\"table\">");
				out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");

				out.print("<tr>");
				out.print("<th>");
				out.print("道具名");
				out.print("</th>");
				
				out.print("<th>");
				out.print("总量");
				out.print("</th>");
				out.print("<th>");
				out.print("玩家总数");
				out.print("</th>");
				out.print("<th>");
				out.print("人均");
				out.print("</th>");
				out.print("<th>");
				out.print("最大数");
				out.print("</th>");
				out.print("<th>");
				out.print("日期");
				out.print("</th>");
				out.print("</tr>");
				
				out.print("<tr>");
				out.print("<td>");
				out.print(goldDetail.get("iname"));
				out.print("</td>");
				out.print("<td>");
				out.print(goldDetail.get("amount"));
				out.print("</td>");
				out.print("<td>");
				out.print(goldDetail.get("totalUser"));
				out.print("</td>");
				out.print("<td>");
				out.print(sf.format(Double.parseDouble(goldDetail.get("amount").toString())/Double.parseDouble(goldDetail.get("totalUser").toString())));
				out.print("</td>");
				out.print("<td>");
				out.print(goldDetail.get("maxUser"));
				out.print("</td>");
				out.print("<td>");
				out.print(sdf.format((Date)goldDetail.get("gtime")));
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