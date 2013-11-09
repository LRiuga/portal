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

public class CreditDetail {
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
	
	public static Map<String,Object> getCreditDetail(String itemName,Date fromTime){
		java.util.Map<String, Object> creditDetail = new java.util.HashMap<String, Object>();
		try {
			Object[] dbArgs = new Object[] {itemName,fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from selling where iname=? and stime=?",
							dbArgs);
			if(rs.next()) {
				creditDetail.put("iname", rs.getString("iname"));
				creditDetail.put("amount",rs.getInt("amount"));
				creditDetail.put("totalUser", rs.getInt("totalUser"));
				creditDetail.put("maxUser",rs.getInt("maxUser"));
				creditDetail.put("minUser",rs.getInt("minUser"));
				creditDetail.put("stime",rs.getDate("stime"));
			}
		} catch (Exception e) {
			logger.error("getCreditDetail with  fromTime=" + fromTime , e);
		}
		
		return creditDetail;
	}
	
	public static Map<String,Object> getOABalanceDetail(String itemName,Date fromTime){
		java.util.Map<String, Object> oabalanceDetail = new java.util.HashMap<String, Object>();
		try {
			Object[] dbArgs = new Object[] {itemName,fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from selling_oabalance where iname=? and stime=?",
							dbArgs);
			if(rs.next()) {
				oabalanceDetail.put("iname", rs.getString("iname"));
				oabalanceDetail.put("amount",rs.getInt("amount"));
				oabalanceDetail.put("totalUser", rs.getInt("totalUser"));
				oabalanceDetail.put("maxUser",rs.getInt("maxUser"));
				oabalanceDetail.put("oabalance",rs.getDouble("oabalance"));
				oabalanceDetail.put("credit",rs.getDouble("credit"));
				oabalanceDetail.put("stime",rs.getDate("stime"));
			}
		} catch (Exception e) {
			logger.error("getOABalanceDetail with  fromTime=" + fromTime , e);
		}
		return oabalanceDetail;
	}
	
	public static Map<String,Object> getGoldDetail(String itemName,Date fromTime){
		java.util.Map<String, Object> goldDetail = new java.util.HashMap<String, Object>();
		try {
			Object[] dbArgs = new Object[] {itemName,fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from selling_gold where iname=? and gtime=?",
							dbArgs);
			if(rs.next()) {
				goldDetail.put("iname", rs.getString("iname"));
				goldDetail.put("amount",rs.getInt("amount"));
				goldDetail.put("totalUser", rs.getInt("totalUser"));
				goldDetail.put("maxUser",rs.getInt("maxUser"));
				goldDetail.put("minUser",rs.getInt("minUser"));
				goldDetail.put("gtime",rs.getDate("gtime"));
			}
		} catch (Exception e) {
			logger.error("getGoldDetail with  fromTime=" + fromTime , e);
		}
		return goldDetail;
	}
	
	public static Map<String,Object> getUsingDetail(String itemName,Date fromTime,String type){
		java.util.Map<String, Object> usingDetail = new java.util.HashMap<String, Object>();
		try {
			Object[] dbArgs = new Object[] {itemName,fromTime,type};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from using where iname=? and utime=? and type=?",
							dbArgs);
			if(rs.next()) {
				usingDetail.put("iname", rs.getString("iname"));
				usingDetail.put("amount",rs.getInt("amount"));
				usingDetail.put("totalUser", rs.getInt("totalUser"));
				usingDetail.put("maxUser",rs.getInt("maxUser"));
				usingDetail.put("minUser",rs.getInt("minUser"));
				usingDetail.put("utime",rs.getDate("utime"));
			}
		} catch (Exception e) {
			logger.error("getUsingDetail with  fromTime=" + fromTime , e);
		}
		
		return usingDetail;
	}

	public static void main(String[] args) {


	}

}
