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

public class NewOAUsing {
	static Logger logger = Logger.getLogger(NewOAUsing.class);
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
	
	
	public static Map<Date,Integer> getDailyUsingMap(Date date1,Date date2){
		Map<Date,Integer> map = new HashMap<Date,Integer>();
		Date date = new Date();
		int amount = 0;
		try {
			Object[] dbArgs = new Object[] {date1,date2};
			DBResultSet rs = dbClient.execSQLQuery(
							"select utime,sum(amount) as amount from newOAUsing where utime>=? and utime<=? group by utime",
							dbArgs);
			while(rs.next()) {
				date = rs.getDate("utime");
				amount = rs.getInt("amount");
				map.put(date,amount);
			}
		} catch (Exception e) {
			logger.error("getDailySellingMap with  date1=" + date1 , e);
		}
		return map;
	}
	
	public static ArrayList<String> getItemList(Date date1,Date date2){
		ArrayList<String> itemList = new ArrayList<String>();
		String iname = "";
		try {
			Object[] dbArgs = new Object[] {date1,date2};
			DBResultSet rs = dbClient.execSQLQuery(
							"select distinct iname from newOAUsing where utime>=? and utime<=? order by iname",
							dbArgs);
			while(rs.next()) {
				itemList.add(rs.getString("iname"));
			}
		} catch (Exception e) {
			logger.error("getItemList with  date1=" + date1 , e);
		}
		return itemList;
	}
	
	public static Map<String,Integer> getOneDateMap(Date date){
		Map<String,Integer> map = new HashMap<String,Integer>();
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select iname,amount from newOAUsing where utime=?",
							dbArgs);
			while(rs.next()) {
				map.put(rs.getString("iname"),rs.getInt("amount"));
			}
		} catch (Exception e) {
			logger.error("getOneDateMap with date=" + date , e);
		}
		return map;
	}
}
