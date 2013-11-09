package userStats;

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

public class NewUserGuide {
	static final Logger logger = Logger.getLogger(MPModel.class);
	static String dbReadUrls = null;
	static String db086 = null;
	static String dbConfig = null;
	static String dbDriver = null;
	static MoDBRW dbClient = null;
	static MoDBRW dbClientConfig = null;
	static MoDBRW dbClient086 = null;
	
	
	
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");

			db086 = serverConf.getString("db086");
			dbConfig = serverConf.getString("dbConfig");
			dbReadUrls = serverConf.getString("dbReadUrls");
			System.out.println(dbReadUrls);
			dbDriver = serverConf.getString("dbDriver");
			
			dbClient = new MoDBRW(dbReadUrls,dbDriver);
			dbClient086 = new MoDBRW(db086,dbDriver);
			dbClientConfig = new MoDBRW(dbConfig,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	static public java.util.Map<Integer, Integer> getNewUserGuide(){
		java.util.Map<Integer, Integer> map = new java.util.HashMap<Integer, Integer>();
		DBResultSet rs = null;
		try {
			String sql = "select id,next from guide where id<1000";
			Object[] dbArgs = new Object[] {};
			rs = dbClient086.execSQLQuery(sql,dbArgs); 
			while(rs.next()){
				map.put(rs.getInt("id"),rs.getInt("next"));
			}
		} catch (Exception e) {
			logger.error("getNewUserGuide ", e);
		}
		return map;
	}
	
	static public Map<Date,Double> getDownloadUV(Date date1,Date date2){
		java.util.Map<Date, Double> map = new java.util.HashMap<Date, Double>();
		DBResultSet rs = null;
		try {
			String sql = "select ddate,amount from downloadstats where ddate>=? and ddate<=? and item='downloadUV'";
			Object[] dbArgs = new Object[] {date1,date2};
			rs = dbClient.execSQLQuery(sql,dbArgs); 
			while(rs.next()){
				map.put(rs.getDate("ddate"),rs.getDouble("amount"));
			}
		} catch (Exception e) {
			logger.error("getDownloadUV ", e);
		}
		return map;
	}
	
	public static List<Integer> getStep(){
		List<Integer> steplist = new ArrayList();
		try {
			DBResultSet rs = dbClientConfig.execSQLQuery("select id,next,type from guide where id < 1000",new Object[]{});
			int start = -1;
			while(rs.next()){
				int type = rs.getInt("type");
				if(type == 1) {
					start = rs.getInt("id");
					break;
				}
			}
			rs.reset();

			Map <Integer,Integer> tempMap  = new HashMap<Integer,Integer>();
			while(rs.next()){
				tempMap.put(rs.getInt("id"),rs.getInt("next"));
			}

			int next = tempMap.get(new Integer(start));
			steplist.add(start);

			while( tempMap.get(new Integer(next))!=0){
				steplist.add(next);
				next = tempMap.get(new Integer(next));
			}
			steplist.add(next);
			for(int step:steplist){
				System.out.println(step);
			}
		} catch (Exception e) {
			logger.error("getStep" , e);
		}
		return steplist;
	}

	static public Map<Date,Map<Integer, Integer>> getGuideCount(Date date1,Date date2){
		Map<Date,Map<Integer, Integer>> map = new java.util.HashMap<Date,Map<Integer,Integer>>();
		DBResultSet rs = null;
		try {
			String sql = "select gdate,guide,amount from newuserguide where gdate>=? and gdate<=?";
			Object[] dbArgs = new Object[] {date1,date2};
			rs = dbClient.execSQLQuery(sql,dbArgs); 
			while(rs.next()){
				Date date = rs.getDate("gdate");
				if(map.containsKey(date)){
					Map<Integer,Integer> guideMap = map.get(date);
					guideMap.put(rs.getInt("guide"),rs.getInt("amount"));
					map.put(date,guideMap);
					System.out.println(date+"!!!"+rs.getInt("guide")+"!!!"+rs.getInt("amount"));
				}else{
					Map<Integer,Integer> guideMap = new HashMap<Integer,Integer>();
					guideMap.put(rs.getInt("guide"),rs.getInt("amount"));
					map.put(date,guideMap);
					System.out.println(date+"!!!"+rs.getInt("guide")+"!!!"+rs.getInt("amount"));
				}
			}
		} catch (Exception e) {
			logger.error("getGuideCount ", e);
		}
		return map;
	}
	public static void main(String[] args) {
		

	}

}
