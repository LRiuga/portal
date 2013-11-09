package userStats;

import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class NewUserMission {
	static final Logger logger = Logger.getLogger(NewUserMission.class);
	static String dbReadUrls = null;
	static String db086 = null;
	static String dbDriver = null;
	static MoDBRW dbClient = null;
	static MoDBRW dbClient086 = null;
	
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");

			db086 = serverConf.getString("db086");
			dbReadUrls = serverConf.getString("dbReadUrls");
			dbDriver = serverConf.getString("dbDriver");
			
			dbClient = new MoDBRW(dbReadUrls,dbDriver);
			dbClient086 = new MoDBRW(db086,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	public static int getNewUserAmount(Date fTime){
		int result = 0;
		Date tTime = new Date(fTime.getTime()+1000*3600*24);
		DBResultSet rs = null;
		try {
			Object[] dbArgs = new Object[] { fTime,tTime };
			rs = dbClient086.execSQLQuery(
							"select count(*) as amount from fisher where newuserflag>=? and newuserflag<?",
							dbArgs);
			if(rs.next()){
				result = rs.getInt("amount");
			}
		} catch (Exception e) {
			logger.error("getNewUserAmount with fromTime=" + fTime + " toTime=" + tTime, e);
		}
		return result;
	}
	
	public static java.util.Map<Integer,Integer> getNewUserMission(Date fTime,int days,int status){
		java.util.Map<Integer,Integer> map = new java.util.HashMap<Integer,Integer>();
		try {
			Object[] dbArgs = new Object[] { fTime,days,status };
			DBResultSet rs = dbClient.execSQLQuery(
							"select mission,amount from newUserMission where mdate=? and days=? and status=?",
							dbArgs);
			while(rs.next()){
				map.put(rs.getInt("mission"),rs.getInt("amount"));
			}
		} catch (Exception e) {
			logger.error("getNewUserAmount with fromTime=" + fTime , e);
		}
		return map;
	}
}
