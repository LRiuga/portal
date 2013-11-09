package toolStat;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.OAStatistic;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class DefenseSystem {
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
	
	static public ArrayList<Date> getDefenseSystemBTimeList(Date fromTime){
		ArrayList<Date> bTimeList = new ArrayList<Date>();
		try {
			Date toTime = new Date(fromTime.getTime()+1*24*3600*1000);
			Object[] dbArgs = new Object[] {fromTime,toTime};
			
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from defense_system where btime>=? and btime<? and item like 'Defense System%' order by item desc ,btime desc",
							dbArgs);
			while(rs.next()) {
				bTimeList.add(rs.getDate("btime"));
			}
		} catch (Exception e) {

		}
		return bTimeList;
	}
	
	static public ArrayList<String> getDefenseSystemMonetIdList(Date fromTime){
		ArrayList<String> monetidList = new ArrayList<String>();
		try {

			Date toTime = new Date(fromTime.getTime()+1*24*3600*1000);
			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from defense_system where btime>=? and btime<? and item like 'Defense System%' order by item desc ,btime desc",
							dbArgs);
			while(rs.next()) {
				monetidList.add(rs.getString("ownerid"));
			}
		} catch (Exception e) {

		}
		return monetidList;
	}
	
	static public ArrayList<String> getDefenseSystemLevelList(Date fromTime){
		ArrayList<String> levelList = new ArrayList<String>();
		try {

			Date toTime = new Date(fromTime.getTime()+1*24*3600*1000);
			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from defense_system where btime>=? and btime<? and item like 'Defense System%' order by item desc ,btime desc",
							dbArgs);
			while(rs.next()) {
				levelList.add(rs.getString("item"));
			}
		} catch (Exception e) {

		}
		return levelList;
	}
	
	//warehouse
	static public ArrayList<Date> getWarehouseBTimeList(Date fromTime){
		ArrayList<Date> bTimeList = new ArrayList<Date>();
		try {
			Date toTime = new Date(fromTime.getTime()+1*24*3600*1000);
			Object[] dbArgs = new Object[] {fromTime,toTime};
			
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from defense_system where btime>=? and btime<? and item like 'warehouse%' order by item desc ,btime desc",
							dbArgs);
			while(rs.next()) {
				bTimeList.add(rs.getDate("btime"));
			}
		} catch (Exception e) {

		}
		return bTimeList;
	}
	
	static public ArrayList<String> getWarehouseMonetIdList(Date fromTime){
		ArrayList<String> monetidList = new ArrayList<String>();
		try {

			Date toTime = new Date(fromTime.getTime()+1*24*3600*1000);
			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from defense_system where btime>=? and btime<? and item like 'warehouse%' order by item desc ,btime desc",
							dbArgs);
			while(rs.next()) {
				monetidList.add(rs.getString("ownerid"));
			}
		} catch (Exception e) {

		}
		return monetidList;
	}
	
	static public ArrayList<String> getWarehouseLevelList(Date fromTime){
		ArrayList<String> levelList = new ArrayList<String>();
		try {

			Date toTime = new Date(fromTime.getTime()+1*24*3600*1000);
			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from defense_system where btime>=? and btime<? and item like 'warehouse%' order by item desc ,btime desc",
							dbArgs);
			while(rs.next()) {
				levelList.add(rs.getString("item"));
			}
		} catch (Exception e) {

		}
		return levelList;
	}
	
	//rent ship
	static public ArrayList<Date> getRentshipBTimeList(Date fromTime){
		ArrayList<Date> bTimeList = new ArrayList<Date>();
		try {
			Date toTime = new Date(fromTime.getTime()+1*24*3600*1000);
			Object[] dbArgs = new Object[] {fromTime,toTime};
			
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from defense_system where btime>=? and btime<? and item like '%ship%' order by item desc ,btime desc",
							dbArgs);
			while(rs.next()) {
				bTimeList.add(rs.getDate("btime"));
			}
		} catch (Exception e) {

		}
		return bTimeList;
	}
	
	static public ArrayList<String> getRentshipMonetIdList(Date fromTime){
		ArrayList<String> monetidList = new ArrayList<String>();
		try {

			Date toTime = new Date(fromTime.getTime()+1*24*3600*1000);
			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from defense_system where btime>=? and btime<? and item like '%ship%' order by item desc ,btime desc",
							dbArgs);
			while(rs.next()) {
				monetidList.add(rs.getString("ownerid"));
			}
		} catch (Exception e) {

		}
		return monetidList;
	}
	
	static public ArrayList<String> getRentshipLevelList(Date fromTime){
		ArrayList<String> levelList = new ArrayList<String>();
		try {

			Date toTime = new Date(fromTime.getTime()+1*24*3600*1000);
			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from defense_system where btime>=? and btime<? and item like '%ship%' order by item desc ,btime desc",
							dbArgs);
			while(rs.next()) {
				levelList.add(rs.getString("item"));
			}
		} catch (Exception e) {

		}
		return levelList;
	}
}
