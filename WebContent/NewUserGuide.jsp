<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="gb2312"%>

<%@ page
	import="java.util.*,OAStat.*,java.util.Date,java.text.*,userStats.*,login.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<style media="all" type="text/css">
@import "css/all.css";
</style>
</head>
<body>
	<h1>New user conversion rate</h1>
	<br />


	<%
		List<Integer> guideList = NewUserGuide.getStep();
		Map<Integer,String> guideDecsMap = new HashMap<Integer,String>();
		guideDecsMap.put(1,"New User");
		guideDecsMap.put(2,"focus到船");
		guideDecsMap.put(3,"Start fishing");
		guideDecsMap.put(4,"对话框消失");
		guideDecsMap.put(5,"Stop fishing");
		guideDecsMap.put(6,"focus warehouse");
		guideDecsMap.put(7,"卖鱼");
		guideDecsMap.put(8,"focus shipyard");
		guideDecsMap.put(9,"买船");
		guideDecsMap.put(23,"获取买船奖励");
		guideDecsMap.put(12,"再次捕鱼");
		guideDecsMap.put(24,"装备sailor");
		guideDecsMap.put(13,"再次Stop fishing");
		guideDecsMap.put(10,"再次focus shipyard");
		guideDecsMap.put(11,"升级shipyard");
		guideDecsMap.put(14,"focus ranking");
		guideDecsMap.put(15,"start stealing");
		guideDecsMap.put(16,"start stealing");
		guideDecsMap.put(28,"stop stealing");
		guideDecsMap.put(30,"升级 warehouse");
		guideDecsMap.put(17,"focus luckydraw");
		guideDecsMap.put(18,"点击任何一个奖励");
		guideDecsMap.put(19,"focus 包裹");
		guideDecsMap.put(20,"获得新手礼包");
		guideDecsMap.put(21,"进入mission界面");

		int days = 1;
		
		Date fromTime = new Date();
		Date toTime = new Date();
		fromTime = new Date();
			Calendar fromWhen = Calendar.getInstance();
			fromWhen.setTime(fromTime);
			GregorianCalendar gc = new GregorianCalendar(fromWhen
					.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
					.get(Calendar.DAY_OF_MONTH));
			gc.add(Calendar.DATE, -1);
			toTime = (Date) gc.getTime();
			gc.add(Calendar.DATE, -15);
			fromTime = (Date) gc.getTime();


		out.print("<table class=\"listing\" cellpadding=\"0\" cellspacing=\"0\">");
	
		out.print("<tr class=\"first\" width=\"177\">");
		out.print("<th>");
		out.print("Date");
		out.print("</th>");
	
		out.print("<th>");
		out.print("Download");
		out.print("</th>");
	
		out.print("<th>");
		out.print("NewUser");
		out.print("</th>");
		
		for(int i=0;i<guideList.size();i++){
			out.print("<th>");
			out.print("<label title=\"");
			if(guideDecsMap.containsKey(guideList.get(i))){
				out.print(guideDecsMap.get(guideList.get(i)));
			}else{
				out.print("Guide");
			}
			out.print("\">");
			out.print("G"+guideList.get(i));
			out.print("</label>");
			out.print("</th>");
		}
		
		out.print("<th>");
		out.print("新手导航完成率");
		out.print("</th>");
		out.print("</tr>");
		
		SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
		DecimalFormat df = new DecimalFormat("0.00");
		DecimalFormat df2 = new DecimalFormat("0");
		long j, k;
		j = (toTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
	
		Map<Date,Map<Integer,Integer>> dateMap = NewUserGuide.getGuideCount(fromTime,toTime);
		Map<Date,Double> downloadUVMap = NewUserGuide.getDownloadUV(fromTime,toTime);
	
		long flag = (fromTime.getTime()-(new Date()).getTime())/(1000*60*60*24);
		for (; j >= flag; j--) {
			if(-j%2 == 1){
				out.print("<tr >");
			}else{
				out.print("<tr class=\"bg\">");
			}
			Date fTime = OAStatUtil.getDate((int)j);
			Date tTime = OAStatUtil.getDate((int)j+1);
							
			out.print("<td>");
			out.print(sdf.format(fTime));
			out.print("</td>");
			
			out.print("<td>");
			if(downloadUVMap.containsKey(fTime)){
				out.print(downloadUVMap.get(fTime));
			}else{
				out.print("");	
			}
			out.print("</td>");
			
			double newUser = WebSiteReport.getDailyValue(fTime, "newUserDB");
			
			out.print("<td>");
			if(newUser>=0){
				out.print(df2.format(newUser));
			}else{
				out.print("");
			}
			
			out.print("</td>");
			java.util.Map<Integer, Integer> guideMap = dateMap.get(fTime);
			if(guideMap!=null){
				for(int i=0;i<guideList.size();i++){
					
					int total = 0;
					for(int x=i;x<guideList.size();x++){
						if(guideMap.containsKey(guideList.get(x))){
							total += guideMap.get(guideList.get(x));
						}
						 
					}
					out.print("<td>");
					if(total>0){
						out.print(total);
					}else{
						out.print("");
					}
					out.print("</td>");
					
				}
			}
			
			out.print("<td>");
			if(newUser>0){
				if(guideList.size()==0){
					out.print("");				
				}else{
					out.print(df.format(guideMap.get(guideList.get(guideList.size()-1))*1.0/newUser));
				}
			}else{
				out.print("");
			}
			out.print("</td>");
			out.print("</tr>");
		}
		out.print("</table>");
%>

	<%
	out.print("<br>");
	out.print("Guide : Description");
	out.print("<br>");
	for(int temp:guideList){
		out.print(temp+" : "+guideDecsMap.get(temp));	
		out.print("<br>");
	}

	
 %>

</body>
</html>