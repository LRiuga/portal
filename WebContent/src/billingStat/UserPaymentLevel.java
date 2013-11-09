package billingStat;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class UserPaymentLevel {
	static Logger logger = Logger.getLogger(UserPaymentLevel.class);
	static String db081 = null;
	static String dbDriver = null;
	static String dbWriteUrla = null;
	static MoDBRW dbClient167 = null;
	static String dbReadUrls = null;
	static MoDBRW dbClient081 = null;
	static MoDBRW dbClient86 = null;
	static ArrayList<Double> paymentList = new ArrayList<Double>();
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");
			db081 = serverConf.getString("db081");
			dbWriteUrla = serverConf.getString("dbWriteUrla");
			dbReadUrls = serverConf.getString("dbReadUrls");
			dbDriver = serverConf.getString("dbDriver");

			dbClient86 = new MoDBRW(db081,dbDriver);
			dbClient081 = new MoDBRW(dbWriteUrla,dbDriver);
			dbClient167 = new MoDBRW(dbReadUrls,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
		
		paymentList.add(10.0);
		paymentList.add(30.0);
		paymentList.add(300.0);
		paymentList.add(1000.0);
		paymentList.add(5000.0);
		paymentList.add(10000.0);
		paymentList.add(1000000.0);
	}
	
	public static Map<Double,Integer> getUserPaymentMap(Date fromDate){
		Date datetemp = new Date(fromDate.getTime()-1000*3600*24*15);
		Date datetemp2 = new Date(datetemp.getTime()-1000*3600*24*15);
		Map<Double,Integer> map = new HashMap<Double,Integer>();
		try {
			Object[] dbArgs = new Object[] {datetemp2,fromDate};
			DBResultSet rs = dbClient86.execSQLQuery(
							"select sum(money) as amount from payment where time_payment>=? and time_payment<? and app_name='ocean age' and user_id>50000 group by user_id order by amount",
							dbArgs);  
			while(rs.next()){
				for(double index:paymentList){
					if(rs.getDouble("amount")<index){
						if(map.containsKey(index)){
							map.put(index,map.get(index)+1);
						}else{
							map.put(index,1);
						}
						break;
					}
				}
			}
		} catch (Exception e) {
			logger.error("getUserPayment", e);
		}
		return map;
	}
	
	public static ArrayList<Double> getPayentList(){
		return paymentList;
	}
}
