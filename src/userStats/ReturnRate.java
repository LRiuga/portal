package userStats;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class ReturnRate {
	static final Logger logger = Logger.getLogger(ReturnRate.class);
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
	
	static public ArrayList<Object> getOneDayData(Date ftime){
		ArrayList<Object> list = new ArrayList<Object>();
		DBResultSet rs = null;
		try {

			Object[] dbArgs = new Object[] {ftime};
			rs = dbClient.execSQLQuery(
							"select *  from return_rate where rtime=?",
							dbArgs);
			while(rs.next()){
				list.add(rs.getDate("rtime"));
				list.add(rs.getInt("amount"));
				list.add(rs.getInt("oneday"));
				list.add(rs.getInt("threeday"));
				list.add(rs.getInt("oneweek"));
				list.add(rs.getInt("twoweek"));
				list.add(rs.getInt("onemonth"));
			}
		} catch (Exception e) {
			logger.error("getOneDayData with ftime=" + ftime, e);
		}
		return list;
	}
	
	public static void main(String args[]){
		Date fTime = new Date();
		Date tTime = new Date();
		if(args.length == 0){
			Calendar fromWhen = Calendar.getInstance();
			fromWhen.setTime(fTime);
			GregorianCalendar gc = new GregorianCalendar(fromWhen
					.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
					.get(Calendar.DAY_OF_MONTH));
			gc.add(Calendar.DATE, -4);
			fTime = (Date) gc.getTime();
		}
		
		getOneDayData(fTime);
		
	}
}
