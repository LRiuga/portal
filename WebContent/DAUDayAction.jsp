<%@ page contentType="text/html;charset=GBK"%>

<%@ page import="org.jfree.chart.ChartFactory,
		org.jfree.chart.JFreeChart,
		org.jfree.chart.servlet.ServletUtilities,
		org.jfree.chart.title.TextTitle,
		org.jfree.data.time.TimeSeries,
		org.jfree.data.time.Month,
		org.jfree.data.time.Day,
		org.jfree.data.time.TimeSeriesCollection,
		java.awt.Font,
		java.util.*,OAStat.*,java.util.Date,java.text.*,toolStat.*"%>
<%@page import="org.jfree.chart.ChartPanel,toolStat.DAUDayAction"%>
<%@page import="java.util.*,OAStat.*,java.util.Date,java.text.*,actionStat.*,util.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
</head>
<body>
	<h1>Action</h1>
	<br />
	<script type="text/javascript" src="js/dateselect.js"></script>
	<div class="table">
		<form action="" method="post">
			<%
				String item = request.getParameter("selectItem");
					if (item == "" || item == null) {
						item = "ShipyardStartfishing";
					}

					String table = "";
					String type = "";
					if (item.equals("ShipyardStartfishing")) {
						table = "userlevelaction";
						type = "startfish";
					} else if (item.equals("ShipyardAttackFisher")) {
						table = "userlevelaction";
						type = "AttackFisher";
					} else if (item.equals("PetTryAttackMonster")) {
						table = "userpetlevelaction";
						type = "attackPersonalMonster";
					} else if (item.equals("PetFinishAttackMonster")) {
						table = "userpetlevelaction";
						type = "personalmonsterdied";
					} else if (item.equals("PetTryMonster")) {
						table = "userpetlevelaction";
						type = "TryAttackPersonalMonster";
					}
			%>
			<select name="selectItem" id="selectItem">
				<option
					<%if (item.equals("ShipyardStartfishing")) {
				out.print("selected=\"selected\"");
			}%>
					value="ShipyardStartfishing">Each ShipyardLevel
					StartFishing</option>
				<option
					<%if (item.equals("ShipyardAttackFisher")) {
				out.print("selected=\"selected\"");
			}%>
					value="ShipyardAttackFisher">Each ShipyardLevel
					AttackFisher</option>
				<option
					<%if (item.equals("PetTryAttackMonster")) {
				out.print("selected=\"selected\"");
			}%>
					value="PetTryAttackMonster">Each PetLevel AttackMonster</option>
				<option
					<%if (item.equals("PetFinishAttackMonster")) {
				out.print("selected=\"selected\"");
			}%>
					value="PetFinishAttackMonster">Each PetLevel KillMonster</option>
				<option
					<%if (item.equals("PetTryMonster")) {
				out.print("selected=\"selected\"");
			}%>
					value="PetTryMonster">Each PetLevel Try AttackMonster</option>
			</select><br /> ʱ�䣺<input name="time" type="text" id="time"
				onfocus="datelist.dfd(this)" /> -<input name="time2" type="text"
				id="time2" onfocus="datelist.dfd(this)" /> <br /> <input name="yes"
				type="submit" value="Search" />
		</form>
	</div>
	<br />
	<%
		if (session != null && session.getAttribute("login") != null) {
		if (session.getAttribute("login").equals("ok")) {
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

			Map<Date, Map<String, Integer>> dayMap = DAUDayAction.getDayMap(table, type, ftime, endtime);
			Set<Date> dateSet = dayMap.keySet();
			List<Date> dateList= new ArrayList<Date>(dateSet);
			Collections.sort(dateList,Collections.reverseOrder());
			
			for(Date date:dateList){
				Map<String, Integer> valueMap = dayMap.get(date);
			
				out.print("<tr>");
				
					out.print("<td>");
					out.print("<a href='DAULevelAction.jsp?time=" + date.toString().substring(0,10) + "'>" +date.toString().substring(0,10) + "</a>");
					out.print("</td>");
					
					out.print("<td>");
					out.print(valueMap.get("total"));
					out.print("</td>");
					out.print("<td>");
					out.print(valueMap.get("users"));
					out.print("</td>");
					out.print("<td>");
					out.print(valueMap.get("average"));
					out.print("</td>");
					out.print("<td>");
					out.print(valueMap.get("max"));
					out.print("</td>");
					out.print("<td>");
					out.print(valueMap.get("mid"));
					out.print("</td>");
					out.print("<td>");
					out.print(valueMap.get("min"));
					out.print("</td>");
					
				out.print("</tr>");
			}

			out.print("</table>");
			out.print("</div>");

			out.print("<br>");
			out.print("</table>");
		}
			} else {
		response.sendRedirect("index.jsp");
			}
	%>
</body>
</html>