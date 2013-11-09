package login;

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

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class WebSiteReport {
	Connection cn = null;
	CallableStatement cmd = null;
	Statement stmt = null;
	ResultSet rs = null;

	static Logger logger = Logger.getLogger(WebSiteReport.class);
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
	
	public static double getDailyValue(Date date,String oakey){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date,oakey};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT oavalue FROM kpi WHERE (sdate = ? and oakey=?)",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getDailyValue with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getLoginServerAmount(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select amount from feedbackserver where fbkey='LoginServer' and ddate=?",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("amount");
			}
		} catch (Exception e) {
			logger.error("getLoginServerAmount with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getDownloadClick(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT amount FROM downloadstats WHERE (ddate = ? and dlkey='KPI' and item='downloadUV')",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("amount");
			}
		} catch (Exception e) {
			logger.error("getDownloadClick with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getLoginServer(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select amount from feedbackserver where fbkey='LoginServer' and ddate=?",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("amount");
			}
		} catch (Exception e) {
			logger.error("getDownloadClick with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static Map<Date,Map<Integer,Double>> getReturnRate(Date date,Date date2,String type){
		try {
			Object[] dbArgs = new Object[] {date,date2,type};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT rTime,dateNum,dateRate FROM newOAReturnRate WHERE (rTime>= ? and rTime<=?) and rateType=?",
							dbArgs);
			Map<Date,Map<Integer,Double>> mapTotal = new  HashMap<Date,Map<Integer,Double>>();
			while(rs.next()) {
				if(mapTotal.containsKey(rs.getDate("rTime"))){
					Map<Integer,Double> dateMap = mapTotal.get(rs.getDate("rTime"));
					dateMap.put(rs.getInt("dateNum"),rs.getDouble("dateRate"));
					mapTotal.put(rs.getDate("rTime"),dateMap);
				}else{
					Map<Integer,Double> dateMap = new HashMap<Integer,Double>();
					dateMap.put(rs.getInt("dateNum"),rs.getDouble("dateRate"));
					mapTotal.put(rs.getDate("rTime"),dateMap);
				}
			}
			return mapTotal;
		} catch (Exception e) {
			logger.error("getDailyValue with  fromTime=" + date , e);
		}
		return null;
	}
}
