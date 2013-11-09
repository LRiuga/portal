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

public class Upgrade {
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
	
	public static Map<String,Integer> getUpgrade(Date fromTime){
		Map<String,Integer> map = new HashMap<String,Integer>();
		try {

			Object[] dbArgs = new Object[] {fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from activity_upgrade where atime=?",
							dbArgs);
			if(rs.next()) {
				map.put("famount",rs.getInt("famount"));
				map.put("fusers",rs.getInt("fusers") );
				map.put("fmax",rs.getInt("fmax"));
				map.put("gamount",rs.getInt("gamount"));
				map.put("gusers",rs.getInt("gusers") );
				map.put("gmax",rs.getInt("gmax") );
			}
		} catch (Exception e) {
			logger.error("getActionAmount with  fromTime=" + fromTime , e);
		}
		
		return map;
	}
}
