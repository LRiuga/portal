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
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	
	DecimalFormat df =  new DecimalFormat("####.##");
	
	DBResultSet ds=DBUtil.db.execSQL("select * from weekReport where dtime in(select top 4 * from (select distinct dtime from weekReport) y order by dtime desc) and server = 'Server6' and channel='J2ME' order by dtime desc", new Object[]{});
	List<String> ddateList = new ArrayList<String>();
	Map<String,String> resultMap = new HashMap<String,String>();
	try{
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			if(!ddateList.contains(_time)){
				ddateList.add(_time);
			}
			resultMap.put(_time+"_"+ds.getString("oakey")+"_"+ds.getString("channel"), df.format(ds.getFloat("oavalue")));
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>

<h1>周报</h1>
<h3>汇总</h3>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th>日期</th>
		<th>收入</th>
		<th>=</th>
		<th>ARPU</th>
		<th>*</th>
		<th>活跃用户数</th>
	</tr>
	<%
		for(String _time : ddateList){
			out.println("<tr>");
			out.println("<td>"+_time+"</td>");
			out.println("<td>"+resultMap.get(_time+"_"+"Topup"+"_"+"J2ME")+"</td><td></td><td>"+resultMap.get(_time+"_"+"ARPU"+"_"+"J2ME")+"</td><td></td><td>"+resultMap.get(_time+"_"+"ActivityFisher"+"_"+"J2ME")+"</td>");
			out.println("</tr>");
		}
	%>
</table>
<br>
<hr>
<h3>ARPU</h3>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th>日期</th>
		<th>ARPU</th>
		<th>=</th>
		<th>渗透率</th>
		<th>*</th>
		<th>ARPPU</th>
	</tr>
	<%
		for(String _time : ddateList){
			out.println("<tr>");
			out.println("<td>"+_time+"</td>");
			out.println("<td>"+resultMap.get(_time+"_"+"ARPU"+"_"+"J2ME")+"</td><td></td><td>"+resultMap.get(_time+"_"+"Permeability"+"_"+"J2ME")+"</td><td></td><td>"+resultMap.get(_time+"_"+"ARPPU"+"_"+"J2ME")+"</td>");
			out.println("</tr>");
		}
	%>
</table>
<br>
<hr>

<h3>ARPPU</h3>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th>日期</th>
		<th>ARPPU</th>
		<th>=</th>
		<th>收入</th>
		<th>/</th>
		<th>付费用户数</th>
	</tr>
	<%
		for(String _time : ddateList){
			out.println("<tr>");
			out.println("<td>"+_time+"</td>");
			out.println("<td>"+resultMap.get(_time+"_"+"ARPPU"+"_"+"J2ME")+"</td><td></td><td>"+resultMap.get(_time+"_"+"Topup"+"_"+"J2ME")+"</td><td></td><td>"+resultMap.get(_time+"_"+"TopupUser"+"_"+"J2ME")+"</td>");
			out.println("</tr>");
		}
	%>
</table>
<br>
<hr>
<h3>活跃用户</h3>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th>日期</th>
		<th>活跃用户</th>
		<th>=</th>
		<th>新用户</th>
		<th>+</th>
		<th>旧用户</th>
	</tr>
	<%
		for(String _time : ddateList){
			out.println("<tr>");
			out.println("<td>"+_time+"</td>");
			out.println("<td>"+resultMap.get(_time+"_"+"ActivityFisher"+"_"+"J2ME")+"</td><td></td><td>"+resultMap.get(_time+"_"+"NewFisher"+"_"+"J2ME")+"</td><td></td><td>"+resultMap.get(_time+"_"+"OldFisher"+"_"+"J2ME")+"</td>");
			out.println("</tr>");
		}
	%>
</table>
<br>
<br>