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
	for(int j=1;j<=8;j++){
		thList.add(j+"");
	}

	Map<String,String> titleMap = new HashMap<String,String>();
	for(int j=1;j<=6;j++){
		titleMap.put(j+"",j+"次");
	}
	titleMap.put(7+"","7~10次");
	titleMap.put(8+"","11~20次");
	
	DBResultSet ds=DBUtil.db.execSQL("select petLevel,challengeCount,users,winTime,challengeTime,dtime from arenaChallenge where dtime >= ? and dtime <= ? order by dtime desc", new Object[]{startTime,endTime});
	List<String> ddateList = new ArrayList<String>();
	/* Map<String,Integer[]> resultMap = new HashMap<String,Integer[]>();
	for(int i=1;i<=50;i++){
		for(int j=1;j<=8;j++){
			Integer[] _temp = {0,0,0};
			resultMap.put(i+"_"+j, _temp);
		}
	} */
	
	Map<String,Integer[]> resultALLMap = new HashMap<String,Integer[]>();
	
	try{
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			if(!ddateList.contains(_time)){
				ddateList.add(_time);
				for(int j=1;j<=8;j++){
					Integer[] _temp = {0,0,0};
					resultALLMap.put(_time+"_"+j, _temp);
				}
			}
			
			if(ds.getInt("challengeCount")<=6){
				/* Integer[] _temp = resultMap.get(ds.getInt("petLevel")+"_"+ds.getInt("challengeCount"));
				_temp[0]=ds.getInt("users");
				_temp[1]=ds.getInt("winTime");
				_temp[2]=ds.getInt("challengeTime");
				resultMap.put(ds.getInt("petLevel")+"_"+ds.getInt("challengeCount"),_temp); */
				
				Integer[] _temp1 = resultALLMap.get(_time+"_"+ds.getInt("challengeCount"));
				_temp1[0]+=ds.getInt("users");
				_temp1[1]+=ds.getInt("winTime");
				_temp1[2]+=ds.getInt("challengeTime");
				resultALLMap.put(_time+ds.getInt("challengeCount"),_temp1);
				
			}else if(ds.getInt("challengeCount")>=11){
				/* Integer[] _temp = resultMap.get(ds.getInt("petLevel")+"_8");
				_temp[0]+=ds.getInt("users");
				_temp[1]+=ds.getInt("winTime");
				_temp[2]+=ds.getInt("challengeTime");
				resultMap.put(ds.getInt("petLevel")+"_8",_temp); */
				
				Integer[] _temp1 = resultALLMap.get(_time+"_8");
				_temp1[0]+=ds.getInt("users");
				_temp1[1]+=ds.getInt("winTime");
				_temp1[2]+=ds.getInt("challengeTime");
				resultALLMap.put(_time+"_8",_temp1);
			}else {
				/* Integer[] _temp = resultMap.get(ds.getInt("petLevel")+"_7");
				_temp[0]+=ds.getInt("users");
				_temp[1]+=ds.getInt("winTime");
				_temp[2]+=ds.getInt("challengeTime");
				resultMap.put(ds.getInt("petLevel")+"_7",_temp); */
				
				Integer[] _temp1 = resultALLMap.get(_time+"_7");
				_temp1[0]+=ds.getInt("users");
				_temp1[1]+=ds.getInt("winTime");
				_temp1[2]+=ds.getInt("challengeTime");
				resultALLMap.put(_time+"_7",_temp1);
			}
			
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>

<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>竞技场挑战分布</h1>
	<h3>可选</h3>
	时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="查询" />
</form>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th rowspan=2>日期</th>
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
				out.println("<td><a href = \"arenaChallengeDistributionLevel.jsp?time=" + time+"\">"+time+"</a></td>");
				
				for(String th : thList){
					Integer[] _temp1 = resultALLMap.get(time+"_"+th);
					out.println("<td>"+_temp1[0]+"</td>");
					if(_temp1[2]>0)
						out.println("<td>"+df.format((double)_temp1[1]/_temp1[2])+"</td>");
					else
						out.println("<td>0</td>");
				}
				out.println("</tr>");
			}
		%>
</table>
</html>
