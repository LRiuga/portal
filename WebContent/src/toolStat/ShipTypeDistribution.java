package toolStat;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.OAStatistic;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class ShipTypeDistribution {
	Connection cn = null;
	CallableStatement cmd = null;
	Statement stmt = null;
	ResultSet rs = null;
	static Logger logger = Logger.getLogger(ShipTypeDistribution.class);
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
	
	public static Map<Integer,Map<Integer,Integer>> getTypeLevelAmountMap(Date date){
		Map<Integer,Map<Integer,Integer>> typeMap = new HashMap<Integer,Map<Integer,Integer>>();
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select shiptype,userlevel,amount from shiptypedistribution where sdate=?",
							dbArgs);
			while(rs.next()){
				int level = rs.getInt("shiptype");
				int monetid = rs.getInt("userlevel");
				int amount = rs.getInt("amount");
				if(typeMap.containsKey(level)){
					Map<Integer,Integer> monetidMap = typeMap.get(level);
					monetidMap.put(monetid,amount);
					typeMap.put(level,monetidMap);
				}else{
					Map<Integer,Integer> monetidMap = new HashMap<Integer,Integer>();
					monetidMap.put(monetid,amount);
					typeMap.put(level,monetidMap);
				}
			}
		} catch (Exception e) {
			logger.error("getTypeLevelAmountMap", e);
		}
		return typeMap;
	}
}
