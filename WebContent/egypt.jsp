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
	thList.add("HAU");
	thList.add("DRU");
	thList.add("DAU");
	thList.add("DNU");
	thList.add("DPU");
	thList.add("TOPUP");
	
	Map<String,String> titleMap = new HashMap<String,String>();
	
	titleMap.put("HAU","��ʷ�û�");
	titleMap.put("DRU","ע���û�");
	titleMap.put("DAU","DAU");
	titleMap.put("DNU","���û�");
	titleMap.put("DPU","�����û�");
	titleMap.put("TOPUP","���ѽ��");
	
	DBResultSet ds=DBUtil.db.execSQL("select oakey,oavalue,dtime from egyptuser where dtime >?  and dtime <=? order by dtime desc", new Object[]{startTime,endTime});
	List<String> ddateList = new ArrayList<String>();
	Map<String,String> resultMap = new HashMap<String,String>();
	try{
		while(ds.next()){
			String _time = sdf.format(ds.getDate("dtime"));
			if(!ddateList.contains(_time)){
				ddateList.add(_time);
			}
			resultMap.put(_time+"_"+ds.getString("oakey"), ds.getInt("oavalue")+"");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<form action="" method="post">
	<h1>�����û�����</h1>
	<h3>��ѡ</h3>
	ʱ�䣺<input name=time type="text" id=time onfocus="datelist.dfd(this)"
		readOnly="readonly"> -<input name="time2" type="text"
		id="time2" onfocus="datelist.dfd(this)" readOnly="readonly"> <br>
	<input name="yes" type="submit" value="��ѯ" />
</form>
<br>
<label>ע����ʷ�û������з�������billing�������Ϊ������ע���û���</label>
<br>
<label>ע���û������з�������billing�������Ϊ�����ĵ���ע���û���</label>
<br>
<br>
<table class="listing" cellpadding="0" cellspacing="0">
	<tr class="first" width="177">
		<th>����</th>
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
					out.println("<td>"+resultMap.get(time+"_"+th)+"</td>");
				}
				out.println("</tr>");
			}
		%>
</table>

<br>
<br>
</html>