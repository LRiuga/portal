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

public class FeedbackStats {
	static Logger logger = Logger.getLogger(FeedbackStats.class);
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
	
	public static ArrayList<String> getItemList(Date date1,Date date2,String fbkey,String classes){
		ArrayList<String> al = new ArrayList<String>();
		String item = "";
		try {
			Object[] dbArgs = new Object[] {date1,date2,fbkey,classes};
			DBResultSet rs = dbClient.execSQLQuery(
							"select distinct item from feedbackServer where ddate>=? and ddate<=? and fbkey=? and class=? order by item",
							dbArgs);
			while(rs.next()) {
				item = rs.getString("item");
				al.add(item);
			}
		} catch (Exception e) {
			logger.error("getMap with  fbkey=" + fbkey , e);
		}
		return al;
	}
	
	public static Map<String,Double> getOneDateMap(Date date,String action,String classes){
		Map<String,Double> map = new HashMap<String,Double>();
		try {
			Object[] dbArgs = new Object[] {date,action,classes};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item,amount from feedbackserver where ddate=? and fbkey=? and class=?",
							dbArgs);
			while(rs.next()) {
				map.put(rs.getString("item"),rs.getDouble("amount"));
			}
		} catch (Exception e) {
			logger.error("getOneDateMap with action=" + action , e);
		}
		return map;
	}
	
	public static Map<Date,Double> getOneKeyMap(Date date1,Date date2,String action,String classes,String item){
		Map<Date,Double> map = new HashMap<Date,Double>();
		Date date = new Date();
		Double amount = 0.0;
		try {
			Object[] dbArgs = new Object[] {date1,date2,action,classes,item};
			DBResultSet rs = dbClient.execSQLQuery(
							"select ddate,amount from feedbackServer where ddate>=? and ddate<=? and fbkey=?  and class=? and item=?",
							dbArgs);
			while(rs.next()) {
				date = rs.getDate("ddate");
				amount = rs.getDouble("amount");
				map.put(date,amount);
			}
		} catch (Exception e) {
			logger.error("getOneKeyMap with  action=" + action , e);
		}
		return map;
	}
	
	public static ArrayList<String> getItemListOneDate(Date date,String action,int num){
		ArrayList<String> al = new ArrayList<String>();
		String item = "";
		try {
			Object[] dbArgs = new Object[] {date,action};
			DBResultSet rs = dbClient.execSQLQuery(
							"select top "+num+" class from feedbackServer where ddate=? and fbkey=? and item='Ave' order by amount desc",
							dbArgs);
			while(rs.next()) {
				item = rs.getString("class");
				al.add(item);
			}
		} catch (Exception e) {
			logger.error("getMap with  action=" + action , e);
		}
		return al;
	}
	
	public static Map<String,Double> getItemMapOneDate(Date date,String action,int num){
		Map<String,Double> map = new HashMap<String,Double>();
		String item = "";
		try {
			Object[] dbArgs = new Object[] {date,action};
			DBResultSet rs = dbClient.execSQLQuery(
							"select top "+num+" class,amount from feedbackServer where ddate=? and fbkey=? and item='Ave' order by amount desc",
							dbArgs);
			while(rs.next()) {
				item = rs.getString("class");
				map.put(item,rs.getDouble("amount"));
			}
		} catch (Exception e) {
			logger.error("getMap with  action=" + action , e);
		}
		return map;
	}

	public static ArrayList<String> getItemListOneDate(Date date,String action){
		ArrayList<String> al = new ArrayList<String>();
		String item = "";
		try {
			Object[] dbArgs = new Object[] {date,action};
			DBResultSet rs = dbClient.execSQLQuery(
							"select class from feedbackServer where ddate=? and fbkey=? and item='Ave' order by amount desc",
							dbArgs);
			while(rs.next()) {
				item = rs.getString("class");
				al.add(item);
			}
		} catch (Exception e) {
			logger.error("getMap with  action=" + action , e);
		}
		return al;
	}
	
	public static Map<String,Double> getItemMapOneDate(Date date,String action,String item){
		Map<String,Double> map = new HashMap<String,Double>();
		try {
			Object[] dbArgs = new Object[] {date,action,item};
			DBResultSet rs = dbClient.execSQLQuery(
							"select class,amount from feedbackServer where ddate=? and fbkey=? and item=?",
							dbArgs);
			while(rs.next()) {
				map.put(rs.getString("class"),rs.getDouble("amount"));
			}
		} catch (Exception e) {
			logger.error("getMap with  action=" + action , e);
		}
		return map;
	}
}
