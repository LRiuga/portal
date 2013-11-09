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
	text-align: center;
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
					<input size="16" type="text" value="" name='time' readonly> <span
						class="add-on"><i class="icon-remove"></i></span> <span
						class="add-on"><i class="icon-th"></i></span>
				</div>
				<label class="control-label">BendDate</label>
				<div class="controls input-append date form_date" data-date=""
					data-date-format="yyyy-mm-dd" data-link-field="dtp_input2"
					data-link-format="yyyy-mm-dd">
					<input size="16" type="text" value="" name='time2' readonly> <span
						class="add-on"><i class="icon-remove"></i></span> <span
						class="add-on"><i class="icon-th"></i></span>
				</div>
				<br />
				<button type="submit" class="btn btn-primary">Submit</button>
				<br />
			</div>

		</form>
	</div>
	<br />


	<%
		if (session != null && session.getAttribute("login") != null) {
			if (session.getAttribute("login").equals("ok")) {
				String ftime = request.getParameter("time");
				String ttime = request.getParameter("time2");

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

				if (ftime == null || "".equals(ftime)) {
					Calendar c = Calendar.getInstance();
					c.add(Calendar.DATE, -21);
					ftime = sdf.format(c.getTime());
				}
				if (ttime == null || "".equals(ttime)) {
					Calendar c = Calendar.getInstance();
					c.add(Calendar.DATE, +1);
					ttime = sdf.format(c.getTime());
				}
				Map<String, Integer> map = new HashMap<String, Integer>();
				List<Date> dateList = new ArrayList<Date>();
				String sql = "select * from tribeAttackAndweiguan where date between ? and ? and dsum = 3 and type = 'attack' order by date desc ";
				DBResultSet ds = DBUtil.db.execSQL(sql, new Object[] {
						ftime, ttime });
				while (ds.next()) {
					Date date = ds.getDate("date");
					if (!dateList.contains(date)) {
						dateList.add(date);
					}
					map.put(date + "" + ds.getInt("num"),
							ds.getInt("amount"));
				}
				
				Map<String, Integer> map2 = new HashMap<String, Integer>();
				List<Date> dateList2 = new ArrayList<Date>();
				String sql2 = "select * from tribeAttackAndweiguan where date between ? and ? and dsum = 3 and type = 'weiguan' order by date desc ";
				DBResultSet ds2 = DBUtil.db.execSQL(sql2, new Object[] {ftime, ttime });
				while (ds2.next()) {
					Date date = ds2.getDate("date");
					if (!dateList2.contains(date)) {
						dateList2.add(date);
					}
					map2.put(sdf.format(date) + "_" + ds2.getInt("num"),
							ds2.getInt("amount"));
				}

				System.out.print(map2);
	%>
	<div class="container">
		<table
			class="table table-striped table-bordered table-hover table-condensed">
			<tr>
				<th rowspan='2'>周期</th>
				<th colspan='10'>打怪人数</th>
			</tr>
			<tr>
				<%
					for (int i = 1; i <= 20; i++) {
				%>
				<th><%=i%></th>
				<%
					}
				%>

			</tr>
			
				<%
					for (Date d : dateList) {
						Calendar c = Calendar.getInstance();
						c.setTime(d);
						c.add(Calendar.DATE, -2);
						Date ed = c.getTime();
						int dd = dayOfWeek(ed);
						if(!(dd == 2 || dd == 5)){
							continue;
						}
				%>
				<tr>
				<td><%=sdf.format(ed) + "-" + sdf.format(d)%></td>
				<%
					for (int i = 1; i <= 20; i++) {
						int jiazushu = 0;
						if(map.get(d + "" + i) !=null){
							jiazushu =map.get(d + "" + i);
						}
								
				%>
					<td><%=jiazushu%></td>
				
				<%
					}
				%></tr><%
							}
				%>
			
		</table>
		<br /> <br /> <br />
		<!--
		<table
			class="table table-striped table-bordered table-hover table-condensed">
			<tr>
				<th rowspan='2'>周期</th>
				<th colspan='10'>围观人数</th>
			</tr>
			<tr>
				<%
					for (int i = 1; i <= 10; i++) {
				%>
				<th><%=i%></th>
				<%
					}
				%>

			</tr>
			<tr>
				<%
					for (Date d : dateList2) {
						Calendar c = Calendar.getInstance();
						c.add(Calendar.DATE, -2);
						Date ed = c.getTime();
						int dd = dayOfWeek(ed);
						if(!(dd == 2 || dd == 5)){
							continue;
						}
				%>
				<td><%=sdf.format(ed) + "-" + sdf.format(d)%></td>
				<%
					for (int i = 1; i <= 10; i++) {
				%>
				<td><%=map2.get(sdf.format(d) + "_" + i)%></td>
				<%
					}
							}
						}
					} else {
						response.sendRedirect("index.jsp");

					}
				%>
			</tr>
		</table> -->
	</div>
	<%!//判断日期为星期几,0为星期六,依此类推
	public static int dayOfWeek(Date date) {
		//首先定义一个calendar，必须使用getInstance()进行实例化
		Calendar aCalendar = Calendar.getInstance();
		//里面野可以直接插入date类型
		aCalendar.setTime(date);
		//计算此日期是一周中的哪一天
		int x = aCalendar.get(Calendar.DAY_OF_WEEK);
		return x;
	}%>
</body>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript"
	src="js/bootstrap-datetimepicker.zh-CN.js"></script>
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