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
	Map<String,Integer> dataMap=new HashMap<String,Integer>();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	
	DecimalFormat df =  new DecimalFormat("####.##");
	
	String startTime = request.getParameter("time");
	try{
		
		if(startTime==null){
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DATE, -1);
			startTime = sdf.format(c.getTime());
		}

		DBResultSet ds=DBUtil.db.execSQL("select * from(select row_number() over(order by todayPay desc) as rowNum,monetid,todayPay,hisPay,dtime from (select * from top10Payment where dtime = ?) q ) as t", new Object[]{startTime});
		while(ds.next()){
			dataMap.put(ds.getInt("rowNum")+"_monetid", ds.getInt("monetid"));
			dataMap.put(ds.getInt("rowNum")+"_todayPay", ds.getInt("todayPay"));
			dataMap.put(ds.getInt("rowNum")+"_hisPay", ds.getInt("hisPay"));
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>

<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>
		付费前十用户
		<%out.print(startTime); %>
	</h1>
	<h3>可选</h3>
	时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> <br> <input name="yes" type="submit"
		value="查询" />
</form>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th>排名</th>
		<th>monetid</th>
		<th>当天付费</th>
		<th>历史付费</th>
	</tr>
	<%
			for(int i= 1;i<=10;i++){
				out.println("<tr>");
				out.println("<td>"+i+"</td>");
				out.println("<td>"+(dataMap.get(i+"_monetid")==null?"-":dataMap.get(i+"_monetid"))+"</td>");
				out.println("<td>"+(dataMap.get(i+"_todayPay")==null?"-":dataMap.get(i+"_todayPay"))+"</td>");
				out.println("<td>"+(dataMap.get(i+"_hisPay")==null?"-":dataMap.get(i+"_hisPay"))+"</td>");
				out.println("</tr>");
			}
		%>
</table>

<br>
<br>
</table>

<br>
<br>