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
	DecimalFormat df2  = new DecimalFormat("###.00");
	if (startTime == null && endTime == null) {
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DATE, -1);
		endTime = sdf.format(c.getTime());

		c.add(Calendar.DATE, -7);
		startTime = sdf.format(c.getTime());
	}

	Map<String, Long> sumMap = new HashMap<String, Long>();

	DBResultSet ds = DBUtil.db
			.execSQL(
					"select * from buyitem where edate >= ? and edate <= ?   order by edate desc",
					new Object[] { startTime, endTime });
	List<String> ddateList = new ArrayList<String>();
	List<String> thList = new ArrayList<String>();
	Map<String, String> goldBuyEquipmentMap = new HashMap<String, String>();
	Map<String, String> creditBuyEquipmentMap = new HashMap<String, String>();
	Map<String, String> creditBuyReinforceStoneMap = new HashMap<String, String>();
	try {
		while (ds.next()) {
			String _time = ds.getDate("edate").toString();
			if (!ddateList.contains(_time)) {
				ddateList.add(_time);
			}
			String type = ds.getString("type");
			
			if(type.equals("Equipment")){
				String useType = ds.getString("usetype");
				System.out.println(useType);
				if(useType.equals("Gold")){
					System.out.println(type);
					goldBuyEquipmentMap.put(_time + "num",ds.getInt("num") + "");
					goldBuyEquipmentMap.put(_time + "person",ds.getInt("person") + "");
					goldBuyEquipmentMap.put(_time + "amount",ds.getInt("amount") + "");
				}else if(useType.equals("Credit")){
					creditBuyEquipmentMap.put(_time + "num",ds.getInt("num") + "");
					creditBuyEquipmentMap.put(_time + "person",ds.getInt("person") + "");
					creditBuyEquipmentMap.put(_time + "amount",ds.getInt("amount") + "");
				}
			}else if(type.equals("ReinforceStone")){
				creditBuyReinforceStoneMap.put(_time + "num",ds.getInt("num") + "");
				creditBuyReinforceStoneMap.put(_time + "person",ds.getInt("person") + "");
				creditBuyReinforceStoneMap.put(_time + "amount",ds.getInt("amount") + "");
			}
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>物品购买情况</h1>
	<h3>可选</h3>
	时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="查询" />
</form>
<br />
<br />
<h1>金币购买装备</h1>
<table class="listing">
	<tr class="first">
		<th>日期</th>
		<th>购买次数</th>
		<th>购买人数</th>
		<th>金额</th>
	</tr>
	<%
		for(String date : ddateList){
	%>
	<tr>
		<td><%=date.toString().substring(0,10) %></td>
		<td><%=goldBuyEquipmentMap.get(date + "num") %></td>
		<td><%=goldBuyEquipmentMap.get(date + "person") %></td>
		<td><%=goldBuyEquipmentMap.get(date + "amount") %></td>
	</tr>
	<%	
		}
	%>
</table>
<br />
<br />
<h1>蓝宝石购买装备</h1>
<table class="listing">
	<tr class="first">
		<th>日期</th>
		<th>购买次数</th>
		<th>购买人数</th>
		<th>金额</th>
	</tr>
	<%
		for(String date : ddateList){
	%>
	<tr>
		<td><%=date.toString().substring(0,10) %></td>
		<td><%=creditBuyEquipmentMap.get(date + "num") %></td>
		<td><%=creditBuyEquipmentMap.get(date + "person") %></td>
		<td><%=creditBuyEquipmentMap.get(date + "amount") %></td>
	</tr>
	<%	
		}
	%>
</table>
<br />
<br />
<h1>蓝宝石购买强化石</h1>
<table class="listing">
	<tr class="first">
		<th>日期</th>
		<th>购买次数</th>
		<th>购买人数</th>
		<th>金额</th>
	</tr>
	<%
		for(String date : ddateList){
	%>
	<tr>
		<td><%=date.toString().substring(0,10) %></td>
		<td><%=creditBuyReinforceStoneMap.get(date + "num") %></td>
		<td><%=creditBuyReinforceStoneMap.get(date + "person") %></td>
		<td><%=creditBuyReinforceStoneMap.get(date + "amount") %></td>
	</tr>
	<%	
		}
	%>
</table>

</html>