package toolStat;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class GemStats {
	Connection cn = null;
	CallableStatement cmd = null;
	Statement stmt = null;
	ResultSet rs = null;
	static Logger logger = Logger.getLogger(GemStats.class);
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
	
	public static Map<String,Set<String>> getAllItem(Date date1,Date date2,int gem){
		Map<String,Set<String>> map = new HashMap<String,Set<String>>();
		try {
			Object[] dbArgs = new Object[] {date1,date2,gem};
			DBResultSet rs = dbClient.execSQLQuery(
							"select type,item from gemstats where gtime>=? and gtime<=? and gem=?",
							dbArgs);
			while(rs.next()){
				String type = rs.getString("type").trim();
				String item = rs.getString("item").trim();
				if(map.containsKey(type)){
					Set<String> itemSet = map.get(type);
					itemSet.add(item);
					map.put(type, itemSet);
				}else{
					Set<String> itemSet = new HashSet<String>();
					itemSet.add(item);
					map.put(type, itemSet);
				}
			}
		} catch (Exception e) {
			logger.error("getAllItem with fromTime=" + date1 , e);
		}
		return map;
	}
	
	public static Map<String,Map<String,Long>> getOneDayData(Date date,int gem){
		Map<String,Map<String,Long>> map = new HashMap<String,Map<String,Long>>();
		try {
			Object[] dbArgs = new Object[] {date,gem};
			DBResultSet rs = dbClient.execSQLQuery(
							"select type,item,amount from gemstats where gtime=? and gem=?",
							dbArgs);
			while(rs.next()){
				String type = rs.getString("type").trim();
				String item = rs.getString("item").trim();
				long amount = rs.getLong("amount");
				if(map.containsKey(type)){
					Map<String,Long> itemMap = map.get(type);
					itemMap.put(item, amount);
					map.put(type, itemMap);
				}else{
					Map<String,Long> itemMap = new HashMap<String,Long>();
					itemMap.put(item, amount);
					map.put(type, itemMap);
				}
			}
		} catch (Exception e) {
			logger.error("getGoldAmount with  fromTime=" + date , e);
		}
		return map;
	}

	public static long getGemAmount(String type,Date date,int gem){
		long amount = 0;
		try {
			Object[] dbArgs = new Object[] {type,date,gem};
			DBResultSet rs = dbClient.execSQLQuery(
							"select amount from gemstats where type=? and gtime=? and gem=?",
							dbArgs);
			if(type.equals("all")){
				if(rs.next()) {
					amount = rs.getLong("amount");
				}
			}else{
				while(rs.next()) {
					amount += rs.getLong("amount");
				}
			}
		} catch (Exception e) {
			logger.error("getGemAmount with  fromTime=" + date , e);
		}
		return amount;
	}
	
	
	public static String Output(double percent){
		DecimalFormat df = new DecimalFormat("#.00");
		if(percent>=0.5){
			return "<font color=\"#FF0000\">"+df.format(percent)+"</font>";
		}else{
			return df.format(percent);
		}
	}
}
