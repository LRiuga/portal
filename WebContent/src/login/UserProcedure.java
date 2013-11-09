package login;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class UserProcedure {
	static Logger logger = Logger.getLogger(UserProcedure.class);
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
	
	public static double getWebSiteVisit(Date date){
		Double amount = 0.0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select amount from downloadstats where ddate=? and dlkey='kpi' and item='uv'",
							dbArgs);
			while(rs.next()) {
				amount = rs.getDouble("amount");
			}
		} catch (Exception e) {
			logger.error("getWebSiteVisit with  date=" + date , e);
		}
		return amount;
	}
	
	public static double getWebSiteDownload(Date date){
		Double amount = 0.0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select amount from downloadstats where ddate=? and dlkey='kpi' and item='downloaduv'",
							dbArgs);
			while(rs.next()) {
				amount = rs.getDouble("amount");
			}
		} catch (Exception e) {
			logger.error("getWebSiteDownload with  date=" + date , e);
		}
		return amount;
	}
	
	public static double getLoginServerUsers(Date date){
		Double amount = 0.0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select amount from feedbackserver where fbkey='LoginServer' and ddate=?",
							dbArgs);
			while(rs.next()) {
				amount = rs.getDouble("amount");
			}
		} catch (Exception e) {
			logger.error("getLoginServerUsers with  date=" + date , e);
		}
		return amount;
	}
	
	public static double getLoginDAU(Date date){
		Double amount = 0.0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select oavalue from newoakpi where oakey='loginDAU' and sdate=?",
							dbArgs);
			while(rs.next()) {
				amount = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getLoginServerUsers with  date=" + date , e);
		}
		return amount;
	}
	
	public static double getPlayDAU(Date date){
		Double amount = 0.0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select oavalue from newoakpi where oakey='playDAU' and sdate=?",
							dbArgs);
			while(rs.next()) {
				amount = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getLoginServerUsers with  date=" + date , e);
		}
		return amount;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
