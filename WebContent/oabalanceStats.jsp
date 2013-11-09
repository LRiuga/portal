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
	<h1>Sapphire:</h1>
	<br/>
	<script language="javascript" src='js/dateselect.js'></script>
	<div class='table'>
		<form action="" method="post">


			时间：<input name="time" type="text" id="time"
				onfocus="datelist.dfd(this)" readonly="readonly"/>
				-<input name="time2"
				type="text" id="time2" onfocus="datelist.dfd(this)" readonly="readonly"/>
			<br /> 
			过去一个月：<input name="time3" type="text" id="time3"
				onfocus="datelist.dfd(this)" readonly="readonly"/> <input name="yes"
				type="submit" value="查询" />
		</form>
	</div>
	<br/>


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

			//道具销售量统计表
			{
				Map<String,Set<String>> typeMap = OABalance.getAllItem(fromTime,toTime);
				Set<String> inSet = new HashSet<String>();
				inSet = typeMap.get("in");
				if(inSet.isEmpty()){
					inSet.add("未统计");
				}
				Set<String> outSet = new HashSet<String>();
				outSet = typeMap.get("out");
				if(outSet.isEmpty()){
					outSet.add("未统计");
				}
				
				int result = 0;
				out.print("<div class=\"table\">");
				out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");

				//打印道具名称
				out.print("<tr class=\"first\" width=\"177\">");
				out.print("<th rowspan=2>");
				out.print("日期");
				out.print("</th>");
				out.print("<th rowspan=2>");
				out.print("Sapphire总量");
				out.print("</th>");
				out.print("<th rowspan=2>");
				out.print("Sapphire产生");
				out.print("</th>");
				out.print("<th rowspan=2>");
				out.print("Sapphire支出");
				out.print("</th>");
				out.print("<th rowspan=1 colspan="+ inSet.size()*2 +">");
				out.print("产生");
				out.print("</th>");
				out.print("<th rowspan=1 colspan="+ outSet.size()*2 +">");
				out.print("支出");
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
				//打印销售量,打印一周的情况
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
									
					//输出时间
					out.print("<td>");
					out.print(sdf.format(fTime));
					out.print("</td>");
					Map<String,Map<String,Long>> dataMap = OABalance.getOneDayData(fTime);
					long allAmount = OABalance.getGoldAmount("all",fTime);
					long inAmount = OABalance.getGoldAmount("in",fTime);
					long outAmount = OABalance.getGoldAmount("out",fTime);
					{
						out.print("<td>");
						out.print(allAmount);
						out.print("</td>");
						
						out.print("<td>");
						out.print(inAmount);
						out.print("</td>");
						
						out.print("<td>");
						out.print(outAmount);
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
									out.print(OABalance.Output(dataMap.get("in").get(inType)*1.0/inAmount));
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
									out.print(OABalance.Output(dataMap.get("out").get(outType)*1.0/outAmount));
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