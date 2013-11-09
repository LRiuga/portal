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

public class DownloadStats {
	static Logger logger = Logger.getLogger(DownloadStats.class);
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
	
	public static Map<Date,Map<String,Double>> getMap(Date date1,Date date2,String action){
		Map<Date,Map<String,Double>> map = new HashMap<Date,Map<String,Double>>();
		Date date = new Date();
		String item = "";
		Double amount = 0.0;
		try {
			Object[] dbArgs = new Object[] {date1,date2,action};
			DBResultSet rs = dbClient.execSQLQuery(
							"select ddate,item,amount from downloadStats where ddate>=? and ddate<=? and dlkey=?",
							dbArgs);
			while(rs.next()) {
				date = rs.getDate("ddate");
				item = rs.getString("item");
				amount = rs.getDouble("amount");
				
				if(map.containsKey(date)){
					Map<String,Double> tempMap = map.get(date);
					tempMap.put(item, amount);
					map.put(date, tempMap);
				}else{
					Map<String,Double> tempMap = new HashMap<String,Double>();
					tempMap.put(item, amount);
					map.put(date, tempMap);
				}
			}
		} catch (Exception e) {
			logger.error("getMap with  action=" + action , e);
		}
		return map;
	}
	
	public static Map<Date,Double> getOneKeyMap(Date date1,Date date2,String action,String item){
		Map<Date,Double> map = new HashMap<Date,Double>();
		Date date = new Date();
		Double amount = 0.0;
		try {
			Object[] dbArgs = new Object[] {date1,date2,action,item};
			DBResultSet rs = dbClient.execSQLQuery(
							"select ddate,amount from downloadStats where ddate>=? and ddate<=? and dlkey=? and item=?",
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
	
	public static Map<String,Double> getOneDateMap(Date date,String action){
		Map<String,Double> map = new HashMap<String,Double>();
		try {
			Object[] dbArgs = new Object[] {date,action};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item,amount from downloadStats where ddate=? and dlkey=?",
							dbArgs);
			while(rs.next()) {
				map.put(rs.getString("item"),rs.getDouble("amount"));
			}
		} catch (Exception e) {
			logger.error("getOneDateMap with action=" + action , e);
		}
		return map;
	}
	
	
	public static ArrayList<String> getItemList(Date date1,Date date2,String action){
		ArrayList<String> al = new ArrayList<String>();
		String item = "";
		try {
			Object[] dbArgs = new Object[] {date1,date2,action};
			DBResultSet rs = dbClient.execSQLQuery(
							"select distinct item from downloadStats where ddate>=? and ddate<=? and dlkey=? order by item",
							dbArgs);
			while(rs.next()) {
				item = rs.getString("item");
				al.add(item);
			}
		} catch (Exception e) {
			logger.error("getMap with  action=" + action , e);
		}
		return al;
	}
	
	public static ArrayList<String> getItemListOneDate(Date date,String action,int num){
		ArrayList<String> al = new ArrayList<String>();
		String item = "";
		try {
			Object[] dbArgs = new Object[] {date,action};
			DBResultSet rs = dbClient.execSQLQuery(
							"select top "+num+" item,amount from downloadStats where ddate=? and dlkey=? order by amount desc",
							dbArgs);
			while(rs.next()) {
				item = rs.getString("item");
				al.add(item);
			}
		} catch (Exception e) {
			logger.error("getMap with  action=" + action , e);
		}
		return al;
	}
	
	public static ArrayList<String> getItemListOneDateFromDownloadphone(Date date,String action,int num){
		ArrayList<String> al = new ArrayList<String>();
		String item = "";
		try {
			Object[] dbArgs = new Object[] {date,action};
			DBResultSet rs = dbClient.execSQLQuery(
							"select top "+num+" item,amount from downloadphone where ddate=? and dlkey=? order by amount desc",
							dbArgs);
			while(rs.next()) {
				item = rs.getString("item");
				al.add(item);
			}
		} catch (Exception e) {
			logger.error("getMap with  action=" + action , e);
		}
		return al;
	}
	
	public static ArrayList<String> getItemListOneDate(Date date,String action){
		ArrayList<String> al = new ArrayList<String>();
		String item = "";
		try {
			Object[] dbArgs = new Object[] {date,action};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item,amount from downloadStats where ddate=? and dlkey=? order by amount desc",
							dbArgs);
			while(rs.next()) {
				item = rs.getString("item");
				al.add(item);
			}
		} catch (Exception e) {
			logger.error("getMap with  action=" + action , e);
		}
		return al;
	}
	
	public static ArrayList<String> getItemListOneDateFromDownloadphone(Date date,String action){
		ArrayList<String> al = new ArrayList<String>();
		String item = "";
		try {
			Object[] dbArgs = new Object[] {date,action};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item,amount from downloadphone where ddate=? and dlkey=? order by amount desc",
							dbArgs);
			while(rs.next()) {
				item = rs.getString("item");
				al.add(item);
			}
		} catch (Exception e) {
			logger.error("getMap with  action=" + action , e);
		}
		return al;
	}
	
	public static ArrayList<String> getVisitDownloadRateList(Date date,int num){
		ArrayList<String> al = new ArrayList<String>();
		String item = "";
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select top "+num+" a.item,(b.amount/a.amount) as amount from downloadStats a inner join downloadStats b on a.ddate=b.ddate and a.dlkey='Model' and b.dlkey='Brand' and a.item=b.item and a.ddate=? order by amount desc",
							dbArgs);
			while(rs.next()) {
				item = rs.getString("item");
				al.add(item);
			}
		} catch (Exception e) {
			logger.error("getVisitDownloadRate with  date=" + date , e);
		}
		return al;
	}
	
	public static ArrayList<String> getVisitDownloadRateList(Date date){
		ArrayList<String> al = new ArrayList<String>();
		String item = "";
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select a.item,(b.amount/a.amount) as amount from downloadStats a inner join downloadStats b on a.ddate=b.ddate and a.dlkey='Model' and b.dlkey='Brand' and a.item=b.item and a.ddate=? order by amount desc",
							dbArgs);
			while(rs.next()) {
				item = rs.getString("item");
				al.add(item);
			}
		} catch (Exception e) {
			logger.error("getVisitDownloadRate with  date=" + date , e);
		}
		return al;
	}
	
	public static Map<String,Double> getVisitDownloadRateMap(Date date,int num){
		Map<String,Double> map = new HashMap<String,Double>();
		String item = "";
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select top "+num+" a.item,(b.amount/a.amount) as amount from downloadStats a inner join downloadStats b on a.ddate=b.ddate and a.dlkey='Model' and b.dlkey='Brand' and a.item=b.item and a.ddate=? order by amount desc",
							dbArgs);
			while(rs.next()) {
				item = rs.getString("item");
				map.put(item,rs.getDouble("amount"));
			}
		} catch (Exception e) {
			logger.error("getVisitDownloadRateMap with  date=" + date , e);
		}
		return map;
	}
	
	public static Map<String,Double> getItemMapOneDate(Date date,String action,int num){
		Map<String,Double> map = new HashMap<String,Double>();
		String item = "";
		try {
			Object[] dbArgs = new Object[] {date,action};
			DBResultSet rs = dbClient.execSQLQuery(
							"select top "+num+" item,amount from downloadStats where ddate=? and dlkey=? order by amount desc",
							dbArgs);
			while(rs.next()) {
				item = rs.getString("item");
				map.put(item,rs.getDouble("amount"));
			}
		} catch (Exception e) {
			logger.error("getMap with  action=" + action , e);
		}
		return map;
	}
	
	public static Map<String,Double> getItemMapOneDate(Date date,String action){
		Map<String,Double> map = new HashMap<String,Double>();
		String item = "";
		try {
			Object[] dbArgs = new Object[] {date,action};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item,amount from downloadStats where ddate=? and dlkey=? order by amount desc",
							dbArgs);
			while(rs.next()) {
				item = rs.getString("item");
				map.put(item,rs.getDouble("amount"));
			}
		} catch (Exception e) {
			logger.error("getMap with  action=" + action , e);
		}
		return map;
	}
	
	public static Map<String,Double> getItemMapOneDateFromDownloadStatsAmount(Date date,String action){
		Map<String,Double> map = new HashMap<String,Double>();
		String item = "";
		try {
			Object[] dbArgs = new Object[] {date,action};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item,amount from downloadphone where ddate=? and dlkey=? order by amount desc",
							dbArgs);
			while(rs.next()) {
				item = rs.getString("item");
				map.put(item,rs.getDouble("amount"));
			}
		} catch (Exception e) {
			logger.error("getMap with  action=" + action , e);
		}
		return map;
	}
	
	public static Map<String,String> getItemMapOneDateFromDownloadStatsOS(Date date,String action){
		Map<String,String> map = new HashMap<String,String>();
		String item = "";
		try {
			Object[] dbArgs = new Object[] {date,action};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item,os from downloadphone where ddate=? and dlkey=? order by amount desc",
							dbArgs);
			while(rs.next()) {
				item = rs.getString("item");
				map.put(item,rs.getString("os"));
			}
		} catch (Exception e) {
			logger.error("getMap with  action=" + action , e);
		}
		return map;
	}
}
