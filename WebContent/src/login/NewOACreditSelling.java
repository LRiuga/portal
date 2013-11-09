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

public class NewOACreditSelling {
	static Logger logger = Logger.getLogger(NewOACreditSelling.class);
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
	
	
	public static Map<Date,Double> getDailySellingMap(Date date1,Date date2){
		Map<Date,Double> map = new HashMap<Date,Double>();
		Date date = new Date();
		Double amount = 0.0;
		try {
			Object[] dbArgs = new Object[] {date1,date2};
			DBResultSet rs = dbClient.execSQLQuery(
							"select stime,sum(credit) as amount from newOASelling where stime>=? and stime<=? group by stime",
							dbArgs);
			while(rs.next()) {
				date = rs.getDate("stime");
				amount = rs.getDouble("amount");
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
							"select distinct iname from newOASelling where stime>=? and stime<=? order by iname",
							dbArgs);
			while(rs.next()) {
				itemList.add(rs.getString("iname"));
			}
		} catch (Exception e) {
			logger.error("getDailySellingMap with  date1=" + date1 , e);
		}
		return itemList;
	}
	
	public static Map<String,Integer> getOneDateMap(Date date){
		Map<String,Integer> map = new HashMap<String,Integer>();
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select iname,amount from newOASelling where stime=?",
							dbArgs);
			while(rs.next()) {
				map.put(rs.getString("iname"),rs.getInt("amount"));
			}
		} catch (Exception e) {
			logger.error("getOneDateMap with date=" + date , e);
		}
		return map;
	}
	
	public static Map<String,Double> getOneDateSellingMap(Date date){
		Map<String,Double> map = new HashMap<String,Double>();
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select iname,credit from newOASelling where stime=?",
							dbArgs);
			while(rs.next()) {
				map.put(rs.getString("iname"),rs.getDouble("credit"));
			}
		} catch (Exception e) {
			logger.error("getOneDateSellingMap with date=" + date , e);
		}
		return map;
	}
}
