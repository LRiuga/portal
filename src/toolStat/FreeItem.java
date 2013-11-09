package toolStat;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class FreeItem {
	Connection cn = null;
	CallableStatement cmd = null;
	Statement stmt = null;
	ResultSet rs = null;

	static Logger logger = Logger.getLogger(FreeItem.class);
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
	
	public static java.util.Map<String,Integer> getActionAmount(String type,Date date){
		java.util.Map<String,Integer>  result = new java.util.HashMap<String, Integer>();
		try {

			Object[] dbArgs = new Object[] {type,date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item,amount from freetool where gettype=? and fdate=? order by item",
							dbArgs);
			while(rs.next()) {
				result.put(rs.getString("item"),rs.getInt("amount"));
			}
		} catch (Exception e) {
			logger.error("getActionAmount with  type=" + type , e);
		}
		
		return result;
	}
	
	public static List<String> getNameList(String type,Date fTime,Date tTime){
		List<String> al = new ArrayList<String>();
		try {

			Object[] dbArgs = new Object[] {type,fTime,tTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select distinct item from freetool where gettype=? and fdate>=? and fdate<=? order by item",
							dbArgs);
			while(rs.next()) {
				al.add(rs.getString("item"));
			}
		} catch (Exception e) {
			logger.error("getNameList with  type=" + type , e);
		}
		
		return al;
	}

	public static void main(String[] args) {
		Date fTime = new Date();
		Date tTime = new Date();
		Calendar fromWhen = Calendar.getInstance();
		fromWhen.setTime(fTime);
		GregorianCalendar gc = new GregorianCalendar(fromWhen
				.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
				.get(Calendar.DAY_OF_MONTH));
		gc.add(Calendar.DATE, -1);
		fTime = (Date) gc.getTime();
		
	}
}
