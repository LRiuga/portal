<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="gb2312"%>
<%@ page
	import="java.util.*,OAStat.*,java.util.Date,java.text.*,newUserBehavior.*,userStats.*"%>
<!DOCTYPE html>
<html>
<head>
</head>
<link type="text/css" rel="stylesheet" href="css/all.css" />
<body>
	<script src="js/dateselect.js"></script>
	<%
	String item = request.getParameter("selectItem");	
    if(item==""||item==null){
		item="Both";
	}
 %>
	<form action="" method="post">
		Date：<input name="time" type="text" id="time"
			onfocus="datelist.dfd(this)" readonly="readonly" /> -<input
			name="time2" type="text" id="time2" onfocus="datelist.dfd(this)"
			readonly="readonly" /> <br /> Last 30 days： <input name="time3"
			type="text" id="time3" onfocus="datelist.dfd(this)"
			readonly="readonly" /> <input name="yes" type="submit" value="Search" />
	</form>
	<%
if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
	
		String ftime = request.getParameter("time");
		String ttime = request.getParameter("time2");
		String time3 = request.getParameter("time3");
		
		java.util.Map<Integer,Integer> all_map = new java.util.HashMap<Integer, Integer>();
		java.util.Map<Integer,Integer> action_map = new java.util.HashMap<Integer, Integer>();
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
			gc.add(Calendar.DATE, -7);
			fromTime = (Date) gc.getTime();
		}
		
		out.print("<table>");
		Map<Date,Map<Integer,Integer>> dateShipyardAmountMap = ShipyardLevel.getAmountMap(fromTime,toTime,"Shipyard");
		long j;	
		out.print("<table class='listing'> ");

		out.print("<tr class='first' >");
		out.print("<th colspan=1 rowspan=1>");
		out.print("Shipyard");
		out.print("</th>");
		
		out.print("<th colspan=1 rowspan=1>");
		out.print("Total");
		out.print("</th>");
		
		for(int level=1;level<24;level++){
			out.print("<th colspan=1 rowspan=1>");
			out.print(level);
			out.print("</th>");
		}
					
	
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
			
			out.print("<td colspan=1>");
			out.print("<a href = \"LevelDistributionTime.jsp?fromTime=" + OAStatUtil.DateConvert(fTime) + "\">" + sdf.format(fTime) + "</a>" );
			out.print("</td>");
		
			if(dateShipyardAmountMap.containsKey(fTime)){
				Map<Integer,Integer> shipyardAmountMap = dateShipyardAmountMap.get(fTime);
			
				Set<Integer> levelSet = shipyardAmountMap.keySet();
				int total = 0;
				for(int level:levelSet){
					total += shipyardAmountMap.get(level);
				}
				
				out.print("<td colspan=1>");
				out.print(total);
				out.print("</td>");

				for(int i=1;i<24;i++){
					out.print("<th colspan=1 rowspan=1>");
					if(shipyardAmountMap.containsKey(i)){
						out.print(shipyardAmountMap.get(i));
					}else{
						out.print("");
					}
					out.print("</th>");
				}
				out.print("</tr>");
			}else{
				for(int i=1;i<24;i++){
					out.print("<td colspan=1>");
					out.print("");
					out.print("</td>");
				}
			}
		}
		out.print("</table>");
		
		out.print("<br>");
		out.print("<br>");
		
		/*
		     宠物统计
		*/
		out.print("<table>");
		Map<Date,Map<Integer,Integer>> datePetAmountMap = ShipyardLevel.getAmountMap(fromTime,toTime,"Pet");
		out.print("<table class='listing' >");

		out.print("<tr class=\"first\" width=\"177\">");
		out.print("<th colspan=1 rowspan=1>");
		out.print("  Pet   ");
		out.print("</th>");
		
		out.print("<th colspan=1 rowspan=1>");
		out.print("Total");
		out.print("</th>");
		
		for(int level=1;level<101;level++){
			out.print("<th colspan=1 rowspan=1>");
			out.print(level);
			out.print("</th>");
		}
		j = (toTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
		flag = (fromTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
		for (; j >= flag; j--) {
			if(-j%2 == 1){
				out.print("<tr >");
			}else{
				out.print("<tr class=\"bg\">");
			}

			Date fTime = OAStatUtil.getDate((int)j);
			Date tTime = OAStatUtil.getDate((int)j+1);
			
			out.print("<td colspan=1>");
			out.print(sdf.format(fTime));
			out.print("</td>");
		
			if(datePetAmountMap.containsKey(fTime)){
				Map<Integer,Integer> petAmountMap = datePetAmountMap.get(fTime);
			
				Set<Integer> levelSet = petAmountMap.keySet();
				int total = 0;
				for(int level:levelSet){
					total += petAmountMap.get(level);
				}
				
				out.print("<td colspan=1>");
				out.print(total);
				out.print("</td>");
				
				for(int i=1;i<101;i++){
					out.print("<th colspan=1 rowspan=1>");
					if(petAmountMap.containsKey(i)){
						out.print(petAmountMap.get(i));
					}else{
						out.print("");
					}
					out.print("</th>");
				}
				out.print("</tr>");
			}else{
				for(int i=1;i<101;i++){
					out.print("<td colspan=1>");
					out.print("");
					out.print("</td>");
				}
			}
		}
		out.print("</table>");
		
		out.print("<br>");
		out.print("<br>");
		
		/*
		     家族等级统计
		*/
		out.print("<table>");
		Map<Date,Map<Integer,Integer>> dateTribeAmountMap = CountTribeLevel.getAmountMap(fromTime,toTime);
		out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");

		out.print("<tr class=\"first\" width=\"177\">");
		out.print("<th colspan=1 rowspan=1>");
		out.print("  Tribe   ");
		out.print("</th>");
		
		out.print("<th colspan=1 rowspan=1>");
		out.print("Total");
		out.print("</th>");
		
		for(int level=1;level<8;level++){
			out.print("<th colspan=1 rowspan=1>");
			out.print(level);
			out.print("</th>");
		}
		j = (toTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
		flag = (fromTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
		for (; j >= flag; j--) {
			if(-j%2 == 1){
				out.print("<tr >");
			}else{
				out.print("<tr class=\"bg\">");
			}

			Date fTime = OAStatUtil.getDate((int)j);
			Date tTime = OAStatUtil.getDate((int)j+1);
			
			out.print("<td colspan=1>");
			out.print(sdf.format(fTime));
			out.print("</td>");
		
			if(dateTribeAmountMap.containsKey(fTime)){
				Map<Integer,Integer> TribeAmountMap = dateTribeAmountMap.get(fTime);
			
				Set<Integer> levelSet = TribeAmountMap.keySet();
				int total = 0;
				for(int level:levelSet){
					total += TribeAmountMap.get(level);
				}
				
				out.print("<td colspan=1>");
				out.print(total);
				out.print("</td>");
				
				for(int i=1;i<8;i++){
					out.print("<th colspan=1 rowspan=1>");
					if(TribeAmountMap.containsKey(i)){
						out.print(TribeAmountMap.get(i));
					}else{
						out.print("");
					}
					out.print("</th>");
				}
				out.print("</tr>");
			}else{
				for(int i=1;i<9;i++){
					out.print("<td colspan=1>");
					out.print("");
					out.print("</td>");
				}
			}
		}
		out.print("</table>");
		
	}else{
	}
}else{
	response.sendRedirect("index.jsp");
}
%>

</body>
</html>