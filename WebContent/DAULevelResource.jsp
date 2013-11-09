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
java.util.*,OAStat.*,java.util.Date,java.text.*,toolStat.*"%>
<%@page import="org.jfree.chart.ChartPanel"%>
<%@ page
	import="java.util.*,OAStat.*,java.util.Date,java.text.*,actionStat.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
</head>
<body>
	<h1>Resource</h1>
	<br />
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
			<%	
	String item = request.getParameter("selectItem");	
	if(item==""||item==null){
		item="GoldSellFish";
	}
	
	String resource = "";
	String type = "";
	if(item.equals("GoldSellFish")){
		resource = "Gold";
		type = "sellFish";
	}else if(item.equals("PearlFishing")){
		resource = "Pearl";
		type = "StopFish";
	}else if(item.equals("GoldLucky")){
		resource = "Gold";
		type = "getGift";
	}else if(item.equals("PearlLucky")){
		resource = "Pearl";
		type = "LuckyDraw";
	}else if(item.equals("PearlPersonalMonster")){
		resource = "Pearl";
		type = "attackPersonalMonster";
	}else if(item.equals("PearlAttackOthers")){
		resource = "Pearl";
		type = "AttackGetRewards";
	}
	
%>
			<select name="selectItem" id="selectItem">
				<option
					<%if(item.equals("GoldSellFish")){out.print("selected=\"selected\"");} %>
					value="GoldSellFish">Get gold by sellFish</option>
				<option
					<%if(item.equals("GoldLucky")){out.print("selected=\"selected\"");} %>
					value="GoldLucky">Get gold by LuckyDraw</option>
				<option
					<%if(item.equals("PearlFishing")){out.print("selected=\"selected\"");} %>
					value="PearlFishing">Get pearl by fishing</option>
				<option
					<%if(item.equals("PearlLucky")){out.print("selected=\"selected\"");} %>
					value="PearlLucky">Get pearl by LuckyDraw</option>
				<option
					<%if(item.equals("PearlPersonalMonster")){out.print("selected=\"selected\"");} %>
					value="PearlPersonalMonster">Get pearl by Attack Personal
					Monster</option>
				<option
					<%if(item.equals("PearlAttackOthers")){out.print("selected=\"selected\"");} %>
					value="PearlAttackOthers">Get pearl by attack others</option>
			</select> Date：<input name="time" type="text" id="time"
				onfocus="datelist.dfd(this)" readOnly> <br> <input
				name="yes" type="submit" value="Search" />
		</form>
	</div>
	<br>
	<%
if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		String ftime = request.getParameter("time");
		Date fTime = OAStatUtil.convertDate(ftime);
	
		if(ftime==null||ftime==""){
			Calendar fromWhen = Calendar.getInstance();
			fromWhen.setTime(fTime);
			GregorianCalendar gc = new GregorianCalendar(fromWhen
					.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
					.get(Calendar.DAY_OF_MONTH));
			gc.add(Calendar.DATE, -1);
			fTime = (Date) gc.getTime();
		}
			out.print("<br>");
			out.print("<table>");
			{
				int result = 0;
				
				out.print("<div class=\"table\">");
				out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
				out.print("<tr class=\"first\" width=\"177\">");
				
				out.print("<th>");
				out.print("Date");
				out.print("</th>");
				
				out.print("<th>");
				out.print("Level");
				out.print("</th>");

				out.print("<th>");
				out.print("Total");
				out.print("</th>");
				
				out.print("<th>");
				out.print("User");
				out.print("</th>");
				
				out.print("<th>");
				out.print("Average");
				out.print("</th>");
				
				out.print("<th>");
				out.print("Max");
				out.print("</th>");
				
				out.print("<th>");
				out.print("Mid");
				out.print("</th>");
				
				out.print("<th>");
				out.print("Min");
				out.print("</th>");

				out.print("</tr>");
				SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
				DecimalFormat df = new DecimalFormat("0.00");

				Map<Integer,Long> totalMap = DAULevelResource.getAmountMap(resource,type,fTime);
				Map<Integer,Double> averageMap = DAULevelResource.getAverageMap(resource,type,fTime);
				Map<Integer,Integer> userMap = DAULevelResource.getUsersMap(resource,type,fTime);
				Map<Integer,Long> maxMap = DAULevelResource.getMaxMap(resource,type,fTime);
				Map<Integer,Long> midMap = DAULevelResource.getMidMap(resource,type,fTime);
				Map<Integer,Long> minMap = DAULevelResource.getMinMap(resource,type,fTime);

				for(int level=0;level<21;level++){
					out.print("<tr >");
					
					out.print("<td>");
					out.print(sdf.format(fTime));
					out.print("</td>");
					
					out.print("<td>");
					if(level==0){
						out.print("AllUser");
					}else{
						out.print(level);					
					}
					out.print("</td>");
					
					out.print("<td>");
					if(totalMap.containsKey(level)){
						out.print(totalMap.get(level));					
					}else{
						out.print("");
					}
					out.print("</td>");
					
					out.print("<td>");
					if(userMap.containsKey(level)){
						out.print(userMap.get(level));					
					}else{
						out.print("");
					}
					out.print("</td>");
					
					out.print("<td>");
					if(averageMap.containsKey(level)){
						out.print(averageMap.get(level));					
					}else{
						out.print("");
					}
					out.print("</td>");
					
					out.print("<td>");
					if(maxMap.containsKey(level)){
						out.print(maxMap.get(level));
					}else{
						out.print("");					
					}
					out.print("</td>");
					
					out.print("<td>");
					if(midMap.containsKey(level)){
						out.print(midMap.get(level));
					}else{
						out.print("");					
					}
					out.print("</td>");
					
					out.print("<td>");
					if(minMap.containsKey(level)){
						out.print(minMap.get(level));					
					}else{
						out.print("");
					}
					out.print("</td>");
					
					out.print("</tr>");
				}
			}
				out.print("</table>");
				out.print("</div>");
			}
			out.print("<br>");
		out.print("</table>");
}else{
	response.sendRedirect("index.jsp");
}
%>
</body>
</html>