package billingStat;

import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class FirstPurse {
	static final Logger logger = Logger.getLogger(FirstPurse.class);
	static String dbReadUrls = null;
	static String dbWriteUrla = null;
	static String db081 = null;//billing
	
	static String dbDriver = null;
	static MoDBRW dbClient = null;
	static MoDBRW dbClient81 = null;
	static MoDBRW dbClient86 = null;
	
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");

			dbWriteUrla = serverConf.getString("dbWriteUrla");
			dbReadUrls = serverConf.getString("dbReadUrls");
			db081 = serverConf.getString("db081");
			dbDriver = serverConf.getString("dbDriver");
			
			dbClient = new MoDBRW(dbReadUrls,dbDriver);
			dbClient81 = new MoDBRW(dbWriteUrla,dbDriver);
			dbClient86 = new MoDBRW(db081,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	static public int getUserAmount(Date fTime,Date tTime){
		int result = 0;
		
		try {
			Object[] dbArgs = new Object[] {fTime,tTime};
			DBResultSet rs = dbClient81.execSQLQuery(
							"select count(*) as amount from GetFreeGiftByCredit where time>=? and time<?",
							dbArgs);
			if(rs.next()){
				result = rs.getInt("amount");
			}else{
				
			}

		} catch (Exception e) {
			logger.error("getValueAmount");
		}
		
		return result;
	}
	
	static public ArrayList<String> getUserList(Date fTime,Date tTime){
		ArrayList<String> idList = new ArrayList<String>();
		
		try {
			Object[] dbArgs = new Object[] {fTime,tTime};
			DBResultSet rs = dbClient81.execSQLQuery(
							"select ownerid from GetFreeGiftByCredit where time>=? and time<?",
							dbArgs);
			while(rs.next()){
				idList.add(rs.getInt("ownerid").toString());
			}

		} catch (Exception e) {
			logger.error("getUserList");
		}
		
		return idList;
	}
	
	static public double getBalance(int monetid){
		double balance = 0;
		try {
			Object[] dbArgs = new Object[] {monetid};
			DBResultSet rs = dbClient86.execSQLQuery(
							"select * from user_account where user_id=?",
							dbArgs);
			while(rs.next()){
				balance = rs.getDouble("balance");
			}

		} catch (Exception e) {
			logger.error("getUserList");
		}
		return balance;
	}
	
}
