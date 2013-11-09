<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<html>
<head>
<title>menu</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="css/menu.css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/menu.js"></script>
</head>
<body style="margin: 0px;">
	<ul>
<%
if(session!=null&&session.getAttribute("login")!=null){
	if(session.getAttribute("login").equals("ok")){
	
		ResourceBundle languageType = ResourceBundle.getBundle("system");
		ResourceBundle enType = ResourceBundle.getBundle(languageType.getString("language"));
		String limitString = session.getAttribute("limit").toString();
		if(limitString!=null){
			if(limitString.equals("3")){
				enType = ResourceBundle.getBundle("English");
			}
		}
		out.print("<li class=\"main\">");
		out.print("<a href=\"#\">"+enType.getString("title.customer_care")+"</a>");
		out.print("<ul>");
		out.print("<li>");
		out.print("<a href=\"currentSellingTemp.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"Realtime Search"+"</a>");
		out.print("</li>");
		out.print("<li>");
		out.print("<a href=\"search.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+enType.getString("subtitle.search_customer")+"</a>");
		out.print("</li>");
		out.print("</ul>");
		out.print("</li>");
		
		out.print("<li class=\"main\">");
		out.print("<a href=\"#\">"+enType.getString("title.basic_statistics")+"</a>");
		out.print("<ul>");
		out.print("<li>");
		out.print("<a href=\"dailyReport.jsp\" target=\"iframe\" style=\"cursor:hand\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+enType.getString("subtitle.daily_report")+"</a>");
		out.print("</li>");
		out.print("<li>");
		out.print("<a href=\"sellingCredit.jsp\" target=\"iframe\" style=\"cursor:hand\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+enType.getString("subtitle.items_purchased")+"</a>");
		out.print("</li> 					");
		out.print("<li>");
		out.print("<a href=\"sellingGold.jsp\" target=\"iframe\" style=\"cursor:hand\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+enType.getString("subtitle.gold_sales")+"</a>");
		out.print("</li>");
		out.print("<li>");
		out.print("<a href=\"userUsing.jsp\" target=\"iframe\" style=\"cursor:hand\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+enType.getString("subtitle.items_used")+"</a>");
		out.print("</li>");
		out.print("<li>");
		out.print("<a href=\"AddValueTimes.jsp\" target=\"iframe\" style=\"cursor:hand\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"Top Up"+"</a>");
		out.print("</li>");
		out.print("</ul>");
		out.print("</li>");
		
		out.print("<li class=\"main\">");
		out.print("<a href=\"#\">"+"Download Stats"+"</a>");
		out.print("<ul>");
		out.print("<li>");
		out.print("<a href=\"FileDownload.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"Download File"+"</a>");
		out.print("</li>");
		out.print("</ul>");
		out.print("</li>");
		
		out.print("<li class=\"main\">");
		out.print("<a href=\"#\">"+enType.getString("title.portal_manage")+"</a>");
		out.print("<ul>");
		out.print("<li>");
		out.print("<a href=\"UserManagement.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+enType.getString("subtitle.user_manage")+"</a>");
		out.print("</li>");
		out.print("</ul>");
		out.print("</li>");
		limitString = session.getAttribute("limit").toString();
		if(limitString!=null){
			if(limitString.equals("3")){
				out.print("<li class=\"main\">");
				out.print("<a href=\"#\">"+"For Inner"+"</a>");
				out.print("<ul>");
				out.print("<li>");
				out.print("<a href=\"WebSiteReportDefault.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"概况"+"</a>");
				out.print("</li>");
				
				out.print("<li>");
				out.print("<a href=\"egypt.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"埃及用户概况"+"</a>");
				out.print("</li>");
				
				out.print("<li>");
				out.print("<a href=\"shipyardLevel.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"等级分布"+"</a>");
				out.print("</li>");
				
				out.print("<li>");
				out.print("<a href=\"upgradeTime.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"升级时间"+"</a>");
				out.print("</li>");
				
				out.print("<li>");
				out.print("<a href=\"GoldStats.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"金币汇总"+"</a>");
				out.print("</li>");
				out.print("<li>");
				out.print("<a href=\"PearlStats.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"珍珠汇总"+"</a>");
				out.print("</li>");
				out.print("<li>");
				out.print("<a href=\"oabalanceStats.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"蓝宝石汇总"+"</a>");
				out.print("</li>");
				
				out.print("<li>");
				out.print("<a href=\"itemBuyGroupUp.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"蓝宝石分类汇总"+"</a>");
				out.print("</li>");
				out.print("<li>");
				out.print("<a href=\"DAUDayResource.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"活跃用户资源获得"+"</a>");
				out.print("</li>");
				out.print("<li>");
				out.print("<a href=\"DAUDayAction.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"活跃用户动作情况"+"</a>");
				out.print("</li>");
				out.print("<li>");
				out.print("<a href=\"LevelReturnRate.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"各船厂等级停留率"+"</a>");
				out.print("</li>");
				out.print("<li>");
				out.print("<a href=\"ShipyardLevelWPD.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"各船厂等级对应仓宠防"+"</a>");
				out.print("</li>");
				out.print("<li>");
				out.print("<a href=\"ShipTypeDistribution.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"船的分布"+"</a>");
				out.print("</li>");
				out.print("<li>");
				out.print("<a href=\"Stocks.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"活跃用户库存"+"</a>");
				out.print("</li>");
				out.print("<li>");
				out.print("<a href=\"userPlatform.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"用户平台"+"</a>");
				out.print("</li>");
				
				out.print("<li>");
				out.print("<a href=\"topupTop10.jsp\" target=\"iframe\" onMouseOver=\"this.style.backgroundImage='url(images/main_69.gif)'; \"onmouseout=\"this.style.backgroundImage='url()';\">"+"付费前十用户"+"</a>");
				out.print("</li>");
		%>
				<li><a href="weaponStats.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">炸弹的分布</a></li>
				<li><a href="resouceUpdate.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">资源更新</a></li>
				<li><a href="luckyDrawNomal.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">普通抽奖</a></li>
				<li><a href="luckyDrawEquipment.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">装备抽奖</a></li>
							
			</ul>
				<li class="main">
					<a href="#" >推广情况</a>
				<ul>
						<li><a href="webSite.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">STC推广渠道</a></li>	
						<li><a href="webSiteBuzz.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">Buzz推广渠道</a></li>	
						<li><a href="inmobi.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">Inmobi付费推广</a></li>	
							
				</ul>
				</li>
				<li class="main">
					<a href="#" >新用户情况</a>
				<ul>
						<li><a href="NewUserGuide.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">新手导航完成情况</a></li>	
						<li><a href="userLoginNew.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">新用户转化</a></li>	
						<li><a href="newUserReturnRate.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">新用户停留</a></li>	
							
				</ul>
				</li>
				<li class="main">
					<a href="#" >Billing情况</a>
				<ul>
						<li><a href="userPayment.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">按渠道用户划分</a></li>	
						<li><a href="channelPayment.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">按Billing渠道划分</a></li>	
							
				</ul>
				</li>
				<li class="main">
					<a href="#" >竞技场</a>
					<ul>
						<li><a href="reportBattle.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">竞技场概括</a></li>	
						<li><a href="arenaChallengeDistribution.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">竞技场挑战分布</a></li>
						<li><a href="petLvUserSum.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">竞技场达标人数</a></li>
						<li><a href="arenaTop20Equipment.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">前20用户装备分布</a></li>
						<li><a href="arenaTop100_1.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">竞技场前100_竞技场1</a></li>
						<li><a href="arenaTop100_2.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">竞技场前100_竞技场2</a></li>
						<li><a href="arenaTop100_3.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">竞技场前100_竞技场3</a></li>
						<li><a href="arenaTop100_4.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">竞技场前100_竞技场4</a></li>
						<li><a href="arenaTop100_5.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">竞技场前100_竞技场5</a></li>
						<li><a href="arenaTop100_6.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">竞技场前100_竞技场6</a></li>	
					</ul>
				</li>	
				<li class="main">
					<a href="#" >宠物</a>
					<ul>
						<li><a href="petlevelaction.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">宠物等级竞技分布</a></li>	
						<li><a href="petExpAndstatstoneFrom.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">宠物经验与星玉来源</a></li>	
					</ul>
				</li>	
				
				<li class="main">
					<a href="#" >家族打怪</a>
					<ul>
						<li><a href="tribeMonterRow.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">家族怪概述</a></li>	
						<li><a href="tribeMonsterAttackCalc.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">家族成员打怪次数分布</a></li>
						<li><a href="tribeMonsterCalcPeriod.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">家族怪产生杀死分布</a></li>	
					</ul>
				</li>	
				
				<li class="main">
					<a href="#" >装备</a>
					<ul>
						<li><a href="EquimentAndStoneBuy.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">装备和强化石的购买</a></li>
						
						<li><a href="Equiment_Inventory.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">装备历史库存</a></li>
						<li><a href="equipmentActivityUserDaily.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">活跃用户装备强化分布</a></li>
						<li><a href="equipmentReinforce.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">库存装备强化分布</a></li>
						<li><a href="equipmentActivityUser.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">活跃用户装备分布</a></li>
						
						<li><a href="equipmentReinforceSum.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">装备强化次数汇总</a></li>
						<li><a href="equipmentReinforceSum_new.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">装备强化次数汇总_新强化系统</a></li>
						<li><a href="equipmentReinforceCalc.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">装备强化次数分布</a></li>
						<li><a href="equipmentConsume.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">装备强化消耗分布</a></li>	
						
					</ul>
				</li>

				
				
				<li class="main">
					<a href="#" >周报</a>
				<ul>
						<li><a href="weekReport_all.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">基本情况_全服</a></li>	
						<li><a href="weekReport_server1.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">基本情况_Server1</a></li>	
						<li><a href="weekReport_server2.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">基本情况_Server2</a></li>
						<li><a href="weekReport_server3.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">基本情况_Server3</a></li>
						<li><a href="weekReport_server4.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">基本情况_Server4</a></li>
						<li><a href="weekReport_server5.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">基本情况_Server5</a></li>
						<li><a href="weekReport_server6.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">基本情况_Server6</a></li>
						<li><a href="weekReport_android.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">Android</a></li>
						<li><a href="weekReport_bb.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">BB</a></li>
						<li><a href="weekReport_j2me.jsp" target="iframe" onMouseOver="this.style.backgroundImage='url(images/main_69.gif)';" onmouseout="this.style.backgroundImage='url()';">J2ME</a></li>	
							
				</ul>
				</li>
				
				
				<% 
				out.print("</li>");
			}
		}
		}
	//}
}else{
	response.sendRedirect("index.jsp");
}

%>
	</ul>
</body>
</html>