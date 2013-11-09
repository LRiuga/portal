<%@page import="util.*"%>
<%@page import="com.mozat.morange.util.DBResultSet"%>
<%@page contentType="text/html;charset=utf8"%>
<%@page import="java.util.*,OAStat.*,java.util.Date,java.text.*,userStats.*,toolStat.*"%>

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
				</div><br />
				<button type="submit" class="btn btn-primary">Submit</button><br />
			</div>
			
		</form>
	</div>
	<br />


	<%
		if (session != null && session.getAttribute("login") != null) {
			if (session.getAttribute("login").equals("ok")) {
				String ftime = request.getParameter("time");
				String ttime = request.getParameter("time2");

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

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
				System.out.println(ftime+ "-----"+ ttime);
				Map<String,Integer> map  = new HashMap<String,Integer>();
				List<Date> dateList = new ArrayList<Date>();
				String sql = "select * from tribeSum where date between ? and ? and dsum = 3 order by date desc ";
				 DBResultSet ds = DBUtil.db.execSQL(sql, new Object[]{ftime,ttime});
				while(ds.next()){
					Date date = ds.getDate("date");
					if(!dateList.contains(date)){
						dateList.add(date);
					}
					map.put(date + "create", ds.getInt("createMonter"));
					map.put(date + "kill", ds.getInt("killMonter"));
					map.put(date + "tribeNum", ds.getInt("tribeNum"));
					map.put(date + "person", ds.getInt("person"));
					map.put(date + "num", ds.getInt("num"));
					map.put(date + "wnum", ds.getInt("wnum"));
				} 
				
				
		
	%>
	<div class="container">
	<table class="table table-striped table-bordered table-hover table-condensed">
		<tr>
		<th>周期</th>
		<th>产生怪物个数</th>
		<th>杀死怪物个数</th>
		<th>杀死怪物占比</th>
		<th><a href='tribeAttAndwg.jsp'>参与打怪家族数</a></th>
		<th>参与打怪人数</th>
		<th>参与打怪次数</th>
		<th>围观人数</th>
		</tr>
		
		<%
		DecimalFormat df = new DecimalFormat("#.00");
		for(Date d: dateList){
			Calendar c = Calendar.getInstance();
			c.setTime(d);
			c.add(Calendar.DATE, -2);
			Date ed = c.getTime();
			
			int dd = dayOfWeek(ed);
			if(!(dd == 2 || dd == 5)){
				continue;
			}
		%><tr>
			<td><a href='tribeMonterday.jsp?time=<%=sdf.format(ed)%>&time2=<%=sdf.format(d)%>'><%=sdf.format(ed) + "~"  + sdf.format(d)%></a></td>
			<td><%=map.get(d + "create") %></td>
			<td><%=map.get(d + "kill") %></td>
			<td><%=df.format(map.get(d + "kill")/(float)map.get(d + "create")*100.0)+"%" %></td>
			<td><%=map.get(d + "tribeNum") %></td>
			<td><%=map.get(d + "person") %></td>
			<td><%=map.get(d + "num") %></td>
			<td><%=map.get(d + "wnum") %></td>
			</tr>
		<%
				}
			}
			} else {
				response.sendRedirect("index.jsp");

			}
		%>
		
	</table>
	</div>
	<%!
		//判断日期为星期几,0为星期六,依此类推
		public static int dayOfWeek(Date date){
		    //首先定义一个calendar，必须使用getInstance()进行实例化
		    Calendar aCalendar=Calendar.getInstance();
		    //里面野可以直接插入date类型
		    aCalendar.setTime(date);
		    //计算此日期是一周中的哪一天
		    int x=aCalendar.get(Calendar.DAY_OF_WEEK);
		    return x;
		}
	%>
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