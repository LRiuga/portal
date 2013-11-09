package actionStat;

import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.OAStatistic;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class ActionNewLog {
	static Logger logger = Logger.getLogger(ActionNewLog.class);
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
	
	public static int getActionAmount(String action,Date fromTime){
		int result = 0;
		
		try {

			Object[] dbArgs = new Object[] {action,fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select actionA from newOAUserAction where item=? and atime=?",
							dbArgs);
			if(rs.next()) {
				result = rs.getInt("actionA");
			}
		} catch (Exception e) {
			logger.error("getActionAmount with  fromTime=" + fromTime , e);
		}
		
		return result;
	}
	
	public static int getMaxAmount(String action,Date fromTime){
		int result = 0;
		
		try {

			Object[] dbArgs = new Object[] {action,fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select maxA from newOAUserAction where item=? and atime=?",
							dbArgs);
			if(rs.next()) {
				result = rs.getInt("maxA");
			}
		} catch (Exception e) {
			logger.error("getMaxAmount with  fromTime=" + fromTime , e);
		}
		
		return result;
	}
	
	public static int getMonetidAmount(String action,Date fromTime){
		int result = 0;
		try {
			Object[] dbArgs = new Object[] {action,fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select monetid from newOAUserAction where item=? and atime=?",
							dbArgs);
			if(rs.next()) {
				result = rs.getInt("monetid");
			}
		} catch (Exception e) {
			logger.error("getMonetidAmount with  fromTime=" + fromTime , e);
		}
		
		return result;
	}
	
	public static int getUserAmount(String action,Date fromTime){
		int result = 0;
		
		try {

			Object[] dbArgs = new Object[] {action,fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select userA from newOAUserAction where item=? and atime=?",
							dbArgs);
			if(rs.next()) {
				result = rs.getInt("userA");
			}
		} catch (Exception e) {
			logger.error("getUserAmount with  fromTime=" + fromTime , e);
		}
		
		return result;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
