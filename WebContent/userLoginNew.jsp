<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sun.java2d.pipe.SpanShapeRenderer.Simple"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="util.*"%>
<%@ page import="com.mozat.morange.util.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<%
	if(session==null||session.getAttribute("login")==null){
		response.sendRedirect("index.jsp");
	}	

	String startTime = request.getParameter("time");
	String endTime = request.getParameter("time2");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df =  new DecimalFormat("####.##");
	if(startTime==null&&endTime==null){
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DATE, -1);
		endTime = sdf.format(c.getTime());
		
		c.add(Calendar.DATE, -7);
		startTime = sdf.format(c.getTime());
	}
	
	List<String> thList = new ArrayList<String>();
	thList.add("all");
	thList.add("stc");
	thList.add("inmobi");
	thList.add("Egypt");
	
	List<String> thList2 = new ArrayList<String>();
	thList2.add("reg");
	thList2.add("login");
	thList2.add("db");
	
	Map<String,String> titleMap = new HashMap<String,String>();
	
	titleMap.put("all","汇总");
	titleMap.put("inmobi","Inmobi");
	titleMap.put("Egypt","Egypt");
	titleMap.put("stc","Stc");
	
	titleMap.put("reg","注册用户数");
	titleMap.put("login","登陆用户数");
	titleMap.put("db","新Fisher");
	
	
	DBResultSet ds=DBUtil.db.execSQL("select * from regUserConvert where rdate >= ? and rdate <= ? order by rdate desc",
					new Object[] { startTime, endTime });
	List<String> ddateList = new ArrayList<String>();
	Map<String, String> resultMap = new HashMap<String, String>();
	try {
		while (ds.next()) {
			String _time = sdf.format(ds.getDate("rdate"));
			if (!ddateList.contains(_time)) {
				ddateList.add(_time);
			}
			resultMap.put(_time + "_" + ds.getString("oakey"),
					ds.getFloat("oavalue") + "");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>用户登陆</h1>
	<h3>可选</h3>
	时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="查询" />
</form>
<table class="listing" >
	<%
			for(String th : thList){
				out.println("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\"><tr class=\"first\" width=\"177\"><th colspan=7>"+titleMap.get(th)+"</th></tr>");
				out.println("<tr class=\"first\" width=\"177\">");
				out.println("<th>日期</th>");
				for(String th1 : thList2){
					out.println("<th>"+titleMap.get(th1)+"</th>");
				}
				
				out.println("<th>登陆/注册</th>");
				out.println("<th>新Fisher/登陆</th>");
				out.println("<th>总转化率</th>");
				out.println("</tr>");
				
				for(String time : ddateList){
					out.println("<tr>");
					out.println("<td>"+time+"</td>");
					for(String th1 : thList2){
						out.println("<td>"+resultMap.get(time+"_"+th+"_"+th1)+"</td>");
					}
					out.println("<td>"+df.format(new Double(resultMap.get(time+"_"+th+"_login"))*100/new Double(resultMap.get(time+"_"+th+"_reg")))+"%</td>");
					out.println("<td>"+df.format(new Double(resultMap.get(time+"_"+th+"_db"))*100/new Double(resultMap.get(time+"_"+th+"_login")))+"%</td>");
					out.println("<td>"+df.format(new Double(resultMap.get(time+"_"+th+"_db"))*100/new Double(resultMap.get(time+"_"+th+"_reg")))+"%</td>");
					out.println("</tr>");
				}
				
				out.println("</table><br><br>");
			}
		%>


	</html>