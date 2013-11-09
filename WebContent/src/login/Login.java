package login;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.OAStatistic;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class Login {
	String userName = null;
	String password = null;
	
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
	
	public static int getLoginStatus(String userName,String password){
		int limit = -1;
		try {
			Object[] dbArgs = new Object[] {userName,password};
			DBResultSet rs = dbClient.execSQLQuery(
							"select limit from login where userName=? and psw=?",
							dbArgs);
			if(rs.next()) {
				limit = rs.getInt("limit");
			}
		} catch (Exception e) {
			logger.error("isLoginSuccessed with  userName=" + userName , e);
		}
		return limit;
	}
}
