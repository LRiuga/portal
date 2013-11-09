package tribeStats;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.OAStatistic;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class AttackMonsterHour {
	Connection cn = null;
	CallableStatement cmd = null;
	Statement stmt = null;
	ResultSet rs = null;
	static Logger logger = Logger.getLogger(AttackMonsterHour.class);
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
	
	public static ArrayList<Integer> getList(Date fromTime){
		ArrayList<Integer> result = new ArrayList<Integer>();
		try {
			Object[] dbArgs = new Object[] {fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select amount,users,reward from attackmonster where atime=? order by id",
							dbArgs);
			while(rs.next()) {
				result.add(rs.getInt("amount"));
				result.add(rs.getInt("users"));
				result.add(rs.getInt("reward"));
			}
		} catch (Exception e) {
			logger.error("getList with  fromTime=" + fromTime , e);
		}
		return result;
	}
	
}
