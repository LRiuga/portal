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
java.util.*,OAStat.*,java.util.Date,java.text.*,userStats.*,toolStat.*"%>
<%@page import="org.jfree.chart.ChartPanel"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<style media="all" type="text/css">
@import "css/all.css";
</style>
</head>
<body>
	<h1>Gold:</h1>
	<br />
	<script language="javascript" src="js/dateselect.js"></script>
	<div class="table">
		<form action="" method="post">


			Date£º<input name="time" type="text" id="time"
				onfocus="datelist.dfd(this)" readonly="readonly" />-<input
				name="time2" type="text" id="time2" onfocus="datelist.dfd(this)"
				readonly="readonly" /> <br /> Last 30 days£º<input name="time3"
				type="text" id="time3" onfocus="datelist.dfd(this)"
				readonly="readonly" /> <input name="yes" type="submit"
				value="Search" />
		</form>
	</div>
	<br />


	<%
if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		out.print("<table>");
		String ftime = request.getParameter("time");
		String ttime = request.getParameter("time2");
		String time3 = request.getParameter("time3");

		{
			out.print("<br>");
			Date fromTime = new Date();
			Date toTime = new Date();
		if(ftime!=""&&ttime!=""){
			fromTime = OAStatUtil.convertDate(ftime);
			toTime = OAStatUtil.convertDate(ttime);
		}else if(time3!=""){
			toTime = OAStatUtil.convertDate(time3);
			fromTime = new Date(toTime.getTime()-1000*3600*24*15);
			fromTime = new Date(fromTime.getTime()-1000*3600*24*15);
		}else if(time3==""){
			Date date = new Date();
			Calendar fromWhen = Calendar.getInstance();
			fromWhen.setTime(date);
			GregorianCalendar gc = new GregorianCalendar(fromWhen
					.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
					.get(Calendar.DAY_OF_MONTH));
			date = (Date) gc.getTime();
			gc.add(Calendar.DATE, -1);
			toTime = (Date) gc.getTime();
			fromTime = new Date(toTime.getTime()-1000*3600*24*15);
			fromTime = new Date(fromTime.getTime()-1000*3600*24*15);
		}
		
		if((ftime==""||ftime==null)&&(ttime==""||ttime==null)&&(time3==""||time3==null)){
				fromTime = new Date();
				Calendar fromWhen = Calendar.getInstance();
				fromWhen.setTime(fromTime);
				GregorianCalendar gc = new GregorianCalendar(fromWhen
						.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
						.get(Calendar.DAY_OF_MONTH));
				gc.add(Calendar.DATE, -1);
				toTime = (Date) gc.getTime();
				gc.add(Calendar.DATE, -15);
				gc.add(Calendar.DATE, -15);
				fromTime = (Date) gc.getTime();
			}

		out.print("</table>");
		out.print("<table>");

			long j, k;
			{
				Map<String,Set<String>> typeMap = GoldStats.getAllItem(fromTime,toTime);
				Set<String> inSet = new HashSet<String>();
				inSet = typeMap.get("in");
				if(inSet.isEmpty()){
					inSet.add(" ");
				}
				Set<String> outSet = new HashSet<String>();
				outSet = typeMap.get("out");
				if(outSet.isEmpty()){
					outSet.add(" ");
				}
				
				int result = 0;
				out.print("<div class=\"table\">");
				out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");

				out.print("<tr class=\"first\" width=\"177\">");
				out.print("<th rowspan=2>");
				out.print("Date");
				out.print("</th>");
				out.print("<th rowspan=2>");
				out.print("Gold Stock");
				out.print("</th>");
				out.print("<th rowspan=2>");
				out.print("Produce");
				out.print("</th>");
				out.print("<th rowspan=2>");
				out.print("Consume");
				out.print("</th>");
				out.print("<th rowspan=1 colspan="+ inSet.size()*2 +">");
				out.print("Produce");
				out.print("</th>");
				out.print("<th rowspan=1 colspan="+ outSet.size()*2 +">");
				out.print("Consume");
				out.print("</th>");
				out.print("</tr>");
				
				out.print("<tr>");
				for(String inType:inSet){
					out.print("<th rowspan=1 colspan=2>");
					out.print(inType);
					out.print("</th>");
				}
				for(String outType:outSet){
					out.print("<th rowspan=1 colspan=2>");
					out.print(outType);
					out.print("</th>");
				}
				out.print("</tr>");
				
				SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
				j = (toTime.getTime()-(new Date()).getTime())/(1000*60*60*24);

				long flag = (fromTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
				for (; j >= flag; j--) {
					if(-j%2 == 1){
						out.print("<tr >");
					}else{
						out.print("<tr class=\"bg\">");
					}

					Date fTime = OAStatUtil.getDate((int)j);
					Date tTime = OAStatUtil.getDate((int)j+1);
									
					out.print("<td>");
					out.print(sdf.format(fTime));
					out.print("</td>");
					Map<String,Map<String,Long>> dataMap = GoldStats.getOneDayData(fTime);
					long allAmount = GoldStats.getGoldAmount("all",fTime);
					long inAmount = GoldStats.getGoldAmount("in",fTime);
					long outAmount = GoldStats.getGoldAmount("out",fTime);
					{
						out.print("<td>");
						if(allAmount>0){
							out.print(allAmount);						
						}else{
							out.print("");	
						}
						out.print("</td>");
						
						out.print("<td>");
						if(inAmount>0){
							out.print(inAmount);
						}else{
							out.print("");	
						}
						out.print("</td>");
						
						out.print("<td>");
						if(outAmount>0){
							out.print(outAmount);
						}else{
							out.print("");						
						}
						out.print("</td>");
						
						for(String inType:inSet){
							out.print("<td colspan=1>");
							if(dataMap.containsKey("in")){
								if(dataMap.get("in").containsKey(inType)){
									out.print(dataMap.get("in").get(inType));
								}else{
									out.print("");
								}
							}else{
								out.print("");
							}
							out.print("</td>");
							
							out.print("<td>");
							if(dataMap.containsKey("in")){
								if(dataMap.get("in").containsKey(inType)){
									out.print(GoldStats.Output(dataMap.get("in").get(inType)*1.0/inAmount*100.0) + "%");
								}else{
									out.print("");
								}
							}else{
								out.print("");
							}
							out.print("</td>");
						}
						for(String outType:outSet){
							out.print("<td colspan=1>");
							if(dataMap.containsKey("out")){
								if(dataMap.get("out").containsKey(outType)){
									out.print(dataMap.get("out").get(outType));
								}else{
									out.print("");
								}
							}else{
								out.print("");
							}
							out.print("</td>");
							
							out.print("<td>");
							if(dataMap.containsKey("out")){
								if(dataMap.get("out").containsKey(outType)){
									out.print(GoldStats.Output(dataMap.get("out").get(outType)*1.0/outAmount*100.0) + "%");
								}else{
									out.print("");
								}
							}else{
								out.print("");
							}
							out.print("</td>");
						}
					}
					out.print("</tr>");
				}
				out.print("</table>");
				out.print("</div>");
			}
			out.print("</table>");
		}
	}
}else{
	response.sendRedirect("index.jsp");
}
%>
</body>
</html>