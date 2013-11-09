package userStats;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import util.MyUtil;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class UserInfo {
	static final Logger logger = Logger.getLogger(UserInfo.class);
	static String dbReadUrls = null;
	static String db086 = null;
	static String dbDriver = null;
	static MoDBRW dbClient = null;
	static String dbWriteUrla = null;
	static MoDBRW dbClient081 = null;
	static MoDBRW dbClient086 = null;
	
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");

			db086 = serverConf.getString("db081");
			dbReadUrls = serverConf.getString("dbReadUrls");
			dbWriteUrla = serverConf.getString("dbWriteUrla");
			
			dbDriver = serverConf.getString("dbDriver");
			
			dbClient = new MoDBRW(dbReadUrls,dbDriver);
			dbClient081 = new MoDBRW(dbWriteUrla,dbDriver);
			dbClient086 = new MoDBRW(db086,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	static public Map<String,Long> GetGoldItemMap(String monetid,Date ftime,Date ttime){
		Map<String,Long> itemMap = new HashMap<String,Long>();
		try {

			Object[] dbArgs = new Object[] { monetid, ftime, ttime };
			DBResultSet rs = dbClient081.execSQLQuery("select msg,server_date from user_event where monetId like ? and server_date >= ? and server_date<=? and msg like 'action=buyByGold%itemDetail%'",
							dbArgs);
			while(rs.next()){
				String msg = rs.getString("msg");
				String item = MyUtil.getValueOfKey(msg,"itemDetail",",");
				item = item.substring(1,item.lastIndexOf(":"));
				String goldString = MyUtil.getValueOfKey(msg,",Gold",",");
				String goldArray[] = goldString.split("->");
				long gold = Long.parseLong(goldArray[0].trim())-Long.parseLong(goldArray[1].trim());
				if(itemMap.containsKey(item)){
					itemMap.put(item,itemMap.get(item)+gold);
				}else{
					itemMap.put(item, gold);
				}
			}
		} catch (Exception e) {
			logger.error("GetGoldItemMap with monetid=" + monetid
					+ " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return itemMap;
	}
	
	static public ArrayList<String> GetGoldItemList(String monetid,Date ftime,Date ttime){
		ArrayList<String> itemList = new ArrayList<String>();
		try {

			Object[] dbArgs = new Object[] { monetid, ftime, ttime };
			DBResultSet rs = dbClient081.execSQLQuery("select msg,server_date from user_event where monetId like ? and server_date >= ? and server_date<=? and msg like 'action=buyByGold%itemDetail%' order by server_date",
							dbArgs);
			while(rs.next()){
				String msg = rs.getString("msg");
				String item = MyUtil.getValueOfKey(msg,"itemDetail",",");
				item = item.substring(1,item.lastIndexOf(":"));
				String goldString = MyUtil.getValueOfKey(msg,",Gold",",");
				String goldArray[] = goldString.split("->");
				long gold = Long.parseLong(goldArray[0].trim())-Long.parseLong(goldArray[1].trim());
				itemList.add(item);
			}
		} catch (Exception e) {
			logger.error("GetGoldItemMap with monetid=" + monetid
					+ " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return itemList;
	}
	
	static public ArrayList<Long> GetGoldMoneyList(String monetid,Date ftime,Date ttime){
		ArrayList<Long> goldList = new ArrayList<Long>();
		try {

			Object[] dbArgs = new Object[] { monetid, ftime, ttime };
			DBResultSet rs = dbClient081.execSQLQuery("select msg,server_date from user_event where monetId like ? and server_date >= ? and server_date<=? and msg like 'action=buyByGold%itemDetail%' order by server_date",
							dbArgs);
			while(rs.next()){
				String msg = rs.getString("msg");
				String goldString = MyUtil.getValueOfKey(msg,",Gold",",");
				String goldArray[] = goldString.split("->");
				long gold = Long.parseLong(goldArray[0].trim())-Long.parseLong(goldArray[1].trim());
				goldList.add(gold);
			}
		} catch (Exception e) {
			logger.error("GetGoldItemMap with monetid=" + monetid
					+ " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return goldList;
	}
	
	static public ArrayList<Date> GetGoldTimeList(String monetid,Date ftime,Date ttime){
		ArrayList<Date> dateList = new ArrayList<Date>();
		try {

			Object[] dbArgs = new Object[] { monetid, ftime, ttime };
			DBResultSet rs = dbClient081.execSQLQuery("select server_date from user_event where monetId like ? and server_date >= ? and server_date<=? and msg like 'action=buyByGold%itemDetail%' order by server_date",
							dbArgs);
			while(rs.next()){
				dateList.add(rs.getDate("server_date"));
			}
		} catch (Exception e) {
			logger.error("GetGoldItemMap with monetid=" + monetid
					+ " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return dateList;
	}
	
	static public Map<Integer,Integer> GetUserAddValueRecord(String monetid,Date ftime,Date ttime){
		Map<Integer,Integer> map = new HashMap<Integer,Integer>();
		try {

			Object[] dbArgs = new Object[] { monetid, ftime, ttime };
			DBResultSet rs = dbClient086.execSQLQuery(
							"select count(money) count,sum(money) as amount from D5_addvalue where user_id=? and createdon>? and createdon<? and status=1 and money<>3",
							dbArgs);
			while(rs.next()){
				int count = rs.getInt("count");
				int money = rs.getInt("amount");
				map.put(count,money);
			}
		} catch (Exception e) {
			logger.error("GetUserAddValueRecord with monetid=" + monetid + " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return map;
	}
	
	static public ArrayList<Integer> GetAddValueMoneyList(String monetid,Date ftime,Date ttime){
		ArrayList<Integer> moneyList = new ArrayList<Integer>();
		try {

			Object[] dbArgs = new Object[] { monetid, ftime, ttime };
			DBResultSet rs = dbClient086.execSQLQuery(
							"select money from D5_addvalue where user_id=? and createdon>? and createdon<? and status=1 and money<>3 order by createdon",
							dbArgs);
			while(rs.next()){
				int money = rs.getInt("money");
				moneyList.add(money);
			}
		} catch (Exception e) {
			logger.error("GetAddValueMoneyList with monetid=" + monetid + " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return moneyList;
	}
	
	static public ArrayList<Date> GetAddValueTimeList(String monetid,Date ftime,Date ttime){
		ArrayList<Date> timeList = new ArrayList<Date>();
		try {

			Object[] dbArgs = new Object[] { monetid, ftime, ttime };
			DBResultSet rs = dbClient086.execSQLQuery(
							"select createdon from D5_addvalue where user_id=? and createdon>? and createdon<? and status=1 and money<>3 order by createdon",
							dbArgs);
			while(rs.next()){
				Date time = rs.getDate("createdon");
				timeList.add(time);
			}
		} catch (Exception e) {
			logger.error("GetAddValueTimeList with monetid=" + monetid + " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return timeList;
	}
	
	static public Map<String,Double> GetCreditItemMap(String monetid,Date ftime,Date ttime){
		Map<String,Double> creditItemMap = new HashMap<String,Double>();
		try {
			Object[] dbArgs = new Object[] { monetid, ftime, ttime };
			DBResultSet rs = dbClient086.execSQLQuery(
							"select item_name,money from payment where user_id=? and time_payment>=? and time_payment<? and app_name='ocean age'",
							dbArgs); 
			while(rs.next()){
				String item = rs.getString("item_name");
				double money = rs.getDouble("money");
				if(creditItemMap.containsKey(item)){
					creditItemMap.put(item,creditItemMap.get(item)+money);
				}else{
					creditItemMap.put(item,money);
				}
			}
		} catch (Exception e) {
			logger.error("GetCreditItemMap with monetid=" + monetid
					+ " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return creditItemMap;
	}
	
	static public ArrayList<String> GetCreditItemRecord(String monetid,Date ftime,Date ttime){
		ArrayList<String> itemList = new ArrayList<String>();
		try {
			Object[] dbArgs = new Object[] { monetid, ftime, ttime };
			DBResultSet rs = dbClient086.execSQLQuery(
							"select item_name,money,time_payment from payment where user_id=? and time_payment>=? and time_payment<? and app_name='ocean age' order by time_payment",
							dbArgs); 
			while(rs.next()){
				String item = rs.getString("item_name");
				itemList.add(item);
			}
		} catch (Exception e) {
			logger.error("GetCreditItemRecord with monetid=" + monetid
					+ " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return itemList;
	}
	
	static public ArrayList<Double> GetCreditMoneyRecord(String monetid,Date ftime,Date ttime){
		ArrayList<Double> itemList = new ArrayList<Double>();
		try {
			Object[] dbArgs = new Object[] { monetid, ftime, ttime };
			DBResultSet rs = dbClient086.execSQLQuery(
							"select item_name,money,time_payment from payment where user_id=? and time_payment>=? and time_payment<? and app_name='ocean age' order by time_payment",
							dbArgs); 
			while(rs.next()){
				double money = rs.getDouble("money");
				itemList.add(money);
			}
		} catch (Exception e) {
			logger.error("GetCreditMoneyRecord with monetid=" + monetid
					+ " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return itemList;
	}
	
	static public ArrayList<Date> GetCreditTimeRecord(String monetid,Date ftime,Date ttime){
		ArrayList<Date> itemList = new ArrayList<Date>();
		try {
			Object[] dbArgs = new Object[] { monetid, ftime, ttime };
			DBResultSet rs = dbClient086.execSQLQuery(
							"select item_name,money,time_payment from payment where user_id=? and time_payment>=? and time_payment<? and app_name='ocean age' order by time_payment",
							dbArgs); 
			while(rs.next()){
				Date date = rs.getDate("time_payment");
				itemList.add(date);
			}
		} catch (Exception e) {
			logger.error("GetCreditMoneyRecord with monetid=" + monetid
					+ " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return itemList;
	}
	
	static public Map<String,Integer> GetUseTypeMap(String monetid,Date ftime,Date ttime){
		Map<String,Integer> useMap = new HashMap<String,Integer>();
		try {
			Object[] dbArgs = new Object[] { monetid, ftime, ttime };
			DBResultSet rs = dbClient081.execSQLQuery("select msg,server_date from user_event where monetid=? and server_date>=? and server_date<? and (msg like 'action=useCrew,%' or msg like 'action=useWeapon,%' or msg like 'action=useAvatar,%' or msg like 'action=useSpeaker,%') order by server_date",
							dbArgs);
			while(rs.next()){
				String msg = rs.getString("msg");
				String item = MyUtil.getValueOfKey(msg,"action",",");
				if(item.contains("use")){
					item = item.replace("use","");
				}
				if(useMap.containsKey(item)){
					useMap.put(item, useMap.get(item)+1);
				}else{
					useMap.put(item, 1);
				}
			}
		} catch (Exception e) {
			logger.error("GetUseItemList with monetid=" + monetid
					+ " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return useMap;
	}
	
	static public ArrayList<String> GetUseItemList(String monetid,Date ftime,Date ttime){
		ArrayList<String> itemList = new ArrayList<String>();
		try {

			Object[] dbArgs = new Object[] { monetid, ftime, ttime };
			DBResultSet rs = dbClient081.execSQLQuery("select msg,server_date from user_event where monetid=? and server_date>=? and server_date<? and (msg like 'action=useCrew,%' or msg like 'action=useWeapon,%' or msg like 'action=useAvatar,%' or msg like 'action=useSpeaker,%') order by server_date",
							dbArgs);
			while(rs.next()){
				String msg = rs.getString("msg");
				itemList.add(msg);
			}
		} catch (Exception e) {
			logger.error("GetUseItemList with monetid=" + monetid
					+ " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return itemList;
	}
	
	static public ArrayList<Date> GetUseTimeList(String monetid,Date ftime,Date ttime){
		ArrayList<Date> timeList = new ArrayList<Date>();
		try {

			Object[] dbArgs = new Object[] { monetid, ftime, ttime };
			DBResultSet rs = dbClient081.execSQLQuery("select msg,server_date from user_event where monetid=? and server_date>=? and server_date<? and (msg like 'action=useCrew,%' or msg like 'action=useWeapon,%' or msg like 'action=useAvatar,%' or msg like 'action=useSpeaker,%') order by server_date",
							dbArgs);
			while(rs.next()){
				Date time = rs.getDate("server_date");
				timeList.add(time);
			}
		} catch (Exception e) {
			logger.error("GetUseTimeList with monetid=" + monetid
					+ " fromTime=" + ftime + " toTime=" + ttime, e);
		}
		return timeList;
	}
	
	static public ArrayList<Object> GetUserInfo(String name){
		ArrayList<Object> infoList = new ArrayList<Object>();
		try {

			Object[] dbArgs = new Object[] { name};
			DBResultSet rs = dbClient081.execSQLQuery("select monetid, nickname from profile where nickname = ?",dbArgs);
			if(rs.next()){
				int monetid = rs.getInt("monetid");
				name = rs.getString("nickname");
				return GetUserInfo(monetid);
			}
		} catch (Exception e) {
			logger.error("GetUserInfo with name=" + name, e);
		}
		return infoList;
	}
	
	static public ArrayList<Object> GetUserInfo(int monetid){
		ArrayList<Object> infoList = new ArrayList<Object>();
		try {

			Object[] dbArgs = new Object[] {monetid,monetid,monetid};
			DBResultSet rs = dbClient081.execSQLQuery("select s.shipyardlevel,f.money,p.nickname name,p.monetid from (select max(buildinglevel) shipyardlevel,monetid from building where monetid = ? and buildingtype = 1  group by monetid) s, (select money,monetid from fisher where monetid = ?) f, (select nickname,monetid from profile where monetid = ?) p where s.monetid = p.monetid  and f.monetid  = p.monetid and s.monetid  = f.monetid",
							dbArgs);
			while(rs.next()){
				String name = rs.getString("name");
				long level = rs.getLong("shipyardlevel");
				long gold = rs.getLong("money");
				infoList.add(monetid);
				infoList.add(name);
				infoList.add(level);
				infoList.add(gold);
			}
		} catch (Exception e) {
			logger.error("GetUserInfo with monetid=" + monetid, e);
		}
		return infoList;
	}
	
	static public Map<Integer,Map<String,Date>> GetUserList(Date fromTime,Date toTime){
		Map<Integer,Map<String,Date>> userMap = new HashMap<Integer,Map<String,Date>>();
		try {
			Object[] dbArgs = new Object[] { fromTime,toTime};
			DBResultSet rs = dbClient081.execSQLQuery("select monetid,name,newuserflag from fisher where monetid in(select monetId from user_event where server_date>=? and server_date<? group by monetId) order by name",
							dbArgs);
			while(rs.next()){
				int monetid = rs.getInt("monetid");
				String name = rs.getString("name");
				Date date = rs.getDate("newuserflag");
				Map<String,Date> map = new HashMap<String,Date>();
				map.put(name, date);
				userMap.put(monetid,map);
			}
		} catch (Exception e) {
			logger.error("GetUserList with fromTime=" + fromTime, e);
		}
		return userMap;
	}
	
	static public int GetCreditAccount(String monetid){
		try {
			Object[] dbArgs = new Object[] {Integer.parseInt(monetid)};
			DBResultSet rs = dbClient081.execSQLQuery(
							"select balance from profile where monetid=?",
							dbArgs); 
			while(rs.next()){
				return rs.getInt("balance");
			}
		} catch (Exception e) {
			logger.error("GetCreditAccount with monetid=" + monetid, e);
		}
		return -1;
	}
	
	public static void main(String args[]){
		String msg = "action=useWeapon,shipId=4249829,actionTo=12907010,itemId=52,weaponId=11019658,shipId=4249829,shipType=name.shiptype.39";
		String item = MyUtil.getValueOfKey(msg,"action",",");
		if(item.contains("use")){
			item = item.replace("use","");
		}
		System.out.println(item);
	}
}
