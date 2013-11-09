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
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	if(startTime==null){
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DATE, -1);
		startTime = sdf.format(c.getTime());
	}
	
	List<String> trList = new ArrayList<String>();
	trList.add("LV1");
	trList.add("LV10");
	trList.add("LV20");
	trList.add("LV25");
	trList.add("LV30");
	trList.add("LV35");
	trList.add("LV40");
	trList.add("LV45");
	trList.add("LV50");
	trList.add("LV60");
	trList.add("LV70");
	trList.add("LV80");
	trList.add("LV90");
	trList.add("LV100");
	
	List<String> thList = new ArrayList<String>();
	thList.add("White");
	thList.add("Green");
	thList.add("Blue");
	thList.add("Purple");
	thList.add("Orange");
	thList.add("Gold");
	
	DBResultSet ds= DBUtil.db.execSQL("select ec.quality,ec.wearlevel,q.arenaid,sum(q.amount) amount from equipmentconfig ec join(select typeid,arenaid,sum(amount) amount from arenaTop20Equipment where ddate = ? group by typeid,arenaid) q on ec.typeid = q.typeid group by  ec.quality,ec.wearlevel,q.arenaid order by q.arenaid desc,ec.wearlevel", new Object[]{startTime});
	List<String> arenaList = new ArrayList<String>();
	Map<String,String> resultMap = new HashMap<String,String>();
	try{
		while(ds.next()){
			String arenaid = ds.getInt("arenaid")+"";
			if(!arenaList.contains(arenaid)){
				arenaList.add(arenaid);
			}
			resultMap.put(arenaid+"_LV"+ds.getInt("wearlevel")+"_"+ds.getString("quality"), ds.getInt("amount")+"");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
<h1>竞技场前20用户武器分布  <% out.println(startTime);%></h1>
<h3>可选</h3>
时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)" readOnly="readonly">
<br>
<input name="yes" type="submit" value="查询" />
</form>
	<%
		for(String arenaid :arenaList ){
			 out.println("<h3>竞技场 "+arenaid+"</h3>");
			 out.println("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
				 out.println("<tr class=\"first\" width=\"177\">");
				 out.println("<th>等级</th>");
				 for(String th : thList){
					 out.println("<th>"+th+"</th>");
				 }
				 out.println("</tr>");
			 for(String tr : trList){
				out.println("<tr>");
				out.println("<td>"+tr+"</td>");
				
				for(String th : thList){
					out.println("<td>"+(resultMap.get(arenaid+"_"+tr+"_"+th)==null?"-":resultMap.get(arenaid+"_"+tr+"_"+th))+"</td>");
				}
				out.println("</tr>");
			 }
			 
			 out.println("</table></br></br>");
		}
	%>
	
</html>