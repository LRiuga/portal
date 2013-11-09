<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sun.java2d.pipe.SpanShapeRenderer.Simple"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.mozat.morange.util.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<%
	String startTime = request.getParameter("time");
	String endTime = request.getParameter("time2");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df2 = new DecimalFormat("###.00");
	if (startTime == null && endTime == null) {
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DATE, -1);
		endTime = sdf.format(c.getTime());

		c.add(Calendar.DATE, -7);
		startTime = sdf.format(c.getTime());
	}


	DBResultSet ds = DBUtil.db
			.execSQL("select time,tlevel,tdate from tribeleveltime where tdate >= ? and tdate <= ?  order by tdate desc ",
					new Object[] { startTime, endTime });
	Map<String, List<Float>> map = new HashMap<String, List<Float>>();
	List<String> thList  = new ArrayList<String>();
	List<Date> dateList  = new ArrayList<Date>();
	try {
		while (ds.next()) {
			int level = ds.getInt("tlevel");
			Date date = ds.getDate("tdate");
			Float time = ds.getFloat("time");
			if(!thList.contains(level + "")){
				thList.add(level + "");
			}
			
			if(!dateList.contains(date)){
				dateList.add(date);
			}
			if(map.containsKey("["+level+"]"+date.toString())){
				List<Float> timeList = map.get("["+level+"]"+date.toString());
				timeList.add(time);
				map.put(level+""+date, timeList);
			}else{
				List<Float> timeList = new ArrayList<Float>();
				timeList.add(time);
				map.put("["+level+"]"+date.toString(), timeList);
			}
		}

	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<h1>家族的升级时间</h1>
<form action="" method="post">
	<h3>可选</h3>
	时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="查询" />
</form>
<br />
<br />



<table class="listing">
	<tr class="first">
		<th rowspan='2'>日期</th>
		<%
			Map<String,String> thMap = new HashMap<String,String>();
			thMap.put("2","LV2");
			thMap.put("3","LV3");
			thMap.put("4","LV4");
			for (String itemid : thList) {
				out.println("<th colspan='4'>" + thMap.get(itemid) + "</th>");
			}
		%>
	</tr>
	<tr>
	<%
		for (String itemid : thList) {
			out.println("<th>最大值</th>");
			out.println("<th>平均值</th>");
			out.println("<th>中位数</th>");
			out.println("<th>最小值</th>");
		}
	%>
	</tr>
	<%
		for (Date date : dateList) {
	%>
	<tr>
		<td><%=date.toString().substring(0, 10)%></td>
	<% 
		for (String itemid : thList) {
			List<Float> list = map.get(thList + date.toString());
			if(list == null ){
			%>
				<td>-</td>
				<td>-</td>
				<td>-</td>
				<td>-</td>
			<% 
			}else {
				Collections.sort(list);
				float avg = getAvg(list);
			%>
				<td><%=df2.format(Collections.max(list)/60/60/24) %></td>
				<td><%=df2.format(avg/60/60/24) %></td>
				<td><%=df2.format(list.get(list.size()/2)/60/60/24) %></td>
				<td><%=df2.format(Collections.min(list)/60/60/24) %></td>
			<% 
				
			}
		}
	%>
	</tr>
	<%
		}
	%>
	
	<%! 
	public float getAvg(List<Float> lst){
		float sum = 0.0f;
		for(float i : lst){
			sum += i;
		}
		return sum/lst.size();
	}
	%>
</table>
</html>