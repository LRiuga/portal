<%@ page contentType="text/html;charset=GBK"%>

<%@ page
	import="org.jfree.chart.ChartFactory,org.jfree.chart.JFreeChart,org.jfree.chart.servlet.ServletUtilities,org.jfree.chart.title.TextTitle,org.jfree.data.time.TimeSeries,org.jfree.data.time.Month,org.jfree.data.time.Day,org.jfree.data.time.TimeSeriesCollection,java.awt.Font,java.util.*,OAStat.*,java.util.Date,java.text.*,userStats.*,login.*"%>
<%@page import="org.jfree.chart.ChartPanel"%>

<!DOCTYPE html >
<html>
<head>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<link rel='stylesheet'  href='css/bootstrap.min.css' type='text/css'  />
<script src="js/dateselect.js"></script>
</head>
<body>
	
	<form action="" method="post">
		时间：<input name="time" type="text" id="time"
			onfocus="datelist.dfd(this)" /> -<input name="time2" type="text"
			id="time2" onfocus="datelist.dfd(this)" /> <br /> <input name="yes"
			type="submit" value="Search" />
	</form>

	<%
	if (session != null && session.getAttribute("login") != null) {
		if (session.getAttribute("login").equals("ok")) {

			String ftime = request.getParameter("time");
			String endtime = request.getParameter("time2");
			
			
			Date toTime = new Date();
			Date fromTime = new Date();
			
			Calendar fromWhen =null;
			GregorianCalendar gc= null;
			
			if(ftime != null && endtime !=null){
				toTime = OAStatUtil.convertDate(endtime);
				fromTime = OAStatUtil.convertDate(ftime);
			}else{
				fromWhen = Calendar.getInstance();
				fromWhen.setTime(fromTime);
				gc = new GregorianCalendar(fromWhen
						.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH),
						fromWhen.get(Calendar.DAY_OF_MONTH));
				gc.add(Calendar.DATE, -1);
				toTime = (Date) gc.getTime();
				gc.add(Calendar.DATE, -15);
				fromTime = (Date) gc.getTime();
			}
			

			
			
			out.print("<h3>新用户</h3>");
			long j = 0;
			int result = 0;
			long flag = 0;
			out.print("<div class='container'>");
			out.print("<table class='table table-bordered table-hover table-condensed' >");
			out.print("<tr>");

			out.print("<th nowrap='nowrap'>");
			out.print("日期");
			out.print("</th>");

			for (int i = 0; i <= 7; i++) {
				out.print("<th nowrap='nowrap'>");
				out.print(i + "天停留率");
				out.print("</th>");
			}

			out.print("</tr>");
			
			Map<Date,Map<Integer,Double>> newUserReturnRateMap = WebSiteReport.getReturnRate(fromTime,toTime,"new");
			SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
			j = (toTime.getTime() - (new Date()).getTime())
					/ (1000 * 60 * 60 * 24);
			flag = (fromTime.getTime() - (new Date()).getTime())
					/ (1000 * 60 * 60 * 24);
			for (; j >= flag; j--) {
				if (-j % 2 == 1) {
					out.print("<tr >");
				} else {
					out.print("<tr class=\"bg\">");
				}

				Date fTime = OAStatUtil.getDate((int) j);
				Date tTime = OAStatUtil.getDate((int) j + 1);
				{
					//输出时间
					out.print("<td>");
					out.print(sdf.format(fTime));
					out.print("</td>");

					if(newUserReturnRateMap!=null&&newUserReturnRateMap.containsKey(fTime)){
						Map<Integer,Double> mapDate = newUserReturnRateMap.get(fTime);
						for (int i = 0; i <= 7; i++) {
							out.print("<td>");
							if(mapDate.containsKey(i)){
								out.print(mapDate.get(i));
							}else{
								out.print("");
							}
							out.print("</td>");
						}
					}else{
						for (int i = 0; i <= 7; i++) {
							out.print("<td>");
							out.print("");
							out.print("</td>");
						}
					}
					
					out.print("</td>");

				}
				out.print("</tr>");
			}
			out.print("</table>");
		}

	} else {
		response.sendRedirect("index.jsp");

	}
%>
</body>
</html>