package activity;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class HelpFriend {
	static final Logger logger = Logger.getLogger(HelpFriend.class);
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
	
	public static Map<String,Integer> getUsingAmount(Date date,int myself){
		Map<String,Integer> map = new HashMap<String, Integer>();
		DBResultSet rs = null;
		Object[] dbArgs = new Object[] {date,myself};
		try {
			rs = dbClient.execSQLQuery(
					"select iname,amount from helpfriend where stime=? and myself=?",
					dbArgs);
			while(rs.next()){
				map.put(rs.getString("iname"),rs.getInt("amount"));
			}
		} catch (Exception e) {
			logger.error("getUserAmount ", e);
		}
		return map;
	}
	
	public static Map<String,Integer> getUserAmount(Date date,int myself){
		Map<String,Integer> map = new HashMap<String, Integer>();
		DBResultSet rs = null;
		Object[] dbArgs = new Object[] {date,myself};
		try {
			rs = dbClient.execSQLQuery(
					"select iname,totalUser from helpfriend where stime=? and myself=?",
					dbArgs);
			while(rs.next()){
				map.put(rs.getString("iname"),rs.getInt("totalUser"));
			}
		} catch (Exception e) {
			logger.error("getUserAmount ", e);
		}
		return map;
	}
	
	public static Map<String,Long> getCompetitionPointsAmount(Date date,int myself){
		Map<String,Long> map = new HashMap<String, Long>();
		DBResultSet rs = null;
		Object[] dbArgs = new Object[] {date,myself};
		try {
			rs = dbClient.execSQLQuery(
					"select iname,points from helpfriend where stime=? and myself=?",
					dbArgs);
			while(rs.next()){
				map.put(rs.getString("iname"),rs.getLong("points"));
			}
		} catch (Exception e) {
			logger.error("getCompetitionPointsAmount ", e);
		}
		return map;
	}
	
	public static Map<String,Long> getMaxAmount(Date date,int myself){
		Map<String,Long> map = new HashMap<String, Long>();
		DBResultSet rs = null;
		Object[] dbArgs = new Object[] {date,myself};
		try {
			rs = dbClient.execSQLQuery(
					"select iname,maxUser from helpfriend where stime=? and myself=?",
					dbArgs);
			while(rs.next()){
				map.put(rs.getString("iname"),rs.getLong("maxUser"));
			}
		} catch (Exception e) {
			logger.error("getMaxAmount ", e);
		}
		return map;
	}
	
	public static void main(String[] args) {

	}

}
