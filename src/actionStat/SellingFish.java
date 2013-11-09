package actionStat;

import java.util.ArrayList;
import java.util.Date;
import java.util.Set;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import toolStat.CurrentSelling;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class SellingFish {
	static Logger logger = Logger.getLogger(CurrentSelling.class);
	static String db086 = null;
	static String dbDriver = null;
	static MoDBRW dbClient = null;
	static ArrayList<String> itemList = new ArrayList<String>();
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");

			db086 = serverConf.getString("db086");
			dbDriver = serverConf.getString("dbDriver");

			dbClient = new MoDBRW(db086,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	static{
		itemList.add("sellFishAndGetGold");
		itemList.add("fishType");
		itemList.add("count");
		itemList.add("oldGold");
		itemList.add("newGold");
		itemList.add("time");
		itemList.add("price");
		itemList.add("Freshness");
		itemList.add("fishName");
	}
	
	public static java.util.Map<Integer,java.util.Map<String,Object>> getLog(String monetid,Date fromTime,Date toTime){
		java.util.Map<Integer,java.util.Map<String,Object>> maps = new java.util.HashMap<Integer,java.util.Map<String,Object>>();
		int count=1;
		try {
			Object[] dbArgs = new Object[] {fromTime, toTime,monetid };
			DBResultSet rs = dbClient.execSQLQuery(
							"select msg,server_date from user_event where msg like 'action=sellfish,fi%' and server_date >= ? and server_date<? and monetId=? order by server_date",
							dbArgs);
			while(rs.next()){
				String msg = rs.getString("msg");
				maps.put(count, getMap(msg,rs.getDate("server_date")));
				count++;
			}
		} catch (Exception e) {
			logger.error("getLog with fromTime=" + fromTime + " toTime=" + toTime, e);
		}
		return maps;
	}
	
	public static java.util.Map<String,Object> getMap(String msg,Date time){
		java.util.Map<String,Object> map = new java.util.HashMap<String,Object>();
		String[] temp1 = msg.split(",");
		map.put("time",time);
		for(String s:temp1){
			String[] temp2 = s.split("=");
			if(temp2.length==2){
				map.put(temp2[0],temp2[1]);
				
			}
		}
//		Set set = map.keySet();
//		for(Object s:set){
//			System.out.print(s+"=");
//			System.out.println(map.get(s));
//		}
		return map;
	}
	
	public static ArrayList<String> getItemList(){
		return itemList;
	}
	
	public static void main(String[] args) {
		String temp = "action=sellfish,fishType=30,fishName=Coffinfish,count=26169,Freshness=1.0,price=26.400000000000002,sellFishAndGetGold=690861,oldGold=192022792,newGold=192713653";
		//getMap(temp);
	}
}
