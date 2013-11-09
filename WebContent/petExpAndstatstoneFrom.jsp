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

	Map<String, String> titleMap = new HashMap<String, String>();
	Map<String, Long> sumMap = new HashMap<String, Long>();
	titleMap.put("Activity", "运营活动奖励");
	titleMap.put("ActivityReward", "日常活动奖励");
	titleMap.put("addRewardsForKillingMonster", "家族打怪奖励");
	titleMap.put("arenaRankingReward", "竞技场排名奖励");
	titleMap.put("attackPersonalMonster", "个人打怪奖励");
	titleMap.put("reportBattle", "挑战奖励");

	DBResultSet ds = DBUtil.db
			.execSQL(
					"select * from petexpfrom where fdate >= ? and fdate <= ?   order by fdate desc",
					new Object[] { startTime, endTime });
	List<String> ddateList = new ArrayList<String>();
	List<String> thList = new ArrayList<String>();
	Map<String, String> resultMap = new HashMap<String, String>();
	try {
		while (ds.next()) {
			String _time = ds.getDate("fdate").toString();
			if (!ddateList.contains(_time)) {
				ddateList.add(_time);
			}
			String th = ds.getString("fromkey");
			if(th.startsWith("Activity") && !"ActivityReward".equals(th)){
				th="Activity";
			}
			if (!thList.contains(th)) {
				thList.add(th);
			}
			if(resultMap.containsKey(_time+"_" + th))
			{
				long value = Long.parseLong(resultMap.get(_time+"_" + th));
				resultMap.put(_time + "_" + th,
						(ds.getLong("fromvalue") +value)+ "");
			}else{
				resultMap.put(_time + "_" + th,
						ds.getLong("fromvalue") + "");
			}
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>宠物经验与星玉来源</h1>
	<h3>可选</h3>
	时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="查询" />
</form>
<h2>宠物经验来源</h2>
<table class="listing">
	<tr class="first">
		<th>日期/PV</th>
		<%
			for (String time : ddateList) {
				long sum = 0;
				for (String th : thList) {
					if(resultMap.get(time + "_" + th) !=null)
					sum += Long.parseLong(resultMap.get(time + "_" + th));
				}
				sumMap.put(time, sum);
			}

			for (String th : thList) {
				out.println("<th colspan='2'>" + titleMap.get(th) + "</th>");
			}
		%>
	</tr>


	<%
		for (String time : ddateList) {
			out.println("<tr>");
			out.println("<td>" + time.substring(0, 10) + "</td>");
			for (String th : thList) {
				out.println("<td>" + resultMap.get(time + "_" + th)
						+ "</td>");
				if(resultMap.get(time + "_" + th) !=null){
				out.println("<td>"
						+ df2.format(Double.parseDouble(resultMap.get(time + "_" + th))
						* 100 / sumMap.get(time)) + "%" + "</td>");
				}else{
					out.println("<td>0.00%</td>");
				}
			}
			out.println("</tr>");
		}
	%>
</table>
<%
	titleMap = new HashMap<String, String>();

	titleMap.put("ActivityReward", "每日充值奖励");
	titleMap.put("Activity", "运营活动奖励");
	titleMap.put("Activity0", "9月25号以前没领奖的运营奖励");
	titleMap.put("addRewardsForKillingMonster", "家族打怪奖励");
	titleMap.put("ContinuousCheckIn", "连续签到奖励");
	titleMap.put("getMissionReward.upgradePet", "宠物升级任务奖励");
	titleMap.put("reportBattle", "挑战奖励");

	sumMap = new HashMap<String, Long>();
	ds = DBUtil.db
			.execSQL(
					"select * from starstonefrom where fdate >= ? and fdate <= ?   order by fdate desc",
					new Object[] { startTime, endTime });
	ddateList = new ArrayList<String>();
	thList = new ArrayList<String>();
	resultMap = new HashMap<String, String>();
	try {
		while (ds.next()) {
			String _time = ds.getDate("fdate").toString();
			if (!ddateList.contains(_time)) {
				ddateList.add(_time);
			}
			String th = ds.getString("fromkey");
			if(th.startsWith("Activity") && !"ActivityReward".equals(th) && !"Activity0".equals(th)){
				th="Activity";
			}
			if (!thList.contains(th)) {
				thList.add(th);
			}
			if(resultMap.containsKey(_time+"_" + th))
			{
				long value = Long.parseLong(resultMap.get(_time+"_" + th));
				resultMap.put(_time + "_" + th,
						(ds.getLong("fromvalue") +value)+ "");
			}else{
				resultMap.put(_time + "_" + th,
						ds.getLong("fromvalue") + "");
			}
			
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<br>
<br>
<h2>星玉来源</h2>
<table class="listing">
	<tr class="first">
		<th>日期/PV</th>
		<%
			for (String time : ddateList) {
				long sum = 0;
				for (String th : thList) {
					if(resultMap.get(time + "_" + th) !=null)
					sum += Long.parseLong(resultMap.get(time + "_" + th));
				}
				sumMap.put(time, sum);
			}
			for (String th : thList) {
				out.println("<th colspan='2'>" + titleMap.get(th) + "</th>");
			}
		%>
	</tr>


	<%
	
		for (String time : ddateList) {
			out.println("<tr>");
			out.println("<td>" + time.substring(0, 10) + "</td>");
			for (String th : thList) {
				out.println("<td>" + resultMap.get(time + "_" + th)
						+ "</td>");
				if(resultMap.get(time + "_" + th) !=null){
					out.println("<td>"
							+ df2.format(Double.parseDouble(resultMap.get(time + "_" + th))
							* 100 / sumMap.get(time)) + "%" + "</td>");
					}else{
						out.println("<td>0.00%</td>");
					}
			}
			out.println("</tr>");
		}
	%>
</table>
</html>