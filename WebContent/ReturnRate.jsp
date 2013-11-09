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
	import="java.util.*,OAStat.*,java.util.Date,java.text.*,newUserBehavior.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
</head>
<body>
	<h1>用户粘性统计</h1>
	<br />
	<script language="javascript">
		document.writeln("<div id='DateGird' style='display:none;position: absolute;border:1px solid #EC5657;background-color: #fbeded;'></div>");
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


	<div class=\"table\">
		<form action="" method="post">


			<h3>时间：</h3>
			<input name="time" type="text" id="time" onfocus="datelist.dfd(this)"
				readOnly> -<input name="time2" type="text" id="time2"
				onfocus="datelist.dfd(this)" readOnly> <input name="yes"
				type="submit" value="查询" />
		</form>
	</div>
	<br>


	<%
if(session!=null&&session.getAttribute("login")!=null){
				if(session.getAttribute("login").equals("ok")){

String ftime = request.getParameter("time");
String ttime = request.getParameter("time2");

if(ftime==null||ftime==""){
	out.print("<h3>请输入开始时间</h3>");
}else if(ttime==null||ttime==""){
	out.print("<h3>请输入结束时间</h3>");
}else{

out.print("<h3>开始时间 =("+ftime + ")    " );
out.print("结束时间 =("+ttime + ")  </h3>  " );
out.print("<br>");
out.print("<br>");
out.print("<table>");
Date fTime = OAStatUtil.convertDate(ftime);
Date tTime = OAStatUtil.convertDate(ttime);
out.print("</table>");
out.print("<table>");
if(fTime.compareTo(tTime)<0  && (tTime.getTime()-(new Date()).getTime())/1000/60/60/24 < 0){

			long j = (tTime.getTime()-(new Date()).getTime())/(1000*60*60*24);

			long flag = (fTime.getTime()-(new Date()).getTime())/(1000*60*60*24);

			
			//
			{
				int result = 0;
				
				out.print("<h2>用户粘性统计</h2>");
				out.print("<div class=\"table\">");
				out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
				Date fromTime = OAStatUtil.getDate((int)j);
				Date toTime = OAStatUtil.getDate((int)j+1);
				DecimalFormat df = new DecimalFormat("0.00");
				
				
				
				
				
				//打印名称
				out.print("<tr class=\"first\" width=\"177\">");
				
				out.print("<th>");
				out.print("时间");
				out.print("</th>");
				
				out.print("<th>");
				out.print("新用户数");
				out.print("</th>");

				out.print("<th>");
				out.print("一天");
				out.print("</th>");
				
				out.print("<th>");
				out.print("三天");
				out.print("</th>");

				out.print("<th>");
				out.print("一周");
				out.print("</th>");
				
				out.print("<th>");
				out.print("两周");
				out.print("</th>");
				
				out.print("<th>");
				out.print("一月");
				out.print("</th>");
				
				out.print("</tr>");
				SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");

				//打印销售量,打印一周的情况
				for (; j >= flag; j--) {

					if(-j%2 == 1){
						out.print("<tr >");
					}else{
						out.print("<tr class=\"bg\">");
					}

					fromTime = OAStatUtil.getDate((int)j);
					toTime = OAStatUtil.getDate((int)j+1);
					ArrayList<Object> list = new ArrayList<Object>();
					list = ReturnRate.getOneDayData(fromTime);
			if(list != null && list.size()==7){
					double amount = Double.valueOf(list.get(1).toString());
					double oneday = Double.valueOf(list.get(2).toString());
					double threeday = Double.valueOf(list.get(3).toString());
					double oneweek = Double.valueOf(list.get(4).toString());
					double twoweek = Double.valueOf(list.get(5).toString());
					double onemonth = Double.valueOf(list.get(6).toString());
					
					
					//输出时间
					out.print("<td>");
					out.print(sdf.format(list.get(0)));
					out.print("</td>");
					
					out.print("<td>");
					out.print(list.get(1));
					out.print("</td>");
					
					out.print("<td>");
					if(oneday/amount==0.0){
						out.print(" ");
					}else{
						out.print(df.format(oneday/amount));
					}
					//out.print(df.format(oneday/amount));
					out.print("</td>");
					

					out.print("<td>");
					if(threeday/amount==0.0){
						out.print(" ");
					}else{
						out.print(df.format(threeday/amount));
					}
					//out.print(df.format(threeday/amount));
					out.print("</td>");
					
					out.print("<td>");
					if(oneweek/amount==0.0){
						out.print(" ");
					}else{
						out.print(df.format(oneweek/amount));
					}
					//out.print(df.format(oneweek/amount));
					out.print("</td>");
					
					out.print("<td>");
					if(twoweek/amount==0.0){
						out.print(" ");
					}else{
						out.print(df.format(twoweek/amount));
					}
					//out.print(df.format(twoweek/amount));
					out.print("</td>");
					
					out.print("<td>");
					if(onemonth/amount==0.0){
						out.print(" ");
					}else{
						out.print(df.format(onemonth/amount));
					}
					//out.print(df.format(onemonth/amount));
					out.print("</td>");
					
					out.print("</tr>");
				}
			}
				out.print("</table>");
				//
				out.print("</div>");
			}
			

}else{
	out.print("<h3>请输入正确的截止时间</h3>");
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