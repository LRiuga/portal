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
	Map<String,String> thMap=new HashMap<String,String>();
	List<String> thList = new ArrayList<String>();
	Map<String,Integer> dataMap=new HashMap<String,Integer>();
	try{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	
		DecimalFormat df =  new DecimalFormat("####.##");
		String startTime = request.getParameter("time");
		if(startTime==null){
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DATE, -1);
			startTime = sdf.format(c.getTime());
		}
		
		DBResultSet ds=DBUtil.db.execSQL("SELECT WearLevel,QualityLevel,Quality,Part,EquipmentName,Price,Unit,Typeid,PartType FROM EquipmentConfig Order By WearLevel,QualityLevel,PartType", new Object[]{});
		
	
		while(ds.next()){
			thList.add(ds.getInt("Typeid")+"");
			String _t = "<td>"+ds.getInt("WearLevel")+"</td>"+"<td>"+ds.getString("Quality")+"</td>"+"<td>"+ds.getString("Part")+"</td>"+"<td>"+ds.getInt("Price")+"</td>"+"<td>"+ds.getString("Unit")+"</td>"+"<td>"+ds.getInt("Typeid")+"</td>";
			thMap.put(ds.getInt("Typeid")+"", _t);
		}
		
		ds=DBUtil.db.execSQL("select typeid,reinforce,oavalue from EquipmentActivityUserReinforce where dtime = ?",new Object[]{startTime});
		
		
		while(ds.next()){
			dataMap.put(ds.getInt("typeid")+"_"+ds.getString("reinforce"), ds.getInt("oavalue"));
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>

<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>活跃用户装备强化等级分布</h1>
	<h3>可选</h3>
	时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> <br> <input name="yes" type="submit"
		value="查询" />
</form>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th rowspan=2>穿戴LV</th>
		<th rowspan=2>品质</th>
		<th rowspan=2>部件</th>
		<th rowspan=2>价格</th>
		<th rowspan=2>单位</th>
		<th rowspan=2>TypeId</th>
		<th colspan=11>装备强化等级</th>
		<th rowspan=2>All</th>
		<th rowspan=2>强化个数</th>
	</tr>
	<tr class="first" width="177">
		<%
		for(int i = 0;i<=10;i++){
			out.print("<th>"+i+"</th>");
		}
	%>
	</tr>
	<%
		for(String key:thList){
			out.println("<tr>");
				out.print(thMap.get(key));
				for(int i = 0;i<=10;i++){
					out.print("<td>"+(dataMap.get(key+"_"+i)==null?"-":dataMap.get(key+"_"+i))+"</td>");
				}
				
				out.print("<td>"+(dataMap.get(key+"_ALL")==null?"-":dataMap.get(key+"_ALL"))+"</td>");
				out.print("<td>"+(dataMap.get(key+"_GT")==null?"-":dataMap.get(key+"_GT"))+"</td>");
			out.println("</tr>");
		}
	%>
</table>

<br>
<br>