<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="gb2312"%>
<%@ page
	import="java.util.*,OAStat.*,java.util.Date,java.text.*,userStats.*,toolStat.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
</head>
<body>
	<h1>金币丢失</h1>
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

p</script>

	<script language="javascript">
function settime(monetid,ftime,ttime){

//	window.open(url);
	alert(monetid);
	alert(ftime);
	alert(ttime);
	
}
</script>
	<h2>查询</h2>
	<form action="" method="post">

		<h3>时间：</h3>
		<input name="time" type="text" id="time" onfocus="datelist.dfd(this)"
			readOnly> -<input name="time2" type="text" id="time2"
			onfocus="datelist.dfd(this)" readOnly> <input name="yes"
			type="submit" value="查询" />
		<h3>ID:</h3>
		<input name="monetid" type="text" required="required" />
	</form>
	<br>


	<%
if(session!=null&&session.getAttribute("login")!=null){
				if(session.getAttribute("login").equals("ok")){

String monetid = request.getParameter("monetid");
String ftime = request.getParameter("time");
String ttime = request.getParameter("time2");
String money = request.getParameter("money");

if(money!=""&&money!=null){
		int mon = Integer.parseInt(money);
//		Gold.AddGold(monetid,mon);
}

if(monetid==null||monetid==""){
	out.print("<h3>请输入玩家ID</h3>");
}else if(ftime==null||ftime==""){
	out.print("<h3>请输入开始时间</h3>");
}else if(ttime==null||ttime==""){
	out.print("<h3>请输入结束时间</h3>");
}else{

	

//int monet = Integer.parseInt(monetid);
out.print("<h3>用户ID =("+monetid + ")    " );
out.print("开始时间 =("+ftime + ")    " );
out.print("结束时间 =("+ttime + ") </h3>   " );
out.print("<br>");
out.print("<br>");

Date fromTime = OAStatUtil.convertDate(ftime);
Date toTime = OAStatUtil.convertDate(ttime);


if(fromTime.compareTo(toTime)<0){
	ArrayList<String> rs = CurrentSelling.getLog_GoldMissing(monetid,fromTime,toTime);
	ArrayList<Date> msgTime = CurrentSelling.getLog_GoldMissing_time(monetid,fromTime,toTime);
	
	//buy or rent
//	ArrayList<String> buyRentKey = new ArrayList<String>();
//	java.util.Map<String, Date> buyRent = new java.util.HashMap<String, Date>();
	//sub money
//	ArrayList<String> subMoneyKey = new ArrayList<String>();
//	java.util.Map<String, Date> subMoney = new java.util.HashMap<String, Date>();
	//others
//	ArrayList<String> othersKey = new ArrayList<String>();
//	java.util.Map<String, Date> others = new java.util.HashMap<String, Date>();
	
//	{
//		for(String s:rs){
//			if(s.contains("Gold")||s.contains("Buy")||s.contains("Upgrade")){
//				buyRentKey.add(s);
//				buyRent.put(s,msgTime.get(s));
//			}else if(s.contains("Sub")){
//				subMoneyKey.add(s);
//				subMoney.put(s,msgTime.get(s));
//			}else{
//				othersKey.add(s);
//				others.put(s,msgTime.get(s));
//			}
//		}
//	
//	}


//
out.print("<h2>Gold记录</h2>");
{
out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
//int max = 0;
//if(buyRent.size()>subMoney.size()){
//	max = buyRent.size();
//}else{
//	max = subMoney.size();
//}

out.print("<tr class=\"first\" width=\"177\">");
out.print("<th>");
out.print("Buy or Rent");
out.print("</th>");
out.print("<th>");
out.print("Time");
out.print("</th>");
//out.print("<th>");
//out.print("Sub Money");
//out.print("</th>");
//out.print("<th>");
//out.print("Time");
//out.print("</th>");
out.print("</tr>");
for(int i=0;i<rs.size();i++){

out.print("<tr class=\"bg\">");
out.print("<td>");
out.print(rs.get(i));	
out.print("</td>");
out.print("<td>");
out.print(msgTime.get(i));	
out.print("</td>");

//out.print("<td>");
//if(i<subMoney.size()){
//	out.print(subMoneyKey.get(i));
//}
//out.print("</td>");
//out.print("<td>");
//if(i<subMoney.size()){
//	out.print(subMoney.get(subMoneyKey.get(i)));
//}
//out.print("</td>");
out.print("</tr>");
}
out.print("</table>");
}
out.print("<br>");

/*
{
out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
int max = othersKey.size();
out.print("<tr class=\"first\" width=\"177\">");
out.print("<th>");
out.print("others");
out.print("</th>");
out.print("<th>");
out.print("Time");
out.print("</th>");
out.print("</tr>");
for(int i=0;i<max;i++){
out.print("<tr>");
out.print("<td>");
out.print(othersKey.get(i));	
out.print("</td>");
out.print("<td class=\"last\">");
out.print(others.get(othersKey.get(i)));	
out.print("</td>");
out.print("</tr>");

out.print("</tr>");
}

out.print("</table>");
}
*/
}


}
}
			}else{
				response.sendRedirect("index.jsp");

			}
%>
</body>
</html>