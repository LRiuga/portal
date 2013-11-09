<%@ page contentType="text/html;charset=GBK"%>

<%@ page
	import="org.jfree.chart.ChartFactory,
org.jfree.chart.JFreeChart,
org.jfree.chart.servlet.ServletUtilities,
org.jfree.chart.title.TextTitle,
org.jfree.data.time.TimeSeries,
org.jfree.data.time.Month,
org.jfree.data.time.Day,
org.jfree.data.time.TimeSeriesCollection,
java.awt.Font,
java.util.*,OAStat.*,java.util.Date,java.text.*,toolStat.*"%>
<%@page import="org.jfree.chart.ChartPanel"%>
<%@ page
	import="java.util.*,OAStat.*,java.util.Date,java.text.*,actionStat.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
</head>
<body>
	<h1>Resource</h1>
	<br />
	<script language="javascript" src="js/dateselect.js"></script>
	<div class="table">
		<form action="" method="post">
			<%	
	String item = request.getParameter("selectItem");	
	if(item==""||item==null){
		item="GoldSellFish";
	}
	
	String resource = "";
	String type = "";
	if(item.equals("GoldSellFish")){
		resource = "Gold";
		type = "sellFish";
	}else if(item.equals("PearlFishing")){
		resource = "Pearl";
		type = "StopFish";
	}else if(item.equals("GoldLucky")){
		resource = "Gold";
		type = "getGift";
	}else if(item.equals("PearlLucky")){
		resource = "Pearl";
		type = "LuckyDraw";
	}else if(item.equals("PearlPersonalMonster")){
		resource = "Pearl";
		type = "attackPersonalMonster";
	}else if(item.equals("PearlAttackOthers")){
		resource = "Pearl";
		type = "AttackGetRewards";
	}
	
%>
			<select name="selectItem" id="selectItem">
				<option
					<%if(item.equals("GoldSellFish")){out.print("selected=\"selected\"");} %>
					value="GoldSellFish">Get gold by sellFish</option>
				<option
					<%if(item.equals("GoldLucky")){out.print("selected=\"selected\"");} %>
					value="GoldLucky">Get gold by LuckyDraw</option>
				<option
					<%if(item.equals("PearlFishing")){out.print("selected=\"selected\"");} %>
					value="PearlFishing">Get pearl by fishing</option>
				<option
					<%if(item.equals("PearlLucky")){out.print("selected=\"selected\"");} %>
					value="PearlLucky">Get pearl by LuckyDraw</option>
				<option
					<%if(item.equals("PearlPersonalMonster")){out.print("selected=\"selected\"");} %>
					value="PearlPersonalMonster">Get pearl by Attack Personal
					Monster</option>
				<option
					<%if(item.equals("PearlAttackOthers")){out.print("selected=\"selected\"");} %>
					value="PearlAttackOthers">Get pearl by attack others</option>
			</select> Date£º<input name="time" type="text" id="time"
				onfocus="datelist.dfd(this)" readonly="readonly" /> - <input
				name="time2" type="text" id="time2" onfocus="datelist.dfd(this)"
				readonly="readonly" /> <br /> <input name="yes" type="submit"
				value="Search" />
		</form>
	</div>
	<br />
	<%
if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		String ftime = request.getParameter("time");
		String endtime = request.getParameter("time2");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		if(ftime==null ){
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DATE, -7);
			ftime = sdf.format(c.getTime());
		}
		if( endtime==null){
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DATE, -1);
			endtime = sdf.format(c.getTime());
		}
			out.print("<br>");
			out.print("<table>");
			{
				int result = 0;
				
				out.print("<div class=\"table\">");
				out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
				out.print("<tr class=\"first\" width=\"177\">");
				
				out.print("<th>");
				out.print("Date");
				out.print("</th>");   
				

				out.print("<th>");
				out.print("Total");
				out.print("</th>");
				
				out.print("<th>");
				out.print("User");
				out.print("</th>");
				
				out.print("<th>");
				out.print("Average");
				out.print("</th>");
				
				out.print("<th>");
				out.print("Max");
				out.print("</th>");
				
				out.print("<th>");
				out.print("Mid");
				out.print("</th>");
				
				out.print("<th>");
				out.print("Min");
				out.print("</th>");

				out.print("</tr>");

				List<ArrayList<String>> allList = DAULevelResource.getAll(resource,type,ftime,endtime);
				for(ArrayList<String> list :allList){
					out.print("<tr>");
					for(String s: list){
						out.print("<td>");
						if(s.endsWith("00.0")){
							out.print("<a href=DAULevelResource.jsp?time=" + s.substring(0,10) + " > " + s.substring(0,10) + "</a>");
						}else{
							out.print(s);
						}
						out.print("</td>");
					}
					out.print("</tr>");
				}

			}
				out.print("</table>");
				out.print("</div>");
			}
			out.print("<br>");
		out.print("</table>");
}else{
	response.sendRedirect("index.jsp");
}
%>
</body>
</html>