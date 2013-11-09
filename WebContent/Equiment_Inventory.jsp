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
	String endTime = request.getParameter("time2");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df2 = new DecimalFormat("###.00");
	if (startTime == null && endTime == null) {
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DATE, -1);
		endTime = sdf.format(c.getTime());

		c.add(Calendar.DATE, -7);
		startTime = sdf.format(c.getTime());
	}

	DBResultSet ds = DBUtil.db
			.execSQL(
					"select sum(equimentCount) equimentCount,sum(equimentPerson) equimentPerson ,rdate,equimenttype from EquipmentInventory where rdate >= ? and rdate <= ?   and isAction = 1 group by equimenttype,rdate order by rdate desc ",
					new Object[] { startTime, endTime });
	List<String> ddateList = new ArrayList<String>();
	List<String> thList = new ArrayList<String>();
	Map<String, String> EquipmentMap = new HashMap<String, String>();
	try {
		while (ds.next()) {
			String _time = ds.getDate("rdate").toString();
			if (!ddateList.contains(_time)) {
				ddateList.add(_time);
			}
			int type = ds.getInt("equimenttype");
			if (!thList.contains(type + "")) {
				thList.add(type + "");
			}
			EquipmentMap.put(_time + type + "count",ds.getInt("equimentCount") + "");
			EquipmentMap.put(_time + type + "person",ds.getInt("equimentPerson") + "");
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
	<h1>装备历史库存</h1>
	<form action="" method="post">
		<h3>可选</h3>
		时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
			readOnly="readonly"> -<input name="time2" type="text"
			id="time2" onfocus="datelist.dfd(this)" readOnly="readonly">
		<br> <input name="yes" type="submit" value="查询" />
	</form>
	<br />
	<br />

	<table class="listing">
		<tr class="first">
			<th rowspan="2">日期</th>
			<%
			Map<String,String> thMap = new HashMap<String,String>();
			thMap.put("1","皇冠");
			thMap.put("2","武器");
			thMap.put("3","防具");
			thMap.put("4","饰品");
		
			for(String th: thList){
				out.println("<th colspan='3' >"+ thMap.get(th)+"</th>");
			}
		out.println("</tr><tr>");
			for(String th: thList){
				out.println("<th>拥有个数</th>");
				out.println("<th>拥有人数</th>");
				out.println("<th>人均拥有量</th>");
			}
		%>
		</tr>

		<%
			for(String date : ddateList){
				out.println("<tr>");
				out.println("<td> <a href='Equiment_Inventory_datail.jsp?time="+date.substring(0,10) + "' >" + date.substring(0,10) + "</td>");
				for(String th: thList){
					out.println("<td >"+ EquipmentMap.get(date + th + "count") +"</td>");
					out.println("<td >"+ EquipmentMap.get(date + th + "person") +"</td>");
					if(EquipmentMap.get(date + th + "count") == null || EquipmentMap.get(date + th + "person") == null){
						out.println("<td >-</td>");
					}else{
						Double avg = Double.parseDouble(EquipmentMap.get(date + th + "count"))/Double.parseDouble(EquipmentMap.get(date + th + "person"));
						out.println("<td >"+ df2.format(avg) +"</td>");
					}
					
				}
				out.println("</tr>");
			}
		%>

	</table>

</body>
</html>