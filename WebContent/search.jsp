<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="gb2312"%>
<%@ page
	import="java.util.*,OAStat.*,java.util.Date,java.text.*,userStats.*,util.*"%>
<style media="all" type="text/css">
@import "css/all.css";
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
</head>
<body>

	<br />
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
	output=output+"<table style='font-size:12px;font-family: \"ËÎÌו\", Helvetica, sans-serif;cursor:default;border:0px solid #999999;border:1px solid #F5D6D6;' border='1' cellpadding='0' cellspacing='0'>";
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

	<script language="javascript">
function settime(monetid,ftime,ttime){

//	window.open(url);
	alert(monetid);
	alert(ftime);
	alert(ttime);
	
}
</script>
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
	<h1><%=enType.getString("subtitle.search_customer") %></h1>
	<form action="search.jsp" method="post">

		<%=enType.getString("date") %>:<input name="time" type="text"
			id="time" onfocus="datelist.dfd(this)" readOnly> -<input
			name="time2" type="text" id="time2" onfocus="datelist.dfd(this)"
			readOnly> <input name="yes" type="submit"
			value=<%=enType.getString("search") %> /> <br> Nickname:<input
			name="name" type="text" /> <input name="yes" type="submit"
			value=<%=enType.getString("search") %> />
	</form>
	<br>
	<%
if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
		String name = request.getParameter("name");
		String ftime = request.getParameter("time");
		String ttime = request.getParameter("time2");
		String monetidString = request.getParameter("monetid");
		
		Date fromTime = new Date();
		Date toTime = new Date();

		if((name==null||name=="")&&(monetidString==null||monetidString=="")){
			if((ftime!=""&&ftime!=null)&&(ttime!=""&&ttime!=null)){
				fromTime = OAStatUtil.convertDate(ftime);
				toTime = OAStatUtil.convertDate(ttime);
				
				Map<Integer,Map<String,Date>> userMap = UserInfo.GetUserList(fromTime,toTime);
				out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
				out.print("<tr class=\"first\" width=\"177\">");
				out.print("<th>");
				out.print("Register");
				out.print("</th>");
				out.print("<th>");
				out.print("Nickname");
				out.print("</th>");
				out.print("<th>");
				out.print("Detail");
				out.print("</th>");
				out.print("</tr>");
				
				Set<Integer> userSet = userMap.keySet();
				for(int monetid:userSet){
					Map<String,Date> map = userMap.get(monetid);
					Set<String> set = map.keySet();
					for(String nickname:set){
						out.print("<tr>");
						out.print("<td>");
						out.print(map.get(nickname));
						out.print("</td>");
						out.print("<td>");
						out.print(nickname);
						out.print("</td>");
						out.print("<td>");
						out.print("<a href = \"search.jsp?monetid=" + monetid + "\">" + "detail" + "</a>" );
						out.print("</td>");
						out.print("<tr>");
					}
				}
				
			}else{
				out.print("<h3>"+enType.getString("notice.insert_customer")+"</h3>");
			}
		}else{
			if(((ftime==""||ftime==null)&&(ttime==""||ttime==null))){
				fromTime = new Date();
				Calendar fromWhen = Calendar.getInstance();
				fromWhen.setTime(fromTime);
				GregorianCalendar gc = new GregorianCalendar(fromWhen
						.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
						.get(Calendar.DAY_OF_MONTH));
				gc.add(Calendar.DATE, -1);
				toTime = (Date) gc.getTime();
				gc.add(Calendar.DATE, -7);
				fromTime = (Date) gc.getTime();
			}else{
				fromTime = OAStatUtil.convertDate(ftime);
				toTime = OAStatUtil.convertDate(ttime);
			}
			
			ftime = MyUtil.DateToString(fromTime);
			ttime = MyUtil.DateToString(toTime);
			
			DecimalFormat df = new DecimalFormat("0.00");
			
			if(fromTime.compareTo(toTime)<0){
				out.print("<div>");
				
				out.print("<h2>"+enType.getString("table.user_info")+"</h2>");
				
				ArrayList<Object> infoList = new ArrayList<Object>();
				if(name != null){
					infoList = UserInfo.GetUserInfo(name);
				}else if(monetidString != null){
					infoList = UserInfo.GetUserInfo(Integer.parseInt(monetidString));
				}
				
				if(infoList!=null&&infoList.size()==4){
					String monetid = infoList.get(0).toString();
					
					int money = UserInfo.GetCreditAccount(monetid);
					out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
					out.print("<tr class=\"first\" width=\"177\">");
					out.print("<th>");
					out.print("monetid");
					out.print("</th>");
					out.print("<th>");
					out.print("Nickname");
					out.print("</th>");
					out.print("<th>");
					out.print(enType.getString("level"));
					out.print("</th>");
					out.print("<th>");
					out.print(enType.getString("gold"));
					out.print("</th>");
					out.print("<th>");
					out.print(enType.getString("balance"));
					out.print("</th>");
					out.print("</tr>");
					
					if(infoList!=null&&infoList.size()==4){
						out.print("<tr>");
						out.print("<td>");
						out.print(infoList.get(0));
						out.print("</td>");
						out.print("<td>");
						out.print(infoList.get(1));
						out.print("</td>");
						out.print("<td>");
						out.print(infoList.get(2));
						out.print("</td>");
						out.print("<td>");
						out.print(infoList.get(3));
						out.print("</td>");
						out.print("<td>");
						out.print(money);
						out.print("</td>");
						out.print("</tr>");
					}else{
						out.print("<tr>");
						out.print("<td>");
						out.print("");
						out.print("</td>");
						out.print("<td>");
						out.print("");
						out.print("</td>");
						out.print("<td>");
						out.print("");
						out.print("</td>");
						out.print("<td>");
						out.print("");
						out.print("</td>");
						out.print("</tr>");
					}
					out.print("</table>");
				
					
					out.print("<h2>"+enType.getString("table.items_purchased")+"</h2>");
					out.print("<a href=\"user_credit.jsp?monetid="+ monetid + "&ftime=" + ftime + "&ttime=" + ttime + "\">"+enType.getString("link.credit_detail")+"</a>");
					out.print("  ");
					out.print("<a href=\"user_gold.jsp?monetid="+ monetid + "&ftime=" + ftime + "&ttime=" + ttime + "\">"+enType.getString("link.gold_detail")+"</a>");
					ArrayList<String> creditItemList = UserInfo.GetCreditItemRecord(monetid,fromTime,toTime);
					Map<String,Double> creditItemMap = UserInfo.GetCreditItemMap(monetid,fromTime,toTime);
					Set<String> creditItemSet = creditItemMap.keySet();
					double creditTotal = 0;
					for(String item:creditItemSet){
						creditTotal += creditItemMap.get(item);
					}
					
					ArrayList<String> itemList = UserInfo.GetGoldItemList(monetid,fromTime,toTime);
					Map<String,Long> goldItemMap = UserInfo.GetGoldItemMap(monetid,fromTime,toTime);
					Set<String> goldItemSet = goldItemMap.keySet();
					long goldTotal = 0;
					for(String item:goldItemSet){
						goldTotal += goldItemMap.get(item);
					}
	
					out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
	
					out.print("<tr class=\"first\" width=\"177\">");
					out.print("<th>");
					out.print(enType.getString("type"));
					out.print("</th>");
					out.print("<th>");
					out.print(enType.getString("count"));
					out.print("</th>");
					out.print("<th>");
					out.print(enType.getString("amount"));
					out.print("</th>");
					out.print("</tr>");
					
					out.print("<tr class=\"bg\">");
					out.print("<td>");
					out.print(enType.getString("credit"));
					out.print("</td>");
					out.print("<td>");
					out.print(creditItemList.size());
					out.print("</td>");
					out.print("<td class=\"last\">");
					out.print(df.format(creditTotal));
					out.print("</td>");
					out.print("</tr>");
					
					out.print("<tr >");
					out.print("<td>");
					out.print(enType.getString("gold"));
					out.print("</td>");
					out.print("<td>");
					out.print(itemList.size());
					out.print("</td>");
					out.print("<td class=\"last\">");
					out.print(goldTotal);
					out.print("</td>");
					out.print("</tr>");
					out.print("</table>");
				
					out.print("<h2>"+enType.getString("table.using")+"</h2>");
					out.print("<a href=\"user_use.jsp?monetid="+ monetid + "&ftime=" + ftime + "&ttime=" + ttime + "\">"+enType.getString("link.use_detail")+"</a>");
					Map<String,Integer> useMap = UserInfo.GetUseTypeMap(monetid,fromTime,toTime);
					Set<String> itemSet = useMap.keySet();
					out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
					out.print("<tr class=\"first\" width=\"177\">");
					out.print("<th>");
					out.print(enType.getString("type"));
					out.print("</th>");
					out.print("<th>");
					out.print(enType.getString("count"));
					out.print("</th>");
					out.print("</tr>");
					
					for(String item:itemSet){
						out.print("<tr>");
						out.print("<td>");
						out.print(item);
						out.print("</td>");
						out.print("<td>");
						out.print(useMap.get(item));
						out.print("</td>");
						out.print("</tr>");
					}
					out.print("</table>");
				
					out.print("<h2>"+enType.getString("table.top_up")+"</h2>");out.print("<a href=\"user_addvalue.jsp?monetid="+ monetid + "&ftime=" + ftime + "&ttime=" + ttime + "\">"+enType.getString("link.top_up_detail")+"</a>");
					Map<Integer,Integer> addvalueMap = UserInfo.GetUserAddValueRecord(monetid,fromTime,toTime);
					Set<Integer> addvalueSet = addvalueMap.keySet();
					int count = 0;
					for(int temp:addvalueSet){
						count = temp;
					}
					out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
					out.print("<tr class=\"first\" width=\"177\">");
					out.print("<th>");
					out.print(enType.getString("count"));
					out.print("</th>");
					out.print("<th>");
					out.print(enType.getString("total"));
					out.print("</th>");
					out.print("</tr>");
					
					out.print("<tr>");
					out.print("<td>");
					if(count>0){
						out.print(count);
					}else{
						out.print("0");				
					}
					out.print("</td>");
					out.print("<td class=\"last\">");
					if(addvalueMap.containsKey(count)){
						out.print(addvalueMap.get(count));
					}else{
						out.print("0");
					}
					out.print("</td>");
					out.print("</tr>");
					
					out.print("</table>");
				}else if(infoList.size()>4){
					int index = 0;
					String tempMonetid = "";
					
						out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
						out.print("<tr class=\"first\" width=\"177\">");
						out.print("<th>");
						out.print("monetid");
						out.print("</th>");
						out.print("<th>");
						out.print("Nickname");
						out.print("</th>");
						out.print("<th>");
						out.print(enType.getString("level"));
						out.print("</th>");
						out.print("<th>");
						out.print(enType.getString("gold"));
						out.print("</th>");
						out.print("<th>");
						out.print("Detail");
						out.print("</th>");
						out.print("</tr>");
						
					for(int i=0;i<infoList.size()/4;i++){
						out.print("<tr>");
						out.print("<td>");
						tempMonetid = infoList.get(index++).toString();
						out.print(tempMonetid);
						out.print("</td>");
						out.print("<td>");
						out.print(infoList.get(index++));
						out.print("</td>");
						out.print("<td>");
						out.print(infoList.get(index++));
						out.print("</td>");
						out.print("<td>");
						out.print(infoList.get(index++));
						out.print("</td>");
						out.print("<td>");
						out.print("<a href = \"search.jsp?monetid=" + tempMonetid + "\">" + "detail" + "</a>" );
						out.print("</td>");
						out.print("<tr>");
					}
				}
			}
		}
	}
}else{
	response.sendRedirect("index.jsp");
}
%>
</body>
</html>