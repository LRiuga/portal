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
	titleMap.put("noFrom","û����Դ");
	titleMap.put("360downloadword","shabik360����վ������");
	titleMap.put("360downloadicon","shabik360����վ��download��ť");
	titleMap.put("shabikicon","shabik360 oa pro icon");
	titleMap.put("shabik360banner","shabik360 banner");
	//titleMap.put("shabikweb","shabik����");
	titleMap.put("plusdownloadword","shabikPlus����վ������");
	//titleMap.put("shabikplusdownloadword","shabikPlus����վ������");
	titleMap.put("plusdownloadicon","shabikPlus����վ��download��ť");
	titleMap.put("shabikplusdownloadbanner","shabikplus����վ��banner");
	titleMap.put("shabikplusdownloadbutton","shabikPlus����վ��banner");
	//titleMap.put("shabikplus","shabikPlus����ҳ��");
	titleMap.put("shabik365","shabik365����ҳ��");
	titleMap.put("shabik365banner","shabik365 banner");
	//titleMap.put("oanoticeboard","��oa��noticeҳ��1");
	//titleMap.put("oa_priceRank","��oa����ҳ��");
	//titleMap.put("oaNoticeBoard","��oa��noticeҳ��2");
	//titleMap.put("oa_speaker","��oa������ҳ��");
	titleMap.put("OA","��OA�ڲ�");
	titleMap.put("shabikoa","shabik360����OA��icon");
	//titleMap.put("sms1","Sms1");
	//titleMap.put("sms2","Sms2");
	//titleMap.put("sms4","Sms4");
	titleMap.put("SMS","SMS");
	titleMap.put("h","HelpSms");
	titleMap.put("shabiknative","Native�ͻ���");
	titleMap.put("other","����");
	
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
	<h1>����ͳ��</h1>
	<h3>��ѡ</h3>
	ʱ�䣺<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="��ѯ" />
</form>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th>����/PV</th>
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
		<th>����/UV</th>
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