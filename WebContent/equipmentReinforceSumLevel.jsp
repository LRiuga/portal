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
	thList.add("count");
	thList.add("users");
	thList.add("sapphirecount");
	thList.add("sapphireuser");
	thList.add("succount");
	thList.add("failcount");
	thList.add("sucRate");
	thList.add("maxusercount");
	thList.add("maxuserid");
	
	Map<String,String> titleMap = new HashMap<String,String>();
	
	titleMap.put("count","ǿ������");
	titleMap.put("users","ǿ������");
	titleMap.put("sapphirecount","����ʯǿ������");
	titleMap.put("sapphireuser","����ʯǿ������");
	titleMap.put("succount","ǿ���ɹ�����");
	titleMap.put("failcount","ǿ��ʧ�ܴ���");
	titleMap.put("sucRate","�ɹ���");
	titleMap.put("maxusercount","ǿ��������");
	titleMap.put("maxuserid","ǿ������û�");
	
	DBResultSet ds=DBUtil.db.execSQL("select weaponlevel,users,count,succount,maxusercount,maxuserid,sapphirecount,sapphireuser,dtime from reinforcecalc where weaponlevel != 'ALL' and dtime = ? order by weaponlevel", new Object[]{startTime});
	List<String> ddateList = new ArrayList<String>();
	Map<String,String> resultMap = new HashMap<String,String>();
	try{
		while(ds.next()){
			String _time =ds.getString("weaponlevel");
			if(!ddateList.contains(_time)){
				ddateList.add(_time);
			}
			resultMap.put(_time+"_users",ds.getInt("users")+"");
			resultMap.put(_time+"_count",ds.getInt("count")+"");
			resultMap.put(_time+"_succount",ds.getInt("succount")+"");
			resultMap.put(_time+"_failcount",(ds.getInt("count")-ds.getInt("succount"))+"");
			resultMap.put(_time+"_sapphirecount",ds.getInt("sapphirecount")+"");
			resultMap.put(_time+"_sapphireuser",ds.getInt("sapphireuser")+"");
			resultMap.put(_time+"_sucRate",df.format(((double)ds.getInt("succount")/ds.getInt("count"))));
			resultMap.put(_time+"_maxusercount",ds.getInt("maxusercount")+"");
			resultMap.put(_time+"_maxuserid",ds.getInt("maxuserid")+"");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html>
<script type="text/javascript" src="js/dateselect.js"></script>
<h1>
	װ��ǿ�������ȼ��ֲ�
	<%out.print(startTime);%>
</h1>
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
				out.println("<td>LV"+time+"</td>");
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