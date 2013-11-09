<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sun.java2d.pipe.SpanShapeRenderer.Simple"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.text.*"%>
<%@ page import = "util.*"%>
<%@ page import = "com.mozat.morange.util.*"%>
<style media="all" type="text/css">@import "css/all.css";</style>
<%
	Map<String,String> thMap=new HashMap<String,String>();
	List<String> thList = new ArrayList<String>();
	Map<String,Double> dataMap=new HashMap<String,Double>();
	
	List<Integer> monetidList = new ArrayList<Integer>();
	thList.add("PetLevel");
	thList.add("StarLevel");
	
	thList.add("EquipmentAttack");
	thList.add("EquipmentDefense");
	thList.add("EquipmentLife");
	
	thList.add("ReinforceAttack");
	thList.add("ReinforceDefense");
	thList.add("ReinforceLife");
	
	thList.add("PetAttack");
	thList.add("PetDefense");
	thList.add("ShipLife");
	
	thList.add("StarAttack");
	thList.add("StarDefense");
	
	thList.add("Attack");
	thList.add("Defense");
	thList.add("Life");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	
	DecimalFormat df =  new DecimalFormat("####.##");
	String startTime = request.getParameter("time");
	try{
		if(startTime==null){
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DATE, -1);
			startTime = sdf.format(c.getTime());
		}
		
		DBResultSet ds=DBUtil.db.execSQL("select monetid,oakey,oavalue from arenaTop100Detail where arenaid = 3  and dtime = ? order by position", new Object[]{startTime});
		
		while(ds.next()){
			if(!monetidList.contains(ds.getInt("monetid"))){
				monetidList.add(ds.getInt("monetid"));
			}
			dataMap.put(ds.getInt("monetid")+"_"+ds.getString("oakey"), ds.getDouble("oavalue"));
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>

<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
<h1>������ǰ100 ������3 <%out.print(startTime); %></h1>
<h3>��ѡ</h3>
ʱ�䣺<input name=time type="text" id=time onfocus="datelist.dfd(this)" readOnly="readonly">
<br>
<input name="yes" type="submit" value="��ѯ" />
</form>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th rowspan=2>����</th>
		<th rowspan=2>monetid</th>
		<th rowspan=2>����ȼ�</th>
		<th rowspan=2>�ǵ�</th>
		<th colspan=3>װ���ӳ�</th>
		<th colspan=3>ǿ���ӳ�</th>
		<th colspan=3>����+��</th>
		<th colspan=2>�ǵȼӳ�</th>
		<th colspan=3>ALL</th>
		
		<th colspan=3>װ������</th>
		<th colspan=3>ǿ������</th>
		<th colspan=2>�������</th>
	</tr>
	<tr class="first" width="177">
		<th>Attack</th>
		<th>Defense</th>
		<th>Life</th>
		
		<th>Attack</th>
		<th>Defense</th>
		<th>Life</th>
		
		
		<th>Attack</th>
		<th>Defense</th>
		<th>Life</th>
		
		<th>Attack</th>
		<th>Defense</th>
		
		<th>Attack</th>
		<th>Defense</th>
		<th>Life</th>
		
		<th>Attack</th>
		<th>Defense</th>
		<th>Life</th>
		
		<th>Attack</th>
		<th>Defense</th>
		<th>Life</th>
		
		
		<th>Attack</th>
		<th>Defense</th>
	</tr>
	<%
		int rank = 1;
		for(int monetid:monetidList){
			
			out.println("<tr>");
				out.print("<td>"+rank+"</td>");
				out.print("<td>"+monetid+"</td>");
				
				for(String th:thList){
					out.print("<td>"+(dataMap.get(monetid+"_"+th)==null?"0":df.format(dataMap.get(monetid+"_"+th)))+"</td>");
				}
				
				out.print("<td>"+(dataMap.get(monetid+"_Attack")==0?"0":df.format((dataMap.get(monetid+"_EquipmentAttack")==0?0:dataMap.get(monetid+"_EquipmentAttack"))/dataMap.get(monetid+"_Attack")))+"</td>");
				out.print("<td>"+(dataMap.get(monetid+"_Defense")==0?"0":df.format((dataMap.get(monetid+"_EquipmentDefense")==0?0:dataMap.get(monetid+"_EquipmentDefense"))/dataMap.get(monetid+"_Defense")))+"</td>");
				out.print("<td>"+(dataMap.get(monetid+"_Life")==0?"0":df.format((dataMap.get(monetid+"_EquipmentLife")==0?0:dataMap.get(monetid+"_EquipmentLife"))/dataMap.get(monetid+"_Life")))+"</td>");
				
				out.print("<td>"+(dataMap.get(monetid+"_Attack")==0?"0":df.format((dataMap.get(monetid+"_ReinforceAttack")==0?0:dataMap.get(monetid+"_ReinforceAttack"))/dataMap.get(monetid+"_Attack")))+"</td>");
				out.print("<td>"+(dataMap.get(monetid+"_Defense")==0?"0":df.format((dataMap.get(monetid+"_ReinforceDefense")==0?0:dataMap.get(monetid+"_ReinforceDefense"))/dataMap.get(monetid+"_Defense")))+"</td>");
				out.print("<td>"+(dataMap.get(monetid+"_Life")==0?"0":df.format((dataMap.get(monetid+"_ReinforceLife")==0?0:dataMap.get(monetid+"_ReinforceLife"))/dataMap.get(monetid+"_Life")))+"</td>");
				
				out.print("<td>"+(dataMap.get(monetid+"_Attack")==0?"0":df.format((dataMap.get(monetid+"_StarAttack")==0?0:dataMap.get(monetid+"_StarAttack"))/dataMap.get(monetid+"_Attack")))+"</td>");
				out.print("<td>"+(dataMap.get(monetid+"_Defense")==0?"0":df.format((dataMap.get(monetid+"_StarDefense")==0?0:dataMap.get(monetid+"_StarDefense"))/dataMap.get(monetid+"_Defense")))+"</td>");
				
			out.println("</tr>");
			rank++;
		}
	%>
</table>

<br>
<br>