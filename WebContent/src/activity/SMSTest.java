package activity;

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

public class SMSTest {

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
	
	public static DBResultSet getTestResult(){
		DBResultSet rs = null;
		try {

			Object[] dbArgs = new Object[] {};
			rs = dbClient.execSQLQuery(
							"select * from SMSTest",
							dbArgs);
		} catch (Exception e) {
			logger.error("getTestResult" , e);
		}
		return rs;
	}
}
