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
java.util.*,OAStat.*,java.util.Date,java.text.*,userStats.*,billingStat.*,com.mozat.morange.util.DBResultSet,util.*"%>
<%@page import="org.jfree.chart.ChartPanel"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<style media="all" type="text/css">
@import "css/all.css";
</style>
</head>
<body>

	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"
		type="text/javascript"></script>
	<script src="js/highcharts.js" type="text/javascript"></script>
	<script type="text/javascript"> 
<%
	ArrayList<String> dateList = RealtimeSearch.getCCUList_Realtime();
	Map<String,Integer> dateMap = RealtimeSearch.getCCU_Realtime();
	if(dateList.size()>0){
		out.print("");
	}
%>	

$(function () {
    var chart;
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'container',
                type: 'line'
            },
            title: {
                text: <%	
							out.print("'"+"CCU"+"'");
                		%>
            },
            subtitle: {
                text: 'Source: oastat.admin.zoota.vn'
            },
            xAxis: {
                categories: [
					<%
						
						DecimalFormat dfdouble = new DecimalFormat("0.00");
						Date fTime = new Date();
						Date tTime = new Date();
						
						StringBuffer sb = new StringBuffer();	
						if(dateList.size()>0){
							for(int i=dateList.size()-690;i<=dateList.size()-1;i++){
								if(i%30==0){
									sb.append("'"+dateList.get(i)+"'");
									sb.append(",");
								}
							}
						}
						if(sb.length()>0){
							out.print(sb.substring(0,sb.length()-1));
						}
					%>
				]
            },
            yAxis: {
                title: {
                    text: 'User '
                }
            },
            tooltip: {
                enabled: true,
                formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                        this.x +': '+ this.y +' ';
                }
            },
            plotOptions: {
                line: {
                    dataLabels: {
                        enabled: true
                    },
                    enableMouseTracking: true
                }
            },
            series: [
	                <%     
	                	out.print("{");            
	                	out.print(" name: '"+"CCU"+"', ");
	                	out.print("data: [");
	                	
	                	sb = new StringBuffer();
	                	if(dateList.size()>0){
		                    for(int ii=dateList.size()-690;ii<=dateList.size()-1;ii++){
		                   		if(ii%30==0){
			                    	if(dateMap.containsKey(dateList.get(ii))){
			                     		sb.append(dateMap.get(dateList.get(ii)));
			                     		sb.append(",");
			                    	}else{
			                    		sb.append("0");
			                     		sb.append(",");
			                    	}
		                    	}
		                    } 
		                }
	                    if(sb.length()>0){
							out.print(sb.substring(0,sb.length()-1));	                    
	                    }
	                    out.print("]");
                		out.print("}");
	                %>	   
            	]
        });
    });
});
</script>
	<br/>
	<br/>
	<div>
		<%

if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		String action = request.getParameter("Action");
		if(action!=null&&action.equals("DownloadExcel")){
			response.setHeader("Content-disposition", "attachment; filename=CurrentSelling.xls");
		}
		
		ResourceBundle languageType = ResourceBundle.getBundle("system");
		ResourceBundle enType = ResourceBundle.getBundle(languageType.getString("language"));
		String limitString = session.getAttribute("limit").toString();
		if(limitString!=null){
			if(limitString.equals("3")){
				enType = ResourceBundle.getBundle("English");
			}
		}
		
		out.print("<h1>"+"Realtime Search"+"</h1>");
	
		Date date = new Date();
		Calendar fromWhen = Calendar.getInstance();
		fromWhen.setTime(new Date());
		GregorianCalendar gc = new GregorianCalendar(fromWhen
				.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
				.get(Calendar.DAY_OF_MONTH));
		gc.add(Calendar.DATE, 0);
		date = (Date) gc.getTime();
		ArrayList<String> unsovle = new ArrayList<String>();
		Map<String,Set<String>> typeMap = RealtimeSearch.getShopItemType();
//		Map<String,String> shopitemNameMap = RealtimeSearch.getShopItemName();
		Map<String,Integer> itemsMap = RealtimeSearch.getBuybyCreditItems();
		Map<String,Integer> priceMap = RealtimeSearch.getShopItemPrice();
		int money = 0;
		Set<String> itemSet = itemsMap.keySet();
		for(String item:itemSet){
			if(priceMap.containsKey(item)){
				money += priceMap.get(item)*itemsMap.get(item);
			}else{
				unsovle.add(item);	
			}
		}
/*
		for(String item:itemsList){
			String name = MyUtil.getValueOfKey(item,"itemName",",").toLowerCase();
			if(priceMap.containsKey(name)){
				money += priceMap.get(name);
				String type = MyUtil.getValueOfKey(item,"itemType",",");
				if(typeMap.containsKey(type)){
					Map<String,Integer> countMap = typeMap.get(type);
					if(countMap.containsKey(name)){
						countMap.put(name,countMap.get(name)+1);
					}else{
						countMap.put(name,1);
					}
				}else{
					Map<String,Integer> countMap = new HashMap<String,Integer>();
					countMap.put(name,1);
					typeMap.put(type,countMap);
				}
			}else{
				unsovle.add(name+"!");
			}
		}
*/
		DecimalFormat df = new DecimalFormat("0.00");
		{
			out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");

			out.print("<tr class=\"first\" width=\"177\">");
			out.print("<th colspan=3>");
			out.print("Top up");
			out.print("</th>");
			out.print("<th colspan=2>");
			out.print("Purchasing");
			out.print("</th>");
			out.print("<th rowspan=2>");
			out.print("New users");
			out.print("</th>");
			out.print("</tr>");
			
			out.print("<tr>");
			out.print("<td colspan=1>");
			out.print("Total(SAR)");
			out.print("</td>");
			out.print("<td colspan=1>");
			out.print("Total(Sapphire)");
			out.print("</td>");
			out.print("<td colspan=1>");
			out.print("User");
			out.print("</td>");
			out.print("<td colspan=1>");
			out.print("Total");
			out.print("</td>");
			out.print("<td colspan=1>");
			out.print("User");
			out.print("</td>");
			out.print("</tr>");
			
			out.print("<tr>");
			int topup = 0;
			topup = RealtimeSearch.getTopupAmount();
			out.print("<td colspan=1>");
			out.print(topup);
			out.print("</td>");
			out.print("<td colspan=1>");
			out.print(topup*5);
			out.print("</td>");
			out.print("<td colspan=1>");
			int topupuser = 0;
			topupuser = RealtimeSearch.getTopupUser();
			if(topupuser>0){
				out.print(topupuser);
			}else{
			
			}
			out.print("</td>");
			out.print("<td colspan=1>");
			out.print(money);
			out.print("</td>");
			out.print("<td colspan=1>");
			out.print(RealtimeSearch.getBuybyCreditUser());
			out.print("</td>");
			out.print("<td>");
			out.print(RealtimeSearch.getNewUser());
			out.print("</td>");
			out.print("</tr>");
			
			out.print("</table>");
		}
		
		/* if(unsovle.size()>0){
			for(String name:unsovle){
				out.println(name);
			}
		} */
		out.print("<br>");	
		out.print("<h2>"+"Sales detail"+"</h2>");		
		{
			if(typeMap!=null&&!typeMap.isEmpty()){
				Set<String> typeSet = typeMap.keySet();
				
				for(String type:typeSet){
					out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
					out.print("<tr class=\"first\" width=\"177\">");
					out.print("<th>");
					out.print(type);
					out.print("</th>");
					
					Set<String> nameSet = typeMap.get(type);
					List<String> list = new ArrayList<String>();
					for(String item:nameSet){
						list.add(item);
					}
					Collections.sort(list);
					for(String item:list){
						out.print("<th>");
						out.print(item);
						out.print("</th>");
					}
					out.print("</tr>");
					
					out.print("<tr>");
					out.print("<td>");
					out.print("Count");
					out.print("</td>");
					for(String item:list){
						out.print("<td>");
						if(itemsMap.containsKey(item)){
							out.print(itemsMap.get(item));
						}else{
							out.print("");
						}
						out.print("</td>");
					}
					out.print("</tr>");
					out.print("</table>");
					out.print("<br>");
				}
				
			}
		}
	}
}else{
	response.sendRedirect("index.jsp");
}
%>
	</div>
	<br />
	<div id="container"
		style="min-width: 400px; height: 400px; margin: 0 auto"></div>
</body>
</html>