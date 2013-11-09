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
	<h1>OABalance销售:</h1>
	<br>
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
			时间：<input name="time" type="text" id="time"
				onfocus="datelist.dfd(this)" readOnly>-<input name="time2"
				type="text" id="time2" onfocus="datelist.dfd(this)" readOnly>
			<br /> 过去一个月：<input name="time3" type="text" id="time3"
				onfocus="datelist.dfd(this)" readOnly> <input name="yes"
				type="submit" value="查询" />
		</form>
	</div>
	<br>


	<%
String graphURL = "";
String filename = "";

if(session!=null&&session.getAttribute("login")!=null){
				if(session.getAttribute("login").equals("ok")){
//日期list
ArrayList<Date> dayList = new ArrayList<Date>();
//total销售量MAP
java.util.Map<Date, Double> selling = new java.util.HashMap<Date, Double>();
//weapon销售量MAP
java.util.Map<Date, Double> weapon = new java.util.HashMap<Date, Double>();
out.print("<table>");
String ftime = request.getParameter("time");
String ttime = request.getParameter("time2");
String time3 = request.getParameter("time3");

{

Date fromTime = OAStatUtil.convertDate(ftime);
Date toTime = OAStatUtil.convertDate(ttime);
if(time3!=""&&time3!=null){
	toTime = OAStatUtil.convertDate(time3);
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
if(fromTime.compareTo(toTime)<0  && (toTime.getTime()-(new Date()).getTime())/1000/60/60/24 < 0){
			//保存道具名称
			ArrayList<String> itemName = new ArrayList<String>();
			ArrayList<String> NewItemName = new ArrayList<String>();
			java.util.Map<String, Integer> itemSell = new java.util.HashMap<String, Integer>();
			java.util.Map<String, Double> itemCredit = new java.util.HashMap<String,Double>();
			java.util.Map<String, Double> itemOaBalance = new java.util.HashMap<String,Double>();
			//保存道具价格_creadit
			java.util.Map<String, Double> itemPrice = new java.util.HashMap<String, Double>();

			itemName = OAStatUtil.getItemNameList(fromTime,toTime);
			//itemPrice = OAStatUtil.getNamePrice();

			Date before = OAStatUtil.convertDate("2012-06-01");

			long j, k;

			//道具销售量统计表
			{

				int result = 0;
				out.print("<div class=\"table\">");
				out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
				
				out.print("<tr class=\"first\" width=\"177\">");
				//打印道具名称
				out.print("<th>");
				out.print("道具名");
				out.print("</th>");
				out.print("<th>");
				out.print("OABalance总额");
				out.print("</th>");
				out.print("<th>");
				out.print("Credit总额");
				out.print("</th>");
				for (int i = itemName.size() - 1; i >= 0; i--) {
					if(itemName.get(i)=="pyramid-background"||itemName.get(i)=="pyramid-shipyard"||itemName.get(i)=="pyramid-warehouse"||itemName.get(i)=="Christmas-background"||
								itemName.get(i)=="Christmas-shipyard"||itemName.get(i)=="Christmas-warehouse"||itemName.get(i)=="Halloween-background"||itemName.get(i)=="Halloween-shipyard"||
									itemName.get(i)=="Halloween-warehouse"||itemName.get(i)=="Destroy-background"||itemName.get(i)=="EiffelTower"||itemName.get(i)=="greatwall"||itemName.get(i)=="liberty"||
										itemName.get(i)=="Romancoliseum"||itemName.get(i)=="4city"||itemName.get(i)=="Defense System 4"||itemName.get(i)=="topaz"||itemName.get(i)=="Sapphire"||itemName.get(i)=="Ruby"
										||itemName.get(i)=="amethyst"||itemName.get(i)=="emerald"||itemName.get(i).contains("Eid")){
					}else if(itemName.get(i)=="Defense System 3"){
						out.print("<th>");
						out.print("Defense System 4");
						NewItemName.add("Defense System 4");
						out.print("</th>");	
						out.print("<th>");
						out.print(itemName.get(i));
						NewItemName.add(itemName.get(i));
						out.print("</th>");	
					}else{
						out.print("<th>");
						out.print(itemName.get(i));
						NewItemName.add(itemName.get(i));
						out.print("</th>");		
					}
				}

				out.print("</tr>");
				
				out.print("<tr>");
				out.print("<th>");
				out.print("单价");
				out.print("</th>");
				for (int i = NewItemName.size() - 1; i >= 0; i--) {
					out.print("<th>");
					out.print(itemPrice.get(NewItemName.get(NewItemName.size()-1-i)));
					out.print("</th>");
				}
		
				out.print("<th>");
				out.print("-----");
				out.print("</th>");
				out.print("<th>");
				out.print("-----");
				out.print("</th>");
				out.print("</tr>");

				SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
				double oabalance = 0.0;
				double credit = 0.0;
				//打印销售量,打印一周的情况
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
									
					//输出时间
					out.print("<td>");
					out.print(sdf.format(fTime));
					out.print("</td>");
					

					//直接读取一行数据
					{
						oabalance = 0.0;
						credit= 0.0;
						DecimalFormat df = new DecimalFormat("0.00");
						
						itemOaBalance = OAStats_local.getCreditOABalance(fTime,tTime);
						Set<String> oabalanceSet = itemOaBalance.keySet();
						for(String s:oabalanceSet){
							oabalance += itemOaBalance.get(s);
						}
						
						itemCredit = OAStats_local.getCreditOABalanceCredit(fTime,tTime);
						Set<String> itemCreditSet = itemOaBalance.keySet();
						for(String s:itemCreditSet){
							credit += itemCredit.get(s);
						}
						
						itemSell = OAStats_local.getSellingOABalance(fTime,tTime);
						
						out.print("<td >");
						out.print(df.format(oabalance));
						out.print("</td>");
						
						out.print("<td >");
						out.print(df.format(credit));
						out.print("</td>");
						
						for (int i = 0; i <= NewItemName.size()-1; i++) {
							out.print("<td >");
							if(itemSell.get(NewItemName.get(i)) == null || itemSell.get(NewItemName.get(i)) == 0){
								out.print("0");
							}else{
								out.print("<a href = \"OABalanceDetail.jsp?itemName=" + NewItemName.get(i) + "&" + "fromTime=" + OAStatUtil.DateConvert(fTime) + "\">" + itemSell.get(NewItemName.get(i)) + "</a>" );
							}
							out.print("</td>");
						}
					}

					out.print("</tr>");

				}
				out.print("</table>");
				out.print("</div>");
			}

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
</body>
</html>