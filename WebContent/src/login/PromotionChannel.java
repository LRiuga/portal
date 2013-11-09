package login;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class PromotionChannel {

	static Logger logger = Logger.getLogger(PromotionChannel.class);
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
	
	public static ArrayList<String> getItemList(Date date1,Date date2){
		ArrayList<String> al = new ArrayList<String>();
		String item = "";
		try {
			Object[] dbArgs = new Object[] {date1,date2};
			DBResultSet rs = dbClient.execSQLQuery(
							"select distinct channel from promotionchannel where cdate>=? and cdate<=? order by channel",
							dbArgs);
			while(rs.next()) {
				item = rs.getString("channel");
				al.add(item);
			}
		} catch (Exception e) {
			logger.error("getItemList with  date1=" + date1 , e);
		}
		return al;
	}
	
	public static Map<Date,Double> getOneKeyMapCount(Date date1,Date date2,String channel){
		Map<Date,Double> map = new HashMap<Date,Double>();
		Date date = new Date();
		Double amount = 0.0;
		try {
			Object[] dbArgs = new Object[] {date1,date2,channel};
			DBResultSet rs = dbClient.execSQLQuery(
							"select cdate,countC from promotionchannel where cdate>=? and cdate<=? and channel=?",
							dbArgs);
			while(rs.next()) {
				date = rs.getDate("cdate");
				amount = rs.getDouble("countC");
				map.put(date,amount);
			}
		} catch (Exception e) {
			logger.error("getOneKeyMap with  channel=" + channel , e);
		}
		return map;
	}
	
	public static Map<Date,Double> getOneKeyMapUser(Date date1,Date date2,String channel){
		Map<Date,Double> map = new HashMap<Date,Double>();
		Date date = new Date();
		Double amount = 0.0;
		try {
			Object[] dbArgs = new Object[] {date1,date2,channel};
			DBResultSet rs = dbClient.execSQLQuery(
							"select cdate,userC from PromotionChannel where cdate>=? and cdate<=? and channel=?",
							dbArgs);
			while(rs.next()) {
				date = rs.getDate("cdate");
				amount = rs.getDouble("userC");
				map.put(date,amount);
			}
		} catch (Exception e) {
			logger.error("getOneKeyMap with  channel=" + channel , e);
		}
		return map;
	}
	
	public static Map<String,Double> getOneDateMapCount(Date date){
		Map<String,Double> map = new HashMap<String,Double>();
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select channel,countC from PromotionChannel where cdate=?",
							dbArgs);
			while(rs.next()) {
				map.put(rs.getString("channel"),rs.getDouble("countC"));
			}
		} catch (Exception e) {
			logger.error("getOneDateMapCount with date=" + date , e);
		}
		return map;
	}
	
	public static Map<String,Double> getOneDateMapUser(Date date){
		Map<String,Double> map = new HashMap<String,Double>();
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select channel,userC from PromotionChannel where cdate=?",
							dbArgs);
			while(rs.next()) {
				map.put(rs.getString("channel"),rs.getDouble("userC"));
			}
		} catch (Exception e) {
			logger.error("getOneDateMapUser with date=" + date , e);
		}
		return map;
	}
	
	public static void main(String[] args) {
		
	}

}
