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
java.util.*,OAStat.*,java.util.Date,java.text.*,userStats.*"%>
<%@page import="org.jfree.chart.ChartPanel"%>
<%@ page
	import="java.util.*,OAStat.*,java.util.Date,java.text.*,login.*"%>
<%@page import="util.HighChartUtil"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
</head>
<body>
	<br />
	<br />
	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"
		type="text/javascript"></script>
	<script src="js/highcharts.js" type="text/javascript"></script>
	<script language="javascript">
		document.writeln("<div id='DateGird' style='display:none; z-index: 10; position: absolute;border:1px solid #EC5657;background-color: #fbeded;'></div>");
		var Glob_YY=parseInt(new Date().getFullYear());
		var Glob_MM=parseInt(new Date().getMonth()+1);
		var Glob_DD=parseInt(new Date().getDate());

function shotable(InputName)
{
        var DateArray=["日","一","二","三","四","五","六"];
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
	<script type="text/javascript"> 
$(function () {
    var chart;
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'container',
                type: 'column',
                margin: [ 50, 50, 100, 80]
            },
            title: {
                text: <%	String item = request.getParameter("selectItem");	
                			if(item==""||item==null){
								item="Model";
							}
							out.print("'"+item+"'");
                	%>
            },
            subtitle: {
                text: 'Source: oastats.mozat.com'
            },
            xAxis: {
                categories: [
					<%
						ArrayList<String> list = new ArrayList<String>();
					
						String ftime = request.getParameter("time");
						String top = request.getParameter("top");	
						
						Date fTime = new Date();
						Date tTime = new Date();
						
						if(ftime!=null&&!ftime.equals("")){
							fTime = OAStatUtil.convertDate(ftime);
						}else{
							Calendar fromWhen = Calendar.getInstance();
							fromWhen.setTime(fTime);
							GregorianCalendar gc = new GregorianCalendar(fromWhen
									.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
									.get(Calendar.DAY_OF_MONTH));
							gc.add(Calendar.DATE, -1);
							fTime = (Date) gc.getTime();
						}
						if(top==null||top.equals("")){
							top = "10";
						}
						
						list = DownloadStats.getItemListOneDateFromDownloadphone(fTime,item,Integer.parseInt(top));
						out.print(HighChartUtil.getxAxis(list));
						
					%>
				]
            },
            yAxis: {
                title: {
                    text: 
                    <%
                    	if(!item.equals("Rate")){
                    		out.print("'Amount '");
                    	}else{
                    		out.print("'Percent '");
                    	}
                    %>
                   
                }
            },
            tooltip: {
                enabled: true,
                formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                        this.x +': '+ this.y +
                        <%
                    	if(!item.equals("Rate")){
                    		out.print("' times'");
                    	}else{
                    		out.print("' %'");
                    	}
                    %>
                    ;
                }
            },
 /////////////////////////////////////////           
 			 series: [{
                name: 'Amount',
                data: [
				<%
					Map<String,Double> map = new HashMap<String,Double>();
					list = DownloadStats.getItemListOneDateFromDownloadphone(fTime,item,Integer.parseInt(top));
//					map = DownloadStats.getItemMapOneDate(fTime,item,Integer.parseInt(top));
					map = DownloadStats.getItemMapOneDateFromDownloadStatsAmount(fTime,item);
					out.print(HighChartUtil.getxAxis(list,map));				
					
				%>
				],
                dataLabels: {
                    enabled: true,
                    rotation: -90,
                    color: '#FFFFFF',
                    align: 'right',
                    x: 4,
                    y: 10,
                    style: {
                        fontSize: '13px',
                        fontFamily: 'Verdana, sans-serif'
                    }
                }
            }]
        });
    });
    
});
</script>
	<div class=\"table\">
		<form action="" method="post">
			<h1>
				时间:<%=fTime%>,项目:<%=item%>,Top:<%=top%></h1>
			时间：<input name="time" type="text" id="time"
				onfocus="datelist.dfd(this)" readOnly="readonly"> 项目: <select
				name="selectItem" id="selectItem">
				<option
					<%if(item.equals("Model")){out.print("selected=\"selected\"");} %>
					value="Model">访问次数</option>
				<option
					<%if(item.equals("Brand")){out.print("selected=\"selected\"");} %>
					value="Brand">下载次数</option>

			</select> Top:<input name="top" id="top"
				onkeyup="value=value.replace(/[^\d]/g,'') "
				onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
			<br> <input name="yes" type="submit" value="查询" />
		</form>
	</div>

	<%

if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		out.print("<div id=\"container\" style=\"min-width: 400px; height: 400px; margin: 0 auto\"></div> ");
	}	
}else{
	response.sendRedirect("index.jsp");
}
%>
	<%

if(list!=null&&list.size()>0){
	out.print("<br>	");
	
	SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
	
	Map<String,String> mapOs = new HashMap<String,String>();
	Map<String,Double> mapDownload = new HashMap<String,Double>();
	
	DecimalFormat dfdouble = new DecimalFormat("0.00");
	
	list = DownloadStats.getItemListOneDateFromDownloadphone(fTime,item);
	map = DownloadStats.getItemMapOneDateFromDownloadStatsAmount(fTime,item);
	mapDownload = DownloadStats.getItemMapOneDateFromDownloadStatsAmount(fTime,"Brand");	
	mapOs = DownloadStats.getItemMapOneDateFromDownloadStatsOS(fTime,item);	
	
	out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
	out.print("<tr class=\"first\" width=\"177\">");
	out.print("<th>");
	out.print("ranking");
	out.print("</th>");
	out.print("<th>");
	out.print("Model");
	out.print("</th>");
	out.print("<th>");
	out.print("OS");
	out.print("</th>");
	
	if(item.equals("Model")){
		out.print("<th>");
		out.print("Visit");
		out.print("</th>");
		out.print("<th>");
		out.print("Download");
		out.print("</th>");
		out.print("<th>");
		out.print("Rate");
		out.print("</th>");
	}else{
		out.print("<th>");
		out.print("Download");
		out.print("</th>");
	}
	
	out.print("</tr>");
	
	int id = 1;
	Map<String,Double> oneDateMap = new HashMap<String,Double>();
	for(String temp:list){
		out.print("<tr>");
		out.print("<td>");
		out.print(id++);
		out.print("</td>");
	
		out.print("<td>");
		out.print(temp);
		out.print("</td>");
		
		out.print("<td>");
		out.print(mapOs.get(temp));
		out.print("</td>");
	
		if(item.equals("Model")){
			out.print("<td>");
			out.print(map.get(temp));
			out.print("</td>");
			
			out.print("<td>");
			if(mapDownload.get(temp)==null){
				out.print("");
			}else{
				out.print(mapDownload.get(temp));		
			}
			out.print("</td>");
			
			out.print("<td>");
			if(mapDownload.get(temp)==null){
				out.print("");
			}else{
				out.print(dfdouble.format(mapDownload.get(temp)/map.get(temp)));		
			}
		}else{
			out.print("<td>");
			if(mapDownload.get(temp)==null){
				out.print("");
			}else{
				out.print(mapDownload.get(temp));		
			}
			out.print("</td>");
		}
		
		out.print("</td>");
		out.print("</tr>");
	}
	out.print("</table>");
	out.print("<br>");
	out.print("<br>");
}

%>
</body>
</html>