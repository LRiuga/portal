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


			
			java.util.Map<String, Object> creditDetail = new java.util.HashMap<String, Object>();
			
			//保存道具价格_creadit
			java.util.Map<String, Double> itemPrice = new java.util.HashMap<String, Double>();

			creditDetail = CreditDetail.getOABalanceDetail(itemName,fromTime);
			//itemPrice = OAStatUtil.getNamePrice();

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
				out.print("销售量");
				out.print("</th>");
				out.print("<th>");
				out.print("玩家总数");
				out.print("</th>");
				out.print("<th>");
				out.print("人均购买");
				out.print("</th>");
				out.print("<th>");
				out.print("最大购买数");
				out.print("</th>");
				out.print("<th>");
				out.print("单价");
				out.print("</th>");
				out.print("<th>");
				out.print("OABalance");
				out.print("</th>");
				out.print("<th>");
				out.print("Credit");
				out.print("</th>");
				out.print("<th>");
				out.print("日期");
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
				out.print(sf.format(Double.parseDouble(creditDetail.get("amount").toString())/Double.parseDouble(creditDetail.get("totalUser").toString())));
				out.print("</td>");
				out.print("<td>");
				out.print(creditDetail.get("maxUser"));
				out.print("</td>");
				out.print("<td>");
				out.print(itemPrice.get(creditDetail.get("iname")));
				out.print("</td>");
				out.print("<td>");
				out.print(df.format(creditDetail.get("oabalance")));
				out.print("</td>");
				out.print("<td>");
				out.print(df.format(creditDetail.get("credit")));
				out.print("</td>");
				out.print("<td>");
				out.print(sdf.format((Date)creditDetail.get("stime")));
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