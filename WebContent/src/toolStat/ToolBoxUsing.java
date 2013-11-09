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

public class ToolBoxUsing {
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
	
	static public ArrayList<Integer> getToolBoxUsingList(String item,Date fromTime){
		int result = 0;
		ArrayList<Integer> ar = new ArrayList<Integer>();
		try {

			Object[] dbArgs = new Object[] {fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select "+ item +" from use_toolbox where ddate=?",
							dbArgs);
			while(rs.next()) {
				result = rs.getInt(item);
				ar.add(result);
			}
		} catch (Exception e) {
			logger.error("getToolBoxUsingList with  fromTime=" + fromTime , e);
		}
		
		return ar;
		
	}
/*	
	static public ArrayList<Integer> getBigToolBoxUsingList(Date fromTime){
		int result = 0;
		ArrayList<Integer> ar = new ArrayList<Integer>();
		try {

			Object[] dbArgs = new Object[] {fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select bigT from use_toolbox where ddate=?",
							dbArgs);
			while(rs.next()) {
				result = rs.getInt("bigT");
				ar.add(result);
			}
		} catch (Exception e) {
			logger.error("getBigToolBoxUsingList with  fromTime=" + fromTime , e);
		}
		
		return ar;
		
	}
	
	static public ArrayList<Integer> getMiddleToolBoxUsingList(Date fromTime){
		int result = 0;
		ArrayList<Integer> ar = new ArrayList<Integer>();
		try {

			Object[] dbArgs = new Object[] {fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select middleT from use_toolbox where ddate=?",
							dbArgs);
			while(rs.next()) {
				result = rs.getInt("middleT");
				ar.add(result);
			}
		} catch (Exception e) {
			logger.error("getMiddleToolBoxUsingList with  fromTime=" + fromTime, e);
		}
		
		return ar;
		
	}
	
	static public ArrayList<Integer> getSmallToolBoxUsingList(Date fromTime){
		int result = 0;
		ArrayList<Integer> ar = new ArrayList<Integer>();
		try {

			Object[] dbArgs = new Object[] {fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select smallT from use_toolbox where ddate=?",
							dbArgs);
			while(rs.next()) {
				result = rs.getInt("smallT");
				ar.add(result);
			}
		} catch (Exception e) {
			logger.error("getSmallToolBoxUsingList with  fromTime=" + fromTime, e);
		}
		
		return ar;
		
	}
*/
}
