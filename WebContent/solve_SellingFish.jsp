<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="gb2312"%>
<%@ page
	import="java.util.*,OAStat.*,java.util.Date,java.text.*,userStats.*,actionStat.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
</head>
<body>
	<h1>�����쳣</h1>
	<br />
	<script language="javascript">
		document.writeln("<div id='DateGird' style='display:none;position: absolute;border:1px solid #EC5657;background-color: #fbeded;'></div>");
		var Glob_YY=parseInt(new Date().getFullYear());
		var Glob_MM=parseInt(new Date().getMonth()+1);
		var Glob_DD=parseInt(new Date().getDate());

function shotable(InputName)
{
        var DateArray=["��","һ","��","��","��","��","��"];
        var output=""
        output=output+"<div style='padding:5px;border:1px solid #fbafb0;'><table style='width:156px;font-size:9pt;cursor:default;border:0px solid #999999;' border='0' cellpadding='0' cellspacing='0'>";
        output=output+"<tr ><td colspan='7' class='TrTitle'><span ID='yearUU'>"+Glob_YY+"</span><span ID='monthUU'>"+Glob_MM+"</span><a href='#' onclick='return;'>*</a></td></tr><table>";
        output=output+"<table style='font-size:12px;font-family: \"����\", Helvetica, sans-serif;cursor:default;border:0px solid #999999;border:1px solid #F5D6D6;' border='1' cellpadding='0' cellspacing='0'>";
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
       {selectMMInnerHTML += "<option Author=wayx value='" + i + "' selected>" + i + "��" + "</option>\r\n";}
    else {selectMMInnerHTML += "<option Author=wayx value='" + i + "'>" + i + "��" + "</option>\r\n";}
}
selectMMInnerHTML += "</select>";
var selectYYInnerHTML = "<select ID=\"sYear\" onchange=\"setPan(this.value,document.getElementById('sMonth').value)\" style='width:65px;background:#F5d6d6'>";
for (var i = 1999; i <= Glob_YY; i++)
{
    if (i == Glob_YY)
       {selectYYInnerHTML += "<option Author=wayx value='" + i + "' selected>" + i + "��" + "</option>\r\n";}
    else {selectYYInnerHTML += "<option Author=wayx value='" + i + "'>" + i + "��" + "</option>\r\n";}
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
	<h2>��ѯ</h2>
	<form action="" method="post">

		<h3>ʱ�䣺</h3>
		<input name="time" type="text" id="time" onfocus="datelist.dfd(this)"
			readOnly> -<input name="time2" type="text" id="time2"
			onfocus="datelist.dfd(this)" readOnly> <input name="yes"
			type="submit" value="��ѯ" />
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
	//Gold.AddGold(monetid,mon);
}

if(monetid==null||monetid==""){
	out.print("<h3>���������ID</h3>");
}else if(ftime==null||ftime==""){
	out.print("<h3>�����뿪ʼʱ��</h3>");
}else if(ttime==null||ttime==""){
	out.print("<h3>���������ʱ��</h3>");
}else{

	

//int monet = Integer.parseInt(monetid);
out.print("<h3>�û�ID =("+monetid + ")    " );
out.print("��ʼʱ�� =("+ftime + ")    " );
out.print("����ʱ�� =("+ttime + ") </h3>   " );
out.print("<br>");
out.print("<br>");

Date fromTime = OAStatUtil.convertDate(ftime);
Date toTime = OAStatUtil.convertDate(ttime);


if(fromTime.compareTo(toTime)<0){
	java.util.Map<Integer,java.util.Map<String,Object>> maps = new java.util.HashMap<Integer,java.util.Map<String,Object>>();
	ArrayList<String> itemList = new ArrayList<String>();
	maps = SellingFish.getLog(monetid,fromTime,toTime);
	itemList = SellingFish.getItemList();
	
//
out.print("<h2>�����¼</h2>");
{
out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");

out.print("<tr class=\"first\" width=\"177\">");
out.print("<th>");
out.print("id");
out.print("</th>");
for(String s:itemList){
	out.print("<th>");
	out.print(s);
	out.print("</th>");
}
out.print("</tr>");

Set set = maps.keySet();
int max=set.size();

for(int i=1;i<=max;i++){
out.print("<tr class=\"bg\">");
java.util.Map<String,Object> map = new java.util.HashMap<String,Object>();
if(maps!=null){
map = maps.get(i);
if(i == max){
	out.print("<td class=\"last\">");
	out.print(i);
	out.print("</td>");
	for(Object s:itemList){
		out.print("<td class=\"last\">");
		out.print(map.get(s));
		out.print("</td>");
	}
}else{
	out.print("<td>");
	out.print(i);
	out.print("</td>");
	for(Object s:itemList){
		out.print("<td>");
		out.print(map.get(s));
		out.print("</td>");
	}
}
}

out.print("</tr>");
}
out.print("</table>");
}
out.print("<br>");

}


}
}
			}else{
				response.sendRedirect("index.jsp");

			}
%>
</body>
</html>