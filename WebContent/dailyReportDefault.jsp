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
	<h1>�ձ�</h1>
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

</script>

	<%
if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		//����list
		ArrayList<Date> dayList = new ArrayList<Date>();
		//total������MAP
		java.util.Map<Date, Double> selling = new java.util.HashMap<Date, Double>();
		//weapon������MAP
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
		//����
		Map<Date,Double> sellingMap = new HashMap<Date,Double>();
		Map<Date,Integer> sellingExceptionMap = new HashMap<Date,Integer>();
		//��ֵ	
		Map<Date,Double> addvalueMap = new HashMap<Date,Double>();
		Map<Date,Integer> addvalueExceptionMap = new HashMap<Date,Integer>();
		//׼������
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
			out.print("����");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("�������û���");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("��OA_DAU");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("OA2_DAU");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("��DAU");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("MAU");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("DAU/MAU");
			out.print("</th>");
						
			out.print("<th nowrap='nowrap'>");
			out.print("�ۼ��û�");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("ƽ����������");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("�����������");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("����ƽ�߱�");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("�û�����ʱ��");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("�����û���");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("���и����û���");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("����");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("��ֵ");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("ƽ������ARPU");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("�����û�ARPU");
			out.print("</th>");
			
			out.print("<th nowrap='nowrap'>");
			out.print("��͸��");
			out.print("</th>");
			
			out.print("</tr>");
	
					SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
	
					//��ӡ������,��ӡһ�ܵ����
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
							//���ʱ��
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
				out.print("1. �������û��������ջ�Ծ�û�����������	");
				out.print("<br>	");
				out.print("2. �ۼ��û������ۼƵ����죬��Ϸ���û���");
				out.print("<br>	");
				out.print("3. ƽ������������acu������һ��ʱ���ڣ���/��/�£��ڸ�ʱ��������������ƽ����Ľ����");
				out.print("<br>	");
				out.print("4. ������������������ʱ�������������е����ֵ");
				out.print("<br>	");
				out.print("5. �û�����ʱ����=acu*24/��Ծ�û��������Ƽ��㷽����");
				out.print("<br>	");
				out.print("6. �����û����������۶������");
				out.print("<br>	");
				out.print("7. ƽ������ARPU=�����۶�/ƽ����������");
				out.print("<br>	");
				out.print("8. �����û�ARPU=�����۶�/�����û���");
				out.print("<br>	");
				out.print("9. ��͸��=���ܸ�������/���ܻ�Ծ�û���");
				out.print("<br>	");
				out.print("10. ���и����û���=����credit�����û�+oabalance����");
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
						out.print("<h2>����ȼ��ֲ�</h2>");
						out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
		
						//��ӡ��������
						out.print("<tr class=\"first\" width=\"177\">");
						out.print("<th>");
						out.print("����");
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
						//��ӡ������,��ӡһ�ܵ����
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
							
								
								//���ʱ��
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
						out.print("<h2>ȫ�û��ȼ��ֲ�</h2>");
						out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
		
						//��ӡ��������
						out.print("<tr class=\"first\" width=\"177\">");
						out.print("<th>");
						out.print("����");
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
						//��ӡ������,��ӡһ�ܵ����
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
							
								
								//���ʱ��
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