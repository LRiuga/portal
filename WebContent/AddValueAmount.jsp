<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="gb2312"%>
<%@ page
	import="java.util.*,OAStat.*,java.util.Date,java.text.*,billingStat.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
</head>
<body>
	<h1>充值金额用户统计</h1>
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


	<form action="" method="post">

		<h3>时间：</h3>
		<input name="time" type="text" id="time" onfocus="datelist.dfd(this)"
			readOnly> -<input name="time2" type="text" id="time2"
			onfocus="datelist.dfd(this)" readOnly>

		<h3>金额下限:</h3>
		<input name="price1" type="text" required="required" />
		<h3>金额上限:</h3>
		<input name="price2" type="text" required="required" /> <input
			name="yes" type="submit" value="查询" />
	</form>
	<br>


	<%
if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		int min = 0;
		int max = 0;
		if(request.getParameter("price1")!=null && request.getParameter("price2")!=null){
			try{
				min = Integer.parseInt(request.getParameter("price1"));
				max = Integer.parseInt(request.getParameter("price2"));
				
				if(min>=max){
					int temp = max;
					max = min;
					min = temp;
				}
			}catch(Exception e){
				out.print("<h3>请输入合适的金额范围</h3>");
			}
		}
		
		String fTime = request.getParameter("time");
		String tTime = request.getParameter("time2");
		
		if(min==0 || max==0){
			out.print("<h3>请输入合适的金额</h3>");
		}else if(fTime==null||fTime==""){
			out.print("<h3>请输入开始时间</h3>");
		}else if(tTime==null||tTime==""){
			out.print("<h3>请输入结束时间</h3>");
		}else{
		SimpleDateFormat dateF = new SimpleDateFormat("MM-dd");
		
		
		out.print("<h3>金额下限 =("+min + ")    " );
		out.print("金额上限 =("+max + ")    " );
		out.print("开始时间 =("+fTime + ")    " );
		out.print("结束时间 =("+tTime + ")  </h3>  " );
		out.print("<br>");
		out.print("<br>");
		
		Date fromTime = OAStatUtil.convertDate(fTime);
		Date toTime = OAStatUtil.convertDate(tTime);
		
		if(fromTime.compareTo(toTime)<0){
		
		out.print("<div class=\"table_search\">");
		//
		out.print("<h2>充值金额用户数</h2>");
		
		{
		out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
		
		out.print("<tr class=\"first\" width=\"177\">");
		out.print("<th>");
		out.print("时间");
		out.print("</th>");
		out.print("<th>");
		out.print("人数");
		out.print("</th>");
		out.print("</tr>");
		
		out.print("<tr class=\"bg\">");
		out.print("<td>");
		out.print(dateF.format(fromTime)+" - "+dateF.format(toTime));
		out.print("</td>");
		out.print("<td class=\"last\">");
		out.print(AddValueTotal.getValueAmount(min,max,fromTime,toTime));
		out.print("</td>");
		out.print("</tr>");
		
		out.print("</table>");
		}
		
		{
		out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
		
		out.print("<tr class=\"first\" width=\"177\">");
		out.print("<th>");
		out.print("id");
		out.print("</th>");
		out.print("<th>");
		out.print("monetid");
		out.print("</th>");
		out.print("<th>");
		out.print("金额");
		out.print("</th>");
		out.print("</tr>");
		
		ArrayList<String> userList = new ArrayList<String>();
		userList = AddValueTotal.getAddValueUserList(min,max,fromTime,toTime);
		java.util.Map<String, Integer> map = new java.util.HashMap<String, Integer>();
		map = AddValueTotal.getAddValueUserMap(min,max,fromTime,toTime);
		
		for(int i=1;i<=userList.size();i++){
		out.print("<tr class=\"bg\">");
		out.print("<td>");
		out.print(i);
		out.print("</td>");
		out.print("<td>");
		out.print(userList.get(i-1));
		out.print("</td>");
		out.print("<td class=\"last\">");
		out.print(map.get(userList.get(i-1)));
		out.print("</td>");
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