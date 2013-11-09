<%@ page contentType="text/html;charset=GBK"%>

<%@ page
	import="org.jfree.chart.ChartFactory,org.jfree.chart.JFreeChart,org.jfree.chart.servlet.ServletUtilities,org.jfree.chart.title.TextTitle,org.jfree.data.time.TimeSeries,org.jfree.data.time.Month,org.jfree.data.time.Day,org.jfree.data.time.TimeSeriesCollection,java.awt.Font,java.util.*,OAStat.*,java.util.Date,java.text.*,userStats.*,login.*"%>
<%@page import="org.jfree.chart.ChartPanel"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
</head>
<body>
	<%	String item = request.getParameter("selectItem");	
    if(item==""||item==null){
		item="[1,1,8]-4";
	}
%>
	<div class=\"table\">
		<form action="" method="post">
			<h2>必选</h2>
			<select name="selectItem" id="selectItem">

				<option
					<%if(item.equals("[1,1,8]-3")){out.print("selected=\"selected\"");} %>
					value="[1,1,8]-3">1.1.8 J2ME</option>
				<option
					<%if(item.equals("[1,1,8]-4")){out.print("selected=\"selected\"");} %>
					value="[1,1,8]-4">1.1.8 BB</option>
				<option
					<%if(item.equals("[1,1,8]-0")){out.print("selected=\"selected\"");} %>
					value="[1,1,8]-0">1.1.8 Android</option>
				<option
					<%if(item.equals("[1,1,7]-4")){out.print("selected=\"selected\"");} %>
					value="[1,1,7]-4">1.1.7 BB</option>
				<option
					<%if(item.equals("[1,1,6]-3")){out.print("selected=\"selected\"");} %>
					value="[1,1,6]-3">1.1.6 J2ME</option>
				<option
					<%if(item.equals("[1,1,6]-4")){out.print("selected=\"selected\"");} %>
					value="[1,1,6]-4">1.1.6 BB</option>
				<option
					<%if(item.equals("[1,1,6]-0")){out.print("selected=\"selected\"");} %>
					value="[1,1,6]-0">1.1.6 Android</option>
				<option
					<%if(item.equals("[1,1,5]-4")){out.print("selected=\"selected\"");} %>
					value="[1,1,5]-4">1.1.5 BB</option>
				<option
					<%if(item.equals("[1,1,5]-3")){out.print("selected=\"selected\"");} %>
					value="[1,1,5]-3">1.1.5 J2ME</option>
				<option
					<%if(item.equals("[1,1,4]-4")){out.print("selected=\"selected\"");} %>
					value="[1,1,4]-4">1.1.4 BB</option>
				<option
					<%if(item.equals("[1,1,4]-3")){out.print("selected=\"selected\"");} %>
					value="[1,1,4]-3">1.1.4 J2ME</option>
				<option
					<%if(item.equals("[1,1,3]-4")){out.print("selected=\"selected\"");} %>
					value="[1,1,3]-4">1.1.3 BB</option>
				<option
					<%if(item.equals("[1,1,3]-3")){out.print("selected=\"selected\"");} %>
					value="[1,1,3]-3">1.1.3 J2ME</option>
			</select>
			<h1><%=item%>统计
			</h1>
			<input name="yes" type="submit" value="查询" />
		</form>
	</div>
	<h1>MO流程</h1>
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

	<%
	if (session != null && session.getAttribute("login") != null) {
		if (session.getAttribute("login").equals("ok")) {
			//日期list
			ArrayList<Date> dayList = new ArrayList<Date>();
			out.print("<table>");
			Date toTime = new Date();
			Date fromTime = new Date();
			Calendar fromWhen = Calendar.getInstance();
			fromWhen.setTime(fromTime);
			GregorianCalendar gc = new GregorianCalendar(fromWhen
					.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH),
					fromWhen.get(Calendar.DAY_OF_MONTH));
			gc.add(Calendar.DATE, -1);
			toTime = (Date) gc.getTime();
			gc.add(Calendar.DATE, -15);
			gc.add(Calendar.DATE, -15);
			fromTime = (Date) gc.getTime();

			out.print("<br>");
			{
				out.print("</table>");
				toTime = new Date();
				fromTime = new Date();
				fromWhen = Calendar.getInstance();
				fromWhen.setTime(fromTime);
				gc = new GregorianCalendar(fromWhen.get(Calendar.YEAR),
						fromWhen.get(Calendar.MONTH), fromWhen
								.get(Calendar.DAY_OF_MONTH));
				gc.add(Calendar.DATE, -1);
				toTime = (Date) gc.getTime();
				gc.add(Calendar.DATE, -8);
				fromTime = (Date) gc.getTime();

				long j;
				int result = 0;
				out.print("<div class=\"table\">");
				out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");

				out.print("<tr class=\"first\" width=\"177\">");
				out.print("<th nowrap='nowrap'>");
				out.print("日期");
				out.print("</th>");

				out.print("<th nowrap='nowrap'>");
				out.print("NewAuthId");
				out.print("</th>");
				
				out.print("<th nowrap='nowrap'>");
				out.print("STC-AuthId");
				out.print("</th>");
				
				out.print("<th nowrap='nowrap'>");
				out.print("Poll-Success");
				out.print("</th>");

				out.print("</tr>");

				SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");

				//打印销售量,打印一周的情况
				j = (toTime.getTime() - (new Date()).getTime())
						/ (1000 * 60 * 60 * 24);
				DecimalFormat dfdouble = new DecimalFormat("0.00");
				DecimalFormat dfint = new DecimalFormat("0");
				long flag = (fromTime.getTime() - (new Date())
						.getTime())
						/ (1000 * 60 * 60 * 24);
				for (; j >= flag; j--) {
					if (-j % 2 == 1) {
						out.print("<tr >");
					} else {
						out.print("<tr class=\"bg\">");
					}

					Date fTime = OAStatUtil.getDate((int) j);
					Date tTime = OAStatUtil.getDate((int) j + 1);
					{
						//输出时间
						out.print("<td>");
						out.print(sdf.format(fTime));
						out.print("</td>");
						
						out.print("<td>");
						int AllPoll = MOMTProcedure.getValue(fTime,item,"AllPoll");
						if (AllPoll == 0) {
							out.print("");
						} else {
							out.print(AllPoll);
						}
						out.print("</td>");
						
						out.print("<td>");
						int STCPoll = MOMTProcedure.getValue(fTime,item,"STCPoll");
						if (STCPoll == 0) {
							out.print("");
						} else {
							out.print(STCPoll);
						}
						out.print("</td>");
						
						out.print("<td>");
						int STCSuccess = MOMTProcedure.getValue(fTime,item,"STCSuccess");
						if (STCSuccess == 0) {
							out.print("");
						} else {
							out.print(STCSuccess);
						}
						out.print("</td>");
					}

					out.print("</tr>");
				}
				out.print("</table>");
			}
			
			out.print("<br>");
			{
				out.print("</table>");
				toTime = new Date();
				fromTime = new Date();
				fromWhen = Calendar.getInstance();
				fromWhen.setTime(fromTime);
				gc = new GregorianCalendar(fromWhen.get(Calendar.YEAR),
						fromWhen.get(Calendar.MONTH), fromWhen
								.get(Calendar.DAY_OF_MONTH));
				gc.add(Calendar.DATE, -1);
				toTime = (Date) gc.getTime();
				gc.add(Calendar.DATE, -8);
				fromTime = (Date) gc.getTime();

				long j;
				int result = 0;
				out.print("<div class=\"table\">");
				out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");

				out.print("<tr class=\"first\" width=\"177\">");
				out.print("<th nowrap='nowrap'>");
				out.print("日期");
				out.print("</th>");
				
				out.print("<th nowrap='nowrap'>");
				out.print("PollSuccess->Monetid");
				out.print("</th>");
				
				out.print("<th nowrap='nowrap'>");
				out.print("PollSuccess->TryLogin");
				out.print("</th>");

				out.print("<th nowrap='nowrap'>");
				out.print("TryLogin->LoginSuccess");
				out.print("</th>");
				
				out.print("</tr>");

				SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");

				//打印销售量,打印一周的情况
				j = (toTime.getTime() - (new Date()).getTime())
						/ (1000 * 60 * 60 * 24);
				DecimalFormat dfdouble = new DecimalFormat("0.00");
				DecimalFormat dfint = new DecimalFormat("0");
				long flag = (fromTime.getTime() - (new Date())
						.getTime())
						/ (1000 * 60 * 60 * 24);
				for (; j >= flag; j--) {
					if (-j % 2 == 1) {
						out.print("<tr >");
					} else {
						out.print("<tr class=\"bg\">");
					}

					Date fTime = OAStatUtil.getDate((int) j);
					Date tTime = OAStatUtil.getDate((int) j + 1);
					{
						//输出时间
						out.print("<td>");
						out.print(sdf.format(fTime));
						out.print("</td>");
						
						out.print("<td>");
						int PollSuccessMonetId = MOMTProcedure.getValue(fTime,item,"PollSuccessMonetId");
						if (PollSuccessMonetId == 0) {
							out.print("");
						} else {
							out.print(PollSuccessMonetId);
						}
						out.print("</td>");
						
						out.print("<td>");
						int PollSuccessTryLoginMonetId = MOMTProcedure.getValue(fTime,item,"PollSuccessTryLoginMonetId");
						if (PollSuccessTryLoginMonetId == 0) {
							out.print("");
						} else {
							out.print(PollSuccessTryLoginMonetId);
						}
						out.print("</td>");

						out.print("<td>");
						int TryLoginLoginSuccess = MOMTProcedure.getValue(fTime,item,"TryLoginLoginSuccess");
						if (TryLoginLoginSuccess == 0) {
							out.print("");
						} else {
							out.print(TryLoginLoginSuccess);
						}
						out.print("</td>");
					}

					out.print("</tr>");
				}
				out.print("</table>");
			}
		}
	} else {
		response.sendRedirect("index.jsp");

	}
%>
</body>
</html>