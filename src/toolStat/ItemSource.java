package toolStat;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class ItemSource {
	Connection cn = null;
	CallableStatement cmd = null;
	Statement stmt = null;
	ResultSet rs = null;

	static Logger logger = Logger.getLogger(ItemSource.class);
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
	
	public static Map<String,Map<String,Integer>> getItemSourceMap(Date date,String type){
		Map<String,Map<String,Integer>> itemSource = new HashMap<String,Map<String,Integer>>();
		try {
			Object[] dbArgs = new Object[] {date,type};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item,gettype,amount from itemSource where fdate=? and itemType=?",
							dbArgs);
			while(rs.next()) {
				String item = rs.getString("item");
				String gettype = rs.getString("gettype");
				int amount = rs.getInt("amount");
				
				if(itemSource.containsKey(item)){
					Map<String,Integer> sourceMap = itemSource.get(item);
					sourceMap.put(gettype, amount);
					itemSource.put(item, sourceMap);
				}else{
					Map<String,Integer> sourceMap = new HashMap<String,Integer>();
					sourceMap.put(gettype, amount);
					itemSource.put(item, sourceMap);
				}
			}
		} catch (Exception e) {
			logger.error("getItemSourceMap with  date=" + date , e);
		}
		
		return itemSource;
	}
	
	public static ArrayList<String> getItemList(Date date1,Date date2,String item){
		ArrayList<String> al = new ArrayList<String>();
		try {
			Object[] dbArgs = new Object[] {date1,date2,item};
			DBResultSet rs = dbClient.execSQLQuery(
							"select distinct gettype from itemSource where fdate>=? and fdate<=? and item=? order by gettype",
							dbArgs);
			while(rs.next()) {
				al.add(rs.getString("gettype"));
			}
		} catch (Exception e) {
			logger.error("getMap with  item=" + item , e);
		}
		return al;
	}
	
	public static ArrayList<String> getItemList(Date date1,Date date2){
		ArrayList<String> al = new ArrayList<String>();
		try {
			Object[] dbArgs = new Object[] {date1,date2};
			DBResultSet rs = dbClient.execSQLQuery(
							"select distinct item from itemSource where fdate>=? and fdate<=? order by item",
							dbArgs);
			while(rs.next()) {
				al.add(rs.getString("item"));
			}
		} catch (Exception e) {
			logger.error("getMap with date1=" + date1 , e);
		}
		return al;
	}
	
	public static Map<String,Integer> getItemMap(Date date){
		Map<String,Integer> map = new HashMap<String,Integer>();
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item,sum(amount) as amount from itemsource where fdate=? group by item",
							dbArgs);
			while(rs.next()) {
				map.put(rs.getString("item"),rs.getInt("amount"));
			}
		} catch (Exception e) {
			logger.error("getMap with  date=" + date , e);
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
							"select fdate,amount from itemSource where fdate>=? and fdate<=? and item=? and gettype=?",
							dbArgs);
			while(rs.next()) {
				date = rs.getDate("fdate");
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
							"select gettype,amount from itemSource where fdate=? and item=?",
							dbArgs);
			while(rs.next()) {
				map.put(rs.getString("gettype"),rs.getDouble("amount"));
			}
		} catch (Exception e) {
			logger.error("getOneDateMap with action=" + action , e);
		}
		return map;
	}
	
	public static List<String> getItemNameList(Date date,String type){
		List<String> list = new ArrayList<String>();
		try {
			Object[] dbArgs = new Object[] {date,type};
			DBResultSet rs = dbClient.execSQLQuery(
							"select distinct item from itemSource where fdate=? and itemType=?",
							dbArgs);
			while(rs.next()) {
				String item = rs.getString("item");
				list.add(item);
			}
		} catch (Exception e) {
			logger.error("getItemNameList with  date=" + date , e);
		}
		return list;
	}
	
	public static Map<String,Integer> getItemTotalMap(Date date,String type){
		Map<String,Integer> map = new HashMap<String,Integer>();
		try {
			Object[] dbArgs = new Object[] {date,type};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item,sum(amount) as amount from itemSource where fdate=? and itemType=? group by item",
							dbArgs);
			while(rs.next()) {
				String item = rs.getString("item");
				int amount = rs.getInt("amount");
				map.put(item, amount);
			}
		} catch (Exception e) {
			logger.error("getItemTotalMap with  date=" + date , e);
		}
		return map;
	}
	
	public static Map<String,Integer> getItemFreeMap(Date date,String type){
		Map<String,Integer> map = new HashMap<String,Integer>();
		try {
			Object[] dbArgs = new Object[] {date,type};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item,sum(amount) as amount from itemSource where fdate=? and itemType=? and (gettype<>'credit' and gettype<>'gold') group by item",
							dbArgs);
			while(rs.next()) {
				String item = rs.getString("item");
				int amount = rs.getInt("amount");
				map.put(item, amount);
			}
		} catch (Exception e) {
			logger.error("getItemFreeMap with  date=" + date , e);
		}
		return map;
	}
	
	public static Map<String,Integer> getItemCreditMap(Date date,String type){
		Map<String,Integer> map = new HashMap<String,Integer>();
		try {
			Object[] dbArgs = new Object[] {date,type};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item,sum(amount) as amount from itemSource where fdate=? and itemType=? and (gettype='credit') group by item",
							dbArgs);
			while(rs.next()) {
				String item = rs.getString("item");
				int amount = rs.getInt("amount");
				map.put(item, amount);
			}
		} catch (Exception e) {
			logger.error("getItemCteditMap with  date=" + date , e);
		}
		return map;
	}
	
	public static Map<String,Integer> getItemGoldMap(Date date,String type){
		Map<String,Integer> map = new HashMap<String,Integer>();
		try {
			Object[] dbArgs = new Object[] {date,type};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item,sum(amount) as amount from itemSource where fdate=? and itemType=? and (gettype='Gold') group by item",
							dbArgs);
			while(rs.next()) {
				String item = rs.getString("item");
				int amount = rs.getInt("amount");
				map.put(item, amount);
			}
		} catch (Exception e) {
			logger.error("getItemGoldMap with  date=" + date , e);
		}
		return map;
	}
	
	public static List<String> getSourceList(Date date,String type){
		List<String> list = new ArrayList<String>();
		try {
			Object[] dbArgs = new Object[] {date,type};
			DBResultSet rs = dbClient.execSQLQuery(
							"select distinct gettype from itemSource where fdate=? and itemType=?",
							dbArgs);
			while(rs.next()) {
				String gettype = rs.getString("gettype");
				list.add(gettype);
			}
		} catch (Exception e) {
			logger.error("getSourceList with  date=" + date , e);
		}
		return list;
	}
	
	public static String Output(double percent){
		DecimalFormat df = new DecimalFormat("#.00");
		if(percent>=0.5){
			return "<font color=\"#FF0000\">"+df.format(percent)+"</font>";
		}else{
			return df.format(percent);
		}
	}
}
