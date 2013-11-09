<%@ page contentType="text/html;charset=UTF-8"%>

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
<%@page import="OAStat.OAStatistic"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
</head>
<body>
	<%
	ResourceBundle languageType = ResourceBundle.getBundle("system");
	ResourceBundle enType = ResourceBundle.getBundle(languageType.getString("language"));
	String limitString = session.getAttribute("limit").toString();
	if(limitString!=null){
		if(limitString.equals("3")){
			enType = ResourceBundle.getBundle("English");
		}
	}
 %>

	<h1><%=enType.getString("subtitle.items_purchased") %>:
	</h1>
	<a href="sellingCredit.jsp?Action=DownloadExcel"><img
		src="images/Excel.gif" width="24" height="23" /><%=enType.getString("link.download_excel") %></a>
	<br>
	<br>
	<script type="text/javascript" src="js/dateselect.js"></script>
	<div class="table">
		<form action="" method="post">
			<%=enType.getString("date") %>：<input name="time" type="text"
				id="time" onfocus="datelist.dfd(this)" readOnly>-<input
				name="time2" type="text" id="time2" onfocus="datelist.dfd(this)"
				readOnly> <br />
			<%=enType.getString("notice.Last30days") %>：<input name="time3"
				type="text" id="time3" onfocus="datelist.dfd(this)" readOnly>
			<input name="yes" type="submit"
				value=<%=enType.getString("search") %> />
		</form>
	</div>
	<br>
	<%
String graphURL = "";
String filename = "";
if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		String action = request.getParameter("Action");
		if(action!=null&&action.equals("DownloadExcel")){
			response.setHeader("Content-disposition", "attachment; filename=CreditSales.xls");
		}
	
		ArrayList<Date> dayList = new ArrayList<Date>();
		java.util.Map<Date, Double> selling = new java.util.HashMap<Date, Double>();
		java.util.Map<Date, Double> weapon = new java.util.HashMap<Date, Double>();
		String ftime = request.getParameter("time");
		String ttime = request.getParameter("time2");
		String time3 = request.getParameter("time3");
		
		ArrayList<String> shopItemList = OAStatistic.getShopItem();
		
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
			GregorianCalendar gc = new GregorianCalendar(fromWhen.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen.get(Calendar.DAY_OF_MONTH));
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
			GregorianCalendar gc = new GregorianCalendar(fromWhen.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen.get(Calendar.DAY_OF_MONTH));
			gc.add(Calendar.DATE, -1);
			toTime = (Date) gc.getTime();
			gc.add(Calendar.DATE, -15);
			gc.add(Calendar.DATE, -15);
			fromTime = (Date) gc.getTime();
		}
		
			out.print("<table>");
			ArrayList<String> NewItemName = new ArrayList<String>();
			
			java.util.Map<String, Integer> itemSell = new java.util.HashMap<String, Integer>();
			java.util.Map<String, Double> itemCredit = new java.util.HashMap<String,Double>();

			long j, k;

			int result = 0;
			out.print("<div class=\"table\">");
			out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
			out.print("<tr class=\"first\" width=\"177\">");
			out.print("<th>");
			out.print(enType.getString("item"));
			out.print("</th>");
			out.print("<th>");
			out.print(enType.getString("sales"));
			out.print("</th>");
			out.print("<th>");
			out.print(enType.getString("customer")+shopItemList.size());
			out.print("</th>");
			
			for (String item : shopItemList) {
				out.print("<th>");
				out.print(item);
				NewItemName.add(item);
				out.print("</th>");
			}
			
			out.print("</tr>");
			
			DecimalFormat dfint = new DecimalFormat("0");
			DecimalFormat df = new DecimalFormat("0.00");
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

				itemSell = OAStats_local.getSellingFromAtoB(fTime,tTime);
				itemCredit = OAStats_local.getCreditFromAtoB(fTime,tTime);
				
				out.print("<td>");
				out.print(df.format(OAStatUtil.getTypeSelling(itemCredit,"All")));
				dayList.add(fTime);
				selling.put(fTime,OAStatUtil.getTypeSelling(itemCredit,"All"));
				out.print("</td>");
				out.print("<td class=\"last\">");
				out.print(dfint.format(DailyReport.getPaymentUser(fTime)));
				out.print("</td>");
				
				for (int i = 0; i <= NewItemName.size()-1; i++) {
					out.print("<td >");
					if(itemSell.get(NewItemName.get(i)) == null || itemSell.get(NewItemName.get(i)) == 0){
						out.print("0");
					}else{
						out.print("<a href = \"CreditDetail.jsp?itemName=" + NewItemName.get(i) + "&" + "fromTime=" + OAStatUtil.DateConvert(fTime) + "\">" + itemSell.get(NewItemName.get(i)) + "</a>" );
					}
					out.print("</td>");
				}
				out.print("</tr>");
			}
			out.print("</table>");
			out.print("</div>");
			
			if(dayList.size()!=0){
				TimeSeries timeSeries = new TimeSeries("Total",Day.class);
				TimeSeries timeSeries_weapon = new TimeSeries("Attack",Day.class);
				TimeSeriesCollection lineDataset = new TimeSeriesCollection();
				for(Date day:dayList){
					timeSeries.add(new Day(day.getDate(),day.getMonth()+1,day.getYear()+1900),selling.get(day));
					timeSeries_weapon.add(new Day(day.getDate(),day.getMonth()+1,day.getYear()+1900),weapon.get(day));
				}
				lineDataset.addSeries(timeSeries_weapon);
				lineDataset.addSeries(timeSeries);
				JFreeChart chart = ChartFactory.createTimeSeriesChart("selling-time", "date", "selling(SAR)", lineDataset, true, true, true);
				TextTitle subtitle = new TextTitle("Sales", new Font("黑体", Font.BOLD, 12));
				chart.addSubtitle(subtitle);
				chart.setTitle(new TextTitle("Sales Stats", new Font("隶书", Font.ITALIC, 15)));
				chart.setAntiAlias(true);
				ChartPanel panel =  new ChartPanel(chart);
				panel.setMaximumDrawWidth(2000);
				panel.setMaximumDrawHeight(1000);
				filename = ServletUtilities.saveChartAsPNG(chart, 500, 300, null, session);
				graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;
			}
		out.print("</table>");
	}
}else{
	response.sendRedirect("index.jsp");
}
%>
	<img src="<%= graphURL %>" width=500 height=300 border=0
		usemap="#<%= filename %>">
</body>
</html>