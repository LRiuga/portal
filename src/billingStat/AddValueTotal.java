package billingStat;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class AddValueTotal {
	static final Logger logger = Logger.getLogger(AddValueTotal.class);
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
	
	static public int getValueAmount(int min,int max,Date fTime,Date tTime){
		int result = 0;
		
		try {
			Object[] dbArgs = new Object[] {fTime,tTime,min,max};
			DBResultSet rs = dbClient081.execSQLQuery(
							"select count(*) as amount from(select sum(money) as money,user_id from addvalue where time_addvalue>=? and time_addvalue<?  group by user_id )a where money >=? and money<=?",
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
	
	static public ArrayList<String> getAddValueUserList(int min,int max,Date fTime,Date tTime){
		ArrayList<String> userList = new ArrayList<String>();
		try {
			Object[] dbArgs = new Object[] {fTime,tTime,min,max};
			DBResultSet rs = dbClient081.execSQLQuery(
							"select money,user_id from(select sum(money) as money,user_id from addvalue where time_addvalue>=? and time_addvalue<? group by user_id)a where money >=? and money<=? order by money desc",
							dbArgs);
			while(rs.next()){
				userList.add(rs.getInt("user_id").toString());
			}
		} catch (Exception e) {
			logger.error("getAddValueUserList");
		}
		return userList;
	}
	
	static public double getCurrentSelling(Date fTime,Date tTime){
		double selling = 0;
		try {
			Object[] dbArgs = new Object[] {fTime,tTime};
			DBResultSet rs = dbClient081.execSQLQuery(
							"select sum(money) as amount from payment where time_payment>=? and time_payment<=? and app_name='ocean age' and user_id>60000",
							dbArgs);
			while(rs.next()){
				selling = rs.getDouble("amount");
			}
		} catch (Exception e) {
			logger.error("getCurrentSelling");
		}
		return selling;
	}
	
	static public int getCurrentSellingUser(Date fTime,Date tTime){
		int selling = 0;
		try {
			Object[] dbArgs = new Object[] {fTime,tTime};
			DBResultSet rs = dbClient081.execSQLQuery(
							"select count(distinct user_id) as amount from payment where time_payment>=? and time_payment<=? and app_name='ocean age' and user_id>60000",
							dbArgs);
			while(rs.next()){
				selling = rs.getInt("amount");
			}
		} catch (Exception e) {
			logger.error("getCurrentSellingUser");
		}
		return selling;
	}
	
	static public List<String> getCurrentSellingList(Date fTime,Date tTime){
		List<String> list = new ArrayList<String>();
		try {
			Object[] dbArgs = new Object[] {fTime,tTime};
			DBResultSet rs = dbClient081.execSQLQuery(
							"select item_name,sum(money) as amount from payment where time_payment>=? and time_payment<=? and app_name='ocean age' and user_id>60000 group by item_name order by amount desc",
							dbArgs);
			while(rs.next()){
				list.add(rs.getString("item_name"));
			}
		} catch (Exception e) {
			logger.error("getCurrentSellingMap");
		}
		return list;
	}
	
	static public Map<String,Double> getCurrentSellingMap(Date fTime,Date tTime){
		Map<String,Double> map = new HashMap<String,Double>();
		try {
			Object[] dbArgs = new Object[] {fTime,tTime};
			DBResultSet rs = dbClient081.execSQLQuery(
							"select item_name,sum(money) as amount from payment where time_payment>=? and time_payment<=? and app_name='ocean age' and user_id>60000 group by item_name order by amount desc",
							dbArgs);
			while(rs.next()){
				map.put(rs.getString("item_name"),rs.getDouble("amount"));
			}
		} catch (Exception e) {
			logger.error("getCurrentSellingMap");
		}
		return map;
	}
	
	static public java.util.Map<String, Integer> getAddValueUserMap(int min,int max,Date fTime,Date tTime){
		java.util.Map<String, Integer> map = new java.util.HashMap<String, Integer>();
		try {
			Object[] dbArgs = new Object[] {fTime,tTime,min,max};
			DBResultSet rs = dbClient081.execSQLQuery(
							"select money,user_id from(select sum(money) as money,user_id from addvalue where time_addvalue>=? and time_addvalue<? group by user_id)a where money >=? and money<=? order by money desc",
							dbArgs);
			while(rs.next()){
				map.put(rs.getInt("user_id").toString(),rs.getInt("money"));
			}
		} catch (Exception e) {
			logger.error("getAddValueUserList");
		}
		return map;
	}

}
