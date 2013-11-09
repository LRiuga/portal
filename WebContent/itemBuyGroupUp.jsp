<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sun.java2d.pipe.SpanShapeRenderer.Simple"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
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
	
	if(startTime==null&&endTime==null){
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DATE, -1);
		endTime = sdf.format(c.getTime());
		
		c.add(Calendar.DATE, -7);
		startTime = sdf.format(c.getTime());
	}
	
	List<String> thList = new ArrayList<String>();
	thList.add("ALL");
	thList.add("LuckyDraw");
	thList.add("LuckyDrawEquipment");
	thList.add("Missile");
	thList.add("T-Bomb");
	thList.add("Defense");
	thList.add("ToolBox");
	thList.add("Arena");
	thList.add("Equipment");
	thList.add("Reinforce");
	thList.add("Pet");
	thList.add("Speaker");
	thList.add("AutoFishing");
	thList.add("Crew");
	thList.add("TribeIcon");
	thList.add("Other");
	
	//thList.add("shabikplus");
	
	Map<String,String> titleMap = new HashMap<String,String>();
	titleMap.put("ALL","汇总");
	titleMap.put("Arena","竞技场");
	titleMap.put("AutoFishing","自动捕鱼");
	titleMap.put("Crew","Crew");
	titleMap.put("Defense","D炸弹");
	titleMap.put("Equipment","装备");
	titleMap.put("LuckyDraw","抽奖");
	titleMap.put("Missile","M炸弹");
	titleMap.put("Other","其他");
	titleMap.put("Pet","变身卡+召唤卡");
	//titleMap.put("shabikplus","shabikPlus介绍页面");
	titleMap.put("Reinforce","装备强化");
	titleMap.put("Speaker","Speaker");
	titleMap.put("T-Bomb","T炸弹");
	titleMap.put("ToolBox","ToolBox");
	titleMap.put("TribeIcon","家族icon");
	titleMap.put("LuckyDrawEquipment","装备抽奖");

	
	DBResultSet ds=DBUtil.db.execSQL("select itemtype,price,users,btime from itemBuyGroupUp where btime >= ? and btime <= ? order by btime desc", new Object[]{startTime,endTime});
	List<String> ddateList = new ArrayList<String>();
	Map<String,String> resultMap = new HashMap<String,String>();
	try{
		while(ds.next()){
			String _time = sdf.format(ds.getDate("btime"));
			if(!ddateList.contains(_time)){
				ddateList.add(_time);
			}
			resultMap.put(_time+"_"+ds.getString("itemtype")+"_PRICE", ds.getInt("price")+"");
			resultMap.put(_time+"_"+ds.getString("itemtype")+"_USERS", ds.getInt("users")+"");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>蓝宝石分类汇总</h1>
	<h3>可选</h3>
	时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="查询" />
</form>
<table class="listing" >
	<tr class="first" >
		<th>日期/蓝宝石</th>
		<% 
				for(String th : thList){
					out.println("<th>"+titleMap.get(th)+"</th>");
				}
			%>
	</tr>


	<%
			for(String time : ddateList){
				out.println("<tr>");
				out.println("<td>"+time+"</td>");
				for(String th : thList){
					out.println("<td>"+(resultMap.get(time+"_"+th+"_PRICE")==null?"-":resultMap.get(time+"_"+th+"_PRICE"))+"</td>");
				}
				out.println("</tr>");
			}
		%>
</table>

<br>
<br>
<table class="listing" >
	<tr class="first" >
		<th>日期/用户数</th>
		<% 
				for(String th : thList){
					out.println("<th>"+titleMap.get(th)+"</th>");
				}
			%>
	</tr>


	<%
			for(String time : ddateList){
				out.println("<tr>");
				out.println("<td>"+time+"</td>");
				for(String th : thList){
					out.println("<td>"+(resultMap.get(time+"_"+th+"_USERS")==null?"-":resultMap.get(time+"_"+th+"_USERS"))+"</td>");
				}
				out.println("</tr>");
			}
		%>
</table>
</html>