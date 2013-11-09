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
	
	String calcStartDate = "2013-09-23";
	String startTime = request.getParameter("time");
	String endTime = request.getParameter("time2");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	if(startTime==null&&endTime==null){
		Calendar c = Calendar.getInstance();
		endTime = sdf.format(c.getTime());
		
		c.add(Calendar.DATE, -7);
		startTime = sdf.format(c.getTime());
	}
	
	
	Map<String,Date[]> periodMap = new HashMap<String,Date[]>();
	
	DBResultSet ds= DBUtil.db.execSQL("select count(distinct monsterid) createNum,weaponType,convert(varchar(10),dateadd(hh,-5,createTime),20) createTime  from tribemonster where  dateadd(hh,-5,createTime) <= ? group by convert(varchar(10),dateadd(hh,-5,createTime),20),weaponType  order by convert(varchar(10),dateadd(hh,-5,createTime),20),weaponType", new Object[]{endTime});
	List<String> ddateList = new ArrayList<String>();
	
	Map<String,Integer> createResultMap = new HashMap<String,Integer>();
	Map<String,Integer> killResultMap = new HashMap<String,Integer>();
	
	try{
		
		
		Date sd = sdf.parse(calcStartDate);
		
		Calendar c1 = Calendar.getInstance();
		c1.setTime(sd);
		
		while(c1.getTimeInMillis()<= sdf.parse(endTime).getTime()){
			if(c1.get(Calendar.DAY_OF_WEEK)==Calendar.MONDAY||c1.get(Calendar.DAY_OF_WEEK)==Calendar.THURSDAY){
				Date[] _temp = {null,null,null};
				
				_temp[0]=c1.getTime();
				c1.add(Calendar.DATE, 1);
				_temp[1]=c1.getTime();
				c1.add(Calendar.DATE, 1);
				_temp[2]=c1.getTime();
				String key = sdf.format(_temp[0])+"~"+sdf.format(_temp[2]);
				ddateList.add(key);
				periodMap.put(key, _temp);
			}
			c1.add(Calendar.DATE, 1);
		}
		
		while(ds.next()){
			String _timeStr = ds.getString("createTime");
			int weaponType = ds.getInt("weaponType");
			int createNum = ds.getInt("createNum");
			
			Date _time = sdf.parse(_timeStr);
			createResultMap.put(sdf.format(_time)+"_"+weaponType, createNum);
		}
		
		ds= DBUtil.db.execSQL("select count(distinct monsterid) killNum,monsterType,convert(varchar(10),dateadd(hh,-5,killTime),20) killTime  from tribemonster where  dateadd(hh,-5,killTime) <= ? group by convert(varchar(10),dateadd(hh,-5,killTime),20),monsterType  order by convert(varchar(10),dateadd(hh,-5,killTime),20),monsterType", new Object[]{endTime});
		
		while(ds.next()){
			String _timeStr = ds.getString("killTime");
			int monsterType = ds.getInt("monsterType");
			int killNum = ds.getInt("killNum");
			
			Date _time = sdf.parse(_timeStr);
			killResultMap.put(sdf.format(_time)+"_"+monsterType, killNum);
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
<h1>家族怪产生杀死分布</h1>
</form>
	<table class="listing" cellpadding="0" cellspacing="0">
		<tr class="first" width="177">
			<th rowspan=2>日期/怪物个数</th>
			<%
				for(int i= 2;i<9;i++){
					out.println("<th colspan=2>M"+i+"</th>");
				}
			%>
		</tr>
		
		<tr class="first" width="177">
			<%
				for(int i= 2;i<9;i++){
					out.println("<th>产生</th><th>杀死</th>");
				}
			%>
		</tr>
		
		
		<%
			StringBuffer dataShowBuffer = new StringBuffer("");
			for(String time : ddateList){
				dataShowBuffer.append("<tr>");
				dataShowBuffer.append("<td><a href='tribeMonsterCalc.jsp?time="+time.split("~")[0]+"' >"+time+"</td>");
				for(int i= 2;i<9;i++){
					dataShowBuffer.append("<td>@createNum_"+time+"_"+(i+21)+"</td><td>@killNum_"+time+"_"+(9-i-1)+"</td>");
				}
				dataShowBuffer.append("</tr>");
			}
			String showstr = dataShowBuffer.toString();
			
			for(String time : ddateList){
				Date[] dateList = periodMap.get(time);
				int _sum[]={0,0,0,0,0,0,0};
				for(int q = 0;q<3;q++){
					Date _d = dateList[q];
					if(_d!=null){
						for(int i= 2;i<9;i++){
							_sum[i-2] = _sum[i-2] + (createResultMap.get(sdf.format(_d)+"_"+(i+21))==null?0:createResultMap.get(sdf.format(_d)+"_"+(i+21)));
						}
					}
				}
				
				for(int i= 2;i<9;i++){	
					showstr = showstr.replace("@createNum_"+time+"_"+(i+21), _sum[i-2]+"");
				}
			} 
			
			
			for(String time : ddateList){
				Date[] dateList = periodMap.get(time);
				int _sum[]={0,0,0,0,0,0,0};
				for(int q = 0;q<3;q++){
					Date _d = dateList[q];
					if(_d!=null){
						for(int i= 2;i<9;i++){
							_sum[i-2] = _sum[i-2] + ( killResultMap.get(sdf.format(_d)+"_"+(9-i-1))==null?0:killResultMap.get(sdf.format(_d)+"_"+(9-i-1)));
						}
					}
				}
				
				for(int i= 2;i<9;i++){	
					showstr = showstr.replace("@killNum_"+time+"_"+(9-i-1), _sum[i-2]+"");
				}
			}
			out.print(showstr); 
		%>
	</table>
	
	<br>
	<br>
</html>