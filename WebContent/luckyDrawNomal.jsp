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
	
	if(startTime==null&&endTime==null){
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DATE, -1);
		endTime = sdf.format(c.getTime());
		
		c.add(Calendar.DATE, -7);
		startTime = sdf.format(c.getTime());
	}
	
	List<String> thList = new ArrayList<String>();
	thList.add("Gold@0");
	thList.add("Balance@0");
	thList.add("Pearl@1");
	
	thList.add("Reinforce_Stone@1");
	thList.add("Reinforce_Stone@3");
	
	thList.add("Shield@1");
	thList.add("Shield@2");
	
	thList.add("Weapon@36");
	thList.add("Speaker@1");
	thList.add("Crew@9");
	
	thList.add("Weapon@32");
	thList.add("Weapon@6");
	thList.add("General@1");
	
	
	Map<String,String> titleMap = new HashMap<String,String>();
	
	titleMap.put("Reinforce_Stone@3","超级强化石");
	titleMap.put("Balance@0","蓝宝石");
	titleMap.put("Weapon@36","T2");
	titleMap.put("Reinforce_Stone@1","普通强化石");
	titleMap.put("Speaker@1","小喇叭");
	titleMap.put("Gold@0","金币");
	titleMap.put("Shield@1","绿装盾牌");
	titleMap.put("Crew@9","LuckyCrew");
	titleMap.put("Pearl@1","珍珠");
	titleMap.put("Shield@2","金装盾牌");
	
	titleMap.put("Weapon@32","D2");
	titleMap.put("Weapon@6","MiddleToolBox");
	titleMap.put("General@1","宠物召唤卡");
	
	
	
	DBResultSet ds=DBUtil.db.execSQL("select itemType,itemTypeid,amount,ddate from luckyDrawNormal where ddate >= ? and ddate <= ? order by ddate desc", new Object[]{startTime,endTime});
	
	List<String> ddateList = new ArrayList<String>();
	Map<String,String> resultMap = new HashMap<String,String>();
	try{
		while(ds.next()){
			String _time = sdf.format(ds.getDate("ddate"));
			if(!ddateList.contains(_time)){
				ddateList.add(_time);
			}
			resultMap.put(_time+"_"+ds.getString("itemType")+"@"+ds.getInt("itemTypeid"), ds.getInt("amount")+"");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
<h1>普通抽奖</h1>
<h3>可选</h3>
时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)" readOnly="readonly">
-<input name="time2" type="text" id="time2" onfocus="datelist.dfd(this)" readOnly="readonly">
<br>
<input name="yes" type="submit" value="查询" />
</form>
	<table class="listing" cellpadding="0" cellspacing="0">
		<tr class="first" width="177">
			<th>日期/产出次数</th>
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
					out.println("<td>"+(resultMap.get(time+"_"+th)==null?"-":resultMap.get(time+"_"+th))+"</td>");
				}
				out.println("</tr>");
			}
		%>
	</table>
	
	<br>
	<br>
	
</html>