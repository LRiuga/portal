<%@page import="util.MyUtil"%>
<%@ page contentType="text/html;charset=GBK"%>

<%@ page
	import="org.jfree.chart.ChartFactory,org.jfree.chart.JFreeChart,org.jfree.chart.servlet.ServletUtilities,org.jfree.chart.title.TextTitle,org.jfree.data.time.TimeSeries,org.jfree.data.time.Month,org.jfree.data.time.Day,org.jfree.data.time.TimeSeriesCollection,java.awt.Font,java.util.*,OAStat.*,java.util.Date,java.text.*,userStats.*,login.*"%>
<%@page import="org.jfree.chart.ChartPanel"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<style media="all" type="text/css">
@import "css/all.css";
</style>
</head>
<body>
	<script language="javascript" src="js/dateselect.js"></script>
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
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			
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
			
			System.out.println(toTime + "|" + fromTime);
			
			//日期list
			ArrayList<Date> dayList = new ArrayList<Date>();
			//total销售量MAP
			java.util.Map<Date, Double> selling = new java.util.HashMap<Date, Double>();

			out.print("<table>");
			
			

			//DAU
			Map<Date, Double> dauMap = new HashMap<Date, Double>();
			Map<Date, Double> rdauMap = new HashMap<Date, Double>();
			Map<Date, Integer> dauExceptionMap = new HashMap<Date, Integer>();
			
			//new user
			Map<Date, Double> newUserMap = new HashMap<Date, Double>();
			Map<Date, Integer> newUserExceptionMap = new HashMap<Date, Integer>();

			//销售
			Map<Date, Double> sellingMap = new HashMap<Date, Double>();
			Map<Date, Integer> sellingExceptionMap = new HashMap<Date, Integer>();

			//准备数据
			{
				long j;
				j = (toTime.getTime() - (new Date()).getTime())
						/ (1000 * 60 * 60 * 24);
				long flag = (fromTime.getTime() - (new Date())
						.getTime())
						/ (1000 * 60 * 60 * 24);
				for (; j >= flag; j--) {
					Date fTime = OAStatUtil.getDate((int) j);
					Date tTime = OAStatUtil.getDate((int) j + 1);

					sellingMap.put(fTime, WebSiteReport.getDailyValue(fTime, "DailySelling"));
					dauMap.put(fTime, WebSiteReport.getDailyValue(fTime, "DAU"));
					newUserMap.put(fTime, WebSiteReport.getDailyValue(fTime, "newUserDB"));
					rdauMap.put(fTime, WebSiteReport.getDailyValue(fTime, "RDAU"));
				}
				sellingExceptionMap = OAStatUtil.checkExceptionValue(sellingMap);
				dauExceptionMap = OAStatUtil.checkExceptionValue(dauMap);
				newUserExceptionMap = OAStatUtil.checkExceptionValue(newUserMap);
			}

			{
				out.print("</table>");
				

				long j;
				int result = 0;
				out.print("<div class=\"table\">");
				out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");

				out.print("<tr class=\"first\" width=\"177\">");
				out.print("<th nowrap='nowrap'>");
				out.print("日期");
				out.print("</th>");

				out.print("<th nowrap='nowrap'>");
				out.print("DAU");
				out.print("</th>");
				
				out.print("<th nowrap='nowrap'>");
				out.print("登陆成功");
				out.print("</th>");
				
				out.print("<th nowrap='nowrap'>");
				out.print("新用户数");
				out.print("</th>");

				out.print("<th nowrap='nowrap'>");
				out.print("MAU");
				out.print("</th>");
				
				out.print("<th nowrap='nowrap'>");
				out.print("历史用户");
				out.print("</th>");

				out.print("<th nowrap='nowrap'>");
				out.print("销售");
				out.print("</th>");

				out.print("<th nowrap='nowrap'>");
				out.print("付费人数");
				out.print("</th>");
				
				out.print("<th nowrap='nowrap'>");
				out.print("日充值人数");
				out.print("</th>");
				
				out.print("<th nowrap='nowrap'>");
				out.print("月充值人数");
				out.print("</th>");
				
				out.print("<th nowrap='nowrap'>");
				out.print("日充值金额");
				out.print("</th>");
				
				out.print("<th nowrap='nowrap'>");
				out.print("月充值金额");
				out.print("</th>");

				out.print("<th nowrap='nowrap'>");
				out.print("ARPU");
				out.print("</th>");
				
				out.print("<th nowrap='nowrap'>");
				out.print("ARPPU");
				out.print("</th>");
				
				out.print("<th nowrap='nowrap'>");
				out.print("平均在线人数");
				out.print("</th>");
				
				out.print("<th nowrap='nowrap'>");
				out.print("最高在线人数");
				out.print("</th>");
				
				out.print("<th nowrap='nowrap'>");
				out.print("用户在线时长");
				out.print("</th>");
				
				out.print("<th nowrap='nowrap'>");
				out.print("渗透率");
				out.print("</th>");

				out.print("</tr>");

				sdf = new SimpleDateFormat("MM-dd");

				//打印销售量,打印一周的情况
				j = (toTime.getTime() - (new Date()).getTime())
						/ (1000 * 60 * 60 * 24);
				DecimalFormat dfdouble = new DecimalFormat("0.00");
				DecimalFormat dfint = new DecimalFormat("0");
				long flag = (fromTime.getTime() - new Date().getTime())/ (1000 * 60 * 60 * 24);
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

						out.print("<td>");
						if (dauMap.get(fTime) == 0) {
							out.print("");
						} else {
							if (dauExceptionMap.get(fTime) == 1) {
								out.print("<font color=\"#FF0000\">");
								out.print(dfint.format(dauMap.get(fTime)));
								out.print("</font>");
							} else if (dauExceptionMap.get(fTime) == 2) {
								out.print("<font color=\"#00FF00\">");
								out.print(dfint.format(dauMap
										.get(fTime)));
								out.print("</font>");
							} else {
								out.print(dauMap.get(fTime));
							}
						}
						out.print("</td>");
						out.print("<td>");
						out.print((rdauMap.get(fTime)==null?"-":rdauMap.get(fTime)));
						out.print("</td>");
						out.print("<td>");
						if (newUserMap.get(fTime) == 0) {
							out.print("");
						} else {
							if (newUserMap.get(fTime) == 1) {
								out.print("<font color=\"#FF0000\">");
								out.print(dfint.format(newUserMap.get(fTime)));
								out.print("</font>");
							} else if (newUserMap.get(fTime) == 2) {
								out.print("<font color=\"#00FF00\">");
								out.print(dfint.format(newUserMap.get(fTime)));
								out.print("</font>");
							} else {
								out.print(newUserMap.get(fTime));
							}
						}
						out.print("</td>");

						out.print("<td>");
						double mau = WebSiteReport.getDailyValue(fTime,
								"MAU");
						if (mau == 0) {
							out.print("");
						} else {
							out.print(dfint.format(mau));
						}
						out.print("</td>");
						
						out.print("<td>");
						double histroyUsers = WebSiteReport.getDailyValue(fTime,
								"FisherAmount");
						if (mau == 0) {
							out.print("");
						} else {
							out.print(dfint.format(histroyUsers));
						}
						out.print("</td>");

						out.print("<td>");
						if (sellingMap.get(fTime) == 0) {
							out.print("");
						} else {
							if (sellingExceptionMap.get(fTime) == 1) {
								out.print("<font color=\"#FF0000\">");
								out.print(sellingMap.get(fTime));
								out.print("</font>");
							} else if (sellingExceptionMap.get(fTime) == 2) {
								out.print("<font color=\"#00FF00\">");
								out.print(sellingMap.get(fTime));
								out.print("</font>");
							} else {
								out.print(sellingMap.get(fTime));
							}
						}
						out.print("</td>");

						out.print("<td>");
						double paymentuser = WebSiteReport.getDailyValue(fTime, "PaymentUser");
						if (paymentuser == 0) {
							out.print("");
						} else {
							out.print(dfint.format(paymentuser));
						}
						out.print("</td>");
						
						out.print("<td>");
						double TopUpUsers = WebSiteReport
								.getDailyValue(fTime, "TopUpUsers");
						if (TopUpUsers == 0) {
							out.print("");
						} else {
							out.print(dfint.format(TopUpUsers));
						}
						out.print("</td>");
						
						out.print("<td>");
						double TopUpUsers30 = WebSiteReport.getDailyValue(fTime, "TopUpUsers30");
						if (TopUpUsers30 == 0) {
							out.print("");
						} else {
							out.print(dfint.format(TopUpUsers30));
						}
						out.print("</td>");
						
						out.print("<td>");
						double TopUpAmount = WebSiteReport
								.getDailyValue(fTime, "TopUpAmount");
						if (TopUpAmount == 0) {
							out.print("");
						} else {
							out.print(dfint.format(TopUpAmount));
						}
						out.print("</td>");
						
						out.print("<td>");
						double TopUpAmount30 = WebSiteReport
								.getDailyValue(fTime, "TopUpAmount30");
						if (TopUpAmount30 == 0) {
							out.print("");
						} else {
							out.print(dfint.format(TopUpAmount30));
						}
						out.print("</td>");

						out.print("<td>");
						double ARPU = WebSiteReport.getDailyValue(
								fTime, "ARPU");
						if (ARPU == 0) {
							out.print("");
						} else {
							out.print(dfdouble.format(ARPU));
						}
						out.print("</td>");
						
						out.print("<td>");
						double ARPPU = WebSiteReport.getDailyValue(
								fTime, "ARPPU");
						if (ARPPU == 0) {
							out.print("");
						} else {
							out.print(dfdouble.format(ARPPU));
						}
						out.print("</td>");
						
						out.print("<td>");
						double avrgUsers = WebSiteReport.getDailyValue(
								fTime, "avrgUsers");
						if (avrgUsers == 0) {
							out.print("");
						} else {
							out.print(dfint.format(avrgUsers));
						}
						out.print("</td>");
						
						out.print("<td>");
						double maxUsers = WebSiteReport.getDailyValue(
								fTime, "maxUsers");
						if (maxUsers == 0) {
							out.print("");
						} else {
							out.print(dfint.format(maxUsers));
						}
						out.print("</td>");
						
						out.print("<td>");
						double userTime = WebSiteReport.getDailyValue(
								fTime, "userTime");
						if (userTime == 0) {
							out.print("");
						} else {
							out.print(dfdouble.format(userTime));
						}
						out.print("</td>");
			
						out.print("<td>");
						double Permeability = WebSiteReport.getDailyValue(
								fTime, "Permeability");
						if (Permeability == 0) {
							out.print("");
						} else {
							out.print(dfdouble.format(Permeability));
						}
						out.print("</td>");
					}

					out.print("</tr>");
				}
				out.print("</table>");
			}
			out.print("</table>");
	
			out.print("<br>");
			out.print("<h3>全用户</h3>");
			long j;
			int result = 0;
			out.print("<div class=\"table\">");
			out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
			out.print("<tr class=\"first\" width=\"177\">");

			out.print("<th nowrap='nowrap'>");
			out.print("日期");
			out.print("</th>");

			for (int i = 0; i <= 7; i++) {
				out.print("<th nowrap='nowrap'>");
				out.print(i + "天停留率");
				out.print("</th>");
			}

			out.print("</tr>");
			
			fromTime = new Date(fromTime.getTime()-1000*3600*24*7);
			sdf = new SimpleDateFormat("MM-dd");
			Map<Date,Map<Integer,Double>> returnRateMap = WebSiteReport.getReturnRate(fromTime,toTime,"all");

			//打印销售量,打印一周的情况
			j = (toTime.getTime() - (new Date()).getTime())
					/ (1000 * 60 * 60 * 24);
			DecimalFormat dfdouble = new DecimalFormat("0.00");
			DecimalFormat dfint = new DecimalFormat("0");
			long flag = (fromTime.getTime() - (new Date()).getTime())
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

					if(returnRateMap!=null&&returnRateMap.containsKey(fTime)){
						Map<Integer,Double> mapDate = returnRateMap.get(fTime);
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