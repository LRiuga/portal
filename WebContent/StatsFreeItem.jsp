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
	<h1>免费道具统计</h1>
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

<%	String item = request.getParameter("selectItem");	
    if(item==""||item==null){
		item="checkInGift";
	}
%>
</script>
	<div class=\"table\">
		<form action="" method="post">
			<h3>时间：</h3>
			<input name="time" type="text" id="time" onfocus="datelist.dfd(this)"
				readOnly> -<input name="time2" type="text" id="time2"
				onfocus="datelist.dfd(this)" readOnly> <select
				name="selectItem" id="selectItem">
				<option
					<%if(item.equals("WorldMonsterAttack")){out.print("selected=\"selected\"");} %>
					value="WorldMonsterAttack">攻击世界怪</option>
				<option
					<%if(item.equals("WorldMonsterKill")){out.print("selected=\"selected\"");} %>
					value="WorldMonsterKill">击杀世界怪</option>
				<option
					<%if(item.equals("WorldMonsterSummon")){out.print("selected=\"selected\"");} %>
					value="WorldMonsterSummon">召唤世界怪</option>
				<option
					<%if(item.equals("WorldMonsterTop")){out.print("selected=\"selected\"");} %>
					value="WorldMonsterTop">世界怪分前三</option>
				<option
					<%if(item.equals("checkInGift")){out.print("selected=\"selected\"");} %>
					value="checkInGift">单日签到</option>
				<option
					<%if(item.equals("continuousLogin")){out.print("selected=\"selected\"");} %>
					value="continuousLogin">连续签到</option>
				<option
					<%if(item.equals("exchangeGem")){out.print("selected=\"selected\"");} %>
					value="exchangeGem">兑换宝石</option>
				<option
					<%if(item.equals("getfreeCrew")){out.print("selected=\"selected\"");} %>
					value="getfreeCrew">免费船员</option>
				<option
					<%if(item.equals("getfreeWeapon")){out.print("selected=\"selected\"");} %>
					value="getfreeWeapon">免费武器</option>
				<option
					<%if(item.equals("mission")){out.print("selected=\"selected\"");} %>
					value="mission">任务奖励</option>
				<option
					<%if(item.equals("MonsterReward")){out.print("selected=\"selected\"");} %>
					value="MonsterReward">怪物奖励</option>
				<option
					<%if(item.equals("TBox")){out.print("selected=\"selected\"");} %>
					value="TBox">开启宝箱</option>
				<option
					<%if(item.equals("invitefriend")){out.print("selected=\"selected\"");} %>
					value="invitefriend">邀请</option>
			</select> <input name="yes" type="submit" value="查询" />
		</form>
	</div>
	<br>


	<%
if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		String ftime = request.getParameter("time");
		String ttime = request.getParameter("time2");
		
		Date fTime = new Date();
		Date tTime = new Date();
		
		if(ftime!=null&&!ftime.equals("")&&ttime!=null&&!ttime.equals("")){
			fTime = OAStatUtil.convertDate(ftime);
			tTime = OAStatUtil.convertDate(ttime);
		}

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
		long j = (tTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
		long flag = (fTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
		if((fTime.getTime()-(new Date()).getTime())/1000/60/60/24 < 0){
			List<String> list = FreeItem.getNameList(item,fTime,tTime);
			java.util.Map<String,Integer> map = new java.util.HashMap<String,Integer>();
			List nameList = list;
			Date fromTime = OAStatUtil.getDate((int)j);
			Date toTime = OAStatUtil.getDate((int)j+1);
			int result = 0;
			out.print("<div class=\"table\">");
			out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
			//
			out.print("<tr class=\"first\" width=\"177\">");
			out.print("<th>");
			out.print("道具名");
			out.print("</th>");
			Collections.sort(nameList);		
			for (int i=0;i<nameList.size();i++) {
				out.print("<th>");
				out.print(nameList.get(i));
				out.print("</th>");	
			}
			Collections.sort(nameList);
			SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
			//打印使用量,打印一周的情况
			for (; j >= flag; j--) {
				if(-j%2 == 1){
					out.print("<tr >");
				}else{
					out.print("<tr class=\"bg\">");
				}
				
				fromTime = OAStatUtil.getDate((int)j);
				toTime = OAStatUtil.getDate((int)j+1);
				map = FreeItem.getActionAmount(item,fromTime);
				out.print("<td>");
				out.print(sdf.format(fromTime));
				out.print("</td>");

				//直接读取一行数据
				{
					for (int i=0;i<nameList.size();i++) {
						out.print("<td>");
						if(map.get(nameList.get(i)) == null || map.get(nameList.get(i)) == 0){
							out.print("0");
						}else{
							out.print(map.get(nameList.get(i)));
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
	out.print("</table>");
}else{
	response.sendRedirect("index.jsp");
}

%>
</body>
</html>