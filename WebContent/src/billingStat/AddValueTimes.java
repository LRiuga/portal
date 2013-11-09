package billingStat;

import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class AddValueTimes {
	static final Logger logger = Logger.getLogger(AddValueTimes.class);
	static String dbReadUrls = null;
	static String db081 = null;
	static String dbDriver = null;
	static MoDBRW dbClient = null;
	static MoDBRW dbClient081 = null;
	
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");

			db081 = serverConf.getString("db081");
			dbReadUrls = serverConf.getString("dbReadUrls");
			dbDriver = serverConf.getString("dbDriver");
			
			dbClient = new MoDBRW(dbReadUrls,dbDriver);
			dbClient081 = new MoDBRW(db081,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	static public java.util.Map<Integer,Integer> getAddValueTimes(Date ftime,Date ttime){
		java.util.Map<Integer,Integer> addvalue = new java.util.HashMap<Integer,Integer>();
		try {
			Object[] dbArgs = new Object[] {ftime,ttime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select money,times from AddValueUser where atime>=? and atime<?",
							dbArgs);
			while(rs.next()){
				addvalue.put(rs.getInt("money"),rs.getInt("times"));
			}
		} catch (Exception e) {
			logger.error("getAddValue");
		}
		return addvalue;
	}
	
	static public java.util.Map<Integer,Integer> getAddValueUsers(Date ftime,Date ttime){
		java.util.Map<Integer,Integer> addvalue = new java.util.HashMap<Integer,Integer>();
		try {
			Object[] dbArgs = new Object[] {ftime,ttime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select money,users from AddValueUser where atime>=? and atime<?",
							dbArgs);
			while(rs.next()){
				addvalue.put(rs.getInt("money"),rs.getInt("users"));
			}
		} catch (Exception e) {
			logger.error("getAddValue");
		}
		return addvalue;
	}
	
	static public int getValue(java.util.Map<Integer,Integer> addvalue){
		int result = 0;
		
		if(addvalue.get(3000)!=null){
			result += addvalue.get(3000)*3000;
		}
		if(addvalue.get(5000)!=null){
			result += addvalue.get(5000)*5000;
		} 
		if(addvalue.get(10000)!=null){
			result += addvalue.get(10000)*10000;
		}
		if(addvalue.get(15000)!=null){
			result += addvalue.get(15000)*15000;
		}
		return result;
	}

}
