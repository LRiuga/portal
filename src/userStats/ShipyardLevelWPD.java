package userStats;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class ShipyardLevelWPD {
	static final Logger logger = Logger.getLogger(ShipyardLevelWPD.class);
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
	
	public static Map<Double,Double> getMaxMap(String type,Date date){
		Map<Double,Double> map = new HashMap<Double,Double>();
		try {
			Object[] dbArgs = new Object[] {type,date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select shipyardlevel,maxlevel from shipyardLevelWPD where type=? and sdate=?",
							dbArgs);
			while(rs.next()){
				double level = rs.getDouble("shipyardlevel");
				double maxlevel = rs.getDouble("maxlevel");
				map.put(level,maxlevel);
			}
		} catch (Exception e) {
			logger.error("getMaxMap " + type , e);
		}
		return map;
	}
	
	public static Map<Double,Double> getMidMap(String type,Date date){
		Map<Double,Double> map = new HashMap<Double,Double>();
		try {
			Object[] dbArgs = new Object[] {type,date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select shipyardlevel,midlevel from shipyardLevelWPD where type=? and sdate=?",
							dbArgs);
			while(rs.next()){
				double level = rs.getDouble("shipyardlevel");
				double maxlevel = rs.getDouble("midlevel");
				map.put(level,maxlevel);
			}
		} catch (Exception e) {
			logger.error("getMaxMap " + type , e);
		}
		return map;
	}
	
	public static Map<Double,Double> getAvgMap(String type,Date date){
		Map<Double,Double> map = new HashMap<Double,Double>();
		try {
			Object[] dbArgs = new Object[] {type,date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select shipyardlevel,avglevel from shipyardLevelWPD where type=? and sdate=?",
							dbArgs);
			while(rs.next()){
				double level = rs.getDouble("shipyardlevel");
				double maxlevel = rs.getDouble("avglevel");
				map.put(level,maxlevel);
			}
		} catch (Exception e) {
			logger.error("getMaxMap " + type , e);
		}
		return map;
	}
}
