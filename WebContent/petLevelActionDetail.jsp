<%@ page contentType="text/html;charset=GBK"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="util.*"%>
<%@ page import="OAStat.*"%>
<%@ page import="com.mozat.morange.util.*"%>

<!DOCTYPE html >
<html>
<head>
<link href="css/all.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<h1>宠物各等级挑战分布</h1>
	<br />
	<script src="js/dateselect.js"></script>
	<div class="table">
		<form action="" method="post">

			Date：<input name="time" type="text" id="time"
				onfocus="datelist.dfd(this)" readonly="readonly" /> <br /> <input
				name="yes" type="submit" value="Search" />
		</form>
	</div>
	<br />
	<%
if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		String startTime = request.getParameter("time");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		if(startTime==null){
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DATE, -1);
			startTime = sdf.format(c.getTime());
		
		}
		DBResultSet ds=DBUtil.db.execSQL("select * from petdarelevelaction where pdate =?  order by plevel ", new Object[]{startTime});
		Map<Integer,ArrayList<Integer>> rMap = new HashMap<Integer,ArrayList<Integer>>();
		List<Integer> levelList = new ArrayList<Integer>();
		try{
			while(ds.next()){
				int level = ds.getInt("plevel");
				levelList.add(level);
				ArrayList<Integer> alllist = new ArrayList<Integer>();
				alllist.add(ds.getInt("pnum"));
				alllist.add(ds.getInt("pperson"));
				alllist.add(ds.getInt("pmax"));
				alllist.add(ds.getInt("pmin"));
				alllist.add(ds.getInt("pavg"));
				alllist.add(ds.getInt("pmid"));
				rMap.put(level, alllist);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		%>
	<h1 style="float: left"><%=startTime %></h1>
	<table class="listing">
		<tr>
			<td>等级</td>
			<td>挑战次数</td>
			<td>挑战人数</td>
			<td>max</td>
			<td>min</td>
			<td>avg</td>
			<td>mid</td>
		</tr>
		<%
			for(int l : levelList){
		%>
		<tr>
			<%
			if(l ==0){
				out.println("<td>全部等级</td>");
			}else{
				out.println("<td>"+l + "</td>");
			} 
			List<Integer> alllist = rMap.get(l);
			for(int a : alllist){
				out.println("<td>" + a + "</td>");
			}
		%>
		</tr>
		<% 		
			}
		%>
	</table>
	<%
		
	}
}else{
	response.sendRedirect("index.jsp");
}
%>
</body>
</html>