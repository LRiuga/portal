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
	thList.add("DAU");
	thList.add("RDAU");
	thList.add("AAU");
	thList.add("NAU");
	
	List<String> thList2 = new ArrayList<String>();
	thList2.add("ALL");
	thList2.add("ANDROID");
	thList2.add("BB");
	thList2.add("J2ME");
	
	Map<String,String> titleMap = new HashMap<String,String>();
	
	titleMap.put("DAU","登陆用户数");
	titleMap.put("RDAU","登陆 成功用户数");
	titleMap.put("NAU","新用户");
	titleMap.put("AAU","有活动用户");
	
	
	DBResultSet ds=DBUtil.db.execSQL("select * from UserPlatform where ldate >= ? and ldate <= ? order by ldate desc", new Object[]{startTime,endTime});
	List<String> ddateList = new ArrayList<String>();
	Map<String,String> resultMap = new HashMap<String,String>();
	try{
		while(ds.next()){
			String _time = sdf.format(ds.getDate("ldate"));
			if(!ddateList.contains(_time)){
				ddateList.add(_time);
			}
			resultMap.put(_time+"_"+ds.getString("oakey"), ds.getFloat("oavalue")+"");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>用户平台</h1>
	<h3>可选</h3>
	时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="查询" />
</form>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th rowspan=2>日期</th>
		<% 
				for(String th : thList){
					out.println("<th colspan=4>"+titleMap.get(th)+"</th>");
				}
			%>
	</tr>
	<tr class="first" width="177">
		<% 
				for(String th : thList){
					for(String th2 : thList2){
						out.println("<th>"+th2+"</th>");
					}
				}
			%>
	</tr>


	<%
			for(String time : ddateList){
				out.println("<tr>");
				out.println("<td>"+time+"</td>");
				for(String th : thList){
					for(String th2 : thList2)
						out.println("<td>"+(resultMap.get(time+"_"+th+"_"+th2)==null?"-":resultMap.get(time+"_"+th+"_"+th2))+"</td>");
				}
				out.println("</tr>");
			}
		%>
</table>

</html>