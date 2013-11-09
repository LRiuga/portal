package userStats;

import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class ShipyardLevel {
	static final Logger logger = Logger.getLogger(ShipyardLevel.class);
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
	
	static public java.util.Map<Integer,Integer> getList(String type,Date ctime){
		java.util.Map<Integer,Integer> map = new java.util.HashMap<Integer, Integer>();
		DBResultSet rs = null;
		Object[] dbArgs = new Object[] {type,ctime};
		try {
				rs = dbClient.execSQLQuery(
						"select * from dailyuserlevel where type=? and ctime=?",
						dbArgs);
				while(rs.next()){
					map.put(rs.getInt("level"),rs.getInt("amount"));
				}
		} catch (Exception e) {
			logger.error("getModelList ", e);
		}
		return map;
	}
	
	static public java.util.Map<Date,Map<Integer,Integer>> getAmountMap(Date fromTime,Date toTime,String type){
		java.util.Map<Date,Map<Integer,Integer>> map = new java.util.HashMap<Date, Map<Integer,Integer>>();
		DBResultSet rs = null;
		Object[] dbArgs = new Object[] {fromTime, toTime ,type};
		try {
				rs = dbClient.execSQLQuery(
						"select ctime,level,amount from dailyuserlevel where ctime>=? and ctime<=? and type=?",dbArgs);
				while(rs.next()){
					Date date = rs.getDate("ctime");
					int level = rs.getInt("level");
					int amount = rs.getInt("amount");
					
					if(map.containsKey(date)){
						Map<Integer,Integer> levelMap = map.get(date);
						levelMap.put(level,amount);
						map.put(date,levelMap);
					}else{
						Map<Integer,Integer> levelMap = new HashMap<Integer,Integer>();
						levelMap.put(level,amount);
						map.put(date,levelMap);
					}
				}
		} catch (Exception e) {
			logger.error("getAmountMap ", e);
		}
		return map;
	}
	
	public static Map<Integer,Integer> getDailyLevelAmount(Date date,String type){
		Map<Integer,Integer> amountMap = new HashMap<Integer,Integer>();
		DBResultSet rs = null;
		Object[] dbArgs = new Object[] {date,type};
		try {
				rs = dbClient.execSQLQuery(
						"select level,amount from dailyuserlevel where ctime=? and type=?",dbArgs);
				while(rs.next()){
					int level = rs.getInt("level");
					int amount = rs.getInt("amount");
					amountMap.put(level, amount);
					System.out.println(level+","+amount);
				}
		} catch (Exception e) {
			logger.error("getDailyLevelAmount ", e);
		}
		return amountMap;
	}
	
	public static Map<Integer,Long> getDailyLevelAverageTime(Date date,String type){
		Map<Integer,Long> averageMap = new HashMap<Integer,Long>();
		DBResultSet rs = null;
		Object[] dbArgs = new Object[] {date,type};
		try {
				rs = dbClient.execSQLQuery(
						"select level,averagePlayTime from dailyuserlevel where ctime=? and type=?",dbArgs);
				while(rs.next()){
					int level = rs.getInt("level");
					long average = rs.getLong("averagePlayTime");
					averageMap.put(level, average);
				}
		} catch (Exception e) {
			logger.error("getDailyLevelAverageTime ", e);
		}
		return averageMap;
	}
	
	public static Map<Integer,Long> getDailyLevelMiddleTime(Date date,String type){
		Map<Integer,Long> middleMap = new HashMap<Integer,Long>();
		DBResultSet rs = null;
		Object[] dbArgs = new Object[] {date,type};
		try {
				rs = dbClient.execSQLQuery(
						"select level,midPlayTime from dailyuserlevel where ctime=? and type=?",dbArgs);
				while(rs.next()){
					int level = rs.getInt("level");
					long middle = rs.getLong("midPlayTime");
					middleMap.put(level, middle);
				}
		} catch (Exception e) {
			logger.error("getDailyLevelMiddleTime ", e);
		}
		return middleMap;
	}
	
	public static Map<Integer,Long> getDailyLevelMinimumTime(Date date,String type){
		Map<Integer,Long> minimumMap = new HashMap<Integer,Long>();
		DBResultSet rs = null;
		Object[] dbArgs = new Object[] {date,type};
		try {
				rs = dbClient.execSQLQuery(
						"select level,minPlayTime from dailyuserlevel where ctime=? and type=?",dbArgs);
				while(rs.next()){
					int level = rs.getInt("level");
					long minimum = rs.getLong("minPlayTime");
					minimumMap.put(level, minimum);
				}
		} catch (Exception e) {
			logger.error("getDailyLevelMinimumTime ", e);
		}
		return minimumMap;
	}
	
	public static String getFormatString(Long time){

		String timeString = "";
		double day = time/3600/24;
		double hour = time/3600;
		double minute = time/60;
		double second = time;
		
		DecimalFormat df = new DecimalFormat("0");
		
		if(day>1){
			timeString += df.format(Math.floor(day))+"天";
		}
		if(hour>1){
			timeString += df.format(Math.floor(hour%24))+"小时";
		}
		if(minute>1){
			timeString += df.format(Math.floor(minute%60))+"分钟";
		}
		if(second>1){
			timeString += df.format(Math.floor(second%60))+"秒";
		}
		
		return timeString;
	
	}
}
