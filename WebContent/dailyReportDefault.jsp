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
	<h1>日报</h1>
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
if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		//日期list
		ArrayList<Date> dayList = new ArrayList<Date>();
		//total销售量MAP
		java.util.Map<Date, Double> selling = new java.util.HashMap<Date, Double>();
		//weapon销售量MAP
		java.util.Map<Date, Double> weapon = new java.util.HashMap<Date, Double>();
		out.print("<table>");
		
		Date toTime = new Date();
		Date fromTime = new Date();
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
		
		//New Users
		Map<Date,Double> newuserMap = new HashMap<Date,Double>();
		Map<Date,Integer> newuserExceptionMap = new HashMap<Date,Integer>();
		//DAU
		Map<Date,Double> dauMap = new HashMap<Date,Double>();
		Map<Date,Integer> dauExceptionMap = new HashMap<Date,Integer>();
		//DAU OA2
		Map<Date,Double> dauOa2Map = new HashMap<Date,Double>();
		Map<Date,Integer> dauOa2ExceptionMap = new HashMap<Date,Integer>();
		//销售
		Map<Date,Double> sellingMap = new HashMap<Date,Double>();
		Map<Date,Integer> sellingExceptionMap = new HashMap<Date,Integer>();
		//充值	
		Map<Date,Double> addvalueMap = new HashMap<Date,Double>();
		Map<Date,Integer> addvalueExceptionMap = new HashMap<Date,Integer>();
		//准备数据
		{
			long j;	
			j = (toTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
			long flag = (fromTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
			for (; j >= flag; j--) {
				Date fTime = OAStatUtil.getDate((int)j);
				Date tTime = OAStatUtil.getDate((int)j+1);
				
				addvalueMap.put(fTime,DailyReport.getAddValue(fTime));
				sellingMap.put(fTime,DailyReport.getDailySelling(fTime));
				dauMap.put(fTime,DailyReport.getDAU(fTime));
				dauOa2Map.put(fTime,DailyReport.getOA2DAU(fTime));
				newuserMap.put(fTime,DailyReport.getNewFisher(fTime));
			}
			addvalueExceptionMap = OAStatUtil.checkExceptionValue(addvalueMap);
			sellingExceptionMap = OAStatUtil.checkExceptionValue(sellingMap);
			dauExceptionMap = OAStatUtil.checkExceptionValue(dauMap);
			newuserExceptionMap = OAStatUtil.checkExceptionValue(newuserMap);
			dauOa2ExceptionMap = OAStatUtil.checkExceptionValue(dauOa2Map);
		}	
		out.print("</table>");
		out.print("<table>");
		{
			toTime = new Date();
			fromTime = new Date();
			fromWhen = Calendar.getInstance();
			fromWhen.setTime(fromTime);
			gc = new GregorianCalendar(fromWhen
					.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
					.get(Calendar.DAY_OF_MONTH));
			gc.add(Calendar.DATE, -1);
			toTime = (Date) gc.getTime();
			gc.add(Calendar.DATE, -3);
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
			out.print("当日新用户数");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("旧OA_DAU");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("OA2_DAU");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("总DAU");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("MAU");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("DAU/MAU");
			out.print("</th>");
						
			out.print("<th nowrap='nowrap'>");
			out.print("累计用户");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("平均在线人数");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("最高在线人数");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("在线平高比");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("用户在线时长");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("付费用户数");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("所有付费用户数");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("销售");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("充值");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("平均在线ARPU");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("付费用户ARPU");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("渗透率");
			out.print("</th>");
			
			out.print("</tr>");
	
					SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
	
					//打印销售量,打印一周的情况
					j = (toTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
					DecimalFormat dfdouble = new DecimalFormat("0.00");
					DecimalFormat dfint = new DecimalFormat("0");
					long flag = (fromTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
					for (; j >= flag; j--) {
						if(-j%2 == 1){
							out.print("<tr >");
						}else{
							out.print("<tr class=\"bg\">");
						}
	
						Date fTime = OAStatUtil.getDate((int)j);
						Date tTime = OAStatUtil.getDate((int)j+1);
						{				
							//输出时间
							out.print("<td>");
							out.print(sdf.format(fTime));
							out.print("</td>");
						
							out.print("<td>");
							if(newuserExceptionMap.get(fTime)==1){
								out.print("<font color=\"#FF0000\">");
								out.print(newuserMap.get(fTime));
								out.print("</font>");
							}else if(newuserExceptionMap.get(fTime)==2){
								out.print("<font color=\"#00FF00\">");
								out.print(newuserMap.get(fTime));
								out.print("</font>");
							}else{
								out.print(newuserMap.get(fTime));
							}
							out.print("</td>");
						
							out.print("<td>");
							if(dauExceptionMap.get(fTime)==1){
								out.print("<font color=\"#FF0000\">");
								out.print(dauMap.get(fTime));
								out.print("</font>");
							}else if(dauExceptionMap.get(fTime)==2){
								out.print("<font color=\"#00FF00\">");
								out.print(dauMap.get(fTime));
								out.print("</font>");
							}else{
								out.print(dauMap.get(fTime));
							}
							out.print("</td>");
							
							out.print("<td>");
							if(dauOa2ExceptionMap.get(fTime)==1){
								out.print("<font color=\"#FF0000\">");
								out.print(dauOa2Map.get(fTime));
								out.print("</font>");
							}else if(dauOa2ExceptionMap.get(fTime)==2){
								out.print("<font color=\"#00FF00\">");
								out.print(dauOa2Map.get(fTime));
								out.print("</font>");
							}else{
								out.print(dauOa2Map.get(fTime));
							}
							out.print("</td>");
							
							out.print("<td>");
							out.print(dfint.format(DailyReport.getTotalDau(fTime)));
							out.print("</td>");
							
							out.print("<td>");
							out.print(dfint.format(DailyReport.getMAU(fTime)));
							out.print("</td>");
							
							out.print("<td>");
							out.print(dfdouble.format(DailyReport.getDAU(fTime)/DailyReport.getMAU(fTime)));
							out.print("</td>");
							
							out.print("<td>");
							out.print(dfint.format(DailyReport.getFisherAmount(fTime)));
							out.print("</td>");
							
							out.print("<td>");
							out.print(dfint.format(DailyReport.getAvrgUsers(fTime)));
							out.print("</td>");
							
							out.print("<td>");
							out.print(dfint.format(DailyReport.getMaxUsers(fTime)));
							out.print("</td>");
							
							out.print("<td>");
							out.print(dfdouble.format((DailyReport.getAvrgUsers(fTime)*1.0)/DailyReport.getMaxUsers(fTime)));
							out.print("</td>");
							
							out.print("<td>");
							out.print(dfdouble.format(DailyReport.getUsersTime(fTime)));
							out.print("</td>");
							
							out.print("<td>");
							out.print(dfint.format(DailyReport.getPaymentUser(fTime)));
							out.print("</td>");
							
							out.print("<td>");
							out.print(dfint.format(DailyReport.getAllPaymentUser(fTime)));
							out.print("</td>");
							
							out.print("<td>");
							if(sellingExceptionMap.get(fTime)==1){
								out.print("<font color=\"#FF0000\">");
								out.print(sellingMap.get(fTime));
								out.print("</font>");
							}else if(sellingExceptionMap.get(fTime)==2){
								out.print("<font color=\"#00FF00\">");
								out.print(sellingMap.get(fTime));
								out.print("</font>");
							}else{
								out.print(sellingMap.get(fTime));
							}
							out.print("</td>");
							
							out.print("<td>");
							if(addvalueExceptionMap.get(fTime)==1){
								out.print("<font color=\"#FF0000\">");
								out.print(addvalueMap.get(fTime));
								out.print("</font>");
							}else if(addvalueExceptionMap.get(fTime)==2){
								out.print("<font color=\"#00FF00\">");
								out.print(addvalueMap.get(fTime));
								out.print("</font>");
							}else{
								out.print(addvalueMap.get(fTime));
							}
							out.print("</td>");
							
							out.print("<td>");
							out.print(DailyReport.getAvrgUserARPU(fTime));
							out.print("</td>");
							
							out.print("<td>");
							out.print(DailyReport.getARPU(fTime));
							out.print("</td>");
							
							out.print("<td class=\"last\">");
							out.print(DailyReport.getPermeability(fTime));
							out.print("</td>");
						}
	
						out.print("</tr>");
	
					}
					out.print("</table>");
					out.print("</div>");
				}
				out.print("<br>	");
				out.print("1. 当日新用户数，当日活跃用户数：不解释	");
				out.print("<br>	");
				out.print("2. 累计用户数：累计到当天，游戏总用户数");
				out.print("<br>	");
				out.print("3. 平均在线人数（acu）：将一段时间内（天/周/月）内各时间点的在线数进行平均后的结果。");
				out.print("<br>	");
				out.print("4. 最高在线人数：当天各时间点的在线人数中的最高值");
				out.print("<br>	");
				out.print("5. 用户在线时长：=acu*24/活跃用户数（近似计算方法）");
				out.print("<br>	");
				out.print("6. 付费用户数，总销售额：不解释");
				out.print("<br>	");
				out.print("7. 平均在线ARPU=总销售额/平均在线人数");
				out.print("<br>	");
				out.print("8. 付费用户ARPU=总销售额/付费用户数");
				out.print("<br>	");
				out.print("9. 渗透率=月总付费人数/月总活跃用户数");
				out.print("<br>	");
				out.print("10. 所有付费用户数=当日credit付费用户+oabalance付费");
				out.print("<br>	");
				
				{
						toTime = new Date();
						fromTime = new Date();
						fromWhen = Calendar.getInstance();
						fromWhen.setTime(fromTime);
						gc = new GregorianCalendar(fromWhen
								.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
								.get(Calendar.DAY_OF_MONTH));
						gc.add(Calendar.DATE, -1);
						toTime = (Date) gc.getTime();
						gc.add(Calendar.DATE, -3);
						fromTime = (Date) gc.getTime();
				
						long j;	
						
						int result = 0;
						out.print("<div class=\"table\">");
						out.print("<h2>家族等级分布</h2>");
						out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
		
						//打印道具名称
						out.print("<tr class=\"first\" width=\"177\">");
						out.print("<th>");
						out.print("日期");
						out.print("</th>");
						
						out.print("<th>");
						out.print("0");
						out.print("</th>");
						
						out.print("<th>");
						out.print("1");
						out.print("</th>");
						
						out.print("<th>");
						out.print("2");
						out.print("</th>");
						
						out.print("<th>");
						out.print("3");
						out.print("</th>");
						
						out.print("<th>");
						out.print("4");
						out.print("</th>");
						
						out.print("</tr>");
		
						SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
						java.util.Map<Integer,Integer> all_map = new java.util.HashMap<Integer, Integer>();
						//打印销售量,打印一周的情况
						j = (toTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
						DecimalFormat dfdouble = new DecimalFormat("0.00");
						DecimalFormat dfint = new DecimalFormat("0");
						long flag = (fromTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
						for (; j >= flag; j--) {
							if(-j%2 == 1){
								out.print("<tr >");
							}else{
								out.print("<tr class=\"bg\">");
							}
		
							Date fTime = OAStatUtil.getDate((int)j);
							Date tTime = OAStatUtil.getDate((int)j+1);
							{			
								all_map = ShipyardLevel.getList("tribe",fTime);
							
								
								//输出时间
								out.print("<td>");
								out.print(sdf.format(fTime));
								out.print("</td>");
							
								out.print("<td>");
								out.print(all_map.get(0));
								out.print("</td>");
								
								out.print("<td>");
								out.print(all_map.get(1));
								out.print("</td>");
								
								out.print("<td>");
								out.print(all_map.get(2));
								out.print("</td>");
								
								out.print("<td>");
								out.print(all_map.get(3));
								out.print("</td>");
							
								out.print("<td class=\"last\">");
								out.print(all_map.get(4));
								out.print("</td>");
							}
		
							out.print("</tr>");
		
						}
						out.print("</table>");
						out.print("</div>");
					}
					
					{
						toTime = new Date();
						fromTime = new Date();
						fromWhen = Calendar.getInstance();
						fromWhen.setTime(fromTime);
						gc = new GregorianCalendar(fromWhen
								.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
								.get(Calendar.DAY_OF_MONTH));
						gc.add(Calendar.DATE, -1);
						toTime = (Date) gc.getTime();
						gc.add(Calendar.DATE, -3);
						fromTime = (Date) gc.getTime();
					
						long j;	
					
						int result = 0;
						out.print("<div class=\"table\">");
						out.print("<h2>全用户等级分布</h2>");
						out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
		
						//打印道具名称
						out.print("<tr class=\"first\" width=\"177\">");
						out.print("<th>");
						out.print("日期");
						out.print("</th>");
						
						out.print("<th>");
						out.print("1");
						out.print("</th>");
						
						out.print("<th>");
						out.print("2");
						out.print("</th>");
						
						out.print("<th>");
						out.print("3");
						out.print("</th>");
						
						out.print("<th>");
						out.print("4");
						out.print("</th>");
						
						out.print("<th>");
						out.print("5");
						out.print("</th>");
						
						out.print("<th>");
						out.print("6");
						out.print("</th>");
						
						out.print("</tr>");
		
						SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
						java.util.Map<Integer,Integer> all_map = new java.util.HashMap<Integer, Integer>();
						//打印销售量,打印一周的情况
						j = (toTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
						DecimalFormat dfdouble = new DecimalFormat("0.00");
						DecimalFormat dfint = new DecimalFormat("0");
						long flag = (fromTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
						for (; j >= flag; j--) {
							if(-j%2 == 1){
								out.print("<tr >");
							}else{
								out.print("<tr class=\"bg\">");
							}
		
							Date fTime = OAStatUtil.getDate((int)j);
							Date tTime = OAStatUtil.getDate((int)j+1);
							{			
								all_map = ShipyardLevel.getList("fisher",fTime);
							
								
								//输出时间
								out.print("<td>");
								out.print(sdf.format(fTime));
								out.print("</td>");
							
								out.print("<td>");
								out.print(all_map.get(1));
								out.print("</td>");
								
								out.print("<td>");
								out.print(all_map.get(2));
								out.print("</td>");
								
								out.print("<td>");
								out.print(all_map.get(3));
								out.print("</td>");
								
								out.print("<td>");
								out.print(all_map.get(4));
								out.print("</td>");
								
								out.print("<td>");
								out.print(all_map.get(5));
								out.print("</td>");
							
								out.print("<td class=\"last\">");
								out.print(all_map.get(6));
								out.print("</td>");
							}
		
							out.print("</tr>");
		
						}
						out.print("</table>");
						out.print("</div>");
					}
		
			out.print("</table>");
		}
	
}else{
	response.sendRedirect("index.jsp");

}
%>
</body>
</html>