package toolStat;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.OAStatistic;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class DAUDayAction {
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
	
	public static Map<Date,Map<String,Integer>> getDayMap(String table,String type,String begindate,String enddate){
		Map<Date,Map<String,Integer>> dayMap = new HashMap<Date,Map<String,Integer>>();
		
		Map<Date, ArrayList<Integer>> userMap = new HashMap<Date, ArrayList<Integer>>();
		Map<Date, ArrayList<Integer>> amountMap = new HashMap<Date, ArrayList<Integer>>();
		try {
			Object[] dbArgs = new Object[] {begindate,enddate,type};
			DBResultSet rs = dbClient.execSQLQuery(
							"select monetid,amount,atime from "+table+" where atime >= ? and atime <= ? and action=? order by atime desc ",
							dbArgs);
			while(rs.next()){
				int monetid = rs.getInt("monetid");
				int amount = rs.getInt("amount");
				Date atime = rs.getDate("atime");
				if(userMap.containsKey(atime) && amountMap.containsKey(atime)){
					ArrayList<Integer> userList = userMap.get(atime);
					userList.add(monetid);
					userMap.put(atime, userList);
					ArrayList<Integer> amountList = amountMap.get(atime);
					amountList.add(amount);
					amountMap.put(atime, amountList);
				}else{
					ArrayList<Integer> userList = new ArrayList<Integer>();
					userList.add(monetid);
					userMap.put(atime, userList);
					ArrayList<Integer> amountList = new ArrayList<Integer>();
					amountList.add(amount);
					amountMap.put(atime, amountList);
				}
			}
			
			//System.out.println("select monetid,amount,atime from "+table+" where atime >=" +  begindate + " and atime <= "+ enddate + " and action=" + type);
			dayMap = getResultMap(userMap,amountMap,dayMap);
			
		} catch (Exception e) {
			logger.error("getDayMap with type=" + type , e);
		}
		return dayMap;
	}
	
	private static Map<Date,Map<String,Integer>> getResultMap(Map<Date, ArrayList<Integer>> userMap,Map<Date, ArrayList<Integer>> amountMap,Map<Date,Map<String,Integer>> dayMap){
		for (Map.Entry<Date, ArrayList<Integer>>  entry : userMap.entrySet()) {
			Date date = entry.getKey();
			ArrayList<Integer> userlist = entry.getValue();
			int userCount = getUsers(userlist);
			ArrayList<Integer>  amountList =  amountMap.get(date);
			int total = getTotal(amountList);
			int max = getMax(amountList);
			int mid = getMid(amountList);
			int min = getMin(amountList);
			int average = total/userCount;
			Map<String,Integer> detailMap = new HashMap<String, Integer>();
			detailMap.put("users",userCount);
			detailMap.put("total",total);
			detailMap.put("max",max);
			detailMap.put("mid",mid);
			detailMap.put("min",min);
			detailMap.put("average",average);
			dayMap.put(date,detailMap);
		}
		return dayMap;
	}
	
	private static int getUsers(ArrayList<Integer> userlist) {
		Set<Integer> s=new HashSet<Integer>(); 
		for(int i : userlist)
		{
			s.add(i);
		}
		return s.size();
	}
	
	private static int getTotal(ArrayList<Integer> userlist) {
		int total = 0;
		for(int i : userlist)
		{
			total += i;
		}
		return total;
	}
	private static int getMax(ArrayList<Integer> userlist) {
		int max = userlist.get(0);
		for(int i : userlist)
		{
			if(i > max) {
				max = i;
			}
		}
		return max;
	}
	private static int getMid(ArrayList<Integer> userlist) {
		Collections.sort(userlist);
		return userlist.get(userlist.size()/2);
	}
	private static int getMin(ArrayList<Integer> userlist) {
		int min = userlist.get(0);
		for(int i : userlist)
		{
			if(i < min) {
				min = i;
			}
		}
		return min;
	}
	
}
