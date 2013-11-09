<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sun.java2d.pipe.SpanShapeRenderer.Simple"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="util.*"%>
<%@ page import="com.mozat.morange.util.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<%
	if(session==null||session.getAttribute("login")==null){
		response.sendRedirect("index.jsp");
	}
	
	String startTime = request.getParameter("time");
	String endTime = request.getParameter("time2");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df =  new DecimalFormat("####.##");
	
	if(startTime==null&&endTime==null){
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DATE, -1);
		endTime = sdf.format(c.getTime());
		
		c.add(Calendar.DATE, -7);
		startTime = sdf.format(c.getTime());
	}
	
	List<String> thList = new ArrayList<String>();
	List<String> th2List = new ArrayList<String>();
	for(int i = 2;i<=23;i++){
		thList.add("LV"+i);
	}
	
	
	for(int i = 3;i<=100;i++){
		th2List.add("LV"+i);
	}
	
	DBResultSet ds=DBUtil.db.execSQL("select oakey,oavalue,dtime from UpgradeShipyardTime where dtime >= ? and dtime <= ? order by dtime desc", new Object[]{startTime,endTime});
	List<String> ddateList = new ArrayList<String>();
	Map<String,String> resultMap = new HashMap<String,String>();
	Map<String,String> result2Map = new HashMap<String,String>();
	try{
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			if(!ddateList.contains(_time)){
				ddateList.add(_time);
			}
			resultMap.put(_time+"_"+ds.getString("oakey"), df.format(ds.getFloat("oavalue")));
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	ds=DBUtil.db.execSQL("select oakey,oavalue,dtime from UpgradePetTime where dtime >= ? and dtime <= ? order by dtime desc", new Object[]{startTime,endTime});
	try{
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			if(!ddateList.contains(_time)){
				ddateList.add(_time);
			}
			result2Map.put(_time+"_"+ds.getString("oakey"), df.format(ds.getFloat("oavalue")));
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	ds = DBUtil.db
			.execSQL("select time,tlevel,tdate from tribeleveltime where tdate >= ? and tdate <= ?  order by tdate desc ",
					new Object[] { startTime, endTime });
	Map<String, List<Float>> map = new HashMap<String, List<Float>>();
	List<String> thList1  = new ArrayList<String>();
	List<Date> dateList  = new ArrayList<Date>();
	try {
		while (ds.next()) {
			int level = ds.getInt("tlevel");
			Date date = ds.getDate("tdate");
			Float time = ds.getFloat("time");
			if(!thList1.contains(level + "")){
				thList1.add(level + "");
			}
			
			if(!dateList.contains(date)){
				dateList.add(date);
			}
			if(map.containsKey(level+date.toString())){
				List<Float> timeList = map.get(level+date.toString());
				timeList.add(time);
				map.put(level+""+date, timeList);
			}else{
				List<Float> timeList = new ArrayList<Float>();
				timeList.add(time);
				map.put(level+date.toString(), timeList);
			}
		}

	} catch (Exception e) {
		e.printStackTrace();
	}

%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>升级时间</h1>
	<h3>可选</h3>
	时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="查询" />
</form>
<h1>船厂升级时间</h1>
<table class="listing">
	<tr class="first">
		<th>日期</th>
		<% 
				for(String th : thList){
					out.println("<th>"+th+"</th>");
				}
			%>
	</tr>

	<%
			for(String time : ddateList){
				out.println("<tr>");
				out.println("<td>"+time+"</td>");
				for(String th : thList){
					out.println("<td>"+(resultMap.get(time+"_"+th)==null?"-":resultMap.get(time+"_"+th))+"</td>");
				}
				out.println("</tr>");
			}
		%>
</table>

<br>
<br>
<h1>宠物升级时间</h1>
<table class="listing" >
	<tr class="first" >
		<th>日期</th>
		<% 
				for(String th : th2List){
					out.println("<th>"+th+"</th>");
				}
			%>
	</tr>

	<%
			for(String time : ddateList){
				out.println("<tr>");
				out.println("<td>"+time+"</td>");
				for(String th : th2List){
					out.println("<td>"+(result2Map.get(time+"_"+th)==null?"-":result2Map.get(time+"_"+th))+"</td>");
				}
				out.println("</tr>");
			}
		%>
</table>

<br>
<br>
<table class="listing">
	<tr class="first">
		<th rowspan='2'>日期</th>
		<%
			Map<String,String> thMap = new HashMap<String,String>();
			thMap.put("2","LV2");
			thMap.put("3","LV3");
			thMap.put("4","LV4");
			for (String itemid : thList1) {
				out.println("<th colspan='4'>" + thMap.get(itemid) + "</th>");
			}
		%>
	</tr>
	<tr>
	<%
		for (String itemid : thList1) {
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
		for (String itemid : thList1) {
			
			List<Float> list = map.get(itemid + date.toString());
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
				<td><%=df.format(Collections.max(list)/60/60/24) %></td>
				<td><%=df.format(avg/60/60/24) %></td>
				<td><%=df.format(list.get(list.size()/2)/60/60/24) %></td>
				<td><%=df.format(Collections.min(list)/60/60/24) %></td>
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