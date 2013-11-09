package OAStat;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class DailyReport {
	Connection cn = null;
	CallableStatement cmd = null;
	Statement stmt = null;
	ResultSet rs = null;

	static Logger logger = Logger.getLogger(DailyReport.class);
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
	
	public static double getDAU(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT oavalue FROM kpi WHERE (sdate = ? and oakey='DAU')",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getDAU with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getOA2DAU(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT oavalue FROM newoakpi WHERE (sdate = ? and oakey='loginDAU')",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getDAU with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getMAU(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT oavalue FROM kpi WHERE (sdate = ? and oakey='MAU')",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getDAU with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getTotalDau(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT oavalue FROM kpi WHERE (sdate = ? and oakey='DAU')",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getDAU with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getFisherAmount(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT oavalue FROM kpi WHERE (sdate = ? and oakey='FisherAmount')",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getFisherAmount with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getAvrgUsers(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT oavalue FROM kpi WHERE (sdate = ? and oakey='avrgUsers')",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getAvrgUsers with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getMaxUsers(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT oavalue FROM kpi WHERE (sdate = ? and oakey='maxUsers')",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getMaxUsers with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getAddValue(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT oavalue FROM kpi WHERE (sdate = ? and oakey='TopUpAmount')",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getAddvalue with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getUsersTime(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT oavalue FROM kpi WHERE (sdate = ? and oakey='userTime')",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getMaxUsers with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getNewFisher(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select oavalue from kpi where oakey='newUserDB' and sdate=?",
							dbArgs);
			if(rs.next()) {
				result = rs.getInt("oavalue") ;
			}
		} catch (Exception e) {
			logger.error("getNewFisher with  fromTime=" + date , e);
		}
		return result;
	}
	 
	public static double getDailySelling(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT oavalue FROM kpi WHERE (sdate = ? and oakey='DailySelling')",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getDailySelling with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getAvrgUserARPU(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT oavalue FROM kpi WHERE (sdate = ? and oakey='avrgUserARPU')",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getAvrgUserARPU with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getAddvalueUser(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT oavalue FROM kpi WHERE (sdate = ? and oakey='AddvalueUser')",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getAddvalueUser with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getPaymentUser(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT oavalue FROM kpi WHERE (sdate = ? and oakey='PaymentUser')",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getPaymentUser with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getAllPaymentUser(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT oavalue FROM kpi WHERE (sdate = ? and oakey='AllPayUser')",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getPaymentUser with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getARPU(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT oavalue FROM kpi WHERE (sdate = ? and oakey='ARPU')",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getARPU with  fromTime=" + date , e);
		}
		return result;
	}
	
	public static double getPermeability(Date date){
		double result = 0;
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT oavalue FROM kpi WHERE (sdate = ? and oakey='Permeability')",
							dbArgs);
			if(rs.next()) {
				result = rs.getDouble("oavalue");
			}
		} catch (Exception e) {
			logger.error("getPermeability with  fromTime=" + date , e);
		}
		return result;
	}
	
	
	public static void main(String[] args) {
		

	}

}
