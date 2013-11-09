package tribeStats;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.OAStatistic;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class TribeTotal {
	Connection cn = null;
	CallableStatement cmd = null;
	Statement stmt = null;
	ResultSet rs = null;
	static ArrayList<String> itemList = new ArrayList<String>();
	static ArrayList<String> actionList = new ArrayList<String>();
	static Logger logger = Logger.getLogger(OAStatistic.class);
	static String dbReadUrls = null;
	static String dbDriver = null;
	static MoDBRW dbClient = null;
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");
			dbReadUrls = serverConf.getString("dbReadUrls");
			dbDriver = serverConf.getString("dbDriver");
			dbClient = new MoDBRW(dbReadUrls,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
		
	}
	static{
		
		itemList.add("CreateTribe");
		itemList.add("JoinTribe");
		itemList.add("GoldTask");
		itemList.add("FishTask");
		
		actionList.add("GoldTask");
		actionList.add("FishTask");
		actionList.add("CreateTribe");
		actionList.add("JoinTribe");
		actionList.add("SendMessage");
		actionList.add("InviteTribe");
		actionList.add("QuitTribe");
		actionList.add("ViewInfo");
		
	}
	
	public static ArrayList<String> getItemList(){
		return itemList;
	}
	
	public static ArrayList<String> getActionList(){
		return actionList;
	}
	
	public static int getItemAmount(String item,Date fromTime){
		int result = 0;
		
		try {

			Object[] dbArgs = new Object[] {item,fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select amount from tribeStats where item=? and ttime=?",
							dbArgs);
			if(rs.next()) {
				result = rs.getInt("amount");
			}
		} catch (Exception e) {
			logger.error("getItemAmount with  fromTime=" + fromTime , e);
		}
		
		return result;
	}
	
	public static ArrayList<String> getattackMonsterItemNameList(Date fromTime,Date toTime){
		ArrayList<String> list = new ArrayList<String>();
		try {
			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select distinct iname from using where utime>=? and utime<=? and type='attackWorldMonster' order by iname",
							dbArgs);
			while(rs.next()) {
				list.add(rs.getString("iname"));
			}
		} catch (Exception e) {
			logger.error("getattackMonsterItemNameList with  fromTime=" + fromTime , e);
		}
		return list;
	}
	
	public static int getUsersAmount(String item,Date fromTime){
		int result = 0;
		
		try {

			Object[] dbArgs = new Object[] {item,fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select users from tribeStats where item=? and ttime=?",
							dbArgs);
			if(rs.next()) {
				result = rs.getInt("users");
			}
		} catch (Exception e) {
			logger.error("getUsersAmount with  fromTime=" + fromTime , e);
		}
		
		return result;
	}
	
	public static java.util.Map<String,Integer> getTribeShipsData(Date ttime){
		java.util.Map<String,Integer> map = new java.util.HashMap<String, Integer>();
		

		try {

			Object[] dbArgs = new Object[] {ttime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select buyShip,upgradeSuccess,upgradeFail from tribeShip where ttime=?",
							dbArgs);
			if(rs.next()) {
				map.put("buyShip",rs.getInt("buyShip"));
				map.put("upgradeSuccess",rs.getInt("upgradeSuccess"));
				map.put("upgradeFail",rs.getInt("upgradeFail"));
			}
		} catch (Exception e) {
			logger.error("getUsersAmount with  fromTime=" + ttime , e);
		}
		
		return map;
	}
	
	public static java.util.Map<String,Integer> getUserActionData(Date ttime){
		java.util.Map<String,Integer> map = new java.util.HashMap<String, Integer>();
		try {

			Object[] dbArgs = new Object[] {ttime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item,actionA from useraction where atime=?",
							dbArgs);
			while(rs.next()) {
				map.put(rs.getString("item"),rs.getInt("actionA"));
			}
		} catch (Exception e) {
			logger.error("getUserActionData with  fromTime=" + ttime , e);
		}
		
		return map;
	}
	
	public static java.util.Map<String,Integer> getUserUsersData(Date ttime){
		java.util.Map<String,Integer> map = new java.util.HashMap<String, Integer>();
		try {

			Object[] dbArgs = new Object[] {ttime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item,userA from useraction where atime=?",
							dbArgs);
			while(rs.next()) {
				map.put(rs.getString("item"),rs.getInt("userA"));
			}
		} catch (Exception e) {
			logger.error("getUserUsersData with  fromTime=" + ttime , e);
		}
		
		return map;
	}
}
