<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sun.java2d.pipe.SpanShapeRenderer.Simple"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import = "java.util.*"%>
<%@ page import = "util.*"%>
<%@ page import = "com.mozat.morange.util.*"%>
<style media="all" type="text/css">@import "css/all.css";</style>
<%
	if(session==null||session.getAttribute("login")==null){
		response.sendRedirect("index.jsp");
	}
	
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
	
	List<String> thList = new ArrayList<String>();
	thList.add("CommonReinforceStone@1@");
	thList.add("AdvancedReinforceStone@2@");
	thList.add("Noting@0@");
	
	thList.add("Equipment@Green@Decorations@");
	thList.add("Equipment@Green@Weapon@");
	thList.add("Equipment@Green@Shield@");
	
	thList.add("Equipment@Orange@Decorations@");
	thList.add("Equipment@Orange@Weapon@");
	thList.add("Equipment@Orange@Shield@");
	
	thList.add("Equipment@Gold@Decorations@");
	thList.add("Equipment@Gold@Weapon@");
	thList.add("Equipment@Gold@Shield@");
	
	
	Map<String,String> titleMap = new HashMap<String,String>();
	
	titleMap.put("AdvancedReinforceStone@2@","高级强化石");
	titleMap.put("CommonReinforceStone@1@","普通强化石");
	titleMap.put("Noting@0@","Noting");
	
	titleMap.put("Equipment@Green@Decorations@","绿装饰品");
	titleMap.put("Equipment@Green@Weapon@","绿装武器");
	titleMap.put("Equipment@Green@Shield@","绿装盾牌");
	
	titleMap.put("Equipment@Orange@Decorations@","橙装饰品");
	titleMap.put("Equipment@Orange@Weapon@","橙装武器");
	titleMap.put("Equipment@Orange@Shield@","橙装盾牌");
	
	titleMap.put("Equipment@Gold@Decorations@","金装饰品");
	titleMap.put("Equipment@Gold@Weapon@","金装武器");
	titleMap.put("Equipment@Gold@Shield@","金装盾牌");
	
	DBResultSet ds=ds=DBUtil.db.execSQL("select itemType,itemtypeid,amount,Quality,Part,ddate from (select * from luckyDrawEquipment where ddate >= ? and ddate <= ? ) l left join equipmentconfig e on l.itemtypeid = e.typeid order by ddate desc", new Object[]{startTime,endTime});
	
	List<String> ddateList = new ArrayList<String>();
	Map<String,String> resultMap = new HashMap<String,String>();
	try{
		while(ds.next()){
			String _time = sdf.format(ds.getDate("ddate"));
			if(!ddateList.contains(_time)){
				ddateList.add(_time);
			}
			String _itemtype = ds.getString("itemType");
			if("Equipment".equals(_itemtype)){
				resultMap.put(_time+"_"+ds.getString("itemType")+"@"+ds.getString("Quality")+"@"+ds.getString("Part")+"@", ds.getInt("amount")+"");
			}else{
				resultMap.put(_time+"_"+ds.getString("itemType")+"@"+ds.getInt("itemtypeid")+"@", ds.getInt("amount")+"");
			}
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
<h1>装备抽奖</h1>
<h3>可选</h3>
时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)" readOnly="readonly">
-<input name="time2" type="text" id="time2" onfocus="datelist.dfd(this)" readOnly="readonly">
<br>
<input name="yes" type="submit" value="查询" />
</form>
	<table class="listing" cellpadding="0" cellspacing="0">
		<tr class="first" width="177">
			<th>日期/产出次数</th>
			<% 
				for(String th : thList){
					out.println("<th>"+titleMap.get(th)+"</th>");
				}
			%>
		</tr>
		
		
		<%
			for(String time : ddateList){
				out.println("<tr>");
				out.println("<td>"+time+"</td>");
				for(String th : thList){
					out.println("<td>"+(resultMap.get(time+"_"+th)==null?"-":resultMap.get(time+"_"+th))+"</td>");
				}
				out.println("</tr>");
			}
		%>
	</table>
	
	<br>
	<br>
	
</html>