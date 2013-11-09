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
	thList.add("HAU");
	thList.add("DRU");
	thList.add("DAU");
	thList.add("DNU");
	thList.add("DPU");
	thList.add("TOPUP");
	
	Map<String,String> titleMap = new HashMap<String,String>();
	
	titleMap.put("HAU","历史用户");
	titleMap.put("DRU","注册用户");
	titleMap.put("DAU","DAU");
	titleMap.put("DNU","新用户");
	titleMap.put("DPU","付费用户");
	titleMap.put("TOPUP","付费金额");
	
	DBResultSet ds=DBUtil.db.execSQL("select oakey,oavalue,dtime from egyptuser where dtime >?  and dtime <=? order by dtime desc", new Object[]{startTime,endTime});
	List<String> ddateList = new ArrayList<String>();
	Map<String,String> resultMap = new HashMap<String,String>();
	try{
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			if(!ddateList.contains(_time)){
				ddateList.add(_time);
			}
			resultMap.put(_time+"_"+ds.getString("oakey"), ds.getInt("oavalue")+"");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>埃及用户汇总</h1>
	<h3>可选</h3>
	时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="查询" />
</form>
<br>
<label>注：历史用户：所有服务器上billing渠道标记为埃及的注册用户。</label>
<br>
<label>注册用户：所有服务器上billing渠道标记为埃及的当天注册用户。</label>
<br>
<br>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
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
				out.println("<td>"+time+"</td>");
				for(String th : thList){
					out.println("<td>"+resultMap.get(time+"_"+th)+"</td>");
				}
				out.println("</tr>");
			}
		%>
</table>

<br>
<br>
</html>