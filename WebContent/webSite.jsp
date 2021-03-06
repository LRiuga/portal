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
	thList.add("all");
	thList.add("noFrom");
	thList.add("360downloadword");
	thList.add("360downloadicon");
	thList.add("shabikicon");
	thList.add("shabik360banner");
	//thList.add("shabikweb");
	thList.add("plusdownloadword");
	thList.add("plusdownloadicon");
	thList.add("shabikplusdownloadbutton");
	//thList.add("shabikplus");
	thList.add("shabik365");
	thList.add("shabik365banner");
	//thList.add("oanoticeboard");
	//thList.add("oa_priceRank");
	//thList.add("oaNoticeBoard");
	//thList.add("oa_speaker");
	thList.add("OA");
	thList.add("shabikoa");
	//thList.add("sms1");
	//thList.add("sms2");
	//thList.add("sms4");
	thList.add("SMS");
	thList.add("h");
	thList.add("shabiknative");
	thList.add("other");
	
	Map<String,String> titleMap = new HashMap<String,String>();
	
	titleMap.put("all","ALL");
	titleMap.put("noFrom","没有来源");
	titleMap.put("360downloadword","shabik360下载站点文字");
	titleMap.put("360downloadicon","shabik360下载站点download按钮");
	titleMap.put("shabikicon","shabik360 oa pro icon");
	titleMap.put("shabik360banner","shabik360 banner");
	//titleMap.put("shabikweb","shabik官网");
	titleMap.put("plusdownloadword","shabikPlus下载站点文字");
	//titleMap.put("shabikplusdownloadword","shabikPlus下载站点文字");
	titleMap.put("plusdownloadicon","shabikPlus下载站点download按钮");
	titleMap.put("shabikplusdownloadbanner","shabikplus下载站点banner");
	titleMap.put("shabikplusdownloadbutton","shabikPlus下载站点banner");
	//titleMap.put("shabikplus","shabikPlus介绍页面");
	titleMap.put("shabik365","shabik365介绍页面");
	titleMap.put("shabik365banner","shabik365 banner");
	//titleMap.put("oanoticeboard","老oa的notice页面1");
	//titleMap.put("oa_priceRank","老oa排名页面");
	//titleMap.put("oaNoticeBoard","老oa的notice页面2");
	//titleMap.put("oa_speaker","老oa的喇叭页面");
	titleMap.put("OA","老OA内部");
	titleMap.put("shabikoa","shabik360中老OA的icon");
	//titleMap.put("sms1","Sms1");
	//titleMap.put("sms2","Sms2");
	//titleMap.put("sms4","Sms4");
	titleMap.put("SMS","SMS");
	titleMap.put("h","HelpSms");
	titleMap.put("shabiknative","Native客户端");
	titleMap.put("other","其他");
	
	DBResultSet ds=DBUtil.db.execSQL("select * from WebSiteData where ddate >= ? and ddate <= ? order by ddate desc", new Object[]{startTime,endTime});
	List<String> ddateList = new ArrayList<String>();
	Map<String,String> resultMap = new HashMap<String,String>();
	try{
		while(ds.next()){
			String _time = sdf.format(ds.getDate("ddate"));
			if(!ddateList.contains(_time)){
				ddateList.add(_time);
			}
			
			if("shabikweb_PV".equals(ds.getString("oakey"))||"other_PV".equals(ds.getString("oakey"))){
				String _other = resultMap.get(_time+"_"+"other_PV");
				if(_other==null){
					resultMap.put(_time+"_"+"other_PV", ds.getFloat("oavalue")+"");
				}else{
					resultMap.put(_time+"_"+"other_PV",new Double(_other)+ds.getFloat("oavalue")+"");
				}
			}else if("oanoticeboard_PV".equals(ds.getString("oakey"))||"oa_priceRank_PV".equals(ds.getString("oakey"))||"oaNoticeBoard_PV".equals(ds.getString("oakey"))||"oa_speaker_PV".equals(ds.getString("oakey"))){
				String _oa = resultMap.get(_time+"_"+"OA_PV");
				if(_oa==null){
					resultMap.put(_time+"_"+"OA_PV", ds.getFloat("oavalue")+"");
				}else{
					resultMap.put(_time+"_"+"OA_PV",new Double(_oa)+ds.getFloat("oavalue")+"");
				}
			}else if("shabikweb_UV".equals(ds.getString("oakey"))||"other_UV".equals(ds.getString("oakey"))){
				String _other = resultMap.get(_time+"_"+"other_UV");
				if(_other==null){
					resultMap.put(_time+"_"+"other_UV", ds.getFloat("oavalue")+"");
				}else{
					resultMap.put(_time+"_"+"other_UV",new Double(_other)+ds.getFloat("oavalue")+"");
				}
			}else if("oanoticeboard_UV".equals(ds.getString("oakey"))||"oa_priceRank_UV".equals(ds.getString("oakey"))||"oaNoticeBoard_UV".equals(ds.getString("oakey"))||"oa_speaker_UV".equals(ds.getString("oakey"))){
				String _oa = resultMap.get(_time+"_"+"OA_UV");
				if(_oa==null){
					resultMap.put(_time+"_"+"OA_UV", ds.getFloat("oavalue")+"");
				}else{
					resultMap.put(_time+"_"+"OA_UV",new Double(_oa)+ds.getFloat("oavalue")+"");
				}
			}else if("shabikplusdownloadword_PV".equals(ds.getString("oakey"))||"plusdownloadword_PV".equals(ds.getString("oakey"))){
				String _oa = resultMap.get(_time+"_"+"plusdownloadword_PV");
				if(_oa==null){
					resultMap.put(_time+"_"+"plusdownloadword_PV", ds.getFloat("oavalue")+"");
				}else{
					resultMap.put(_time+"_"+"plusdownloadword_PV",new Double(_oa)+ds.getFloat("oavalue")+"");
				}
			}else if("shabikplusdownloadword_UV".equals(ds.getString("oakey"))||"plusdownloadword_UV".equals(ds.getString("oakey"))){
				String _oa = resultMap.get(_time+"_"+"plusdownloadword_UV");
				if(_oa==null){
					resultMap.put(_time+"_"+"plusdownloadword_UV", ds.getFloat("oavalue")+"");
				}else{
					resultMap.put(_time+"_"+"plusdownloadword_UV",new Double(_oa)+ds.getFloat("oavalue")+"");
				}
			}else if("sms1_PV".equals(ds.getString("oakey"))||"sms2_PV".equals(ds.getString("oakey"))||"sms4_PV".equals(ds.getString("oakey"))){
				String _oa = resultMap.get(_time+"_"+"SMS_PV");
				if(_oa==null){
					resultMap.put(_time+"_"+"SMS_PV", ds.getFloat("oavalue")+"");
				}else{
					resultMap.put(_time+"_"+"SMS_PV",new Double(_oa)+ds.getFloat("oavalue")+"");
				}
			}else if("sms1_UV".equals(ds.getString("oakey"))||"sms2_UV".equals(ds.getString("oakey"))||"sms4_UV".equals(ds.getString("oakey"))){
				String _oa = resultMap.get(_time+"_"+"SMS_UV");
				if(_oa==null){
					resultMap.put(_time+"_"+"SMS_UV", ds.getFloat("oavalue")+"");
				}else{
					resultMap.put(_time+"_"+"SMS_UV",new Double(_oa)+ds.getFloat("oavalue")+"");
				}
			}else{
				resultMap.put(_time+"_"+ds.getString("oakey"), ds.getFloat("oavalue")+"");
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>渠道统计</h1>
	<h3>可选</h3>
	时间：<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="查询" />
</form>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th>日期/PV</th>
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
					out.println("<td>"+(resultMap.get(time+"_"+th+"_PV")==null?"0":resultMap.get(time+"_"+th+"_PV"))+"</td>");
				}
				out.println("</tr>");
			}
		%>
</table>

<br>
<br>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th>日期/UV</th>
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
					out.println("<td>"+(resultMap.get(time+"_"+th+"_UV")==null?"0":resultMap.get(time+"_"+th+"_UV"))+"</td>");
				}
				out.println("</tr>");
			}
		%>
</table>
</html>