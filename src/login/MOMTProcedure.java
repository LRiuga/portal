package login;

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

public class MOMTProcedure {
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
	
	public static int getValue(Date date,String version,String stepName){
		int result = 0;
		try {
			Object[] dbArgs = new Object[] {date,version,stepName};
			DBResultSet rs = dbClient.execSQLQuery(
							"SELECT stepValue FROM newoamomtprocedure WHERE (mdate = ? and version=? and stepName=?)",
							dbArgs);
			if(rs.next()) {
				result = rs.getInt("stepValue");
			}
		} catch (Exception e) {
			logger.error("getValue with  fromTime=" + date , e);
		}
		return result;
	}
}
