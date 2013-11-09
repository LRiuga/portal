package activity;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.OAStatistic;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class CompetitionTop {
	Connection cn = null;
	CallableStatement cmd = null;
	Statement stmt = null;
	ResultSet rs = null;

	static Logger logger = Logger.getLogger(OAStatistic.class);
	static String dbReadUrls = null;
	static String dbWriteUrla = null;
	static String dbDriver = null;
	static MoDBRW dbClient167 = null;
	static MoDBRW dbClient188 = null;
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");
			dbReadUrls = serverConf.getString("dbReadUrls");
			dbDriver = serverConf.getString("dbDriver");
			dbWriteUrla = serverConf.getString("dbWriteUrla");
			dbDriver = serverConf.getString("dbDriver");

			dbClient188 = new MoDBRW(dbWriteUrla,dbDriver);
			dbClient167 = new MoDBRW(dbReadUrls,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	public static ArrayList<Integer> getTop100Monetid(){
		ArrayList<Integer> list = new ArrayList<Integer>();
		try {
			Object[] dbArgs = new Object[] {};
			DBResultSet rs = dbClient188.execSQLQuery(
							"select top 50 monetid from fisher where competition>0 order by competition desc",
							dbArgs);
			while(rs.next()){
				list.add(rs.getInt("monetid"));
			}
		} catch (Exception e) {
			logger.error("getTop100Monetid");
		}
		return list;
	}
	
	public static Map<Integer,Long> getTop100MonetidPoint(){
		Map<Integer,Long> map = new HashMap<Integer,Long>();
		try {
			Object[] dbArgs = new Object[] {};
			DBResultSet rs = dbClient188.execSQLQuery(
							"select monetid,competition from fisher where competition>0 order by competition desc",
							dbArgs);
			while(rs.next()){
				map.put(rs.getInt("monetid"),rs.getLong("competition"));
			}
		} catch (Exception e) {
			logger.error("getTop100MonetidPoint");
		}
		return map;
	}
	
	public static Map<Integer,Integer> getTop100MonetidAbombUsing(ArrayList<Integer> monetidList){
		Map<Integer,Integer> map = new HashMap<Integer,Integer>();
		StringBuffer ids = new StringBuffer();
		for(int id:monetidList){
			ids.append(id);
			ids.append(",");
		}
		try {
			Object[] dbArgs = new Object[] {};
			DBResultSet rs = dbClient188.execSQLQuery(
							"select monetid,count(*) as amount from user_event where server_date>='2013/2/6 19:00:00' and msg like 'action=attack,actionTo=0,itemId=58%' and monetid in ("+ids.substring(0,ids.length()-1)+") group by monetid",
							dbArgs);
			while(rs.next()){
				map.put(rs.getInt("monetid"),rs.getInt("amount"));
			}
		} catch (Exception e) {
			logger.error("getTop100MonetidAbombUsing");
		}
		return map;
	}
	
	public static Map<Integer,Integer> getTop100MonetidAllUsing(ArrayList<Integer> monetidList){
		Map<Integer,Integer> map = new HashMap<Integer,Integer>();
		StringBuffer ids = new StringBuffer();
		for(int id:monetidList){
			ids.append(id);
			ids.append(",");
		}
		try {
			Object[] dbArgs = new Object[] {};
			DBResultSet rs = dbClient188.execSQLQuery(
							"select monetid,count(*) as amount from user_event where server_date>='2013/2/6 19:00:00' and msg like 'action=attack,actionTo=%,itemId=%' and monetid in ("+ids.substring(0,ids.length()-1)+") group by monetid",
							dbArgs);
			while(rs.next()){
				map.put(rs.getInt("monetid"),rs.getInt("amount"));
			}
		} catch (Exception e) {
			logger.error("getTop100MonetidAbombUsing");
		}
		return map;
	}
	
	public static Map<Integer,Integer> getTop100MonetidWorldMonster(ArrayList<Integer> monetidList){
		Map<Integer,Integer> map = new HashMap<Integer,Integer>();
		StringBuffer ids = new StringBuffer();
		for(int id:monetidList){
			ids.append(id);
			ids.append(",");
		}
		try {
			Object[] dbArgs = new Object[] {};
			DBResultSet rs = dbClient188.execSQLQuery(
							"select monetid,count(*) as amount from user_event where server_date>='2013/2/6 19:00:00' and msg like 'action=attackWorldMonster,actionTo=%,itemId=%' and monetid in ("+ids.substring(0,ids.length()-1)+") group by monetid",
							dbArgs);
			while(rs.next()){
				map.put(rs.getInt("monetid"),rs.getInt("amount"));
			}
		} catch (Exception e) {
			logger.error("getTop100MonetidAbombUsing");
		}
		return map;
	}
}
