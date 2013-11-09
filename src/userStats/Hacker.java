package userStats;

import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import toolStat.CurrentSelling;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class Hacker {

	static Logger logger = Logger.getLogger(CurrentSelling.class);
	static String db086 = null;
	static String dbDriver = null;
	static MoDBRW dbClient = null;
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");

			db086 = serverConf.getString("db086");
			dbDriver = serverConf.getString("dbDriver");

			dbClient = new MoDBRW(db086,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	static public ArrayList<String> getHackerMonetidList(Date fromTime) {
		ArrayList<String> msgs = new ArrayList<String>();
		try {
			Date toTime = new Date(fromTime.getTime()+1000*60*60*24);
			Object[] dbArgs = new Object[] {fromTime, toTime };
			DBResultSet rs = dbClient.execSQLQuery(
							"select monetid from user_event where msg like 'hacker loading fisher%' and server_date>=? and server_date<? order by server_date desc",
							dbArgs);
			while(rs.next()){
				msgs.add(rs.getInt("monetid").toString());
			}
		} catch (Exception e) {
			logger.error("getHackerMonetidList with fromTime=" + fromTime, e);
		}

		return msgs;
	}
	
	static public ArrayList<Date> getHackerDateList(Date fromTime) {
		ArrayList<Date> dates = new ArrayList<Date>();
		try {
			Date toTime = new Date(fromTime.getTime()+1000*60*60*24);	
			Object[] dbArgs = new Object[] {fromTime, toTime };
			DBResultSet rs = dbClient.execSQLQuery(
							"select server_date from user_event where msg like 'hacker loading fisher%' and server_date>=? and server_date<? order by server_date desc",
							dbArgs);
			while(rs.next()){
				dates.add(rs.getDate("server_date"));
			}
		} catch (Exception e) {
			logger.error("getHackerDateList with fromTime=" + fromTime, e);
		}

		return dates;
	}
	
	static public int getHackerAmount(Date fromTime,Date toTime) {
		int amount = 0;
		try {
			
			Object[] dbArgs = new Object[] {fromTime, toTime };
			DBResultSet rs = dbClient.execSQLQuery(
							"select count(distinct monetid) as amount from user_event where msg like 'hacker loading fisher%' and server_date>=? and server_date<?",
							dbArgs);
			while(rs.next()){
				amount = rs.getInt("amount");
			}
		} catch (Exception e) {
			logger.error("getHackerAmount with fromTime=" + fromTime + " toTime=" + toTime, e);
		}

		return amount;
	}
	
}
