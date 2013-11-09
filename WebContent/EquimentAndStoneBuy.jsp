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

	Map<String, Long> sumMap = new HashMap<String, Long>();

	DBResultSet ds = DBUtil.db
			.execSQL(
					"select edate,itemid,num,person,amount from selling_equiment where edate >= ? and edate <= ?  and type='Equipment' and usetype='Gold' order by edate desc ",
					new Object[] { startTime, endTime });
	List<String> ddateList = new ArrayList<String>();
	List<String> thList = new ArrayList<String>();
	Map<String, String> goldBuyEquipmentMap = new HashMap<String, String>();
	Map<String, String> goldBuyAllMap = new HashMap<String, String>();
	try {
		while (ds.next()) {
			String _time = ds.getDate("edate").toString();
			if (!ddateList.contains(_time)) {
				ddateList.add(_time);
			}
			int itemid = ds.getInt("itemid");
			System.out.println(itemid);
			if (itemid == 9999) {
				goldBuyAllMap.put(_time + "num", ds.getInt("num") + "");
				goldBuyAllMap.put(_time + "person", ds.getInt("person")
						+ "");
				goldBuyAllMap.put(_time + "amount",
						ds.getLong("amount") + "");
			} else {
				if (!thList.contains(itemid + "")) {
					thList.add(itemid + "");
				}

				goldBuyEquipmentMap.put(_time + itemid + "",
						ds.getInt("num") + "");
			}
		}

	} catch (Exception e) {
		e.printStackTrace();
	}

	ds = DBUtil.dbconf.execSQL(
			"select itemid,itemcredittext from shopitem",
			new Object[] {});
	Map<String, String> itemMap = new HashMap<String, String>();
	try {
		while (ds.next()) {
			itemMap.put(ds.getInt("itemid") + "",
					ds.getString("itemcredittext"));
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<h1>装备和强化石的购买</h1>
<form action="" method="post">
	<h3>可选</h3>
	时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="查询" />
</form>
<br />
<br />
<h3>金币购买装备</h3>
<table class="listing">
	<tr class="first">
		<th>日期</th>
		<th>购买次数</th>
		<th>购买人数</th>
		<th>金额</th>
	</tr>
	<%
		for (String date : ddateList) {
	%>
	<tr>
		<td><%=date.toString().substring(0, 10)%></td>
		<td><%=goldBuyAllMap.get(date + "num")%></td>
		<td><%=goldBuyAllMap.get(date + "person")%></td>
		<td><%=goldBuyAllMap.get(date + "amount")%></td>
	</tr>
	<%
		}
	%>
</table>
<br />
<br />
<h3>金币购买装备详细</h3>
<table class="listing">
	<tr class="first">
		<th>日期</th>
		<%
			for (String itemid : thList) {
				out.println("<th>" + itemMap.get(itemid) + "</th>");
			}
		%>
	</tr>
	<%
		for (String date : ddateList) {
	%>
	<tr>
		<td><%=date.toString().substring(0, 10)%></td>
		<%
			for (String itemid : thList) {
					if (goldBuyEquipmentMap.get(date + itemid) == null) {
						out.println("<td>0</td>");
					} else {
						out.println("<td>"
								+ goldBuyEquipmentMap.get(date + itemid)
								+ "</td>");
					}
				}
		%>
	</tr>
	<%
		}
	%>
</table>
<br>
<br>
<%
	ds = DBUtil.db
			.execSQL(
					"select edate,itemid,num,person,amount from selling_equiment where edate >= ? and edate <= ?  and type='Equipment' and usetype='Credit' order by edate desc ",
					new Object[] { startTime, endTime });
	ddateList = new ArrayList<String>();
	thList = new ArrayList<String>();
	goldBuyEquipmentMap = new HashMap<String, String>();
	goldBuyAllMap = new HashMap<String, String>();
	try {
		while (ds.next()) {
			String _time = ds.getDate("edate").toString();
			if (!ddateList.contains(_time)) {
				ddateList.add(_time);
			}
			int itemid = ds.getInt("itemid");
			if (itemid == 9999) {
				goldBuyAllMap.put(_time + "num", ds.getInt("num") + "");
				goldBuyAllMap.put(_time + "person", ds.getInt("person")
						+ "");
				goldBuyAllMap.put(_time + "amount",
						ds.getLong("amount") + "");
			} else {
				if (!thList.contains(itemid + "")) {
					thList.add(itemid + "");
				}

				goldBuyEquipmentMap.put(_time + itemid + "",
						ds.getInt("num") + "");
			}
		}

	} catch (Exception e) {
		e.printStackTrace();
	}

	ds = DBUtil.dbconf.execSQL(
			"select itemid,itemcredittext from shopitem",
			new Object[] {});
	itemMap = new HashMap<String, String>();
	try {
		while (ds.next()) {
			itemMap.put(ds.getInt("itemid") + "",
					ds.getString("itemcredittext"));
		}

	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<h3>蓝宝石购买装备</h3>
<table class="listing">
	<tr class="first">
		<th>日期</th>
		<th>购买次数</th>
		<th>购买人数</th>
		<th>金额</th>
	</tr>
	<%
		for (String date : ddateList) {
	%>
	<tr>
		<td><%=date.toString().substring(0, 10)%></td>
		<td><%=goldBuyAllMap.get(date + "num")%></td>
		<td><%=goldBuyAllMap.get(date + "person")%></td>
		<td><%=goldBuyAllMap.get(date + "amount")%></td>
	</tr>
	<%
		}
	%>
</table>
<br />
<br />
<h3>蓝宝石购买装备详细</h3>
<table class="listing">
	<tr class="first">
		<th>日期</th>
		<%
			for (String itemid : thList) {
				out.println("<th>" + itemMap.get(itemid) + "</th>");
			}
		%>
	</tr>
	<%
		for (String date : ddateList) {
	%>
	<tr>
		<td><%=date.toString().substring(0, 10)%></td>
		<%
			for (String itemid : thList) {
					if (goldBuyEquipmentMap.get(date + itemid) == null) {
						out.println("<td>0</td>");
					} else {
						out.println("<td>"
								+ goldBuyEquipmentMap.get(date + itemid)
								+ "</td>");
					}
				}
		%>
	</tr>
	<%
		}
	%>
</table>
<br>
<br>
<%
	ds = DBUtil.db
			.execSQL(
					"select edate,itemid,num,person,amount from selling_equiment where edate >= ? and edate <= ?  and type='ReinforceStone' and usetype='Credit' order by edate desc ",
					new Object[] { startTime, endTime });
	ddateList = new ArrayList<String>();
	thList = new ArrayList<String>();
	goldBuyEquipmentMap = new HashMap<String, String>();
	goldBuyAllMap = new HashMap<String, String>();
	try {
		while (ds.next()) {
			String _time = ds.getDate("edate").toString();
			if (!ddateList.contains(_time)) {
				ddateList.add(_time);
			}
			int itemid = ds.getInt("itemid");
			System.out.println(itemid);
			if (itemid == 9999) {
				goldBuyAllMap.put(_time + "num", ds.getInt("num") + "");
				goldBuyAllMap.put(_time + "person", ds.getInt("person")
						+ "");
				goldBuyAllMap.put(_time + "amount",
						ds.getLong("amount") + "");
			} else {
				if (!thList.contains(itemid + "")) {
					thList.add(itemid + "");
				}

				goldBuyAllMap.put(_time + "num" + itemid, ds.getInt("num") + "");
				goldBuyAllMap.put(_time + "person" + itemid, ds.getInt("person")+ "");
				goldBuyAllMap.put(_time + "amount" + itemid,ds.getLong("amount") + "");
			}
		}

	} catch (Exception e) {
		e.printStackTrace();
	}
%>

<h3>蓝宝石购买强化石</h3>
<table class="listing">
	<tr class="first">
		<th>日期</th>
		<th>购买次数</th>
		<th>购买人数</th>
		<th>金额</th>
	</tr>
	<%
		for (String date : ddateList) {
	%>
	<tr>
		<td><%=date.toString().substring(0, 10)%></td>
		<td><%=goldBuyAllMap.get(date + "num")%></td>
		<td><%=goldBuyAllMap.get(date + "person")%></td>
		<td><%=goldBuyAllMap.get(date + "amount")%></td>
	</tr>
	<%
		}
	%>
</table>
<br />
<br />
<h3>蓝宝石购买强化石详细</h3>
<table class="listing">
	<tr class="first">
		<th rowspan='2'>日期</th>
		<%
			Map<String,String> thMap = new HashMap<String,String>();
			thMap.put("1","普通强化石捆绑50个卖");
			thMap.put("2","普通强化石捆绑150个卖");
			thMap.put("3","高级强化石捆绑30个卖");
			thMap.put("4","高级强化石捆绑100个卖");
			thMap.put("5","超级强化石捆绑5个卖");
			thMap.put("6","超级强化石捆绑50个卖");
			for (String itemid : thList) {
				out.println("<th colspan='3'>" + thMap.get(itemid) + "</th>");
			}
		%>
	</tr>
	<tr>
	<%
		for (String itemid : thList) {
			out.println("<th>购买次数</th>");
			out.println("<th>购买人数</th>");
			out.println("<th>购买花费的蓝宝石</th>");
		}
	%>
	</tr>
	<%
		for (String date : ddateList) {
	%>
	<tr>
		<td><%=date.toString().substring(0, 10)%></td>
	<% 
		for (String itemid : thList) {
		%>
			<td><%=goldBuyAllMap.get(date + "num" + itemid)==null ? "0" : goldBuyAllMap.get(date + "num" + itemid) %></td>
			<td><%=goldBuyAllMap.get(date + "person" + itemid)==null ? "0" : goldBuyAllMap.get(date + "person" + itemid) %></td>
			<td><%=goldBuyAllMap.get(date + "amount" + itemid)==null ? "0" : goldBuyAllMap.get(date + "amount" + itemid) %></td>
		<% 
		}
	%>
	</tr>
	<%
		}
	%>
</table>
</html>