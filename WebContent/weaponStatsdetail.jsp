<%@page import="util.*"%>
<%@page import="com.mozat.morange.util.DBResultSet"%>
<%@ page contentType="text/html;charset=utf8"%>
<%@ page
	import="java.util.*,OAStat.*,java.util.Date,java.text.*,userStats.*,toolStat.*"%>

<!DOCTYPE html >
<html>
<head>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/datetimepicker.css" rel="stylesheet">
<style>
body {
	background: #f8fcd4;
	background: radial-gradient(center, ellipse cover, #f8fcd4 19%, #dbfacb 100%);
	background-attachment: fixed;
}
td th {
	text-align:center;	
	}
</style>
</head>
<body>
	<br />
	<div class="container">
		<form action="" method="post">

			<div class="control-group">
				<label class="control-label">BeginDate</label>
				<div class="controls input-append date form_date" data-date=""
					data-date-format="yyyy-mm-dd" data-link-field="dtp_input2"
					data-link-format="yyyy-mm-dd">
					<input size="16" type="text" value="" name="time" readonly> <span
						class="add-on"><i class="icon-remove"></i></span> <span
						class="add-on"><i class="icon-th"></i></span>
				</div>
				<label class="control-label">BendDate</label>
				<div class="controls input-append date form_date" data-date=""
					data-date-format="yyyy-mm-dd" data-link-field="dtp_input2"
					data-link-format="yyyy-mm-dd">
					<input size="16" type="text" value="" name="time2" readonly> <span
						class="add-on"><i class="icon-remove"></i></span> <span
						class="add-on"><i class="icon-th"></i></span>
				</div><br />
				<input type="text" placeholder="手动输入weaponid" name="weaponid"/>
				<button type="submit" class="btn btn-primary">Submit</button><br />
			</div>
			
		</form>
	</div>
	<br />


	<%
		//if (session != null && session.getAttribute("login") != null) {
			//if (session.getAttribute("login").equals("ok")) {
				String ftime = request.getParameter("time");
				String ttime = request.getParameter("time2");
				String weaponstr = request.getParameter("weaponid");
				int weaponid = 22;
				try{
				weaponid = Integer.parseInt(weaponstr);
				}catch(Exception ee){
					System.out.print("weaponid错误");
				}
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

				if (ftime == null || "".equals(ftime)) {
					Calendar c = Calendar.getInstance();
					c.add(Calendar.DATE, -7);
					ftime = sdf.format(c.getTime());
				}
				if (ttime == null || "".equals(ttime)) {
					Calendar c = Calendar.getInstance();
					c.add(Calendar.DATE, +1);
					ttime = sdf.format(c.getTime());
				}
				Map<String,Integer> map  = new HashMap<String,Integer>();
				List<Date> dateList = new ArrayList<Date>();
				String sql = "SELECT type,wdate,[from], amount  from weaponStatus  where wdate between ? and ? and weaponid = ? order by wdate desc ";
				 DBResultSet ds = DBUtil.db.execSQL(sql, new Object[]{ftime,ttime,weaponid});
				while(ds.next()){
					Date date = ds.getDate("wdate");
					if(!dateList.contains(date)){
						dateList.add(date);
					}
					map.put(date + ds.getString("type") +ds.getString("from") , ds.getInt("amount"));
				} 
				
				Map<Integer,String> weaponMap = new HashMap<Integer,String>();
				weaponMap.put(22, "M1");
				weaponMap.put(23, "M2");
				weaponMap.put(24, "M3");
				weaponMap.put(25, "M4");
				weaponMap.put(26, "M5");
				weaponMap.put(27, "M6");
				weaponMap.put(28, "M7");
				weaponMap.put(29, "M8");
				weaponMap.put(30, "M9");
				weaponMap.put(31, "D1");
				weaponMap.put(32, "D2");
				weaponMap.put(33, "D3");
				weaponMap.put(34, "D4");
				weaponMap.put(35, "T1");
				weaponMap.put(36, "T2");
				weaponMap.put(37, "T3");
				
		//	}
		//} else {
		//	response.sendRedirect("index.jsp");

		//}
	%>
	<div class="container">
	<table class="table table-striped table-bordered table-hover table-condensed">
		<tr>
		<th rowspan='2'>日期</th>
		<th colspan='5'><%=weaponMap.get(weaponid) %>产出</th>
		<th colspan='3'><%=weaponMap.get(weaponid) %>消耗</th>
		
		</tr>
		<tr>
		<th>金币购买</th>
		<th>蓝宝石购买</th>
		<th>任务奖励</th>
		<th>免费抽奖</th>
		<th>蓝宝石抽奖</th>
		<th>个人打怪</th>
		<th>炸人</th>
		<th>家族打怪</th>
		</tr>
		
		 <%
		 for(Date d : dateList){
		 %>
		 <tr>
		 <td><%=d.toString().substring(0,10) %></td>
		 <td><%=map.get(d+ "in" + "Gold")==null?0:map.get(d+ "in" + "Gold") %></td>
		 <td><%=map.get(d+ "in" + "Credit")==null?0:map.get(d+ "in" + "Credit") %></td>
		 <td><%=map.get(d+ "in" + "Mission")==null?0:map.get(d+ "in" + "Mission") %></td>
		 <td><%=map.get(d+ "in" + "FreeLucky")==null?0:map.get(d+ "in" + "FreeLucky") %></td>
		 <td><%=map.get(d+ "in" + "CreditLucky")==null?0:map.get(d+ "in" + "CreditLucky") %></td>
		 <td><%=map.get(d+ "out" + "attackPerson")==null?0:map.get(d+ "out" + "attackPerson") %></td>
		 <td><%=map.get(d+ "out" + "attackFisher")==null?0:map.get(d+ "out" + "attackFisher") %></td>
		 <td><%=map.get(d+ "out" + "tribe")==null?0:map.get(d+ "out" + "tribe") %></td>
		 </tr>
		 <% 
		 }
		 %>
	</table>
	
	
	</div>
</body>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript">
	$('.form_date').datetimepicker({
		language : 'zh-CN',
		weekStart : 1,
		todayBtn : 1,
		autoclose : 1,
		todayHighlight : 1,
		startView : 2,
		minView : 2,
		forceParse : 0
	});
</script>
</html>