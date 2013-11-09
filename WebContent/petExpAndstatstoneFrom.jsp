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
	titleMap.put("Activity", "��Ӫ�����");
	titleMap.put("ActivityReward", "�ճ������");
	titleMap.put("addRewardsForKillingMonster", "�����ֽ���");
	titleMap.put("arenaRankingReward", "��������������");
	titleMap.put("attackPersonalMonster", "���˴�ֽ���");
	titleMap.put("reportBattle", "��ս����");

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
	<h1>���ﾭ����������Դ</h1>
	<h3>��ѡ</h3>
	ʱ�䣺<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="��ѯ" />
</form>
<h2>���ﾭ����Դ</h2>
<table class="listing">
	<tr class="first">
		<th>����/PV</th>
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

	titleMap.put("ActivityReward", "ÿ�ճ�ֵ����");
	titleMap.put("Activity", "��Ӫ�����");
	titleMap.put("Activity0", "9��25����ǰû�콱����Ӫ����");
	titleMap.put("addRewardsForKillingMonster", "�����ֽ���");
	titleMap.put("ContinuousCheckIn", "����ǩ������");
	titleMap.put("getMissionReward.upgradePet", "��������������");
	titleMap.put("reportBattle", "��ս����");

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
<h2>������Դ</h2>
<table class="listing">
	<tr class="first">
		<th>����/PV</th>
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