<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sun.java2d.pipe.SpanShapeRenderer.Simple"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.mozat.morange.util.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<%
	if(session==null||session.getAttribute("login")==null){
		response.sendRedirect("index.jsp");
	}
	
	String startTime = request.getParameter("time");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df =  new DecimalFormat("####.##");
	
	if(startTime==null){
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DATE, -1);
		startTime = sdf.format(c.getTime());
	}
	
	
	List<String> thList = new ArrayList<String>();
	for(int j=1;j<=8;j++){
		thList.add(j+"");
	}

	Map<String,String> titleMap = new HashMap<String,String>();
	for(int j=1;j<=6;j++){
		titleMap.put(j+"",j+"次");
	}
	titleMap.put(7+"","7~10次");
	titleMap.put(8+"","11~20次");
	
	DBResultSet ds=DBUtil.db.execSQL("select petLevel,challengeCount,users,winTime,challengeTime,dtime from arenaChallenge where dtime = ? order by petLevel", new Object[]{startTime});
	List<String> ddateList = new ArrayList<String>();
	Map<String,Integer[]> resultMap = new HashMap<String,Integer[]>();
	for(int i=1;i<=50;i++){
		for(int j=1;j<=8;j++){
			Integer[] _temp = {0,0,0};
			resultMap.put("LV"+i+"_"+j, _temp);
		}
		ddateList.add("LV"+i);
	} 
	
	try{
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			String _petLevel = "LV"+ds.getInt("petLevel");
			
			if(ds.getInt("challengeCount")<=6){
				Integer[] _temp = resultMap.get(_petLevel+"_"+ds.getInt("challengeCount"));
				_temp[0]=ds.getInt("users");
				_temp[1]=ds.getInt("winTime");
				_temp[2]=ds.getInt("challengeTime");
				resultMap.put(_petLevel+"_"+ds.getInt("challengeCount"),_temp);
				
			}else if(ds.getInt("challengeCount")>=11){
				 Integer[] _temp = resultMap.get(_petLevel+"_8");
				_temp[0]+=ds.getInt("users");
				_temp[1]+=ds.getInt("winTime");
				_temp[2]+=ds.getInt("challengeTime");
				resultMap.put(_petLevel+"_8",_temp); 
				
		
			}else {
				Integer[] _temp = resultMap.get(_petLevel+"_7");
				_temp[0]+=ds.getInt("users");
				_temp[1]+=ds.getInt("winTime");
				_temp[2]+=ds.getInt("challengeTime");
				resultMap.put(_petLevel+"_7",_temp); 
		
			}
			
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>

<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>
		竞技场挑战 宠物等级分布
		<%out.print(startTime);%>
	</h1>
	<table class="listing" cellpadding="0" cellspacing="0">
		<tr class="first" width="177">
			<th rowspan=2>等级</th>
			<% 
				for(String th : thList){
					out.println("<th colspan=2>"+titleMap.get(th)+"</th>");
				}
			%>
		</tr>
		<tr class="first" width="177">
			<% 
				for(String th : thList){
					out.println("<th>挑战人数</th>");
					out.println("<th>胜率</th>");
				}
		%>
		</tr>

		<%
			for(String time : ddateList){
				out.println("<tr>");
				out.println("<td>"+time+"</td>");
				
				for(String th : thList){
					Integer[] _temp1 = resultMap.get(time+"_"+th);
					if(_temp1[0]>0)
						out.println("<td>"+_temp1[0]+"</td>");
					else
						out.println("<td>-</td>");
					
					if(_temp1[2]>0)
						out.println("<td>"+df.format((double)_temp1[1]/_temp1[2])+"</td>");
					else
						out.println("<td>-</td>");
				}
				out.println("</tr>");
			}
		%>
	</table>
</html>
