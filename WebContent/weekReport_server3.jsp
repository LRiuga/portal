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
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	
	DecimalFormat df =  new DecimalFormat("####.##");
	
	DBResultSet ds=DBUtil.db.execSQL("select * from weekReport where dtime in(select top 4 * from (select distinct dtime from weekReport) y order by dtime desc) and server = 'Server3' order by dtime desc", new Object[]{});
	List<String> ddateList = new ArrayList<String>();
	Map<String,String> resultMap = new HashMap<String,String>();
	try{
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			if(!ddateList.contains(_time)){
				ddateList.add(_time);
			}
			resultMap.put(_time+"_"+ds.getString("oakey")+"_"+ds.getString("channel"), df.format(ds.getFloat("oavalue")));
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<h1>�ܱ� Server 3</h1>
<h3>����</h3>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th>����</th>
		<th>����</th>
		<th>=</th>
		<th>ARPU</th>
		<th>*</th>
		<th>��Ծ�û���</th>
	</tr>
	<%
		for(String _time : ddateList){
			out.println("<tr>");
			out.println("<td>"+_time+"</td>");
			out.println("<td>"+resultMap.get(_time+"_"+"Topup"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"ARPU"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"ActivityFisher"+"_"+"-")+"</td>");
			out.println("</tr>");
		}
	%>
</table>
<br>
<hr>
<h3>ARPU</h3>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th>����</th>
		<th>ARPU</th>
		<th>=</th>
		<th>��͸��</th>
		<th>*</th>
		<th>ARPPU</th>
	</tr>
	<%
		for(String _time : ddateList){
			out.println("<tr>");
			out.println("<td>"+_time+"</td>");
			out.println("<td>"+resultMap.get(_time+"_"+"ARPU"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"Permeability"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"ARPPU"+"_"+"-")+"</td>");
			out.println("</tr>");
		}
	%>
</table>
<br>
<hr>

<h3>ARPPU</h3>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th>����</th>
		<th>ARPPU</th>
		<th>=</th>
		<th>����</th>
		<th>/</th>
		<th>�����û���</th>
	</tr>
	<%
		for(String _time : ddateList){
			out.println("<tr>");
			out.println("<td>"+_time+"</td>");
			out.println("<td>"+resultMap.get(_time+"_"+"ARPPU"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"Topup"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"TopupUser"+"_"+"-")+"</td>");
			out.println("</tr>");
		}
	%>
</table>
<br>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th rowspan=2>����</th>
		<th colspan=5>�߸���</th>
		<th colspan=5>�и���</th>
		<th colspan=5>�͸���</th>
	</tr>

	<tr class="first" width="177">
		<th>���ѽ��</th>
		<th>=</th>
		<th>��������</th>
		<th>*</th>
		<th>ARPPU</th>
		<th>���ѽ��</th>
		<th>=</th>
		<th>��������</th>
		<th>*</th>
		<th>ARPPU</th>
		<th>���ѽ��</th>
		<th>=</th>
		<th>��������</th>
		<th>*</th>
		<th>ARPPU</th>
	</tr>
	<%
		for(String _time : ddateList){
			out.println("<tr>");
			out.println("<td>"+_time+"</td>");
			out.println("<td>"+resultMap.get(_time+"_"+"TopupHigh"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"TopupHighUser"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"TopupHighARPPU"+"_"+"-")+"</td>");
			out.println("<td>"+resultMap.get(_time+"_"+"TopupMiddle"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"TopupMiddleUser"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"TopupMiddleARPPU"+"_"+"-")+"</td>");
			out.println("<td>"+resultMap.get(_time+"_"+"TopupLow"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"TopupLowUser"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"TopupLowARPPU"+"_"+"-")+"</td>");
			out.println("</tr>");
		}
	%>
</table>
<br>
<hr>

<h3>�����û�</h3>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th rowspan=2>����</th>
		<th colspan=5>���û�</th>
		<th colspan=5>���û�</th>
	</tr>

	<tr class="first" width="177">
		<th>����</th>
		<th>=</th>
		<th>ARPU</th>
		<th>*</th>
		<th>��Ծ�û���</th>
		<th>����</th>
		<th>=</th>
		<th>ARPU</th>
		<th>*</th>
		<th>��Ծ�û���</th>
	</tr>
	<%
		for(String _time : ddateList){
			out.println("<tr>");
			out.println("<td>"+_time+"</td>");
			out.println("<td>"+resultMap.get(_time+"_"+"TopupNew"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"TopupNewARPU"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"NewFisher"+"_"+"-")+"</td>");
			out.println("<td>"+resultMap.get(_time+"_"+"TopupOld"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"TopupOldARPU"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"OldFisher"+"_"+"-")+"</td>");
			out.println("</tr>");
		}
	%>
</table>
<br>

<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th rowspan=2>����</th>
		<th colspan=5>���û�</th>
		<th colspan=5>���û�</th>
	</tr>

	<tr class="first" width="177">
		<th>ARPU</th>
		<th>=</th>
		<th>��͸��</th>
		<th>*</th>
		<th>ARPPU</th>
		<th>ARPU</th>
		<th>=</th>
		<th>��͸��</th>
		<th>*</th>
		<th>ARPPU</th>
	</tr>
	<%
		for(String _time : ddateList){
			out.println("<tr>");
			out.println("<td>"+_time+"</td>");
			out.println("<td>"+resultMap.get(_time+"_"+"TopupNewARPU"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"TopupNewPermeability"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"TopupNewARPPU"+"_"+"-")+"</td>");
			out.println("<td>"+resultMap.get(_time+"_"+"TopupOldARPU"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"TopupOldPermeability"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"TopupOldARPPU"+"_"+"-")+"</td>");
			out.println("</tr>");
		}
	%>
</table>
<br>
<hr>
<h3>��Ծ�û�</h3>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th>����</th>
		<th>��Ծ�û�</th>
		<th>=</th>
		<th>���û�</th>
		<th>+</th>
		<th>���û�</th>
	</tr>
	<%
		for(String _time : ddateList){
			out.println("<tr>");
			out.println("<td>"+_time+"</td>");
			out.println("<td>"+resultMap.get(_time+"_"+"ActivityFisher"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"NewFisher"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"OldFisher"+"_"+"-")+"</td>");
			out.println("</tr>");
		}
	%>
</table>
<br>
<hr>
<h3>���û�</h3>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th>����</th>
		<th>���û�</th>
		<th>=</th>
		<th>Stc ���û�</th>
		<th>+</th>
		<th>Inmobi���û�</th>
		<th>+</th>
		<th>�������û�</th>
	</tr>
	<%
		for(String _time : ddateList){
			out.println("<tr>");
			out.println("<td>"+_time+"</td>");
			out.println("<td>"+resultMap.get(_time+"_"+"NewFisher"+"_"+"-")+"</td><td></td><td>"+resultMap.get(_time+"_"+"NewFisher"+"_"+"STC")+"</td><td></td><td>"+resultMap.get(_time+"_"+"NewFisher"+"_"+"INMOBI")+"</td><td></td><td>"+resultMap.get(_time+"_"+"NewFisher"+"_"+"EGYPT")+"</td>");
			out.println("</tr>");
		}
	%>
</table>
<br>
<br>