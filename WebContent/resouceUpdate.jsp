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
		//if (session != null && session.getAttribute("login") != null) {
		//	if (session.getAttribute("login").equals("ok")) {
				String ftime = request.getParameter("time");
				String ttime = request.getParameter("time2");

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
				String sql = "select * from resouceUpdate where rdate between ? and ?  order by rdate desc ";
				DBResultSet ds = DBUtil.db.execSQL(sql, new Object[]{ftime,ttime});
				while(ds.next()){
					Date date = ds.getDate("rdate");
					if(!dateList.contains(date)){
						dateList.add(date);
					}
					String pfrom =  ds.getString("platFrom");
					
					map.put(date + pfrom + "resouceUpdate", ds.getInt("resouceUpdate"));
					map.put(date + pfrom + "resouceUpdateSuccess", ds.getInt("resouceUpdateSuccess"));
					map.put(date + pfrom + "updateLoginSuccess", ds.getInt("updateLoginSuccess"));
					map.put(date + pfrom + "login", ds.getInt("login"));
					map.put(date + pfrom + "loginSuccess", ds.getInt("loginSuccess"));
				} 
				
				
		
	%>
	<div class="container">
	<table class="table table-striped table-bordered table-hover table-condensed">
		<tr>
		<th>日期</th>
		<th>手机平台</th>
		<th>资源更新人数</th>
		<th>资源更新成功人数</th>
		<th>更新资源成功且登录成功人数</th>
		<th>总登陆人数</th>
		<th>总登陆成功人数</th>
		<th>资源更新成功率</th>
		<th>登录成功/资源更新成功</th>
		<th>总登陆成功率</th>
		</tr>
		
		<%
		DecimalFormat df = new DecimalFormat("#.00");
		for(Date d: dateList){
		%>
			<tr>
			<td rowspan='4'><%=d.toString().substring(0,10) %></td>
			<td>BB</td>
			<td><%=map.get(d + "BB" + "resouceUpdate") %></td>
			<td><%=map.get(d + "BB" + "resouceUpdateSuccess") %></td>
			<td><%=map.get(d + "BB" + "updateLoginSuccess") %></td>
			<td><%=map.get(d + "BB" + "login") %></td>
			<td><%=map.get(d + "BB" + "loginSuccess") %></td>
			<td><%=df.format(map.get(d + "BB" + "resouceUpdateSuccess")/(float)map.get(d + "BB" + "resouceUpdate")*100.0)+"%" %></td>
			<td><%=df.format(map.get(d + "BB" + "updateLoginSuccess")/(float)map.get(d + "BB" + "resouceUpdateSuccess")*100.0)+"%" %></td>
			<td><%=df.format(map.get(d + "BB" + "loginSuccess")/(float)map.get(d + "BB" + "login")*100.0)+"%" %></td>
			</tr>
			<tr>
			<td>J2ME</td>
			<td><%=map.get(d + "J2ME" + "resouceUpdate") %></td>
			<td><%=map.get(d + "J2ME" + "resouceUpdateSuccess") %></td>
			<td><%=map.get(d + "J2ME" + "updateLoginSuccess") %></td>
			<td><%=map.get(d + "J2ME" + "login") %></td>
			<td><%=map.get(d + "J2ME" + "loginSuccess") %></td>
			<td><%=df.format(map.get(d + "J2ME" + "resouceUpdateSuccess")/(float)map.get(d + "J2ME" + "resouceUpdate")*100.0)+"%" %></td>
			<td><%=df.format(map.get(d + "J2ME" + "updateLoginSuccess")/(float)map.get(d + "J2ME" + "resouceUpdateSuccess")*100.0)+"%" %></td>
			<td><%=df.format(map.get(d + "J2ME" + "loginSuccess")/(float)map.get(d + "J2ME" + "login")*100.0)+"%" %></td>
			</tr>
			<tr>
			<td>Android</td>
			<td><%=map.get(d + "Android" + "resouceUpdate") %></td>
			<td><%=map.get(d + "Android" + "resouceUpdateSuccess") %></td>
			<td><%=map.get(d + "Android" + "updateLoginSuccess") %></td>
			<td><%=map.get(d + "Android" + "login") %></td>
			<td><%=map.get(d + "Android" + "loginSuccess") %></td>
			<td><%=df.format(map.get(d + "Android" + "resouceUpdateSuccess")/(float)map.get(d + "Android" + "resouceUpdate")*100.0)+"%" %></td>
			<td><%=df.format(map.get(d + "Android" + "updateLoginSuccess")/(float)map.get(d + "Android" + "resouceUpdateSuccess")*100.0)+"%" %></td>
			<td><%=df.format(map.get(d + "Android" + "loginSuccess")/(float)map.get(d + "Android" + "login")*100.0)+"%" %></td>
			</tr>
			<tr>
			<td>All</td>
			<td><%=map.get(d + "BB" + "resouceUpdate") +map.get(d + "J2ME" + "resouceUpdate")+map.get(d + "Android" + "resouceUpdate") %></td>
			<td><%=map.get(d + "BB" + "resouceUpdateSuccess")+map.get(d + "J2ME" + "resouceUpdateSuccess")+map.get(d + "Android" + "resouceUpdateSuccess") %></td>
			<td><%=map.get(d + "BB" + "updateLoginSuccess")+map.get(d + "J2ME" + "updateLoginSuccess")+map.get(d + "Android" + "updateLoginSuccess") %></td>
			<td><%=map.get(d + "BB" + "login")+map.get(d + "J2ME" + "login")+map.get(d + "Android" + "login") %></td>
			<td><%=map.get(d + "BB" + "loginSuccess")+map.get(d + "J2ME" + "loginSuccess")+map.get(d + "Android" + "loginSuccess") %></td>
			<td><%=df.format((map.get(d + "BB" + "resouceUpdateSuccess")+map.get(d + "J2ME" + "resouceUpdateSuccess")+map.get(d + "Android" + "resouceUpdateSuccess"))/(float)(map.get(d + "BB" + "resouceUpdate") +map.get(d + "J2ME" + "resouceUpdate")+map.get(d + "Android" + "resouceUpdate") )*100.0)+"%" %></td>
			<td><%=df.format((map.get(d + "BB" + "updateLoginSuccess")+map.get(d + "J2ME" + "updateLoginSuccess")+map.get(d + "Android" + "updateLoginSuccess"))/(float)(map.get(d + "BB" + "resouceUpdateSuccess")+map.get(d + "J2ME" + "resouceUpdateSuccess")+map.get(d + "Android" + "resouceUpdateSuccess"))*100.0)+"%" %></td>
			<td><%=df.format((map.get(d + "BB" + "loginSuccess")+map.get(d + "J2ME" + "loginSuccess")+map.get(d + "Android" + "loginSuccess"))/(float)(map.get(d + "BB" + "login")+(float)+map.get(d + "J2ME" + "login")+map.get(d + "Android" + "login"))*100.0)+"%" %></td>
			</tr>
			
		<%
		}
		//	}
		//} else {
		//	response.sendRedirect("index.jsp");
	//	}
		%>
		
	</table>
	</div>
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