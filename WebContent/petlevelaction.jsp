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

			<h3>可选</h3>
			时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
				readOnly="readonly"> -<input name="time2" type="text"
				id="time2" onfocus="datelist.dfd(this)" readOnly="readonly">
			<br> <input name="yes" type="submit" value="查询" />
		</form>
	</div>
	<br />
	<%
		if (session != null && session.getAttribute("login") != null) {
			if (session.getAttribute("login").equals("ok")) {
				String startTime = request.getParameter("time");
				String endTime = request.getParameter("time2");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				if (startTime == null && endTime == null) {
					Calendar c = Calendar.getInstance();
					c.add(Calendar.DATE, -1);
					endTime = sdf.format(c.getTime());

					c.add(Calendar.DATE, -7);
					startTime = sdf.format(c.getTime());
				}
				DBResultSet ds = DBUtil.db
						.execSQL(
								"select * from petdarelevelaction where pdate >= ? and pdate <= ? and plevel = 0 order by pdate desc ",
								new Object[] { startTime, endTime });
				Map<String, ArrayList<Integer>> rMap = new HashMap<String, ArrayList<Integer>>();
				List<String> levelList = new ArrayList<String>();
				try {
					while (ds.next()) {
						String pdate = ds.getDate("pdate").toString();
						levelList.add(pdate);
						ArrayList<Integer> alllist = new ArrayList<Integer>();
						alllist.add(ds.getInt("pnum"));
						alllist.add(ds.getInt("pperson"));
						alllist.add(ds.getInt("pmax"));
						alllist.add(ds.getInt("pmin"));
						alllist.add(ds.getInt("pavg"));
						alllist.add(ds.getInt("pmid"));
						rMap.put(pdate, alllist);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
	%>
	<table class="listing">
		<tr>
			<td>时间</td>
			<td>挑战次数</td>
			<td>挑战人数</td>
			<td>max</td>
			<td>min</td>
			<td>avg</td>
			<td>mid</td>
		</tr>
		<%
			for (String date : levelList) {
		%>
		<tr>
			<%
			out.println("<td> <a href='petLevelActionDetail.jsp?time="+date.substring(0,10) +"'>" + date.substring(0,10) + "</td>");
			List<Integer> alllist = rMap.get(date);
			for (int a : alllist) {
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
		} else {
			response.sendRedirect("index.jsp");
		}
	%>
</body>
</html>