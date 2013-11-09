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

public class LevelReturnRate {
	static final Logger logger = Logger.getLogger(LevelReturnRate.class);
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
	
	static public java.util.Map<Integer,Map<Integer,Double>> getReturnRateMap(Date fromTime){
		java.util.Map<Integer,Map<Integer,Double>> map = new java.util.HashMap<Integer, Map<Integer,Double>>();
		DBResultSet rs = null;
		Object[] dbArgs = new Object[] {fromTime};
		try {
				rs = dbClient.execSQLQuery(
						"select shipyardlevel,datenum,daterate from levelreturnrate where statstime=?",dbArgs);
				while(rs.next()){
					int level = rs.getInt("shipyardlevel");
					int amount = rs.getInt("datenum");
					double rate = rs.getDouble("daterate");
					
					if(map.containsKey(level)){
						Map<Integer,Double> levelMap = map.get(level);
						levelMap.put(amount,rate);
						map.put(level,levelMap);
					}else{
						Map<Integer,Double> levelMap = new HashMap<Integer,Double>();
						levelMap.put(amount,rate);
						map.put(level,levelMap);
					}
				}
		} catch (Exception e) {
			logger.error("getReturnRateMap ", e);
		}
		return map;
	}
}
