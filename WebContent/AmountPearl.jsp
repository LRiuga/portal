<%@ page contentType="text/html;charset=GBK"%>

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
java.util.*,OAStat.*,java.util.Date,java.text.*,userStats.*,toolStat.*"%>
<%@page import="org.jfree.chart.ChartPanel"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
</head>
<body>
	<h1>Pear</h1>
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


			Date：<input name="time" type="text" id="time"
				onfocus="datelist.dfd(this)" readOnly>-<input name="time2"
				type="text" id="time2" onfocus="datelist.dfd(this)" readOnly>
			<br /> Last 30 days：<input name="time3" type="text" id="time3"
				onfocus="datelist.dfd(this)" readOnly> <input name="yes"
				type="submit" value="Search" />
		</form>
	</div>
	<br>


	<%
	if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		out.print("<table>");
		String ftime = request.getParameter("time");
		String ttime = request.getParameter("time2");
		String time3 = request.getParameter("time3");

		{
	out.print("<br>");
	Date fromTime = new Date();
	Date toTime = new Date();
		if(ftime!=""&&ttime!=""){
	fromTime = OAStatUtil.convertDate(ftime);
	toTime = OAStatUtil.convertDate(ttime);
		}else if(time3!=""){
	toTime = OAStatUtil.convertDate(time3);
	fromTime = new Date(toTime.getTime()-1000*3600*24*15);
	fromTime = new Date(fromTime.getTime()-1000*3600*24*15);
		}else if(time3==""){
	Date date = new Date();
	Calendar fromWhen = Calendar.getInstance();
	fromWhen.setTime(date);
	GregorianCalendar gc = new GregorianCalendar(fromWhen
			.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
			.get(Calendar.DAY_OF_MONTH));
	date = (Date) gc.getTime();
	gc.add(Calendar.DATE, -1);
	toTime = (Date) gc.getTime();
	fromTime = new Date(toTime.getTime()-1000*3600*24*15);
	fromTime = new Date(fromTime.getTime()-1000*3600*24*15);
		}

		if((ftime==""||ftime==null)&&(ttime==""||ttime==null)&&(time3==""||time3==null)){
	fromTime = new Date();
	Calendar fromWhen = Calendar.getInstance();
	fromWhen.setTime(fromTime);
	GregorianCalendar gc = new GregorianCalendar(fromWhen
			.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
			.get(Calendar.DAY_OF_MONTH));
	gc.add(Calendar.DATE, -1);
	toTime = (Date) gc.getTime();
	gc.add(Calendar.DATE, -15);
	gc.add(Calendar.DATE, -15);
	fromTime = (Date) gc.getTime();
		}

		out.print("</table>");
		out.print("<table>");

	long j, k;
	{
		Map<String,Set<String>> typeMap = AmountPearl.getAllItem(fromTime,toTime);
		Set<String> inSet = new HashSet<String>();
		inSet = typeMap.get("add");
		if(inSet.isEmpty()){
			inSet.add(" ");
		}
		Set<String> outSet = new HashSet<String>();
		outSet = typeMap.get("sub");
		if(outSet.isEmpty()){
			outSet.add(" ");
		}
		
		int result = 0;
		out.print("<div class=\"table\">");
		out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");

		out.print("<tr class=\"first\" width=\"177\">");
		out.print("<th rowspan=2>");
		out.print("Date");
		out.print("</th>");
		out.print("<th rowspan=1 colspan="+ inSet.size()*2 +">");
		out.print("Produce");
		out.print("</th>");
		out.print("<th rowspan=1 colspan="+ outSet.size()*2 +">");
		out.print("Consume");
		out.print("</th>");
		out.print("</tr>");
		
		out.print("<tr>");
		for(String inType:inSet){
			out.print("<th rowspan=1 colspan=2>");
			out.print(inType);
			out.print("</th>");
		}
		for(String outType:outSet){
			out.print("<th rowspan=1 colspan=2>");
			out.print(outType);
			out.print("</th>");
		}
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
			Map<String,Map<String,Long>> dataMap = AmountPearl.getOneDayData(fTime);
			long inAmount = AmountPearl.getGoldAmount("add",fTime);
			long outAmount = AmountPearl.getGoldAmount("sub",fTime);
			{
				out.print("<td>");
				if(inAmount>0){
					out.print(inAmount);
				}else{
					out.println("");				
				}
				out.print("</td>");
				
				out.print("<td>");
				if(outAmount>0){
					out.print(outAmount);
				}else{
					out.println("");				
				}
				out.print("</td>");
				
				for(String inType:inSet){
					out.print("<td colspan=1>");
					if(dataMap.containsKey("add")){
						if(dataMap.get("add").containsKey(inType)){
							out.print(dataMap.get("add").get(inType));
						}else{
							out.print("");
						}
					}else{
						out.print("");
					}
					out.print("</td>");
					
					out.print("<td>");
					if(dataMap.containsKey("add")){
						if(dataMap.get("add").containsKey(inType)){
							out.print(AmountPearl.Output(dataMap.get("add").get(inType)*1.0/inAmount));
						}else{
							out.print("");
						}
					}else{
						out.print("");
					}
					out.print("</td>");
				}
				for(String outType:outSet){
					out.print("<td colspan=1>");
					if(dataMap.containsKey("sub")){
						if(dataMap.get("sub").containsKey(outType)){
							out.print(dataMap.get("sub").get(outType));
						}else{
							out.print("");
						}
					}else{
						out.print("");
					}
					out.print("</td>");
					
					out.print("<td>");
					if(dataMap.containsKey("sub")){
						if(dataMap.get("sub").containsKey(outType)){
							out.print(AmountPearl.Output(dataMap.get("sub").get(outType)*1.0/outAmount));
						}else{
							out.print("");
						}
					}else{
						out.print("");
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
}
}
}else{
	response.sendRedirect("index.jsp");
}
%>
</body>
</html>