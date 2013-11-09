package actionStat;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.OAStatistic;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class actionActive {
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
	
	public static int getActionAmount(String action,Date fromTime){
		int result = 0;
		
		try {

			Object[] dbArgs = new Object[] {action,fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select actionA from userAction where item=? and atime=?",
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
							"select maxA from userAction where item=? and atime=?",
							dbArgs);
			if(rs.next()) {
				result = rs.getInt("maxA");
			}
		} catch (Exception e) {
			logger.error("getMaxAmount with  fromTime=" + fromTime , e);
		}
		
		return result;
	}
	
	public static String getMonetidAmount(String action,Date fromTime){
		String result = "";
		
		try {

			Object[] dbArgs = new Object[] {action,fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select monetid from userAction where item=? and atime=?",
							dbArgs);
			if(rs.next()) {
				result = rs.getString("monetid");
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
							"select userA from userAction where item=? and atime=?",
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
		Date fTime = new Date();
		Date tTime = new Date();
		Calendar fromWhen = Calendar.getInstance();
		fromWhen.setTime(fTime);
		GregorianCalendar gc = new GregorianCalendar(fromWhen
				.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
				.get(Calendar.DAY_OF_MONTH));
		gc.add(Calendar.DATE, -1);
		fTime = (Date) gc.getTime();
		
		System.out.println(getActionAmount("start_fishing",fTime));
		System.out.println(getUserAmount("start_fishing",fTime));
	}

}
