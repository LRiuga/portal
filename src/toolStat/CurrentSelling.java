package toolStat;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.SqlCondition;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class CurrentSelling {

	static Logger logger = Logger.getLogger(CurrentSelling.class);
	static String db086 = null;
	static String db081 = null;
	static String dbDriver = null;
	static MoDBRW dbClient = null;
	static MoDBRW dbClient081 = null;
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");
			db081 = serverConf.getString("db081");
			db086 = serverConf.getString("db086");
			dbDriver = serverConf.getString("dbDriver");

			dbClient = new MoDBRW(db086,dbDriver);
			dbClient081 = new MoDBRW(db081,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	static public ArrayList<String> getSelling(Date fromTime,Date toTime) {
		ArrayList<String> msgs = new ArrayList<String>();
		try {

			Object[] dbArgs = new Object[] {fromTime, toTime };
			DBResultSet rs = dbClient.execSQLQuery(
					"select msg from user_event where (msg like 'callback%' or msg like 'action=AttackMonster%credit%' or msg like 'action=AttackMonster%callback%') and server_date >= ? and server_date<? and monetid>50000",
							dbArgs);
			while(rs.next()){
				String temp = rs.getString("msg");
				msgs.add(temp);
			}
		} catch (Exception e) {
			logger.error("getSelling with fromTime=" + fromTime + " toTime=" + toTime, e);
		}

		return msgs;
	}
	
	static public ArrayList<String> getSellingOABalance(Date fromTime,Date toTime) {
		ArrayList<String> msgs = new ArrayList<String>();
		try {

			Object[] dbArgs = new Object[] {fromTime, toTime };
			DBResultSet rs = dbClient.execSQLQuery(
							"select msg from user_event where msg like 'monetid%oaBalance%' and server_date >= ? and server_date<?",
							dbArgs);
			while(rs.next()){
				String temp = rs.getString("msg");
				msgs.add(temp);
			}
		} catch (Exception e) {
			logger.error("getSelling getSellingOABalance fromTime=" + fromTime + " toTime=" + toTime, e);
		}

		return msgs;
	}
	
	static public double getOaBalance(String temp) {
		double oabalance = 0.0;
		if(temp.contains("oaBalance=")){
			int start = 0;
			int end = 0;
			if(temp.indexOf("oaBalance=") != -1){
				start = temp.indexOf("oaBalance=") + 10;
				temp = temp.substring(start);
				if(temp.indexOf(",") != -1){
					end = temp.indexOf(",");
					oabalance = Double.parseDouble(temp.substring(0,end));
				}
			}
		}
		return oabalance;
	}
	
	static public double getOaBalanceBilling(String temp) {
		double oabalance = 0.0;
		if(temp.contains("Billing=")){
			int start = 0;
			int end = 0;
			if(temp.indexOf("Billing=") != -1){
				start = temp.indexOf("Billing=") + 8;
				temp = temp.substring(start);
				if(temp.indexOf(",") != -1){
					end = temp.indexOf(",");
					oabalance = Double.parseDouble(temp.substring(0,end));
				}
			}
		}
		return oabalance;
	}
	
	static public ArrayList<String> getLog_GoldMissing(String monetid,Date fromTime,Date toTime) {
		ArrayList<String> msgs = new ArrayList<String>();
		try {

			Object[] dbArgs = new Object[] {monetid,fromTime, toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select msg from user_event where monetid =? and server_date>=? and server_date<=? and (msg like '%money%'  or msg like 'buy new ship%'  or msg like 'sell ship%' or msg like 'Upgrade Shipyard Level to %' or msg like 'gold%') order by server_date desc",
							dbArgs);
			while(rs.next()){
				msgs.add(rs.getString("msg"));
			}
		} catch (Exception e) {
			logger.error("getLog_GoldMissing with fromTime=" + fromTime + " toTime=" + toTime, e);
		}

		return msgs;
	}
	
	static public ArrayList<String> getLog_ShipMissing(String monetid) {
		ArrayList<String> msgs = new ArrayList<String>();
		try {

			Object[] dbArgs = new Object[] {monetid};
			DBResultSet rs = dbClient.execSQLQuery(
							"select msg from user_event where monetid=? and (msg like 'sell ship%' or msg like '%buy%ship%' or msg like 'rent ship%') order by server_date desc",
							dbArgs);
			while(rs.next()){
				msgs.add(rs.getString("msg"));
			}
		} catch (Exception e) {
			logger.error("getLog_GoldMissing monetid=" + monetid, e);
		}

		return msgs;
	}
	
	static public ArrayList<Date> getLog_GoldMissing_time(String monetid,Date fromTime,Date toTime) {
		ArrayList<Date> msgs = new ArrayList<Date>();
		try {

			Object[] dbArgs = new Object[] { monetid,fromTime, toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select server_date from user_event where monetid =?  and server_date>=? and server_date<=? and (msg like '%money%'  or msg like 'buy new ship%'  or msg like 'sell ship%' or msg like 'Upgrade Shipyard Level to %' or msg like 'gold%') order by server_date desc",
							dbArgs);
			while(rs.next()){
				msgs.add(rs.getDate("server_date"));
			}
		} catch (Exception e) {
			logger.error("getLog_GoldMissing with fromTime=" + fromTime + " toTime=" + toTime, e);
		}

		return msgs;
	}
	
	static public ArrayList<Date> getLog_ShipMissing_time(String monetid) {
		ArrayList<Date> msgs = new ArrayList<Date>();
		try {

			Object[] dbArgs = new Object[] {monetid};
			DBResultSet rs = dbClient.execSQLQuery(
							"select server_date from user_event where monetid=? and (msg like 'sell ship%' or msg like '%buy%ship%' or msg like 'rent ship%') order by server_date desc",
							dbArgs);
			while(rs.next()){
				msgs.add(rs.getDate("server_date"));
			}
		} catch (Exception e) {
			logger.error("getLog_GoldMissing with monetid=" + monetid, e);
		}

		return msgs;
	}
	
	static public int countAmount(String item,ArrayList<String> msgs) throws Exception{
		int result = 0;
		Pattern pt1 = null;
        Matcher mc1 = null;
		if(item.contains("%")){
			item = item.replace("%","[a-zA-Z ]*");
		}	
		if(item.contains("[^0-9]")){
			item = item.replace("[^0-9]","[^0-9]*");
		}	
		pt1 = Pattern.compile(item);
		for(String temp:msgs){
		    mc1 = pt1.matcher(temp);
			if(mc1.matches()){
				result++;
			}
		}
		return result;
	}
	
	public static String getItemName(String msg){
		String item = "";
		//crew
		if(msg.contains("Callback : Add crewTypeId = 1,")
				&& !msg.contains("Callback : Add crewTypeId = 1,from=hotShop,flag=Hot,num=10")
				&& !msg.contains("combo")
		){
			return "Sailor";
		}else if(msg.contains("Callback : Add crewTypeId = 1,")
				&&msg.contains("combo=5")
		){
			return "Sailor5";	
		}else if(msg.contains("Callback : Add crewTypeId = 1,")
				&&msg.contains("combo=10")
		){
			return "Sailor10";	
		}else if(msg.contains("Callback : Add crewTypeId = 2,")
				&&!msg.contains("combo")
		){
			return "Thief";	
		}else if(msg.contains("Callback : Add crewTypeId = 2,")
				&&msg.contains("combo=5")
		){
			return "Thief5";	
		}else if(msg.contains("Callback : Add crewTypeId = 2,")
				&&msg.contains("combo=10")
		){
			return "Thief10";	
		}else if(msg.contains("Callback : Add crewTypeId = 3,")
				&&!msg.contains("combo")
		){
			return "Guard";	
		}else if(msg.contains("Callback : Add crewTypeId = 3,")
				&&msg.contains("combo=5")
		){
			return "Guard5";	
		}else if(msg.contains("Callback : Add crewTypeId = 3,")
				&&msg.contains("combo=10")
		){
			return "Guard10";	
		}else if(msg.contains("Callback : Add crewTypeId = 4,")
				&& !msg.contains("Callback : Add crewTypeId = 4,from=hotShop,flag=Hot,num=10")
				&& !msg.contains("combo")
		){
			return "Prophet";	
		}else if(msg.contains("Callback : Add crewTypeId = 4,")
				&& msg.contains("combo=5")
		){
			return "Prophet5";	
		}else if(msg.contains("Callback : Add crewTypeId = 4,") 
				&& msg.contains("combo=10")
		){
			return "Prophet10";	
		}else if(msg.contains("Callback : Add crewTypeId = 5,")
				&&!msg.contains("combo")
		){
			return "Spy";	
		}else if(msg.contains("Callback : Add crewTypeId = 5,")
				&&msg.contains("combo=5")
		){
			return "Spy5";	
		}else if(msg.contains("Callback : Add crewTypeId = 5,")
				&&msg.contains("combo=10")
		){
			return "Spy10";	
		}else if(msg.contains("Callback : Add crewTypeId = 6,")
				&&!msg.contains("combo")
		){
			return "Insurance";	
		}else if(msg.contains("Callback : Add crewTypeId = 6,")
				&&msg.contains("combo=5")
		){
			return "Insurance5";	
		}else if(msg.contains("Callback : Add crewTypeId = 6,")
				&&msg.contains("combo=10")
		){
			return "Insurance10";	
		}else if(msg.contains("Callback : Add crewTypeId = 7,")
				&&!msg.contains("combo")
		){
			return "Robber";	
		}else if(msg.contains("Callback : Add crewTypeId = 7,")
				&&msg.contains("combo=5")
		){
			return "Robber5";	
		}else if(msg.contains("Callback : Add crewTypeId = 7,")
				&&msg.contains("combo=10")
		){
			return "Robber10";	
		}else if(msg.contains("Callback : Add crewTypeId = 8") 
				&& !msg.contains("Callback : Add crewTypeId = 8,from=hotShop,flag=Hot,num=10")
				&& !msg.contains("combo")
		){
			return "Fish Trader";	
		}else if(msg.contains("Callback : Add crewTypeId = 8")
				&&msg.contains("combo=5")
		){
			return "Fish Trader5";	
		}else if(msg.contains("Callback : Add crewTypeId = 8")
				&&msg.contains("combo=10")
		){
			return "Fish Trader10";	
		}else if(msg.contains("Callback : Add crewTypeId = 9,from=hotShop,flag=New")
				||msg.contains("Callback : Add crewTypeId = 9,")
		){
			return "lucky crew";	
		}else if(msg.contains("Callback : Add crewTypeId = 10,")
		
		){
			return "Sliver Net";	
		}else if(msg.contains("Callback : Add crewTypeId = 11,")
		
		){
			return "Golden Net";	
		}
		//weapon
		else if(msg.contains("Callback Credit: weaponType = 1,")
				||msg.contains("Callback : Add Weapon = 1,")){
			return "small-missile";	
		}else if(msg.contains("Callback Credit: weaponType = 2,")
				||msg.contains("Callback : Add Weapon = 2,")){
			return "middle-missile";	
		}else if(msg.contains("Callback Credit: weaponType = 3,")
				||msg.contains("Callback : Add Weapon = 3,")){
			return "big-missile";	
		}else if(msg.contains("Callback Credit: weaponType = 4,")
				||msg.contains("Use=Weapon,weaponTypeId=4,Credit : Add Weapon =name.weapontype.4,")
		){
			return "shield";	
		}else if(msg.contains("Callback Credit: weaponType = 5,")
				||msg.contains("action=AttackMonster,Use= weaponTypeId=5,Credit : Add Weapon =")
				||msg.contains("Callback : Add Weapon = 5,")
		){
			return "small-toolbox";	
		}else if(msg.contains("Callback Credit: weaponType = 5 BuyToolByCredit")){
			return "small-toolbox";	
		}else if(msg.contains("Callback Credit: weaponType = 6,")
				||msg.contains("action=AttackMonster,Use= weaponTypeId=6,Credit : Add Weapon =")
				||msg.contains("Callback : Add Weapon = 6,")
		){
			return "middle-toolbox";	
		}else if(msg.contains("Callback Credit: weaponType = 6 BuyToolByCredit")){
			return "middle-toolbox";	
		}else if(msg.contains("Callback Credit: weaponType = 7,")
				||msg.contains("action=AttackMonster,Use= weaponTypeId=7,Credit : Add Weapon =")
				||msg.contains("Callback : Add Weapon = 7,")
		){
			return "big-toolbox";	
		}else if(msg.contains("Callback Credit: weaponType = 7 BuyToolByCredit")){
			return "big-toolbox";	
		}else if(msg.contains("Callback Credit:10_bigtoolbox_combo,from=hotshop,flag=Hot")){
			return "10_bigtoolbox_combo hot";	
		}else if(msg.contains("Callback Credit: weaponType = 8,")
				||msg.contains("action=AttackMonster,Use=Weapon,weaponTypeId=8")
				||msg.contains("Callback : Add Weapon = 8,")
		){
			return "A-bomb";	
		}else if(msg.contains("Callback Credit: weaponType = 8 BuyToolByCredit")){
			return "A-bomb";	
		}else if(msg.contains("Callback Credit:5 A-Bomb")
				||msg.contains("Callback Credit: weaponType = 105")
		){
			return "5 A-Bomb";	
		}else if(msg.contains("Callback Credit:10 A-Bomb")
				||msg.contains("Callback Credit: weaponType = 106")
		){
			return "10 A-Bomb";	
		}else if(msg.contains("Callback Credit:100 A-Bomb") 
				&& !msg.contains("Callback Credit:100 A-Bomb,from=hotShop,flag=Hot")
				||msg.contains("Callback Credit: weaponType = 123")
		){
			return "100 A-Bomb";	
		}else if(msg.contains("Callback Credit: weaponType = 9,")){
			return "TBox";	
		}else if(msg.contains("Callback Credit: weaponType = 10,")){
			return "Missile defense";	
		}else if(msg.contains("Callback Credit: weaponType = 11,")){
			return "a-bomb defense";	
		}else if(msg.contains("Callback Credit: weaponType = 12,")){
			return "Anti-Missilecomb";	
		}else if(msg.contains("Callback Credit:10_anti_missile_combo")
				||msg.contains("Callback Credit: weaponType = 121,")
		){
			return "10 anti missile";	
		}else if(msg.contains("Callback Credit: weaponType = 13,")){
			return "Anti-Abombcomb";	
		}else if(msg.contains("Callback Credit:10_anti_abomb_combo")
				||msg.contains("Callback Credit: weaponType = 122")
		){
			return "10 anti abomb";	
		}else if(msg.contains("Callback Credit: weaponType = 14,")){
			return "MissileAbombcomb";	
		}else if(msg.contains("Callback Credit: weaponType = 15,")){
			return "Big-Bomb";	
		}else if(msg.contains("Callback Credit: weaponType = 15 BuyToolByCredit")){
			return "Big-Bomb";	
		}else if(msg.contains("Callback Credit:5 big bomb")
				||msg.contains("Callback Credit: weaponType = 109,")
		){
			return "5 Big-Bomb";	
		}else if(msg.contains("Callback Credit:10 big bomb")
				||msg.contains("Callback Credit: weaponType = 110,")
		){
			return "10 Big-Bomb";	
		}else if(msg.contains("Callback Credit: weaponType = 16,")
				||msg.contains("Callback Credit: weaponType = 16 ")
				||msg.contains("action=AttackMonster,Use= weaponTypeId=16,Credit : Add Weapon =")
		){
			return "Super-toolbox";	
		}else if(msg.contains("Callback Credit: weaponType = 20,")){
			return "MessageBomb";	
		}else if(msg.contains("Callback Credit: weaponType = 21,")){
			return "MessageMissile";	
		}
//		else if(msg.contains("Callback Credit: weaponType = 16 BuyToolByCredit")){
//			return "Super-toolbox";	
//		}
		else if(msg.contains("Callback Credit:5 super toolbox")
				||msg.contains("Callback Credit: weaponType = 107,")
		){
			return "5 Super-toolbox";	
		}else if(msg.contains("Callback Credit:10 super toolbox")
				||msg.contains("Callback Credit: weaponType = 108,")
		){
			return "10 Super-toolbox";	
		}else if(msg.contains("Callback Credit:100 super toolbox") 
				&& !msg.contains("Callback Credit:100 super toolbox,from=hotShop,flag=Hot")
				||msg.contains("Callback Credit: weaponType = 120")
		){
			return "100 Super-toolbox";	
		}else if(msg.contains("Callback : CrewCombo FishermanCombo") 
				&& !(msg.contains("Callback : CrewCombo FishermanCombo,from=hotShop,flag=Hot,num=10"))
				||(msg.contains("Callback : Add crewTypeId = 21,")&&!msg.contains("combo=5")&&!msg.contains("combo=10"))
		){
			return "FishermanCombo";	
		}else if(msg.contains("Callback : Add crewTypeId = 21,")
				&&msg.contains("combo=5")
		){
			return "FishmanCombo5";	
		}else if(msg.contains("Callback : Add crewTypeId = 21,")
				&&msg.contains("combo=10")
		){
			return "FishmanCombo10";	
		}else if((msg.contains("Callback : CrewCombo PirateCombo")
				||msg.contains("Callback : Add crewTypeId = 22,"))&&!msg.contains("combo=5")&&!msg.contains("combo=10")
		){
			return "PirateCombo";	
		}else if(msg.contains("Callback : Add crewTypeId = 22,")&&msg.contains("combo=5")){
			return "PirateCombo5";	
		}else if(msg.contains("Callback : Add crewTypeId = 22,")&&msg.contains("combo=10")){
			return "PirateCombo10";	
		}else if(msg.contains("Callback Credit:MissileCombo")
				||msg.contains("Callback Credit: weaponType = 101,")
		){
			return "MissileCombo";	
		}else if(msg.contains("Callback Credit:5_missile_combo")
				||msg.contains("Callback Credit: weaponType = 111,")
		){
			return "5_missile_combo";	
		}else if(msg.contains("Callback Credit:10_missile_combo")
				||msg.contains("Callback Credit: weaponType = 115,")
		){
			return "10_missile_combo";	
		}else if(msg.contains("Callback Credit:BigMissileCombo")
				||msg.contains("Callback Credit: weaponType = 102,")
		){
			return "BigMissileCombo";	
		}else if(msg.contains("Callback Credit:5_big_missile_combo")
				||msg.contains("Callback Credit: weaponType = 112")
		){
			return "5_big_missile_combo";	
		}else if(msg.contains("Callback Credit:10_big_missile_combo")
				||msg.contains("Callback Credit: weaponType = 116,")
		){
			return "10_big_missile_combo";	
		}else if(msg.contains("Callback Credit:BigToolboxCombo")
				||msg.contains("Callback Credit: weaponType = 104,")
		){
			return "BigToolboxCombo";	
		}else if(msg.contains("Callback Credit:5_bigtoolbox_combo")
				||msg.contains("Callback Credit: weaponType = 114,")
		){
			return "5_bigtoolbox_combo";	
		}else if(msg.contains("Callback Credit:10_bigtoolbox_combo")
				||msg.contains("Callback Credit: weaponType = 118,")
		){
			return "10_bigtoolbox_combo";	
		}
		//
		else if(msg.contains("Callback : Add crewTypeId = 1,from=hotShop,flag=Hot,num=10,")){
			return "10 Sailor hot";	
		}else if(msg.contains("Callback : Add crewTypeId = 4,from=hotShop,flag=Hot,num=10,")){
			return "10 Prophet hot";	
		}else if(msg.contains("Callback : Add crewTypeId = 8,from=hotShop,flag=Hot,num=10,")){
			return "10 FishTrader hot";	
		}else if(msg.contains("Callback : CrewCombo FishermanCombo,from=hotShop,flag=Hot,num=10,")){
			return "10 FishmanCombo hot";	
		}else if(msg.contains("Callback Credit:100 A-Bomb,from=hotShop,flag=Hot")){
			return "100 A-bomb hot";	
		}else if(msg.contains("Callback Credit:100 super toolbox,from=hotShop,flag=Hot")){
			return "100 supertoolbox hot";	
		}else if(msg.contains("Callback Credit:10_bigtoolbox_combo,from=hotshop,flag=Hot")){
			return "10_bigtoolbox_combo hot";	
		}else if(msg.contains("Callback Credit:10_big_missile_combo,from=hotShop,flag=Hot")){
			return "10_big_missile_combo hot";	
		}else if(msg.contains("Callback : ComboItem=1,from=hotShop,flag=combo")){
			return "Lucky_Refresh";	
		}else if(msg.contains("Callback : ComboItem=2,from=hotShop,flag=combo")){
			return "Lucky_Freeze";	
		}else if(msg.contains("Callback : ComboItem=3,from=hotShop,flag=combo")){
			return "AbombLucky";	
		}else if(msg.contains("Callback : ComboItem=4,from=hotShop,flag=combo")){
			return "Abomb_Refresh";	
		}else if(msg.contains("Callback : ComboItem=5,from=hotShop,flag=combo")){
			return "Abomb_Freeze";	
		}else if(msg.contains("Callback : Add FishTackleId = 1,from=hotShop,flag=New")){
			return "Refresh_keeping_card";	
		}else if(msg.contains("Callback : Add FishTackleId = 1,action=allocFishTackle,fishTackle=1")){
			return "Refresh_keeping_card";	
		}else if(msg.contains("Callback : Add FishTackleId = 2,action=allocFishTackle,fishTackle=2")){
			return "Freeze_card";	
		}else if(msg.contains("Callback : Add FishTackleId = 2,from=hotShop,flag=New")){
			return "Freeze_card";	
		}else if(msg.contains("Callback : Add FishTackleId = 3,from=hotShop,flag=New")
				||msg.contains("Callback : Add FishTackleId = 3")
		){
			return "fish_change_card";	
		}
		else if(msg.contains("Callback : Add Weapon = 17,from=hotShop,flag=Hot,retId=")
				||msg.contains("Use=Weapon,weaponTypeId=17,Callback : Add Weapon = 17,")
				||msg.contains("Callback Credit: weaponType = 17,lastId=")
		){
			return "Whirlwind";	
		}else if(msg.contains("Callback : Add Weapon = 17,from=hotShop,flag=Hot,num=5,retId=")
				||msg.contains("Callback Credit: weaponType = 124,")
		){
			return "5 Whirlwind";	
		}else if(msg.contains("Callback : Add Weapon = 17,from=hotShop,flag=Hot,num=10,retId=")
				||msg.contains("Callback Credit: weaponType = 127,")
		){
			return "10 Whirlwind";	
		}else if(msg.contains("Callback : Add Weapon = 18,from=hotShop,flag=Hot,retId=")
				||msg.contains("Use=Weapon,weaponTypeId=18,Callback : Add Weapon = 18,")
				||msg.contains("Callback Credit: weaponType = 18,lastId=")
		){
			return "Fireball";	
		}else if(msg.contains("Callback : Add Weapon = 18,from=hotShop,flag=Hot,num=5,retId=")
				||msg.contains("Callback Credit: weaponType = 125,")){
			return "5 Fireball";	
		}else if(msg.contains("Callback : Add Weapon = 18,from=hotShop,flag=Hot,num=10,retId=")
				||msg.contains("Callback Credit: weaponType = 128,")
		){
			return "10 Fireball";	
		}else if(msg.contains("Callback : Add Weapon = 19,from=hotShop,flag=Hot,retId=")
				||msg.contains("Use=Weapon,weaponTypeId=19,Callback : Add Weapon = 19,")
				||msg.contains("Callback Credit: weaponType = 19,lastId=")
		){
			return "Thunderbolt";	
		}else if(msg.contains("Callback : Add Weapon = 19,from=hotShop,flag=Hot,num=5,retId=")
				||msg.contains("Callback Credit: weaponType = 126,")
		){
			return "5 Thunderbolt";	
		}else if(msg.contains("Callback : Add Weapon = 19,from=hotShop,flag=Hot,num=10,retId=")
				||msg.contains("Callback Credit: weaponType = 129,")
		){
			return "10 Thunderbolt";	
		}
		else if(msg.contains("Callback Credit: weaponYardType = 1")){
			if(msg.contains("lastTime=7")){
				return "Defense System 1";
			}else if(msg.contains("lastTime=12")){
				return "Defense System 1-12";
			}else if(msg.contains("lastTime=30")){
				return "Defense System 1-30";
			}else{
				return "Defense System 1";
			}
		}else if(msg.contains("Callback Credit: weaponYardType = 2")){
			if(msg.contains("lastTime=7")){
				return "Defense System 2";
			}else if(msg.contains("lastTime=12")){
				return "Defense System 2-12";
			}else if(msg.contains("lastTime=30")){
				return "Defense System 2-30";
			}else{
				return "Defense System 2";
			}
		}else if(msg.contains("Callback Credit: weaponYardType = 3")){
			if(msg.contains("lastTime=7")){
				return "Defense System 3";
			}else if(msg.contains("lastTime=12")){
				return "Defense System 3-12";
			}else if(msg.contains("lastTime=30")){
				return "Defense System 3-30";
			}else{
				return "Defense System 3";
			}
		}else if(msg.contains("Callback Credit: weaponYardType = 4")){
			if(msg.contains("lastTime=7")){
				return "Defense System 4";
			}else if(msg.contains("lastTime=12")){
				return "Defense System 4-12";
			}else if(msg.contains("lastTime=30")){
				return "Defense System 4-30";
			}else{
				return "Defense System 4";
			}
		}else if(msg.contains("Callback Credit: warehouseTypeId = 1")){
			return "Warehouse 1";	
		}else if(msg.contains("Callback Credit: warehouseTypeId = 2")){
			return "Warehouse 2";	
		}else if(msg.contains("Callback Credit: warehouseTypeId = 3")){
			return "Warehouse 3";	
		}else if(msg.contains("Callback Credit: rentShipType = 221")){
			return "rentShipA1";	
		}else if(msg.contains("Callback Credit: rentShipType = 222")){
			return "rentShipA2";	
		}else if(msg.contains("Callback Credit: rentShipType = 223")){
			return "rentShipA3";	
		}else if(msg.contains("Callback Credit: rentShipType = 231")){
			return "rentShipB1";	
		}else if(msg.contains("Callback Credit: rentShipType = 232")){
			return "rentShipB2";	
		}else if(msg.contains("Callback Credit: rentShipType = 233")){
			return "rentShipB3";	
		}else if(msg.contains("Callback Credit: rentShipType = 241")){
			return "rentShipC1";	
		}else if(msg.contains("Callback Credit: rentShipType = 242")){
			return "rentShipC2";	
		}else if(msg.contains("Callback Credit: rentShipType = 243")){
			return "rentShipC3";	
		}else if(msg.contains("reiconbycredit,iconId=01")){
			return "icon1";	
		}else if(msg.contains("reiconbycredit,iconId=02")){
			return "icon2";	
		}else if(msg.contains("reiconbycredit,iconId=03")){
			return "icon3";	
		}else if(msg.contains("reiconbycredit,iconId=04")){
			return "icon4";	
		}else if(msg.contains("reiconbycredit,iconId=07")){
			return "icon7";	
		}else if(msg.contains("reiconbycredit,iconId=08")){
			return "icon8";	
		}else if(msg.contains("Callback Credit:OlympicAbomb,from=hotShop,")){
			return "OlympicAbomb";
		}else if(msg.contains("Callback Credit:OlympicAbomb10,from=hotShop,")){
			return "OlympicAbomb10";
		}else if(msg.contains("Callback Credit:OlympicTbox,from=hotShop,")){
			return "OlympicTbox";
		}else if(msg.contains("Callback Credit:OlympicTbox10,from=hotShop,")){
			return "OlympicTbox10";
		}else if(msg.contains("Callback Credit:OlympicThief,from=hotShop,")){
			return "OlympicThief";
		}else if(msg.contains("Callback Credit:OlympicThief10,from=hotShop,")){
			return "OlympicThief10";
		}else if(msg.contains("Callback Credit:OlympicAbomb100,from=hotShop,")){
			return "OlympicAbomb100";
		}
		//checkin
		else if(msg.contains("callback credit : checkin")){
			return "checkin";
		}
		//world monster
		else if(msg.contains("Callback Credit: Strengthen World Monster")){
			return "WorldMonsterStrengUp";
		}else if(msg.contains("Callback Credit: Summon World Monster")){
			return "summonMonster";
		}
//		//temp
//		else if(msg.contains("Callback Credit:Eid2msgBomb,from=hotShop")){
//			return "Eid2msgBomb";
//		}else if(msg.contains("Callback Credit:Weekend3Lucky,from=hotShop")){
//			return "Weekend3Lucky";
//		}else if(msg.contains("Callback Credit:EidWFT,from=hotShop")){
//			return "EidWFT";
//		}
		return item;
	}
	
	public static String getItemName_oabalance(String msg){
		String item = "";
		//crew
		if(msg.contains("Sailor,") && !msg.contains("Sailor10")){
			return "Sailor";
		}else if(msg.contains("Thief,")){
			return "Thief";	
		}else if(msg.contains("Guard,")){
			return "Guard";	
		}else if(msg.contains("Prophet,") && !msg.contains("Prophet10")){
			return "Prophet";	
		}else if(msg.contains("Spy,")){
			return "Spy";	
		}else if(msg.contains("Insurance,")){
			return "Insurance";	
		}else if(msg.contains("Robber,")){
			return "Robber";	
		}else if((msg.contains("Fish Trader,") || msg.contains("Fish_Trader,"))&&!msg.contains("FishTrader10,")){
			return "Fish Trader";	
		}
//		else if(msg.contains("Callback : Add crewTypeId = 9,from=hotShop,flag=New")||msg.contains("Callback : Add crewTypeId = 9,")){
//			return "lucky crew";	
//		}
		else if(msg.contains("SilverNet,")){
			return "Sliver Net";	
		}else if(msg.contains("GoldNet,")){
			return "Golden Net";	
		}
		//weapon
		else if(msg.contains("small-missile,")){
			return "small-missile";	
		}else if(msg.contains("middle-missile,")){
			return "middle-missile";	
		}else if(msg.contains("big-missile,")){
			return "big-missile";	
		}else if(msg.contains("shield,")){
			return "shield";	
		}else if(msg.contains("small-toolbox,")){
			return "small-toolbox";	
		}else if(msg.contains("middle-toolbox,")){
			return "middle-toolbox";	
		}else if(msg.contains("big-toolbox,")){
			return "big-toolbox";	
		}else if(msg.contains("10_bigtoolbox_combo,")){
			return "10_bigtoolbox_combo hot";	
		}else if(msg.contains("=A-bomb,")){
			return "A-bomb";	
		}else if(msg.contains("5 A-bomb,")||msg.contains("5_A-bomb,")){
			return "5 A-Bomb";	
		}else if(msg.contains("10 A-bomb,")||msg.contains("10_A-bomb,")){
			return "10 A-Bomb";	
		}else if(msg.contains("100A-bomb,")){
			return "100 A-Bomb";	
		}else if(msg.contains("TBox,")){
			return "TBox";	
		}else if(msg.contains("Anti-Missile,")){
			return "Missile defense";	
		}else if(msg.contains("Anti-Abomb,")){
			return "a-bomb defense";	
		}else if(msg.contains("Anti-Missilecomb,")){
			return "Anti-Missilecomb";	
		}else if(msg.contains("10_anti_missile_combo,")){
			return "10 anti missile";	
		}else if(msg.contains("Anti-Abombcomb,")){
			return "Anti-Abombcomb";	
		}else if(msg.contains("10_anti_abomb_combo,")){
			return "10 anti abomb";	
		}else if(msg.contains("MissileAbombcomb,")){
			return "MissileAbombcomb";	
		}else if(msg.contains("=Big-bomb,")){
			return "Big-Bomb";	
		}else if(msg.contains("5_big_bomb,")){
			return "5 Big-Bomb";	
		}else if(msg.contains("10_big_bomb,")){
			return "10 Big-Bomb";	
		}else if(msg.contains("=super-toolbox,")){
			return "Super-toolbox";	
		}
//		else if(msg.contains("Callback Credit: weaponType = 20,")){
//			return "MessageBomb";	
//		}else if(msg.contains("Callback Credit: weaponType = 21,")){
//			return "MessageMissile";	
//		}
		else if(msg.contains("5_super_toolbox,")){
			return "5 Super-toolbox";	
		}else if(msg.contains("10_super_toolbox,")){
			return "10 Super-toolbox";	
		}else if(msg.contains("100super,")){
			return "100 Super-toolbox";	
		}else if(msg.contains("Fishman_Combo,")){
			return "FishermanCombo";	
		}else if(msg.contains("Pirate_Combo,")){
			return "PirateCombo";	
		}else if(msg.contains("Missile_Combo,")){
			return "MissileCombo";	
		}else if(msg.contains("5_missile_combo,")){
			return "5_missile_combo";	
		}else if(msg.contains("10_missile_combo,")){
			return "10_missile_combo";	
		}else if(msg.contains("Big Missile Combo,")||msg.contains("Big_Missile_Combo,")){
			return "BigMissileCombo";	
		}else if(msg.contains("5_big_missile_combo,")){
			return "5_big_missile_combo";	
		}else if(msg.contains("10_big_missile_combo,")){
			return "10_big_missile_combo";	
		}else if(msg.contains("Big_Toolbox_Combo,")){
			return "BigToolboxCombo";	
		}else if(msg.contains("5_bigtoolbox_combo,")){
			return "5_bigtoolbox_combo";	
		}else if(msg.contains("10_bigtoolbox_combo,")){
			return "10_bigtoolbox_combo";	
		}
		//
		else if(msg.contains("Sailor10,")){
			return "10 Sailor hot";	
		}else if(msg.contains("Prophet10,")){
			return "10 Prophet hot";	
		}else if(msg.contains("FishTrader10,")){
			return "10 FishTrader hot";	
		}else if(msg.contains("FishmanCombo10,")){
			return "10 FishmanCombo hot";	
		}else if(msg.contains("abomb_Freeze_card,")){
			return "Abomb_Freeze";	
		}else if(msg.contains("Refresh_keeping_card,")){
			return "Refresh_keeping_card";	
		}else if(msg.contains("Freeze_card,")){
			return "Freeze_card";	
		}else if(msg.contains("fish_change_card,")){
			return "fish_change_card";	
		}
		else if(msg.contains("=Whirlwind,")){
			return "Whirlwind";	
		}else if(msg.contains("5_Whirlwind,")){
			return "5 Whirlwind";	
		}else if(msg.contains("10_Whirlwind,")){
			return "10 Whirlwind";	
		}else if(msg.contains("=Fireball,")){
			return "Fireball";	
		}else if(msg.contains("5_Fireball,")){
			return "5 Fireball";	
		}else if(msg.contains("10_Fireball,")){
			return "10 Fireball";	
		}else if(msg.contains("=Firebolt,")){
			return "Thunderbolt";	
		}else if(msg.contains("5_Firebolt,")){
			return "5 Thunderbolt";	
		}else if(msg.contains("10_Firebolt,")){
			return "10 Thunderbolt";	
		}
		else if(msg.contains("Level1,")){
			return "Defense System 1";	
		}else if(msg.contains("Level2,")){
			return "Defense System 2";	
		}else if(msg.contains("Level3,")){
			return "Defense System 3,";	
		}else if(msg.contains("Level4,")){
			return "Defense System 4";	
		}else if(msg.contains("warehouse1,")){
			return "Warehouse 1";	
		}else if(msg.contains("warehouse2,")){
			return "Warehouse 2";	
		}else if(msg.contains("warehouse3,")){
			return "Warehouse 3";	
		}else if(msg.contains("rentShipA1,")){
			return "rentShipA1";	
		}else if(msg.contains("rentShipA2,")){
			return "rentShipA2";	
		}else if(msg.contains("rentShipA3,")){
			return "rentShipA3";	
		}else if(msg.contains("rentShipB1,")){
			return "rentShipB1";	
		}else if(msg.contains("rentShipB2,")){
			return "rentShipB2";	
		}else if(msg.contains("rentShipB3,")){
			return "rentShipB3";	
		}else if(msg.contains("rentShipC1,")){
			return "rentShipC1";	
		}else if(msg.contains("rentShipC2,")){
			return "rentShipC2";	
		}else if(msg.contains("rentShipC3,")){
			return "rentShipC3";	
		}else if(msg.contains("checkin,")){
			return "checkin";	
		}else if(msg.contains("OlympicAbomb10,")){
			return "OlympicAbomb10";	
		}else if(msg.contains("FishmanCombo5,")){
			return "FishmanCombo5";	
		}else if(msg.contains("FishTrader5,")){
			return "FishTrader5";	
		}else if(msg.contains("OlympicTbox,")){
			return "OlympicTbox";	
		}else if(msg.contains("OlympicTbox10,")){
			return "OlympicTbox10";	
		}else if(msg.contains("icon,")){
			return "icon";	
		}else if(msg.contains("OlympicAbomb,")){
			return "icon";	
		}else if(msg.contains("OlympicAbomb100,")){
			return "OlympicAbomb100";	
		}else if(msg.contains("PirateCombo10,")){
			return "PirateCombo10";	
		}else if(msg.contains("PirateCombo5,")){
			return "PirateCombo5";	
		}else if(msg.contains("WorldMonsterStrengUp,")){
			return "WorldMonsterStrengUp";	
		}else if(msg.contains("summonMonster,")){
			return "summonMonster";	
		}
		return item;
	}
	
	static public int countAmountContain(String item,ArrayList<String> msgs) throws Exception{
		int result = 0;
		if(item.contains("%")){
			item = item.replace("%","");
		}
		
		for(String temp:msgs){
			if(temp.contains("Callback : Add Weapon = 18,from=hotShop,flag=Hot,num=10,")){
				System.out.println(temp);
			}
			if(item.contains("Callback : Add Weapon = 18")){
				System.out.println(item);
			}
			if(temp.contains(item)){
				result++;
			}
		}
		return result;
	}
	
	static public int CreditUserAmount(Date fromTime,Date toTime){
		int result = 0;
		try {
			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient081.execSQLQuery(
							"select count(distinct user_id) as amount from payment where app_name='ocean age' and time_payment>=? and time_payment<?",
							dbArgs);
			if(rs.next()){
				result = rs.getInt("amount");
			}
		} catch (Exception e) {
			logger.error("CreditUserAmount with result=" + result, e);
		}
		return result;
	}
	
	public static void main(String[] args) {
//		int result = 0;
//		Pattern pt1 = null;
//        Matcher mc1 = null;
//        String item = "Callback : Add Weapon = 18,from=hotShop,flag=Hot,num=10,%";
//		if(item.contains("%")){
//			item = item.replace("%","[a-zA-Z]*");
//		}	
//		if(item.contains("[^0-9]")){
//			item = item.replace("[^0-9]","[^0-9]*");
//		}	
//		pt1 = Pattern.compile(item);
//		ArrayList<String> msgs = new ArrayList<String>();
//		msgs.add("Callback : Add Weapon = 18,from=hotShop,flag=Hot,num=10,retId=14498458");
//		for(String temp:msgs){
//		    mc1 = pt1.matcher(temp);
//			if(mc1.matches()){
//				result++;
//			}
//		}
		System.out.println(getItemName("action=AttackMonster,Use=Weapon,weaponTypeId=18,Callback : Add Weapon = 18,weaponId=20435081,thisTime=17,all=10261,tId=3765,CompetitionPoint=4046340"));
	}

}
