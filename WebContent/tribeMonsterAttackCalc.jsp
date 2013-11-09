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
	thList.add("1");
	thList.add("2");
	thList.add("3");
	thList.add("4");

	
	Map<String,String> titleMap = new HashMap<String,String>();
	
	titleMap.put("1","1次");
	titleMap.put("2","2次");
	titleMap.put("3","3次");
	titleMap.put("4","4次");
	
	DBResultSet ds=DBUtil.db.execSQL("select times,users,dtime from monsterAttackUserCount where dtime >= ? and dtime <= ? order by dtime desc", new Object[]{startTime,endTime});
	List<String> ddateList = new ArrayList<String>();
	Map<String,String> resultMap = new HashMap<String,String>();
	try{
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			if(!ddateList.contains(_time)){
				ddateList.add(_time);
			}
			resultMap.put(_time+"_"+ds.getInt("times"), ds.getInt("users")+"");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
<h1>家族成员打怪次数分布</h1>
<h3>可选</h3>
时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)" readOnly="readonly">
-<input name="time2" type="text" id="time2" onfocus="datelist.dfd(this)" readOnly="readonly">
<br>
<input name="yes" type="submit" value="查询" />
</form>
	<table class="listing" cellpadding="0" cellspacing="0">
		<tr class="first" width="177">
			<th>日期/人数</th>
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