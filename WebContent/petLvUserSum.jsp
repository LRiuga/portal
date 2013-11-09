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
	
	List<String> thList = new ArrayList<String>();
	thList.add("arena1");
	thList.add("arena2");
	thList.add("arena3");
	thList.add("arena4");
	thList.add("arena5");
	thList.add("arena6");
	thList.add("arena7");
	thList.add("arena8");
	
	
	Map<String,String> titleMap = new HashMap<String,String>();
	
	titleMap.put("arena1","������1(1-20��)");
	titleMap.put("arena2","������2(21-30��)");
	titleMap.put("arena3","������3(26-35��)");
	titleMap.put("arena4","������4(31-40��)");
	titleMap.put("arena5","������5(36-45��)");
	titleMap.put("arena6","������6(41-50��)");
	titleMap.put("arena7","������7(46-70��)");
	titleMap.put("arena8","������8(61-100��)");
	
	DBResultSet ds=DBUtil.db.execSQL("select arenaid,users,server from petLvUser order by server", new Object[]{});
	Map<String,String> resultMap = new HashMap<String,String>();
	List<String> serverList = new ArrayList<String>();
	try{
		
		while(ds.next()){
			String _server = ds.getString("server");
			if(!serverList.contains(_server)){
				serverList.add(_server);
			}
			resultMap.put(ds.getString("server")+"_arena"+ds.getInt("arenaid"), ds.getInt("users")+"");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<h1>�������������</h1>
	<table class="listing" cellpadding="0" cellspacing="0">
		<tr class="first" width="177">
			<th>�������</th>
			<% 
				for(String th : thList){
					out.println("<th>"+titleMap.get(th)+"</th>");
				}
			%>
		</tr>
		
		
		<%
			for(String server : serverList){
				out.println("<tr>");
				out.println("<td>"+server+"</td>");
				for(String th : thList){
					out.println("<td>"+(resultMap.get(server+"_"+th)==null?"0":resultMap.get(server+"_"+th))+"</td>");
				}
				out.println("</tr>");
			}
		%>
	</table>
	
	<br>
	<br>
</html>