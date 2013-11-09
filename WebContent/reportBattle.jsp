<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sun.java2d.pipe.SpanShapeRenderer.Simple"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="util.*"%>
<%@ page import="com.mozat.morange.util.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<%
	String startTime = request.getParameter("time");
	String endTime = request.getParameter("time2");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	if(startTime==null&&endTime==null){
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DATE, -1);
		endTime = sdf.format(c.getTime());
		
		c.add(Calendar.DATE, -7);
		startTime = sdf.format(c.getTime());
	}
	
	
	
	DBResultSet ds=DBUtil.db.execSQL("select * from reportbattle where rdate >= ? and rdate <= ?   order by rdate desc", new Object[]{startTime,endTime});
	Map<Date,ArrayList<Integer>> rMap = new HashMap<Date,ArrayList<Integer>>();
	Map<Date,ArrayList<Integer>> bMap = new HashMap<Date,ArrayList<Integer>>();
	Map<Date,String> oMap = new HashMap<Date,String>();
	List<Date> dateList = new ArrayList<Date>();
	
	try{
		while(ds.next()){
			Date date = ds.getDate("rdate");
			dateList.add(date);
			ArrayList<Integer> alllist = new ArrayList<Integer>();
			alllist.add(ds.getInt("allnum"));
			alllist.add(ds.getInt("allperson"));
			alllist.add(ds.getInt("successnum"));
			alllist.add(ds.getInt("successperson"));
			alllist.add(ds.getInt("failnum"));
			alllist.add(ds.getInt("failperson"));
			alllist.add(ds.getInt("reward"));
			rMap.put(date, alllist);
			ArrayList<Integer> buylist = new ArrayList<Integer>();
			buylist.add(ds.getInt("buynum"));
			buylist.add(ds.getInt("buyperson"));
			buylist.add(ds.getInt("buyamount"));
			bMap.put(date, buylist);
			
			oMap.put(date,ds.getString("other"));
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>����������</h1>
	<h3>��ѡ</h3>
	ʱ�䣺<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="��ѯ" />
</form>
<br />
<br />
<table class="listing">
	<tr class="first">
		<th>����</th>
		<th>����ս����</th>
		<th>����ս����</th>
		<th>ʤ����ս����</th>
		<th>ʤ����ս����</th>
		<th>ʧ����ս����</th>
		<th>ʧ����ս����</th>
		<th>������ȡ����</th>
	</tr>
	<%
		for(Date date:dateList){
		%>
	<tr>
		<td><%=date.toString().substring(0,10) %></td>
		<%
			ArrayList<Integer> rlist = rMap.get(date);
			for(int r : rlist){
			%>
		<td><%=r %></td>
		<% 	
			}
			%>
	</tr>
	<% 	
		}
		%>
</table>
<br />
<h1>��������������ս����</h1>
<table class="listing">
	<%
		
		for(Date date:dateList){
			String other = oMap.get(date);
			String[] others = other.split(",");
		%>

	<tr>
		<td>������id</td>
		<% 
				for(String s : others){
					out.println("<td>" + s.split(":")[0] + "</td>");
				}
			break;
		}
			%>
	</tr>
	<%
		
		for(Date date:dateList){
			String other = oMap.get(date);
			String[] others = other.split(",");
		%>

	<tr>
		<td><%=date.toString().substring(0,10) %></td>
		<% 
					for(String s : others){
						out.println("<td>" + s.split(":")[1] + "</td>");
					}
				}
				%>
	</tr>


</table>
<br />
<h1>������ս</h1>
<table class="listing">
	<tr class="first">
		<th>����</th>
		<th>������ս����</th>
		<th>������ս����</th>
		<th>������ս��������ʯ</th>
	</tr>
	<%
		for(Date date:dateList){
		%>
	<tr>
		<td><%=date.toString().substring(0,10) %></td>
		<%
			ArrayList<Integer> rlist = bMap.get(date);
			for(int r : rlist){
			%>
		<td><%=r %></td>
		<% 	
			}
			%>
	</tr>
	<% 	
		}
		%>
</table>


</html>