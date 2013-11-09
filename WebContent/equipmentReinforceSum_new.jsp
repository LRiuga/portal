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
	thList.add("count");
	thList.add("users");
	thList.add("sapphirecount");
	thList.add("sapphireuser");
	thList.add("succount");
	thList.add("failcount");
	thList.add("sucRate");
	thList.add("maxusercount");
	thList.add("maxuserid");
	
	Map<String,String> titleMap = new HashMap<String,String>();
	
	titleMap.put("count","强化次数");
	titleMap.put("users","强化人数");
	titleMap.put("sapphirecount","蓝宝石强化次数");
	titleMap.put("sapphireuser","蓝宝石强化人数");
	titleMap.put("succount","强化成功次数");
	titleMap.put("failcount","强化失败次数");
	titleMap.put("sucRate","成功率");
	titleMap.put("maxusercount","强化最多次数");
	titleMap.put("maxuserid","强化最多用户");
	
	DBResultSet ds=DBUtil.db.execSQL("select weaponlevel,users,count,succount,maxusercount,maxuserid,sapphirecount,sapphireuser,dtime ,type from reinforcecalc_new where weaponlevel = 'ALL' and dtime > ? and dtime <= ?  order by dtime desc", new Object[]{startTime,endTime});
	List<String> ddateList = new ArrayList<String>();
	Map<String,String> resultMap = new HashMap<String,String>();
	Map<String,String> comMap = new HashMap<String,String>();
	Map<String,String> advMap = new HashMap<String,String>();
	Map<String,String> supMap = new HashMap<String,String>();
	try{
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			if(!ddateList.contains(_time)){
				ddateList.add(_time);
			}
			String type = ds.getString("type");
			if("all".equals(type)){
				resultMap.put(_time+"_users",ds.getInt("users")+"");
				resultMap.put(_time+"_count",ds.getInt("count")+"");
				resultMap.put(_time+"_succount",ds.getInt("succount")+"");
				resultMap.put(_time+"_failcount",(ds.getInt("count")-ds.getInt("succount"))+"");
				resultMap.put(_time+"_sapphirecount",ds.getInt("sapphirecount")+"");
				resultMap.put(_time+"_sapphireuser",ds.getInt("sapphireuser")+"");
				resultMap.put(_time+"_sucRate",df.format(((double)ds.getInt("succount")/ds.getInt("count"))));
				resultMap.put(_time+"_maxusercount",ds.getInt("maxusercount")+"");
				resultMap.put(_time+"_maxuserid",ds.getInt("maxuserid")+"");
			}
			if("commonReinforceStone".equals(type)){
				comMap.put(_time+"_users",ds.getInt("users")+"");
				comMap.put(_time+"_count",ds.getInt("count")+"");
				comMap.put(_time+"_succount",ds.getInt("succount")+"");
				comMap.put(_time+"_failcount",(ds.getInt("count")-ds.getInt("succount"))+"");
				comMap.put(_time+"_sapphirecount",ds.getInt("sapphirecount")+"");
				comMap.put(_time+"_sapphireuser",ds.getInt("sapphireuser")+"");
				comMap.put(_time+"_sucRate",df.format(((double)ds.getInt("succount")/ds.getInt("count"))));
				comMap.put(_time+"_maxusercount",ds.getInt("maxusercount")+"");
				comMap.put(_time+"_maxuserid",ds.getInt("maxuserid")+"");
			}
			if("advancedReinforceStone".equals(type)){
				advMap.put(_time+"_users",ds.getInt("users")+"");
				advMap.put(_time+"_count",ds.getInt("count")+"");
				advMap.put(_time+"_succount",ds.getInt("succount")+"");
				advMap.put(_time+"_failcount",(ds.getInt("count")-ds.getInt("succount"))+"");
				advMap.put(_time+"_sapphirecount",ds.getInt("sapphirecount")+"");
				advMap.put(_time+"_sapphireuser",ds.getInt("sapphireuser")+"");
				advMap.put(_time+"_sucRate",df.format(((double)ds.getInt("succount")/ds.getInt("count"))));
				advMap.put(_time+"_maxusercount",ds.getInt("maxusercount")+"");
				advMap.put(_time+"_maxuserid",ds.getInt("maxuserid")+"");
			}
			if("superReinforceStone".equals(type)){
				supMap.put(_time+"_users",ds.getInt("users")+"");
				supMap.put(_time+"_count",ds.getInt("count")+"");
				supMap.put(_time+"_succount",ds.getInt("succount")+"");
				supMap.put(_time+"_failcount",(ds.getInt("count")-ds.getInt("succount"))+"");
				supMap.put(_time+"_sapphirecount",ds.getInt("sapphirecount")+"");
				supMap.put(_time+"_sapphireuser",ds.getInt("sapphireuser")+"");
				supMap.put(_time+"_sucRate",df.format(((double)ds.getInt("succount")/ds.getInt("count"))));
				supMap.put(_time+"_maxusercount",ds.getInt("maxusercount")+"");
				supMap.put(_time+"_maxuserid",ds.getInt("maxuserid")+"");
			}
			
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>装备强化次数汇总</h1>
	<h3>可选</h3>
	时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="查询" />
</form>
<table class="listing" >
	<tr class="first" >
		<th>日期</th>
		<% 
				for(String th : thList){
					out.println("<th>"+titleMap.get(th)+"</th>");
				}
			%>
	</tr>


	<%
			for(String time : ddateList){
				out.println("<tr>");
				out.println("<td><a href = 'equipmentReinforceSumLevel_new.jsp?time=" + time+"&type=all'>"+time+"</td>");
				for(String th : thList){
					out.println("<td>"+resultMap.get(time+"_"+th)+"</td>");
				}
				out.println("</tr>");
			}
		%>
</table>
<br/>
<h1>普通强化石</h1>
<table class="listing" >
	<tr class="first" >
		<th>日期</th>
		<% 
				for(String th : thList){
					out.println("<th>"+titleMap.get(th)+"</th>");
				}
			%>
	</tr>


	<%
			for(String time : ddateList){
				out.println("<tr>");
				out.println("<td><a href = 'equipmentReinforceSumLevel_new.jsp?time=" + time+"&type=commonReinforceStone'>"+time+"</td>");
				for(String th : thList){
					out.println("<td>"+comMap.get(time+"_"+th)+"</td>");
				}
				out.println("</tr>");
			}
		%>
</table>
<br/>
<h1>高级强化石</h1>
<table class="listing" >
	<tr class="first" >
		<th>日期</th>
		<% 
				for(String th : thList){
					out.println("<th>"+titleMap.get(th)+"</th>");
				}
			%>
	</tr>


	<%
			for(String time : ddateList){
				out.println("<tr>");
				out.println("<td><a href = 'equipmentReinforceSumLevel_new.jsp?time=" + time+"&type=advancedReinforceStone'>"+time+"</td>");
				for(String th : thList){
					out.println("<td>"+advMap.get(time+"_"+th)+"</td>");
				}
				out.println("</tr>");
			}
		%>
</table>
<br/>
<h1>超级强化石</h1>
<table class="listing" >
	<tr class="first" >
		<th>日期</th>
		<% 
				for(String th : thList){
					out.println("<th>"+titleMap.get(th)+"</th>");
				}
			%>
	</tr>


	<%
			for(String time : ddateList){
				out.println("<tr>");
				out.println("<td><a href = 'equipmentReinforceSumLevel_new.jsp?time=" + time+"&type=superReinforceStone'>"+time+"</td>");
				for(String th : thList){
					out.println("<td>"+supMap.get(time+"_"+th)+"</td>");
				}
				out.println("</tr>");
			}
		%>
</table>
<br>
<br>
</html>