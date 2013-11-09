<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sun.java2d.pipe.SpanShapeRenderer.Simple"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.mozat.morange.util.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<%
	String startTime = request.getParameter("time");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df2 = new DecimalFormat("###.00");
	if (startTime == null ) {
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DATE, -1);
		startTime = sdf.format(c.getTime());

	}

	DBResultSet ds = DBUtil.db
			.execSQL(
					"select * from EquipmentInventory where rdate = ?  and isaction = 1  ",
					new Object[] { startTime });
	List<String> levelList = new ArrayList<String>();
	List<String> thList = new ArrayList<String>();
	Map<String, String> EquipmentMap = new HashMap<String, String>();
	try {
		while (ds.next()) {
			String level = ds.getInt("petlevel").toString();
			if (!levelList.contains(level)) {
				levelList.add(level);
			}
			int type = ds.getInt("equimentType");
			System.out.println(type);
			if (!thList.contains(type + "")) {
				thList.add(type + "");
			}
			EquipmentMap.put(level + type + "count",ds.getInt("equimentCount") + "");
			EquipmentMap.put(level + type + "person",ds.getInt("equimentPerson") + "");
		}

	} catch (Exception e) {
		e.printStackTrace();
	}
	
	
%>
<html>
<head>
<script type="text/javascript" src="js/dateselect.js"></script>
</head>
<body>
	<form action="" method="post">
		<h3>可选</h3>
		时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
			readOnly="readonly"> -<input name="time2" type="text"
			id="time2" onfocus="datelist.dfd(this)" readOnly="readonly">
		<br> <input name="yes" type="submit" value="查询" />
	</form>
	<br />
	<br />
	<h1>装备历史库存</h1>
	<table class="listing">
		<tr class="first">
			<th rowspan="2">宠物等级</th>
			<%
			Map<String,String> thMap = new HashMap<String,String>();
			thMap.put("1","皇冠");
			thMap.put("2","武器");
			thMap.put("3","防具");
			thMap.put("4","饰品");
		
			for(String th: thList){
				out.println("<th colspan='2' >"+ thMap.get(th)+"</th>");
			}
		out.println("</tr><tr>");
			for(String th: thList){
				out.println("<th>拥有个数</th>");
				out.println("<th>拥有人数</th>");
			}
		%>
		</tr>

		<%
			for(String level : levelList){
				out.println("<tr>");
				out.println("<td>" + level + "</td>");
				for(String th: thList){
					out.println("<td >"+ EquipmentMap.get(level + th + "count") +"</td>");
					out.println("<td >"+ EquipmentMap.get(level + th + "person") +"</td>");
				}
				out.println("</tr>");
			}
		%>

	</table>

</body>
</html>