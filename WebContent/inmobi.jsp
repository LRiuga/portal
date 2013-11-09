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
	thList.add("inmobi_Download_UV");
	thList.add("inmobi_Download_SUC_UV");
	thList.add("inmobi_reg");
	thList.add("inmobi_login");
	thList.add("inmobi_db");

	
	Map<String,String> titleMap = new HashMap<String,String>();
	
	titleMap.put("inmobi_Download_UV","下载");
	titleMap.put("inmobi_Download_SUC_UV","下载成功");
	titleMap.put("inmobi_reg","注册");
	titleMap.put("inmobi_login","登陆");
	titleMap.put("inmobi_db","新Fisher");

	
	DBResultSet ds=DBUtil.db.execSQL("select * from WebSiteData where ddate >= ? and ddate <= ? and oakey like 'inmobi%' order by ddate desc", new Object[]{startTime,endTime});
	List<String> ddateList = new ArrayList<String>();
	Map<String,String> resultMap = new HashMap<String,String>();
	try{
		while(ds.next()){
			String _time = sdf.format(ds.getDate("ddate"));
			if(!ddateList.contains(_time)){
				ddateList.add(_time);
			}
			resultMap.put(_time+"_"+ds.getString("oakey"), ds.getFloat("oavalue")+"");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	ds=DBUtil.db.execSQL("select * from regUserConvert where rdate >= ? and rdate <= ? and oakey like 'inmobi%' order by rdate desc", new Object[]{startTime,endTime});
	try{
		while(ds.next()){
			String _time = sdf.format(ds.getDate("rdate"));
			resultMap.put(_time+"_"+ds.getString("oakey"), ds.getFloat("oavalue")+"");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>Inmobi付费推广</h1>
	<h3>可选</h3>
	时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="查询" />
</form>

	<table class="listing" >
		<tr class="first" >
			<th>日期/PV</th>
			<% 

				System.out.println(thList);
				for(String th : thList){
					out.println("<th>"+titleMap.get(th)+"</th>");
				}
				out.println("<th>下载成功率</th>");
				out.println("<th>注册/下载成功</th>");
				out.println("<th>登陆/注册</th>");
				out.println("<th>新Fisher/登陆</th>");
				out.println("<th>总转化率</th>");
			%>
	</tr>


	<%
			for(String time : ddateList){
				out.println("<tr>");
				out.println("<td>"+time+"</td>");
				for(String th : thList){
					out.println("<td>"+resultMap.get(time+"_"+th)+"</td>");
				}
				
				if(resultMap.get(time+"_inmobi_Download_SUC_UV")== null || resultMap.get(time+"_inmobi_Download_UV") == null){
					out.println("<td>-</td>");
				}else{
					out.println("<td>"+df.format(new Double(resultMap.get(time+"_inmobi_Download_SUC_UV"))*100/new Double(resultMap.get(time+"_inmobi_Download_UV")))+"%</td>");
				}
				
				if(resultMap.get(time+"_inmobi_reg")== null || resultMap.get(time+"_inmobi_Download_SUC_UV") == null){
					out.println("<td>-</td>");
				}else{
					out.println("<td>"+df.format(new Double(resultMap.get(time+"_inmobi_reg"))*100/new Double(resultMap.get(time+"_inmobi_Download_SUC_UV")))+"%</td>");
				}
				
				if(resultMap.get(time+"_inmobi_login")== null || resultMap.get(time+"_inmobi_reg") == null){
					out.println("<td>-</td>");
				}else{
					out.println("<td>"+df.format(new Double(resultMap.get(time+"_inmobi_login"))*100/new Double(resultMap.get(time+"_inmobi_reg")))+"%</td>");
				}
				
				if(resultMap.get(time+"_inmobi_db")== null || resultMap.get(time+"_inmobi_login") == null){
					out.println("<td>-</td>");
				}else{
					out.println("<td>"+df.format(new Double(resultMap.get(time+"_inmobi_db"))*100/new Double(resultMap.get(time+"_inmobi_login")))+"%</td>");
				}
				
				if(resultMap.get(time+"_inmobi_db")== null || resultMap.get(time+"_inmobi_Download_UV") == null){
					out.println("<td>-</td>");
				}else{
					out.println("<td>"+df.format(new Double(resultMap.get(time+"_inmobi_db"))*100/new Double(resultMap.get(time+"_inmobi_Download_UV")))+"%</td>");
				}
				out.println("</tr>");
			}
		
		
		%>
</table>
</html>