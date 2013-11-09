package toolStat;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.OAStatistic;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class ToolHour {

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
	
	static public ArrayList<Date> getToolHourTimeList(String item,Date fromTime,Date toTime){
		Date result = new Date();
		ArrayList<Date> ar = new ArrayList<Date>();
		try {

			Object[] dbArgs = new Object[] {item,fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select stime from toolhour where item=? and stime>=? and stime<? order by stime desc",
							dbArgs);
			while(rs.next()) {
				result = rs.getDate("stime");
				ar.add(result);
			}
		} catch (Exception e) {
			logger.error("getToolHourTimeList with  fromTime=" + fromTime , e);
		}		
		return ar;
		
	}
	
	static public ArrayList<Integer> getToolHourAmountList(String item,Date fromTime,Date toTime){
		int result = 0;
		ArrayList<Integer> ar = new ArrayList<Integer>();
		try {

			Object[] dbArgs = new Object[] {item,fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select amount from toolhour where item=? and stime>=? and stime<? order by stime desc",
							dbArgs);
			while(rs.next()) {
				result = rs.getInt("amount");
				ar.add(result);
			}
		} catch (Exception e) {
			logger.error("getToolHourAmountList with  fromTime=" + fromTime, e);
		}
		
		return ar;
		
	}
	
	public static void main(String[] args) {
//		Date date = new Date();
//		SimpleDateFormat sdf = new SimpleDateFormat("dd HH:mm");	
//		System.out.println(date);
//		System.out.println(sdf.format(date));
		Date fTime = new Date();
		Date tTime = new Date();
		Calendar fromWhen = Calendar.getInstance();
		fromWhen.setTime(fTime);
		GregorianCalendar gc = new GregorianCalendar(fromWhen
				.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
				.get(Calendar.DAY_OF_MONTH));
		gc.add(Calendar.DATE, -1);
		fTime = (Date) gc.getTime();
		ArrayList<Integer> amountList = new ArrayList<Integer>();
		amountList = getToolHourAmountList("BigToolboxCombo",fTime,tTime);
		for(int i:amountList){
			System.out.println(i);
		}
	}

}
