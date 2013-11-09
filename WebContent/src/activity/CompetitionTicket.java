package activity;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.OAStatistic;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class CompetitionTicket {
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
	
	public static java.util.Map<Integer,Integer> getTicketAmount(Date date){
		java.util.Map<Integer,Integer> map = new java.util.HashMap<Integer, Integer>(); 
		try {

			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select tickettype,amount from CompetitionTicket where ctime=?",
							dbArgs);
			while(rs.next()){
				map.put(rs.getInt("tickettype"),rs.getInt("amount"));
			}
		} catch (Exception e) {
			logger.error("getTicketAmount" , e);
		}
		return map;
	}
	
	public static java.util.Map<Integer,Integer> getTicketTotal(Date date){
		DBResultSet rs = null;
		java.util.Map<Integer,Integer> map = new java.util.HashMap<Integer, Integer>(); 
		try {

			Object[] dbArgs = new Object[] {date};
			rs = dbClient.execSQLQuery(
							"select tickettype,total from CompetitionTicket where ctime=?",
							dbArgs);
			while(rs.next()){
				map.put(rs.getInt("tickettype"),rs.getInt("total"));
			}
		} catch (Exception e) {
			logger.error("getTicketAmount" , e);
		}
		return map;
	}
}
