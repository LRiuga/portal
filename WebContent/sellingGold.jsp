<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*,OAStat.*,java.util.Date,java.text.*,userStats.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
</head>
<style type="text/css">
.STYLE3 {
	font-size: 12px;
	color: #435255;
}
</style>
<%
	ResourceBundle languageType = ResourceBundle.getBundle("system");
	ResourceBundle enType = ResourceBundle.getBundle(languageType.getString("language"));
	String limitString = session.getAttribute("limit").toString();
	if(limitString!=null){
		if(limitString.equals("3")){
			enType = ResourceBundle.getBundle("English");
		}
	}
 %>
<body>
	<h1><%=enType.getString("gold")%>
		<%=enType.getString("sales")%>:
	</h1>
	<a href="sellingGold.jsp?Action=DownloadExcel"><img
		src="images/Excel.gif" width="24" height="23" /><%=enType.getString("link.download_excel") %></a>
	<br>
	<script language="javascript">
		document.writeln("<div id='DateGird' style='display:none;position: absolute;border:1px solid #EC5657;background-color: #fbeded;'></div>");
		var Glob_YY=parseInt(new Date().getFullYear());
		var Glob_MM=parseInt(new Date().getMonth()+1);
		var Glob_DD=parseInt(new Date().getDate());

function shotable(InputName)
{
        var DateArray=["Sun","Mon","Tues","Wed","Thur","Fri","Sat"];
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
       {selectMMInnerHTML += "<option Author=wayx value='" + i + "' selected>" + i + "" + "</option>\r\n";}
    else {selectMMInnerHTML += "<option Author=wayx value='" + i + "'>" + i + "" + "</option>\r\n";}
}
selectMMInnerHTML += "</select>";
var selectYYInnerHTML = "<select ID=\"sYear\" onchange=\"setPan(this.value,document.getElementById('sMonth').value)\" style='width:65px;background:#F5d6d6'>";
for (var i = 1999; i <= Glob_YY; i++)
{
    if (i == Glob_YY)
       {selectYYInnerHTML += "<option Author=wayx value='" + i + "' selected>" + i + "" + "</option>\r\n";}
    else {selectYYInnerHTML += "<option Author=wayx value='" + i + "'>" + i + "" + "</option>\r\n";}
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
			<%=enType.getString("date") %>：<input name="time" type="text"
				id="time" onfocus="datelist.dfd(this)" readOnly>-<input
				name="time2" type="text" id="time2" onfocus="datelist.dfd(this)"
				readOnly> <br />
			<%=enType.getString("notice.Last30days") %>：<input name="time3"
				type="text" id="time3" onfocus="datelist.dfd(this)" readOnly>
			<input name="yes" type="submit"
				value=<%=enType.getString("search") %> />
		</form>
	</div>
	<br>


	<%
if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		String action = request.getParameter("Action");
		if(action!=null&&action.equals("DownloadExcel")){
			response.setHeader("Content-disposition", "attachment; filename=GoldSales.xls");
		}
		ArrayList<String> shopItemList = OAStatistic.getShopGoldItem();
		out.print("<table>");
		String ftime = request.getParameter("time");
		String ttime = request.getParameter("time2");
		String time3 = request.getParameter("time3");
		{
			out.print("<br>");

			Date fTime = OAStatUtil.convertDate(ftime);
			Date tTime = OAStatUtil.convertDate(ttime);
			if(time3!=""&&time3!=null){
				tTime = OAStatUtil.convertDate(time3);
				fTime = new Date(tTime.getTime()-1000*3600*24*15);
				fTime = new Date(fTime.getTime()-1000*3600*24*15);
			}
			
			if((ftime==""||ftime==null)&&(ttime==""||ttime==null)&&(time3==""||time3==null)){
				fTime = new Date();
				Calendar fromWhen = Calendar.getInstance();
				fromWhen.setTime(fTime);
				GregorianCalendar gc = new GregorianCalendar(fromWhen
						.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
						.get(Calendar.DAY_OF_MONTH));
				gc.add(Calendar.DATE, -1);
				tTime = (Date) gc.getTime();
				gc.add(Calendar.DATE, -15);
				gc.add(Calendar.DATE, -15);
				fTime = (Date) gc.getTime();
			}
			
			out.print("</table>");
			out.print("<table>");
			if(fTime.compareTo(tTime)<0  && (tTime.getTime()-(new Date()).getTime())/1000/60/60/24 < 0){
				ArrayList<String> itemName = new ArrayList<String>();
				ArrayList<String> newItemName = new ArrayList<String>();
				ArrayList<Integer> itemSell = new ArrayList<Integer>();
				java.util.Map<String, Integer> itemGold = new java.util.HashMap<String, Integer>();
				
				ArrayList<Integer> itemUVPV = new ArrayList<Integer>();
				itemName = OAStatUtil.getItemNameList(fTime,tTime);
	
				long j = (tTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
	
				long flag = (fTime.getTime()-(new Date()).getTime())/(1000*60*60*24);

			
			{
				int result = 0;
				out.print("<div class=\"table\">");
				out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
				Date fromTime = OAStatUtil.getDate((int)j);
				Date toTime = OAStatUtil.getDate((int)j+1);
				ArrayList<String> nameList = new ArrayList<String>();
//				newItemName = OAStats_local.getNameLise(fromTime,toTime);
				out.print("<tr class=\"first\" width=\"177\">");
				out.print("<th>");
				out.print(enType.getString("item"));
				out.print("</th>");
				for (String s:shopItemList) {
					out.print("<th>");
					out.print(s);
					out.print("</th>");
				}
				SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");

				for (; j >= flag; j--) {
					
					if(-j%2 == 1){
						out.print("<tr >");
					}else{
						out.print("<tr class=\"bg\">");
					}

					fromTime = OAStatUtil.getDate((int)j);
					toTime = OAStatUtil.getDate((int)j+1);
					
					out.print("<td>");
					out.print(sdf.format(fromTime));
					out.print("</td>");

					{
						itemGold = OAStats_local.getSellingGoldFromAtoB(
								fromTime, toTime);
						for (int i=0;i<shopItemList.size();i++) {
							out.print("<td >");
							if(itemGold.get(shopItemList.get(i)) == null || itemGold.get(shopItemList.get(i)) == 0){
								out.print("0");
							}else{
								out.print("<a href = \"GoldDetail.jsp?itemName=" + shopItemList.get(i) + "&" + "fromTime=" + OAStatUtil.DateConvert(fromTime) + "\">" + itemGold.get(shopItemList.get(i)) + "</a>" );
							}
							out.print("</td>");
						}
					}

					out.print("</tr>");
				}
				out.print("</table>");
				out.print("</div>");
			}
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