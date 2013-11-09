package activity;

import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class SignUp {
	static Logger logger = Logger.getLogger(PhoneTicket.class);
	static String dbDriver = null;
	static String dbWriteUrla = null;
	static MoDBRW dbClient081 = null;
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");
			dbWriteUrla = serverConf.getString("dbWriteUrla");
			dbDriver = serverConf.getString("dbDriver");

			dbClient081 = new MoDBRW(dbWriteUrla,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	public static int getTotalAmount(Date date1,Date date2){
		try {
			Object[] dbArgs = new Object[] {date1,date2};
			DBResultSet rs = dbClient081.execSQLQuery(
							"select count(*) as amount from applicant where applydate>=? and applydate<?",
							dbArgs);
			if(rs.next()){
				return (rs.getInt("amount"));
			}
		} catch (Exception e) {
			logger.error("getTotalAmount");
		}
		return -1;
	}
	
	public static int getTotalSuccessAmount(Date date1,Date date2){
		try {
			Object[] dbArgs = new Object[] {date1,date2};
			DBResultSet rs = dbClient081.execSQLQuery(
							"select count(*) as amount from applicant where applydate>=? and applydate<? and status=1",
							dbArgs);
			if(rs.next()){
				return (rs.getInt("amount"));
			}
		} catch (Exception e) {
			logger.error("getTotalSuccessAmount");
		}
		return -1;
	}
	
	public static int getTotalUser(Date date1,Date date2){
		try {
			Object[] dbArgs = new Object[] {date1,date2};
			DBResultSet rs = dbClient081.execSQLQuery(
							"select count(distinct monetid) as amount from applicant where applydate>=? and applydate<?",
							dbArgs);
			if(rs.next()){
				return (rs.getInt("amount"));
			}
		} catch (Exception e) {
			logger.error("getTotalUser");
		}
		return -1;
	}
	
	public static int getTotalSuccessUser(Date date1,Date date2){
		try {
			Object[] dbArgs = new Object[] {date1,date2};
			DBResultSet rs = dbClient081.execSQLQuery(
							"select count(distinct monetid) as amount from applicant where applydate>=? and applydate<? and status=1",
							dbArgs);
			if(rs.next()){
				return (rs.getInt("amount"));
			}
		} catch (Exception e) {
			logger.error("getTotalSuccessUser");
		}
		return -1;
	}
}
