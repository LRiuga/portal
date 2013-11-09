<%@ page contentType="text/html;charset=UTF-8"%>

<%@ page
	import="org.jfree.chart.ChartFactory,
org.jfree.chart.JFreeChart,
org.jfree.chart.servlet.ServletUtilities,
org.jfree.chart.title.TextTitle,
org.jfree.data.time.TimeSeries,
org.jfree.data.time.Month,
org.jfree.data.time.Day,
org.jfree.data.time.TimeSeriesCollection,
java.awt.Font,
java.util.*,OAStat.*,java.util.Date,java.text.*,billingStat.*"%>
<%@page import="org.jfree.chart.ChartPanel"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<%
	ResourceBundle languageType = ResourceBundle.getBundle("system");
	ResourceBundle enType = ResourceBundle.getBundle(languageType.getString("language"));
	String limitString = session.getAttribute("limit").toString();
	if(limitString!=null){
		if(limitString.equals("3")){
			enType = ResourceBundle.getBundle("English");
		}
	}
 %>
</head>
<body>
	<h1><%=enType.getString("subtitle.top_up") %></h1>
	<a href="AddValueTimes.jsp?Action=DownloadExcel"><img
		src="images/Excel.gif" width="24" height="23" /><%=enType.getString("link.download_excel") %></a>
	<br>
	<script language="javascript">
		document.writeln("<div id='DateGird' style='display:none;position: absolute;border:1px solid #EC5657;background-color: #fbeded;'></div>");
		var Glob_YY=parseInt(new Date().getFullYear());
		var Glob_MM=parseInt(new Date().getMonth()+1);
		var Glob_DD=parseInt(new Date().getDate());

function shotable(InputName)
{
       var DateArray=["Sun","Mon","Tues","Wed","Thur","Fri","Sat"];
        var output=""
        output=output+"<div style='padding:5px;border:1px solid #fbafb0;'><table style='width:156px;font-size:9pt;cursor:default;border:0px solid #999999;' border='0' cellpadding='0' cellspacing='0'>";
        output=output+"<tr ><td colspan='7' class='TrTitle'><span ID='yearUU'>"+Glob_YY+"</span><span ID='monthUU'>"+Glob_MM+"</span><a href='#' onclick='return;'>*</a></td></tr><table>";
        output=output+"<table style='font-size:12px;font-family: \"宋体\", Helvetica, sans-serif;cursor:default;border:0px solid #999999;border:1px solid #F5D6D6;' border='1' cellpadding='0' cellspacing='0'>";
        output=output+"<tr align='center'>";
        for(var i=0;i<7;i++) output=output+"<td class='TrOver'>"+DateArray[i]+"</td>";
        output=output+"</tr>";
        for(var i=0;i<6;i++){
        output=output+"<tr align='center'>";
                for(var j=0;j<7;j++) output=output+"<td id='TD' name='TD' class='TdOver' onmouseover='datelist.OverBK(this,\""+InputName.name+"\")' msg=''>&nbsp;</td>";
                        output=output+"</tr>";
                }
        output=output+"</tabe></div>";

var selectMMInnerHTML = "<select ID=\"sMonth\" onchange=\"setPan(document.getElementById('sYear').value,this.value)\" style='width:50px;background:#F5d6d6'>";
for (var i = 1; i < 13; i++)
{
    if (i == Glob_MM)
       {selectMMInnerHTML += "<option Author=wayx value='" + i + "' selected>" + i + "月" + "</option>\r\n";}
    else {selectMMInnerHTML += "<option Author=wayx value='" + i + "'>" + i + "月" + "</option>\r\n";}
}
selectMMInnerHTML += "</select>";
var selectYYInnerHTML = "<select ID=\"sYear\" onchange=\"setPan(this.value,document.getElementById('sMonth').value)\" style='width:65px;background:#F5d6d6'>";
for (var i = 1999; i <= Glob_YY; i++)
{
    if (i == Glob_YY)
       {selectYYInnerHTML += "<option Author=wayx value='" + i + "' selected>" + i + "年" + "</option>\r\n";}
    else {selectYYInnerHTML += "<option Author=wayx value='" + i + "'>" + i + "年" + "</option>\r\n";}
}
selectYYInnerHTML += "</select>";
        document.getElementById("DateGird").innerHTML= output;
        document.getElementById("monthUU").innerHTML= selectMMInnerHTML;
        document.getElementById("yearUU").innerHTML= selectYYInnerHTML;
        //document.writeln(output);

}
function classGetDate(sName)
{
this.obj=sName || "uncDate";
//alert(Date.parse(this.obj.value));

this.YY=Glob_YY;
this.MM=Glob_MM;
this.DD=Glob_DD;
document.getElementById("DateGird").style.display="";
setPan(this.YY,this.MM);
}

function GetDay(y,m){
        this.TDate=function(){
                this.DayArray=[];
                for(var i=0;i<42;i++)this.DayArray[i]="&nbsp;";
                for(var i=0;i<new Date(y,m,0).getDate();i++)this.DayArray[i+new Date(y,m-1,1).getDay()]=i+1;
                return this.DayArray;
                }
        return this;
        }

function setPan(YY,MM)
{
var DArray=GetDay(YY,MM).TDate();
var TDArr=document.getElementsByName("TD");
if (MM<10){var showMM="0"+MM;}else{var showMM=MM;}
for(var i=0;i<TDArr.length;i++){
        if (Glob_DD==DArray[i]&&YY==new Date().getFullYear()&&MM==new Date().getMonth()+1){TDArr[i].className="TdOut";}else{TDArr[i].className="TdOver"}
        TDArr[i].innerHTML=DArray[i];
        if (DArray[i]<10){var showDD="0"+DArray[i];}else{var showDD=DArray[i];}
        TDArr[i].msg=YY+"-"+showMM+"-"+showDD;
        }
}

datelist={
        dfd:function (sName)
        {
        var dateGirdObj=document.getElementById("DateGird");
        //var i= sName.style.top


        dateGirdObj.style.top=cmGetY(sName)+20;
        dateGirdObj.style.left=cmGetX(sName);
        shotable(sName);
        classGetDate(sName);
        },
        OverBK:function(t,m){
                
                if(t.className!="TdOut"){
                        
                        t.onmouseout=function(){t.className="TdOver";}
                }
                if(t.innerHTML!="&nbsp;")t.className="TdOut";
                t.onclick=function(){
                        if (t.innerHTML!="&nbsp;"){//alert(t.innerHTML);

                                document.getElementById(m).value=t.msg;
                                t.className="TdOver";
                                document.getElementById("DateGird").style.display="none";
                        }
                }
                
        }
}


function cmGetX (obj){var x = 0;do{x += obj.offsetLeft;obj = obj.offsetParent;}while(obj);return x;}
function cmGetY (obj){var y = 0;do{y += obj.offsetTop;obj = obj.offsetParent;}while(obj);return y;}

</script>


	<div class=\"table\">
		<form action="" method="post">


			<h3><%=enType.getString("date") %>：
			</h3>
			<input name="time" type="text" id="time" onfocus="datelist.dfd(this)"
				readOnly> -<input name="time2" type="text" id="time2"
				onfocus="datelist.dfd(this)" readOnly> <input name="yes"
				type="submit" value=<%=enType.getString("search") %> />
		</form>
	</div>
	<br>


	<%
if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		String action = request.getParameter("Action");
		if(action!=null&&action.equals("DownloadExcel")){
			response.setHeader("Content-disposition", "attachment; filename=TopUp.xls");
		}
	
			java.util.Map<Date, Integer> addValues = new java.util.HashMap<Date, Integer>();
			java.util.Map<Date, Integer> users = new java.util.HashMap<Date, Integer>();
			out.print("<table>");
			String ftime = request.getParameter("time");
			String ttime = request.getParameter("time2");
			
			Date fromTime = new Date();
			Date toTime = new Date();
			
			if(ftime==null||ftime==""){
				Calendar fromWhen = Calendar.getInstance();
				fromWhen.setTime(fromTime);
				GregorianCalendar gc = new GregorianCalendar(fromWhen
						.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
						.get(Calendar.DAY_OF_MONTH));
				gc.add(Calendar.DATE, -1);
				toTime = (Date) gc.getTime();
				gc.add(Calendar.DATE, -15);
				fromTime = (Date) gc.getTime();
			}else{
				fromTime = OAStatUtil.convertDate(ftime);
				toTime = OAStatUtil.convertDate(ttime);
			}
			out.print("<br>");
			out.print("</table>");
			out.print("<table>");
			if(fromTime.compareTo(toTime)<0  && (toTime.getTime()-(new Date()).getTime())/1000/60/60/24 < 0){
				long j, k;
						//
						{
							int result = 0;
							out.print("<div class=\"table\">");
							out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
			
							//
							out.print("<tr class=\"first\" width=\"177\">");
							out.print("<th rowspan=\"2\" colspan=\"1\">");
							out.print(enType.getString("date"));
							out.print("</th>");
							out.print("<th rowspan=\"1\"  colspan=\"2\">");
							out.print(enType.getString("total"));
							out.print("</th>");
							out.print("<th rowspan=\"1\" colspan=\"2\">");
							out.print("5");
							out.print("</th>");	
							out.print("<th rowspan=\"1\" colspan=\"2\">");
							out.print("10");
							out.print("</th>");	
							out.print("<th rowspan=\"1\" colspan=\"2\">");
							out.print("20");
							out.print("</th>");							
							out.print("</tr>");
							
							out.print("<tr>");
							out.print("<th rowspan=\"1\" colspan=\"1\">");
							out.print("Amount");
							out.print("</th>");
							out.print("<th rowspan=\"1\" colspan=\"1\">");
							out.print("Users");
							out.print("</th>");
							out.print("<th rowspan=\"1\" colspan=\"1\">");
							out.print("Amount");
							out.print("</th>");
							out.print("<th rowspan=\"1\" colspan=\"1\">");
							out.print("Users");
							out.print("</th>");
							out.print("<th rowspan=\"1\" colspan=\"1\">");
							out.print("Amount");
							out.print("</th>");
							out.print("<th rowspan=\"1\" colspan=\"1\">");
							out.print("Users");
							out.print("</th>");
							out.print("<th rowspan=\"1\" colspan=\"1\">");
							out.print("Amount");
							out.print("</th>");
							out.print("<th rowspan=\"1\" colspan=\"1\">");
							out.print("Users");
							out.print("</th>");
							out.print("</tr>");
			
							SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
			
							j = (toTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
			
							long flag = (fromTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
							for (; j >= flag; j--) {
								if(-j%2 == 1){
									out.print("<tr >");
								}else{
									out.print("<tr class=\"bg\">");
								}
			
								Date fTime = OAStatUtil.getDate((int)j);
								Date tTime = OAStatUtil.getDate((int)j+1);
												
								out.print("<td>");
								out.print(sdf.format(fTime));
								out.print("</td>");
			
								{
									java.util.Map<Integer,Integer> addValueTimes = AddValueTimes.getAddValueTimes(fTime,tTime);
									java.util.Map<Integer,Integer> addValueUsers = AddValueTimes.getAddValueUsers(fTime,tTime);
									
									int total = 0;
									if(addValueTimes.containsKey(5)){
										total += addValueTimes.get(5)*5;
									}
									if(addValueTimes.containsKey(10)){
										total += addValueTimes.get(10)*10;
									}
									if(addValueTimes.containsKey(20)){
										total += addValueTimes.get(20)*20;
									}
									
									out.print("<td>");
									if(total>0){
										out.print(total);
									}else{
										out.print("");
									}
									out.print("</td>");
									
									out.print("<td>");
									if(addValueUsers.containsKey(0)){
										out.print(addValueUsers.get(0));
									}else{
										out.print("");
									}
									out.print("</td>");
									
									out.print("<td>");
									if(addValueTimes.containsKey(5)){
										out.print(addValueTimes.get(5)*5);
									}else{
										out.print("");
									}
									out.print("</td>");
									
									out.print("<td>");
									if(addValueUsers.containsKey(5)){
										out.print(addValueUsers.get(5));
									}else{
										out.print("");
									}
									out.print("</td>");
									
									out.print("<td>");
									if(addValueTimes.containsKey(10)){
										out.print(addValueTimes.get(10)*10);
									}else{
										out.print("");
									}
									out.print("</td>");
									
									out.print("<td>");
									if(addValueUsers.containsKey(10)){
										out.print(addValueUsers.get(10));
									}else{
										out.print("");
									}
									out.print("</td>");
									
									out.print("<td>");
									if(addValueTimes.containsKey(20)){
										out.print(addValueTimes.get(20)*20);
									}else{
										out.print("");
									}
									out.print("</td>");
									
									out.print("<td>");
									if(addValueUsers.containsKey(20)){
										out.print(addValueUsers.get(20));
									}else{
										out.print("");
									}
									out.print("</td>");
									
								}
								out.print("</tr>");
							}
							out.print("</table>");
							out.print("</div>");
						}
			}else{
				out.print("<h3>incorrect date</h3>");
			}
			out.print("</table>");
			}
}else{
	response.sendRedirect("index.jsp");
}
%>
</body>
</html>