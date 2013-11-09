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
	import="java.util.*,OAStat.*,java.util.Date,java.text.*,actionStat.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
</head>
<body>
	<h1>关键动作统计</h1>
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
			<h2>必选</h2>
			<%	String item = request.getParameter("selectItem");	
	if(item==""||item==null){
		item="startFish";
	}

%>
			<select name="selectItem" id="selectItem">
				<option
					<%if(item.equals("startFish")){out.print("selected=\"selected\"");} %>
					value="startFish">捕鱼</option>
				<option
					<%if(item.equals("startSteal")){out.print("selected=\"selected\"");} %>
					value="startSteal">偷鱼</option>
				<option
					<%if(item.equals("attack")){out.print("selected=\"selected\"");} %>
					value="attack">攻击</option>
				<option
					<%if(item.equals("addGold")){out.print("selected=\"selected\"");} %>
					value="addGold">增加金币</option>
				<option
					<%if(item.equals("attackMonster")){out.print("selected=\"selected\"");} %>
					value=attackMonster>打家族怪</option>
				<option
					<%if(item.equals("attackWorldMonster")){out.print("selected=\"selected\"");} %>
					value=attackWorldMonster>打世界怪</option>
				<option
					<%if(item.equals("buyByCredit")){out.print("selected=\"selected\"");} %>
					value="buyByCredit">Credit购买</option>
				<option
					<%if(item.equals("buyByGold")){out.print("selected=\"selected\"");} %>
					value="buyByGold">Gold购买</option>
				<option
					<%if(item.equals("buyShip")){out.print("selected=\"selected\"");} %>
					value="buyShip">买船</option>
				<option
					<%if(item.equals("catchSteal")){out.print("selected=\"selected\"");} %>
					value="catchSteal">抓小偷</option>
				<option
					<%if(item.equals("sellFish")){out.print("selected=\"selected\"");} %>
					value="sellFish">卖单鱼</option>
				<option
					<%if(item.equals("sellAllfish")){out.print("selected=\"selected\"");} %>
					value="sellAllfish">卖所有鱼</option>
				<option
					<%if(item.equals("sellGem")){out.print("selected=\"selected\"");} %>
					value="sellGem">卖宝石</option>
				<option
					<%if(item.equals("sellShip")){out.print("selected=\"selected\"");} %>
					value="sellShip">卖船</option>
				<option
					<%if(item.equals("upgradeShipyard")){out.print("selected=\"selected\"");} %>
					value="upgradeShipyard">升级船厂</option>
				<option
					<%if(item.equals("upgradeTribeShip")){out.print("selected=\"selected\"");} %>
					value="upgradeTribeShip">升级家族船</option>
				<option
					<%if(item.equals("upgradMorangeVessel")){out.print("selected=\"selected\"");} %>
					value="upgradMorangeVessel">升级潜水艇</option>
				<option
					<%if(item.equals("useCrew")){out.print("selected=\"selected\"");} %>
					value="useCrew">使用Crew</option>
				<option
					<%if(item.equals("useSpeaker")){out.print("selected=\"selected\"");} %>
					value="useSpeaker">使用Speaker</option>
				<option
					<%if(item.equals("useWeapon")){out.print("selected=\"selected\"");} %>
					value="useWeapon">使用Weapon</option>
			</select>
			<h3>可选</h3>
			时间：<input name="time" type="text" id="time"
				onfocus="datelist.dfd(this)" readOnly> -<input name="time2"
				type="text" id="time2" onfocus="datelist.dfd(this)" readOnly>
			<br> <input name="yes" type="submit" value="查询" />
		</form>
	</div>
	<br>


	<%

String graphURL_action = "";
String graphURL_users = "";
String filename_action = "";
String filename_users = "";

if(session!=null&&session.getAttribute("login")!=null){
				if(session.getAttribute("login").equals("ok")){

String ftime = request.getParameter("time");
String ttime = request.getParameter("time2");
Date fTime = OAStatUtil.convertDate(ftime);
Date tTime = OAStatUtil.convertDate(ttime);
{
if(ftime==null||ftime==""){
	Calendar fromWhen = Calendar.getInstance();
	fromWhen.setTime(fTime);
	GregorianCalendar gc = new GregorianCalendar(fromWhen
			.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
			.get(Calendar.DAY_OF_MONTH));
	gc.add(Calendar.DATE, -1);
	tTime = (Date) gc.getTime();
	gc.add(Calendar.DATE, -15);
	fTime = (Date) gc.getTime();
}
out.print("<table>");

out.print("</table>");
out.print("<table>");
if(fTime.compareTo(tTime)<0  && (tTime.getTime()-(new Date()).getTime())/1000/60/60/24 < 0){

			long j = (tTime.getTime()-(new Date()).getTime())/(1000*60*60*24);

			long flag = (fTime.getTime()-(new Date()).getTime())/(1000*60*60*24);

			
			j = (tTime.getTime()-(new Date()).getTime())/(1000*60*60*24);

			flag = (fTime.getTime()-(new Date()).getTime())/(1000*60*60*24);

			out.print("<br>");
			
			//
			{
				int result = 0;
				
				out.print("<h2>动作数统计</h2>");
				out.print("<div class=\"table\">");
				out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
				Date fromTime = OAStatUtil.getDate((int)j);
				Date toTime = OAStatUtil.getDate((int)j+1);

				//打印名称
				out.print("<tr class=\"first\" width=\"177\">");
				
				out.print("<th>");
				out.print("时间");
				out.print("</th>");
				
				out.print("<th>");
				out.print("动作");
				out.print("</th>");

				out.print("<th>");
				out.print("总次数");
				out.print("</th>");
				
				out.print("<th>");
				out.print("总人数");
				out.print("</th>");
				
				out.print("<th>");
				out.print("人均数");
				out.print("</th>");
				
				out.print("<th>");
				out.print("最大次数");
				out.print("</th>");
				
				out.print("<th>");
				out.print("MonetId");
				out.print("</th>");

				//访问量统计时间线
TimeSeries timeSeries_action = new TimeSeries("action",Day.class);
TimeSeries timeSeries_user = new TimeSeries("user",Day.class);
//时间曲线数据集合
TimeSeriesCollection lineDataset_action = new TimeSeriesCollection();
TimeSeriesCollection lineDataset_users = new TimeSeriesCollection();
				

				out.print("</tr>");
				SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
				DecimalFormat df = new DecimalFormat("0.00");

				//
				for (; j >= flag; j--) {

					if(-j%2 == 1){
						out.print("<tr >");
					}else{
						out.print("<tr class=\"bg\">");
					}

					fromTime = OAStatUtil.getDate((int)j);
					toTime = OAStatUtil.getDate((int)j+1);
					
					int action = actionActive.getActionAmount(item,fromTime);
					int users = actionActive.getUserAmount(item,fromTime);
					int max = actionActive.getMaxAmount(item,fromTime);
					String monetid = actionActive.getMonetidAmount(item,fromTime);
					
					//输出时间
					out.print("<td>");
					out.print(sdf.format(fromTime));
					out.print("</td>");
					
					out.print("<td>");
					out.print(item);
					out.print("</td>");
					
					out.print("<td>");
					out.print(action);
					timeSeries_action.add(new Day(fromTime.getDate(),fromTime.getMonth()+1,fromTime.getYear()+1900),action);
					out.print("</td>");
					
					out.print("<td>");
					out.print(users);
					timeSeries_user.add(new Day(fromTime.getDate(),fromTime.getMonth()+1,fromTime.getYear()+1900),users);
					out.print("</td>");
					
					if(action!=0){
						out.print("<td class=\"last\">");
						out.print(df.format((action+0.0)/users));
						out.print("</td>");
					}else{
						out.print("<td class=\"last\">");
						out.print("未统计");
						out.print("</td>");
					}
					
					out.print("<td>");
					out.print(max);
					out.print("</td>");
					
					out.print("<td>");
					out.print(monetid);
					out.print("</td>");

					out.print("</tr>");
				}
				
				lineDataset_action.addSeries(timeSeries_action);
				lineDataset_users.addSeries(timeSeries_user);	
							
JFreeChart chart_action = ChartFactory.createTimeSeriesChart("catch", "date", "amount", lineDataset_action, true, true, true);
//设置子标题
TextTitle subtitle_action = new TextTitle(item, new Font("黑体", Font.BOLD, 12));
chart_action.addSubtitle(subtitle_action);
//设置主标题
chart_action.setTitle(new TextTitle(item, new Font("隶书", Font.ITALIC, 15)));
chart_action.setAntiAlias(true);
ChartPanel panel =  new ChartPanel(chart_action);
panel.setMaximumDrawWidth(2000);
panel.setMaximumDrawHeight(1000);
filename_action = ServletUtilities.saveChartAsPNG(chart_action, 500, 300, null, session);
graphURL_action = request.getContextPath() + "/DisplayChart?filename=" + filename_action;

JFreeChart chart_users = ChartFactory.createTimeSeriesChart("catch", "date", "amount", lineDataset_users, true, true, true);
//设置子标题
TextTitle subtitle_users = new TextTitle(item, new Font("黑体", Font.BOLD, 12));
chart_users.addSubtitle(subtitle_users);
//设置主标题
chart_users.setTitle(new TextTitle(item, new Font("隶书", Font.ITALIC, 15)));
chart_users.setAntiAlias(true);
ChartPanel panel_users =  new ChartPanel(chart_users);
panel_users.setMaximumDrawWidth(2000);
panel_users.setMaximumDrawHeight(1000);
filename_users = ServletUtilities.saveChartAsPNG(chart_users, 500, 300, null, session);
graphURL_users = request.getContextPath() + "/DisplayChart?filename=" + filename_users;
out.print("</table>");
out.print("</div>");
}
			j = (tTime.getTime()-(new Date()).getTime())/(1000*60*60*24);

			flag = (fTime.getTime()-(new Date()).getTime())/(1000*60*60*24);

			out.print("<br>");
			

}else{
	out.print("请输入正确的截止时间");
}
out.print("</table>");
}
}
			}else{
				response.sendRedirect("index.jsp");

			}
%>
	<img src="<%= graphURL_action %>" width=500 height=300 border=0
		usemap="#<%= filename_action %>">
	<img src="<%= graphURL_users %>" width=500 height=300 border=0
		usemap="#<%= filename_users %>">
</body>
</html>