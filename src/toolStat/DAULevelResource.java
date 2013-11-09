package toolStat;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.OAStatistic;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class DAULevelResource {
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
	
	public static Map<Integer,Long> getAmountMap(String resource,String type,Date date){
		Map<Integer,Long> map = new HashMap<Integer,Long>();
		try {
			Object[] dbArgs = new Object[] {resource,type,date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select level,amount from daulevelresource where resource=? and type=? and stime=? and action='in'",
							dbArgs);
			while(rs.next()){
				int level = rs.getInt("level");
				long amount = rs.getLong("amount");
				map.put(level,amount);
			}
		} catch (Exception e) {
			logger.error("getAmountMap with resource=" + resource , e);
		}
		return map;
	}
	
	public static Map<Integer,Double> getAverageMap(String resource,String type,Date date){
		Map<Integer,Double> map = new HashMap<Integer,Double>();
		try {
			Object[] dbArgs = new Object[] {resource,type,date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select level,averageS from daulevelresource where resource=? and type=? and stime=?  and action='in'",
							dbArgs);
			while(rs.next()){
				int level = rs.getInt("level");
				double averageS = rs.getDouble("averageS");
				map.put(level,averageS);
			}
		} catch (Exception e) {
			logger.error("getAverageMap with resource=" + resource , e);
		}
		return map;
	}
	
	public static Map<Integer,Long> getMaxMap(String resource,String type,Date date){
		Map<Integer,Long> map = new HashMap<Integer,Long>();
		try {
			Object[] dbArgs = new Object[] {resource,type,date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select level,maxS from daulevelresource where resource=? and type=? and stime=? and action='in'",
							dbArgs);
			while(rs.next()){
				int level = rs.getInt("level");
				long amount = rs.getLong("maxS");
				map.put(level,amount);
			}
		} catch (Exception e) {
			logger.error("getMaxMap with resource=" + resource , e);
		}
		return map;
	}
	
	public static Map<Integer,Integer> getUsersMap(String resource,String type,Date date){
		Map<Integer,Integer> map = new HashMap<Integer,Integer>();
		try {
			Object[] dbArgs = new Object[] {resource,type,date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select level,users from daulevelresource where resource=? and type=? and stime=? and action='in'",
							dbArgs);
			while(rs.next()){
				int level = rs.getInt("level");
				int amount = rs.getInt("users");
				map.put(level,amount);
			}
		} catch (Exception e) {
			logger.error("getUsersMap with resource=" + resource , e);
		}
		return map;
	}
	
	public static Map<Integer,Long> getMidMap(String resource,String type,Date date){
		Map<Integer,Long> map = new HashMap<Integer,Long>();
		try {
			Object[] dbArgs = new Object[] {resource,type,date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select level,midS from daulevelresource where resource=? and type=? and stime=? and action='in'",
							dbArgs);
			while(rs.next()){
				int level = rs.getInt("level");
				long amount = rs.getLong("midS");
				map.put(level,amount);
			}
		} catch (Exception e) {
			logger.error("getMidMap with resource=" + resource , e);
		}
		return map;
	}
	
	public static Map<Integer,Long> getMinMap(String resource,String type,Date date){
		Map<Integer,Long> map = new HashMap<Integer,Long>();
		try {
			Object[] dbArgs = new Object[] {resource,type,date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select level,minS from daulevelresource where resource=? and type=? and stime=? and action='in'",
							dbArgs);
			while(rs.next()){
				int level = rs.getInt("level");
				long amount = rs.getLong("minS");
				map.put(level,amount);
			}
		} catch (Exception e) {
			logger.error("getMinMap with resource=" + resource , e);
		}
		return map;
	}
	
	public static List<ArrayList<String>> getAll(String resource,String type,String bdate,String edate){
		List<ArrayList<String>> resuList = new ArrayList<ArrayList<String>>();
		try {
			Object[] dbArgs = new Object[] {resource,type,bdate,edate};
			DBResultSet rs = dbClient.execSQLQuery(
							"select amount,users,averageS,maxS,midS,minS,stime from daulevelresource where resource=? and type=? and stime >= ? and stime <= ? and action='in' and level = 0 order by stime desc",
							dbArgs);
			while(rs.next()){
				ArrayList<String> sList = new ArrayList<String>();
				sList.add(rs.getDate("stime").toString());
				sList.add(rs.getLong("amount").toString());
				sList.add(rs.getLong("users").toString());
				sList.add(rs.getInt("averageS").toString());
				sList.add(rs.getInt("maxS").toString());
				sList.add(rs.getInt("midS").toString());
				sList.add(rs.getInt("minS").toString());
				resuList.add(sList);
				
			}
		} catch (Exception e) {
			logger.error("getall with resource=" + resource , e);
		}
		return resuList;
	}
}
