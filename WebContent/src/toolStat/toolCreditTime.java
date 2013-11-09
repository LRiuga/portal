package toolStat;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class toolCreditTime {
	static final Logger logger = Logger.getLogger(toolCreditTime.class);
	static String dbReadUrls = null;
	static String db086 = null;
	static String dbDriver = null;
	static MoDBRW dbClient = null;
	static MoDBRW dbClient086 = null;
	
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");

			db086 = serverConf.getString("db086");
			dbReadUrls = serverConf.getString("dbReadUrls");
			dbDriver = serverConf.getString("dbDriver");
			
			dbClient = new MoDBRW(dbReadUrls,dbDriver);
			dbClient086 = new MoDBRW(db086,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	static public int getTotalCredit(String item,Date ftime,Date ttime){
		int result = 0;
		try {

			Object[] dbArgs = new Object[] { item, ftime, ttime };
			DBResultSet rs = dbClient086
					.execSQLQuery(
							"select count(*) as amount from user_event where msg like ? and server_date>=? and server_date<?",
							dbArgs);
			if(rs.next()){
				result  = rs.getInt("amount");
			}
		} catch (Exception e) {
			logger.error("getTotalCredit with item=" + item
					+ " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return result;
	}
	
	static public int getMaxCredit(String item,Date ftime,Date ttime){
		int result = 0;
		try {

			Object[] dbArgs = new Object[] { item, ftime, ttime };
			DBResultSet rs = dbClient086
					.execSQLQuery(
							"select top 1 * from (select count(monetid) as amount from user_event where msg like ? and server_date>=? and server_date<?  group by monetid)a order by amount desc ",
							dbArgs);
			if(rs.next()){
				result  = rs.getInt("amount");
			}
		} catch (Exception e) {
			logger.error("getMaxCredit with item=" + item
					+ " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return result;
	}
	
	static public int getMinCredit(String item,Date ftime,Date ttime){
		int result = 0;
		try {

			Object[] dbArgs = new Object[] { item, ftime, ttime };
			DBResultSet rs = dbClient086
					.execSQLQuery(
							"select top 1 * from (select count(monetid) as amount from user_event where msg like ? and server_date>=? and server_date<?  group by monetid)a order by amount",
							dbArgs);
			if(rs.next()){
				result  = rs.getInt("amount");
			}
		} catch (Exception e) {
			logger.error("getMinCredit with item=" + item
					+ " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return result;
	}
	
	static public int getUserAmount(String item,Date ftime,Date ttime){
		int result = 0;
		try {

			Object[] dbArgs = new Object[] { item, ftime, ttime };
			DBResultSet rs = dbClient086
					.execSQLQuery(
							"select count(amount) as amount from (select count(monetid) as amount from user_event where msg like ? and server_date>=? and server_date<?  group by monetid)a",
							dbArgs);
			if(rs.next()){
				result  = rs.getInt("amount");
			}
		} catch (Exception e) {
			logger.error("getUserAmount with item=" + item
					+ " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return result;
	}
	
	public static void main(String[] args) {
		Date fTime = new Date();
		Date tTime = new Date();
		Calendar fromWhen = Calendar.getInstance();
		fromWhen.setTime(fTime);
		GregorianCalendar gc = new GregorianCalendar(fromWhen
				.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
				.get(Calendar.DAY_OF_MONTH));
		gc.add(Calendar.DATE, -21);
		fTime = (Date) gc.getTime();
		gc.add(Calendar.DATE, 1);
		tTime = (Date) gc.getTime();
		
		System.out.println(fTime);
		System.out.println(tTime);
		
		System.out.println(getTotalCredit("Callback Credit: weaponType = 5",fTime,tTime));
		System.out.println(getMaxCredit("Callback Credit: weaponType = 5",fTime,tTime));
		System.out.println(getMinCredit("Callback Credit: weaponType = 5",fTime,tTime));
		System.out.println(getUserAmount("Callback Credit: weaponType = 5",fTime,tTime));
	}

}
