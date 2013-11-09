<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="gb2312"%>
<%@ page
	import="java.util.*,OAStat.*,java.util.Date,java.text.*,toolStat.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<style media="all" type="text/css">
@import "css/all.css";
</style>
</head>
<body>
	<script language="javascript" src="js/dateselect.js"></script>
	<%
	ResourceBundle languageType = ResourceBundle.getBundle("system");
	ResourceBundle enType = ResourceBundle.getBundle(languageType.getString("language"));
	String limitString = session.getAttribute("limit").toString();
	if(limitString!=null){
		if(limitString.equals("3")){
			enType = ResourceBundle.getBundle("English");
		}
	}
	out.print("<h1>Stock</h1>");
	out.print("<a href = \"Stocks.jsp?Action=DownloadExcel\">"+enType.getString("link.download_excel")+"</a>");
	
%>
	<form action="" method="post"> <%=enType.getString("date") %>£º
	<input name="time" type="text" id="time" onfocus="datelist.dfd(this)" readonly="readonly" />
	-<input name="time2" type="text" id="time2" onfocus="datelist.dfd(this)" readonly="readonly" /> <br />
	<%=enType.getString("notice.Last30days") %>£º
	<input name="time3" type="text" id="time3" onfocus="datelist.dfd(this)" readonly="readonly" />
	<input name="yes" type="submit" value="Search" />
	</form>
	<br/>
	<%
	if(session!=null&&session.getAttribute("login")!=null){
		if(session.getAttribute("login").equals("ok")){
				String action = request.getParameter("Action");
				if(action!=null&&action.equals("DownloadExcel")){
					response.setHeader("Content-disposition", "attachment; filename=Stocks.xls");
				}
			
				String ftime = request.getParameter("time");
				String ttime = request.getParameter("time2");
				String time3 = request.getParameter("time3");
				String type = request.getParameter("selectItem");
				{
					out.print("<table>");
					Date fTime = OAStatUtil.convertDate(ftime);
					Date tTime = OAStatUtil.convertDate(ttime);
					if(time3!=""&&time3!=null){
						tTime = OAStatUtil.convertDate(time3);
						fTime = new Date(tTime.getTime()-1000*3600*24*15);
						fTime = new Date(fTime.getTime()-1000*3600*24*15);
					}
					if((ftime==""||ftime==null)&&(ttime==""||ttime==null)&&(time3==""||time3==null)){
						fTime = new Date();
						Calendar fromWhen = Calendar.getInstance();
						fromWhen.setTime(fTime);
						GregorianCalendar gc = new GregorianCalendar(fromWhen
								.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
								.get(Calendar.DAY_OF_MONTH));
						gc.add(Calendar.DATE, -1);
						tTime = (Date) gc.getTime();
						gc.add(Calendar.DATE, -15);
						gc.add(Calendar.DATE, -15);
						fTime = (Date) gc.getTime();
					}
					out.print("</table>");
					out.print("<table>");
					long j = (tTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
					long flag = (fTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
					if((fTime.getTime()-(new Date()).getTime())/1000/60/60/24 < 0){
						{
						java.util.Map<String,Integer> map = new java.util.HashMap<String,Integer>();
						java.util.Map<String,Integer> maxMap = new java.util.HashMap<String,Integer>();
						ArrayList<String> nameList = new ArrayList<String>();
						nameList = OAStatUtil.getItemNameList(fTime,tTime);
						Date fromTime = OAStatUtil.getDate((int)j);
						Date toTime = OAStatUtil.getDate((int)j+1);
						int result = 0;
						out.print("<div class=\"table\">");
						out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
						//
						out.print("<tr class=\"first\" width=\"177\">");
						out.print("<th colspan=1>");
						out.print(enType.getString("item"));
						out.print("</th>");
						for (String string:nameList) {
							out.print("<th colspan=1>");
							out.print(string);
							out.print("</th>");							
						}
						SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
						for (; j >= flag; j--) {
							if(-j%2 == 1){
								out.print("<tr >");
							}else{
								out.print("<tr class=\"bg\">");
							}
							fromTime = OAStatUtil.getDate((int)j);
							toTime = OAStatUtil.getDate((int)j+1);
							map = Stocks.getStocks(fromTime);
							maxMap = Stocks.getMaxStocks(fromTime);
							out.print("<td  colspan=1>");
							out.print(sdf.format(fromTime));
							out.print("</td>");
							{
								for (int i=0;i<nameList.size();i++) {
									out.print("<td colspan=1>");
									if(map.get(nameList.get(i)) == null || map.get(nameList.get(i)) == 0){
										out.print("");
									}else{
										out.print("<a href = \"DAUStocksDetail.jsp?itemName=" + nameList.get(i) + "&" + "fromTime=" + OAStatUtil.DateConvert(fromTime) + "\">" + map.get(nameList.get(i)) + "</a>" );
									}
									out.print("</td>");
								}
							}
							out.print("</tr>");
						}
						out.print("</table>");
						out.print("</div>");
					}
				out.print("</table>");
				out.print("</div>");
			}
			out.print("<br>");
		}	
		out.print("</table>");
	}
}else{
	response.sendRedirect("index.jsp");
}
%>
</body>
</html>