package billingStat;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class ConsumerCashback {
	static Logger logger = Logger.getLogger(ConsumerCashback.class);
	static String db081 = null;
	static String dbDriver = null;
	static String dbWriteUrla = null;
	static MoDBRW dbClient167 = null;
	static String dbReadUrls = null;
	static MoDBRW dbClient081 = null;
	static MoDBRW dbClient86 = null;
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
	}
	
	public static Map<String,Double> getUserPaymentMap(){
		Map<String,Double> map = new HashMap<String,Double>();
		try {
			Object[] dbArgs = new Object[] {};
			DBResultSet rs = dbClient081.execSQLQuery(
							"exec LoadRankByCashBack",
							dbArgs);  
			while(rs.next()){
				map.put(rs.getInt("monetid").toString(), rs.getDouble("amount"));
			}
		} catch (Exception e) {
			logger.error("getUserPayment", e);
		}
		return map;
	}
	
	public static Vector<Double> getPaymentVector(){
		Vector<Double> vector = new Vector<Double>();
		try {
			Object[] dbArgs = new Object[] {};
			DBResultSet rs = dbClient081.execSQLQuery(
							"exec LoadRankByCashBack",
							dbArgs);
			while(rs.next()){
				vector.add(rs.getDouble("amount"));
			}
		} catch (Exception e) {
			logger.error("getUserPayment", e);
		}
		return vector;
	}
	
	public static Vector<Integer> getUserVector(){
		Vector<Integer> vector = new Vector<Integer>();
		try {
			Object[] dbArgs = new Object[] {};
			DBResultSet rs = dbClient081.execSQLQuery(
							"exec LoadRankByCashBack",
							dbArgs);
			while(rs.next()){
				vector.add(rs.getInt("monetid"));
			}
		} catch (Exception e) {
			logger.error("getUserVector", e);
		}
		return vector;
	}
	
	public static double getOABalance(double money){
		double oabalance = 0;
		if(money<1){
			oabalance = 0;//0%
		}else if(money<=19.99){
			oabalance = money * 0.3;//30%
		}else if(money<=49.9){
			oabalance = money * 0.5;//50%
		}else if(money<199.9){
			oabalance = money * 0.6;//60%
		}else if(money<499.9){
			oabalance = money * 0.7;//70%
		}else if(money<999.9){
			oabalance = money * 0.8;//80%
		}else if(money<=2999.9){
			oabalance = money * 0.9;//90%
		}else if(money>=3000){
			oabalance = money * 1;//100%
		}
		return oabalance;
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
