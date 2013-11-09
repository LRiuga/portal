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
	Map<String,Integer> data2Map=new HashMap<String,Integer>();
	
	Map<String,Integer> comMap=new HashMap<String,Integer>();
	Map<String,Integer> comMap2=new HashMap<String,Integer>();
	
	Map<String,Integer> advMap=new HashMap<String,Integer>();
	Map<String,Integer> advMap2=new HashMap<String,Integer>();
	
	Map<String,Integer> supMap=new HashMap<String,Integer>();
	Map<String,Integer> supMap2=new HashMap<String,Integer>();
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
		
		thMap.put("1", "白");
		thMap.put("2", "绿");
		thMap.put("3", "蓝");
		thMap.put("4", "紫");
		thMap.put("5", "橙");
		thMap.put("6", "金");
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
		
		ds=DBUtil.db.execSQL("select sum(reinforcecount) oavalue,wearlevel,qualityLevel,dtime from (select reinforcecount,equipmentid,dtime from EquipmentConsume_new where  dtime > ? and dtime <= ? and type = 'all' ) eua left join equipmentconfig e on eua.equipmentid=e.typeid group by wearlevel,qualityLevel,dtime order by dtime desc,wearlevel,qualityLevel", new Object[]{startTime,endTime});
		
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			if(!thList.contains(_time)){
				thList.add(_time);
			}
			dataMap.put(_time+"_"+ds.getInt("wearlevel")+"_"+ds.getInt("qualityLevel"), ds.getInt("oavalue"));
			
		}
		
		ds=DBUtil.db.execSQL("select sum(sapphirecount) oavalue,wearlevel,qualityLevel,dtime from (select sapphirecount,equipmentid,dtime from EquipmentConsume_new where  dtime > ? and dtime <= ? and type = 'all' ) eua left join equipmentconfig e on eua.equipmentid=e.typeid group by wearlevel,qualityLevel,dtime order by dtime desc,wearlevel,qualityLevel", new Object[]{startTime,endTime});
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			data2Map.put(_time+"_"+ds.getInt("wearlevel")+"_"+ds.getInt("qualityLevel"), ds.getInt("oavalue"));
		}
		
		ds=DBUtil.db.execSQL("select sum(reinforcecount) oavalue,wearlevel,qualityLevel,dtime from (select reinforcecount,equipmentid,dtime from EquipmentConsume_new where  dtime > ? and dtime <= ? and type = 'commonReinforceStone' ) eua left join equipmentconfig e on eua.equipmentid=e.typeid group by wearlevel,qualityLevel,dtime order by dtime desc,wearlevel,qualityLevel", new Object[]{startTime,endTime});
		
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			if(!thList.contains(_time)){
				thList.add(_time);
			}
			comMap.put(_time+"_"+ds.getInt("wearlevel")+"_"+ds.getInt("qualityLevel"), ds.getInt("oavalue"));
			
		}
		
		ds=DBUtil.db.execSQL("select sum(sapphirecount) oavalue,wearlevel,qualityLevel,dtime from (select sapphirecount,equipmentid,dtime from EquipmentConsume_new where  dtime > ? and dtime <= ? and type = 'commonReinforceStone' ) eua left join equipmentconfig e on eua.equipmentid=e.typeid group by wearlevel,qualityLevel,dtime order by dtime desc,wearlevel,qualityLevel", new Object[]{startTime,endTime});
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			comMap2.put(_time+"_"+ds.getInt("wearlevel")+"_"+ds.getInt("qualityLevel"), ds.getInt("oavalue"));
		}
		
		ds=DBUtil.db.execSQL("select sum(reinforcecount) oavalue,wearlevel,qualityLevel,dtime from (select reinforcecount,equipmentid,dtime from EquipmentConsume_new where  dtime > ? and dtime <= ? and type = 'advancedReinforceStone' ) eua left join equipmentconfig e on eua.equipmentid=e.typeid group by wearlevel,qualityLevel,dtime order by dtime desc,wearlevel,qualityLevel", new Object[]{startTime,endTime});
		
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			if(!thList.contains(_time)){
				thList.add(_time);
			}
			advMap.put(_time+"_"+ds.getInt("wearlevel")+"_"+ds.getInt("qualityLevel"), ds.getInt("oavalue"));
			
		}
		
		ds=DBUtil.db.execSQL("select sum(sapphirecount) oavalue,wearlevel,qualityLevel,dtime from (select sapphirecount,equipmentid,dtime from EquipmentConsume_new where  dtime > ? and dtime <= ? and type = 'advancedReinforceStone' ) eua left join equipmentconfig e on eua.equipmentid=e.typeid group by wearlevel,qualityLevel,dtime order by dtime desc,wearlevel,qualityLevel", new Object[]{startTime,endTime});
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			advMap2.put(_time+"_"+ds.getInt("wearlevel")+"_"+ds.getInt("qualityLevel"), ds.getInt("oavalue"));
		}
		
		ds=DBUtil.db.execSQL("select sum(reinforcecount) oavalue,wearlevel,qualityLevel,dtime from (select reinforcecount,equipmentid,dtime from EquipmentConsume_new where  dtime > ? and dtime <= ? and type = 'superReinforceStone' ) eua left join equipmentconfig e on eua.equipmentid=e.typeid group by wearlevel,qualityLevel,dtime order by dtime desc,wearlevel,qualityLevel", new Object[]{startTime,endTime});
		
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			if(!thList.contains(_time)){
				thList.add(_time);
			}
			supMap.put(_time+"_"+ds.getInt("wearlevel")+"_"+ds.getInt("qualityLevel"), ds.getInt("oavalue"));
			
		}
		
		ds=DBUtil.db.execSQL("select sum(sapphirecount) oavalue,wearlevel,qualityLevel,dtime from (select sapphirecount,equipmentid,dtime from EquipmentConsume_new where  dtime > ? and dtime <= ? and type = 'superReinforceStone' ) eua left join equipmentconfig e on eua.equipmentid=e.typeid group by wearlevel,qualityLevel,dtime order by dtime desc,wearlevel,qualityLevel", new Object[]{startTime,endTime});
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			supMap2.put(_time+"_"+ds.getInt("wearlevel")+"_"+ds.getInt("qualityLevel"), ds.getInt("oavalue"));
		}
		
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>

<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>装备强化消耗分布</h1>
	<h3>可选</h3>
	时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="查询" />
</form>
<h2>全部</h2>
<h3>强化次数</h3>
<table class="listing" >
	<tr class="first"  >
		<th rowspan=2>日期/个数</th>
		<%
			for(String k :th2List){
				out.print("<th colspan=6>LV"+k+"</th>");
			}
		%>
	</tr>

	<tr class="first"  >
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
<h3>蓝宝石强化次数</h3>
<table class="listing"  >
	<tr class="first"  >
		<th rowspan=2>日期/个数</th>
		<%
			for(String k :th2List){
				out.print("<th colspan=6>LV"+k+"</th>");
			}
		%>
	</tr>

	<tr class="first"  >
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
						out.print("<td>"+(data2Map.get(key+"_"+key1+"_"+key2)==null?"-":data2Map.get(key+"_"+key1+"_"+key2))+"</td>");
					}
				}
			out.println("</tr>");
		}
	%>
</table>
<br/><br/>
<h2>普通强化石</h2>
<h3>强化次数</h3>
<table class="listing" >
	<tr class="first"  >
		<th rowspan=2>日期/个数</th>
		<%
			for(String k :th2List){
				out.print("<th colspan=5>LV"+k+"</th>");
			}
		%>
	</tr>

	<tr class="first"  >
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
						out.print("<td>"+(comMap.get(key+"_"+key1+"_"+key2)==null?"-":comMap.get(key+"_"+key1+"_"+key2))+"</td>");
					}
				}
			out.println("</tr>");
		}
	%>
</table>

<br>
<h3>蓝宝石强化次数</h3>
<table class="listing"  >
	<tr class="first"  >
		<th rowspan=2>日期/个数</th>
		<%
			for(String k :th2List){
				out.print("<th colspan=5>LV"+k+"</th>");
			}
		%>
	</tr>

	<tr class="first"  >
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
						out.print("<td>"+(comMap2.get(key+"_"+key1+"_"+key2)==null?"-":comMap2.get(key+"_"+key1+"_"+key2))+"</td>");
					}
				}
			out.println("</tr>");
		}
	%>
</table>

<br/><br/>
<h2>高级强化石</h2>
<h3>强化次数</h3>
<table class="listing" >
	<tr class="first"  >
		<th rowspan=2>日期/个数</th>
		<%
			for(String k :th2List){
				out.print("<th colspan=5>LV"+k+"</th>");
			}
		%>
	</tr>

	<tr class="first"  >
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
						out.print("<td>"+(advMap.get(key+"_"+key1+"_"+key2)==null?"-":advMap.get(key+"_"+key1+"_"+key2))+"</td>");
					}
				}
			out.println("</tr>");
		}
	%>
</table>

<br>
<h3>蓝宝石强化次数</h3>
<table class="listing"  >
	<tr class="first"  >
		<th rowspan=2>日期/个数</th>
		<%
			for(String k :th2List){
				out.print("<th colspan=5>LV"+k+"</th>");
			}
		%>
	</tr>

	<tr class="first"  >
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
						out.print("<td>"+(advMap2.get(key+"_"+key1+"_"+key2)==null?"-":advMap2.get(key+"_"+key1+"_"+key2))+"</td>");
					}
				}
			out.println("</tr>");
		}
	%>
</table>

<br/><br/>
<h2>超级强化石</h2>
<h3>强化次数</h3>
<table class="listing" >
	<tr class="first"  >
		<th rowspan=2>日期/个数</th>
		<%
			for(String k :th2List){
				out.print("<th colspan=5>LV"+k+"</th>");
			}
		%>
	</tr>

	<tr class="first"  >
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
						out.print("<td>"+(advMap.get(key+"_"+key1+"_"+key2)==null?"-":advMap.get(key+"_"+key1+"_"+key2))+"</td>");
					}
				}
			out.println("</tr>");
		}
	%>
</table>

<br>
<h3>蓝宝石强化次数</h3>
<table class="listing"  >
	<tr class="first"  >
		<th rowspan=2>日期/个数</th>
		<%
			for(String k :th2List){
				out.print("<th colspan=5>LV"+k+"</th>");
			}
		%>
	</tr>

	<tr class="first"  >
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
						out.print("<td>"+(advMap2.get(key+"_"+key1+"_"+key2)==null?"-":advMap2.get(key+"_"+key1+"_"+key2))+"</td>");
					}
				}
			out.println("</tr>");
		}
	%>
</table>

<br>
<br>