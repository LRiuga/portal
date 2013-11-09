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
	Map<String,String> thMap=new HashMap<String,String>();
	List<String> thList = new ArrayList<String>();
	List<String> th2List = new ArrayList<String>();
	List<String> th3List = new ArrayList<String>();
	Map<String,Integer> dataMap=new HashMap<String,Integer>();
	try{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	
		DecimalFormat df =  new DecimalFormat("####.##");
		
		String startTime = request.getParameter("time");
		String endTime = request.getParameter("time2");
		if(startTime==null&&endTime==null){
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DATE, -1);
			endTime = sdf.format(c.getTime());
			
			c.add(Calendar.DATE, -7);
			startTime = sdf.format(c.getTime());
		}
		
		thMap.put("1", "��");
		thMap.put("2", "��");
		thMap.put("3", "��");
		thMap.put("4", "��");
		thMap.put("5", "��");
		thMap.put("6", "��");
		th3List.add("1");
		th3List.add("2");
		th3List.add("3");
		th3List.add("4");
		th3List.add("5");
		th3List.add("6");
		
		DBResultSet ds =  DBUtil.db.execSQL("select distinct wearlevel from EquipmentConfig order by wearlevel", new Object[]{});
		while(ds.next()){
			th2List.add(""+ds.getInt("wearlevel"));
		}
		
		ds=DBUtil.db.execSQL("select sum(oavalue) oavalue,wearlevel,qualityLevel,dtime from (select * from EquipmentActivityUserReinforce where reinforce = 'ALL' and dtime > ? and dtime <= ?) eua left join equipmentconfig e on eua.typeid=e.typeid group by wearlevel,qualityLevel,dtime order by dtime desc,wearlevel,qualityLevel", new Object[]{startTime,endTime});
		
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			
			if(!thList.contains(_time)){
				thList.add(_time);
			}
			
			dataMap.put(_time+"_"+ds.getInt("wearlevel")+"_"+ds.getInt("qualityLevel"), ds.getInt("oavalue"));
			
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>

<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>��Ծ�û�װ���ֲ�</h1>
	<h3>��ѡ</h3>
	ʱ�䣺<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="��ѯ" />
</form>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th rowspan=2>����/����</th>
		<%
			for(String k :th2List){
				out.print("<th colspan=6>LV"+k+"</th>");
			}
		%>
	</tr>

	<tr class="first" width="177">
		<%
			for(String k1 :th2List){
				for(String k :th3List){
					out.print("<th>"+thMap.get(k)+"</th>");
				}
			}
		%>
	</tr>

	<%
		for(String key:thList){
			out.println("<tr>");
				out.print("<td>"+key+"</td>");
				for(String key1:th2List){
					for(String key2:th3List){
						out.print("<td>"+(dataMap.get(key+"_"+key1+"_"+key2)==null?"-":dataMap.get(key+"_"+key1+"_"+key2))+"</td>");
					}
				}
			out.println("</tr>");
		}
	%>
</table>

<br>
<br>