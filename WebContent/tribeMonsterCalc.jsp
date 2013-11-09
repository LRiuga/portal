<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sun.java2d.pipe.SpanShapeRenderer.Simple"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import = "java.util.*"%>
<%@ page import = "util.*"%>
<%@ page import = "com.mozat.morange.util.*"%>
<style media="all" type="text/css">@import "css/all.css";</style>
<%
	if(session==null||session.getAttribute("login")==null){
		response.sendRedirect("index.jsp");
	}
	
	
	String startTime = request.getParameter("time");
	String endTime = request.getParameter("time2");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	List<String> ddateList = new ArrayList<String>();
	Calendar c = Calendar.getInstance();
	c.add(Calendar.DATE, -2);
	if(startTime==null){
		startTime = sdf.format(c.getTime());
	}
	
	c.setTime(sdf.parse(startTime));
	ddateList.add(sdf.format(c.getTime()));	
	for(int i = 0;i<2;i++){
		c.add(Calendar.DATE, 1);
		ddateList.add(sdf.format(c.getTime()));	
	}
	c.add(Calendar.DATE, 1);
	endTime = sdf.format(c.getTime());
	
	Map<String,Date[]> periodMap = new HashMap<String,Date[]>();
	
	DBResultSet ds= DBUtil.db.execSQL("select count(distinct monsterid) createNum,weaponType,convert(varchar(10),dateadd(hh,-5,createTime),20) createTime  from tribemonster where  dateadd(hh,-5,createTime) <? and dateadd(hh,-5,createTime) >= ? group by convert(varchar(10),dateadd(hh,-5,createTime),20),weaponType  order by convert(varchar(10),dateadd(hh,-5,createTime),20),weaponType", new Object[]{endTime,startTime});
	
	
	Map<String,Integer> createResultMap = new HashMap<String,Integer>();
	Map<String,Integer> killResultMap = new HashMap<String,Integer>();
	
	try{
		
		while(ds.next()){
			String _timeStr = ds.getString("createTime");
			int weaponType = ds.getInt("weaponType");
			int createNum = ds.getInt("createNum");
			
			Date _time = sdf.parse(_timeStr);
			createResultMap.put(sdf.format(_time)+"_"+weaponType, createNum);
		}
		
		ds= DBUtil.db.execSQL("select count(distinct monsterid) killNum,monsterType,convert(varchar(10),dateadd(hh,-5,killTime),20) killTime  from tribemonster where  dateadd(hh,-5,killTime) < ? and dateadd(hh,-5,killTime) > ? group by convert(varchar(10),dateadd(hh,-5,killTime),20),monsterType  order by convert(varchar(10),dateadd(hh,-5,killTime),20),monsterType", new Object[]{endTime,startTime});
		
		while(ds.next()){
			String _timeStr = ds.getString("killTime");
			int monsterType = ds.getInt("monsterType");
			int killNum = ds.getInt("killNum");
			
			Date _time = sdf.parse(_timeStr);
			killResultMap.put(sdf.format(_time)+"_"+monsterType, killNum);
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
<h1>家族怪产生杀死分布</h1>
</form>
	<table class="listing" >
		<tr class="first" >
			<th rowspan=2>日期/怪物个数</th>
			<%
				for(int i= 2;i<9;i++){
					out.println("<th colspan=2>M"+i+"</th>");
				}
			%>
		</tr>
		
		<tr class="first" >
			<%
				for(int i= 2;i<9;i++){
					out.println("<th>产生</th><th>杀死</th>");
				}
			%>
		</tr>
		
		
		<%
			StringBuffer dataShowBuffer = new StringBuffer("");
			for(String time : ddateList){
				dataShowBuffer.append("<tr>");
				dataShowBuffer.append("<td>"+time+"</td>");
				for(int i= 2;i<9;i++){
					dataShowBuffer.append("<td>@createNum_"+time+"_"+(i+21)+"</td><td>@killNum_"+time+"_"+(9-i-1)+"</td>");
				}
				dataShowBuffer.append("</tr>");
			}
			String showstr = dataShowBuffer.toString();
			
			for(String time : ddateList){
				int _sum[]={0,0,0,0,0,0,0};
				if(time!=null){
					for(int i= 2;i<9;i++){
						_sum[i-2] = _sum[i-2] + (createResultMap.get(time+"_"+(i+21))==null?0:createResultMap.get(time+"_"+(i+21)));
					}
				}
				
				for(int i= 2;i<9;i++){	
					showstr = showstr.replace("@createNum_"+time+"_"+(i+21), _sum[i-2]+"");
				}
			} 
			
			
			for(String time : ddateList){
				int _sum[]={0,0,0,0,0,0,0};
				if(time!=null){
					for(int i= 2;i<9;i++){
						_sum[i-2] = _sum[i-2] + ( killResultMap.get(time+"_"+(9-i-1))==null?0:killResultMap.get(time+"_"+(9-i-1)));
					}
				}
				for(int i= 2;i<9;i++){	
					showstr = showstr.replace("@killNum_"+time+"_"+(9-i-1), _sum[i-2]+"");
				}
			}
			out.print(showstr); 
		%>
	</table>
	
	<br>
	<br>
</html>