package toolStat;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;
import java.util.Map;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.OAStatistic;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class Stocks {
	Connection cn = null;
	CallableStatement cmd = null;
	Statement stmt = null;
	ResultSet rs = null;

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
	
	public static Map<String,Integer> getStocks(Date fromTime){
		java.util.Map<String, Integer> stocks = new java.util.HashMap<String, Integer>();
		try {
			Object[] dbArgs = new Object[] {fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from daustocks where stime=?",
							dbArgs);
			while(rs.next()) {
				stocks.put(rs.getString("item"),rs.getInt("amount"));
			}
		} catch (Exception e) {
			logger.error("getStocks with  fromTime=" + fromTime , e);
		}
		return stocks;
	}
	
	public static Map<String,Integer> getMaxStocks(Date fromTime){
		java.util.Map<String, Integer> stocks = new java.util.HashMap<String, Integer>();
		try {
			Object[] dbArgs = new Object[] {fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from daustocks where stime=?",
							dbArgs);
			while(rs.next()) {
				stocks.put(rs.getString("item"),rs.getInt("maxS"));
			}
		} catch (Exception e) {
			logger.error("getMaxStocks with  fromTime=" + fromTime , e);
		}
		return stocks;
	}
	
	public static Map<String,Object> getStocksDetail(String item,Date date){
		java.util.Map<String, Object> stocks = new java.util.HashMap<String, Object>();
		try {
			Object[] dbArgs = new Object[] {item,date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from daustocks where item=? and stime=?",
							dbArgs);
			if(rs.next()) {
				stocks.put("Item",rs.getString("item"));
				stocks.put("Total",rs.getLong("amount"));
				stocks.put("Average",rs.getDouble("averageS"));
				stocks.put("Max",rs.getLong("maxS"));
				stocks.put("Mid",rs.getLong("midS"));
				stocks.put("Min",rs.getLong("minS"));
				stocks.put("Monetid",rs.getLong("monetid"));
			}
		} catch (Exception e) {
			logger.error("getStocksDetail with  fromTime=" + date , e);
		}
		return stocks;
	}
	
	public static Map<Integer,Integer> getTribeId(Date fromTime){
		java.util.Map<Integer, Integer> ids = new java.util.HashMap<Integer, Integer>();
		try {
			Object[] dbArgs = new Object[] {fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select tid from contribution where ctime=? order by contribution desc",
							dbArgs);
			int i = 1;
			while(rs.next()) {
				ids.put(i,rs.getInt("tid"));
				i++;
			}
		} catch (Exception e) {
			logger.error("getTribeId with  fromTime=" + fromTime , e);
		}
		return ids;
	}
	
	public static Map<Integer,Integer> getContributin(Date fromTime){
		java.util.Map<Integer, Integer> ids = new java.util.HashMap<Integer, Integer>();
		try {
			Object[] dbArgs = new Object[] {fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select contribution from contribution where ctime=? order by contribution desc",
							dbArgs);
			int i = 1;
			while(rs.next()) {
				ids.put(i,rs.getInt("contribution"));
				i++;
			}
		} catch (Exception e) {
			logger.error("getContributin with  fromTime=" + fromTime , e);
		}
		return ids;
	}
}
