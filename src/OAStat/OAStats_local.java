package OAStat;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class OAStats_local {
	Connection cn = null;
	CallableStatement cmd = null;
	Statement stmt = null;
	ResultSet rs = null;

	static Logger logger = Logger.getLogger(OAStatistic.class);
	static String dbReadUrls = null;
	static String dbWriteUrla = null;
	static String dbDriver = null;
	static MoDBRW dbClient = null;
	static MoDBRW dbClient81 = null;
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");
			dbReadUrls = serverConf.getString("dbReadUrls");
			dbWriteUrla = serverConf.getString("dbWriteUrla");
			dbDriver = serverConf.getString("dbDriver");
			dbClient = new MoDBRW(dbReadUrls,dbDriver);
			dbClient81 = new MoDBRW(dbWriteUrla,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}

	static public void setSellingFromA(String item,int sellingAmount,Date fromTime) {
		try {

			Object[] dbArgs = new Object[] {item,sellingAmount,fromTime};
			Date toTime = new Date(fromTime.getTime()+1*24*3600*1000);
			Object[] dbArgs2 = new Object[] {item,fromTime,toTime};
			dbClient.execSQLUpdate("delete from selling where iname = ? and stime>=? and stime<?", dbArgs2);
			dbClient.execSQLUpdate(
							"insert into selling(iname,amount,stime)values (?,?,?)",
							dbArgs);
			
		} catch (Exception e) {
			logger.error("setSellingFromAtoB with item=" + item + " amount=" + sellingAmount
					+ " fromTime=" + fromTime, e);
		}

	}
	
	static public void setUsingFromA(String item,int usingAmount,Date fromTime) {
		try {
			Object[] dbArgs = new Object[] {item,usingAmount,fromTime};
			Date toTime = new Date(fromTime.getTime()+1*24*3600*1000);
			Object[] dbArgs2 = new Object[] {item,fromTime,toTime};
			dbClient.execSQLUpdate("delete from using where iname = ? and utime>=? and utime<?", dbArgs2);
			dbClient.execSQLUpdate(
							"insert into using(iname,amount,utime)values (?,?,?)",
							dbArgs);
			
		} catch (Exception e) {
			logger.error("setUsingFromAtoB with item=" + item + " amount=" + usingAmount
					+ " fromTime=" + fromTime, e);
		}

	}

	static public Map<String, Integer> getSellingFromAtoB(Date fromTime,Date toTime){
		java.util.Map<String, Integer> map = new java.util.HashMap<String, Integer>();
		ArrayList<String> nameList = new ArrayList<String>();
		try {

			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from selling where stime>=? and stime<?",
							dbArgs);
			while(rs.next()) {
				nameList.add(rs.getString("iname"));
			}
		} catch (Exception e) {
			logger.error("getSellingFromAtoB  nameList fromTime=" + fromTime + " toTime=" + toTime, e);
		}
		ArrayList<Integer> amountList = new ArrayList<Integer>();
		try {

			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from selling where stime>=? and stime<?",
							dbArgs);
			while(rs.next()) {
				amountList.add(rs.getInt("amount"));
			}
		} catch (Exception e) {
			logger.error("getSellingFromAtoB  amountList fromTime=" + fromTime + " toTime=" + toTime, e);
		}
		
		for(int i =0;i<nameList.size();i++){
			map.put(nameList.get(i),amountList.get(i));
		}
		
		return map;
	}
	
	static public Map<String, Integer> getSellingOABalance(Date fromTime,Date toTime){
		java.util.Map<String, Integer> map = new java.util.HashMap<String, Integer>();
		ArrayList<String> nameList = new ArrayList<String>();
		try {

			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select iname from selling_oabalance where stime>=? and stime<?",
							dbArgs);
			while(rs.next()) {
				nameList.add(rs.getString("iname"));
			}
		} catch (Exception e) {
			logger.error("getSellingOABalance  nameList fromTime=" + fromTime + " toTime=" + toTime, e);
		}
		ArrayList<Integer> amountList = new ArrayList<Integer>();
		try {

			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select amount from selling_oabalance where stime>=? and stime<?",
							dbArgs);
			while(rs.next()) {
				amountList.add(rs.getInt("amount"));
			}
		} catch (Exception e) {
			logger.error("getSellingOABalance  amountList fromTime=" + fromTime + " toTime=" + toTime, e);
		}
		
		for(int i =0;i<nameList.size();i++){
			map.put(nameList.get(i),amountList.get(i));
		}
		
		return map;
	}
	
	static public Map<String, Double> getCreditOABalance(Date fromTime,Date toTime){
		java.util.Map<String, Double> map = new java.util.HashMap<String, Double>();
		ArrayList<String> nameList = new ArrayList<String>();
		try {

			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select iname from selling_oabalance where stime>=? and stime<?",
							dbArgs);
			while(rs.next()) {
				nameList.add(rs.getString("iname"));
			}
		} catch (Exception e) {
		}
		ArrayList<Double> amountList = new ArrayList<Double>();
		try {

			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select oabalance from selling_oabalance where stime>=? and stime<?",
							dbArgs);
			while(rs.next()) {
				amountList.add(rs.getDouble("oabalance"));
			}
		} catch (Exception e) {
		}
		
		for(int i =0;i<nameList.size();i++){
			map.put(nameList.get(i),amountList.get(i));
		}
		return map;
	}
	
	static public Map<String, Double> getCreditOABalanceCredit(Date fromTime,Date toTime){
		java.util.Map<String, Double> map = new java.util.HashMap<String, Double>();
		try {

			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select iname,credit from selling_oabalance where stime>=? and stime<?",
							dbArgs);
			while(rs.next()) {
				map.put(rs.getString("iname"),rs.getDouble("credit"));
			}
		} catch (Exception e) {
		}
		return map;
	}
	
	static public Map<String, Double> getCreditFromAtoB(Date fromTime,Date toTime){
		java.util.Map<String, Double> map = new java.util.HashMap<String, Double>();
		try {

			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from selling where stime>=? and stime<?",
							dbArgs);
			while(rs.next()) {
				map.put(rs.getString("iname"),rs.getDouble("credit"));
			}
		} catch (Exception e) {
		}
		return map;
	}
	
	static public Map<String, Double> getOaBalanceFromAtoB(Date fromTime,Date toTime){
		java.util.Map<String, Double> map = new java.util.HashMap<String, Double>();
		try {

			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from selling_oabalance where stime>=? and stime<?",
							dbArgs);
			while(rs.next()) {
				map.put(rs.getString("iname"),rs.getDouble("oabalance"));
			}
		} catch (Exception e) {
		}
		return map;
	}
	
	static public double getOABalanceAmount(Date fromTime,Date toTime){
		double total = 0.0;
		try {

			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select sum(oabalance) as amount from selling_oabalance where stime>=? and stime<?",
							dbArgs);
			while(rs.next()) {
				total += rs.getDouble("amount");
			}
		} catch (Exception e) {
		}
		return total;
	}
	
	static public java.util.Map<String, Integer> getUVPV_users(Date fromTime,Date toTime){
		int result = 0;
		java.util.Map<String, Integer> map = new java.util.HashMap<String, Integer>();
		ArrayList<String> pages = OAStatUtil.getItemPageList();
//		ArrayList<Integer> ar = new ArrayList<Integer>();
		try {
			for(int i =0;i<pages.size();i++){
				Object[] dbArgs = new Object[] {pages.get(i),fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select max(users) as users from uvpv where item=? and ctime>=? and ctime<?",
						dbArgs);
				if(rs.next()) {
					result = rs.getInt("users");
					map.put(pages.get(i),result);
				}
			}
		} catch (Exception e) {
//			logger.error("getSellingFromAtoB with item=" + item + " amount=" + result
//					+ " fromTime=" + fromTime + " toTime=" + toTime, e);
		}
		
		return map;
	}
	
	static public java.util.Map<String, Integer> getUVPV_max(Date fromTime,Date toTime){
		int result = 0;
		java.util.Map<String, Integer> map = new java.util.HashMap<String, Integer>();
		ArrayList<String> pages = OAStatUtil.getItemPageList();
		try {
			for(int i =0;i<pages.size();i++){
				Object[] dbArgs = new Object[] {pages.get(i),fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select max(maxP) as maxP from uvpv where item=? and ctime>=? and ctime<?",
						dbArgs);
				if(rs.next()) {
					result = rs.getInt("maxP");
					map.put(pages.get(i),result);
				}
			}
		} catch (Exception e) {
			logger.error("getUVPV_max", e);
		}
		
		return map;
	}
	
	static public java.util.Map<String, Integer> getUVPV_users_new(Date fromTime,Date toTime){
		int result = 0;
		java.util.Map<String, Integer> map = new java.util.HashMap<String, Integer>();
		ArrayList<String> pages = OAStatUtil.getItemNewUserPageList();
//		ArrayList<Integer> ar = new ArrayList<Integer>();
		try {
			for(int i =0;i<pages.size();i++){
				Object[] dbArgs = new Object[] {pages.get(i),fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select max(users) as users from new_user_pv where item=? and ctime>=? and ctime<?",
						dbArgs);
				if(rs.next()) {
					result = rs.getInt("users");
					map.put(pages.get(i),result);
				}
			}
		} catch (Exception e) {
//			logger.error("getSellingFromAtoB with item=" + item + " amount=" + result
//					+ " fromTime=" + fromTime + " toTime=" + toTime, e);
		}
		
		return map;
	}

	static public ArrayList<String> getNameLise(Date fromTime,Date toTime){
		ArrayList<String> nameList = new ArrayList<String>();
		try {

			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select iname from selling_gold where gtime >= ? and gtime < ? order by id",
							dbArgs);
			while(rs.next()) {
				nameList.add(rs.getString("iname"));
			}
		} catch (Exception e) {
//			logger.error("getSelling_goldFromAtoB with item=" + item + " amount=" + result
//					+ " fromTime=" + fromTime + " toTime=" + toTime, e);
		}
		return nameList;
	}
	
	static public int countPlayUsersAmount(Date fromTime,Date toTime) {
		int result = 0;
		try {
			toTime = new Date(toTime.getTime()+1000*60*60*24);
			Object[] dbArgs = new Object[] { toTime ,fromTime};
			DBResultSet rs = dbClient81.execSQLQuery(
							"select count(distinct monetid) as amount from user_event where server_date<=? and server_date>=?",
							dbArgs);
			if (rs.next()) {
				result = rs.getInt("amount");
			} else {
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countPlayUsersAmount with fromTime=" + fromTime + " toTime=" + toTime, e);
			result = -1;
		}

		return result;
	}
	
	static public int countAllUsersAmount(Date fromTime,Date toTime) {
		int result = 0;
		try {
			toTime = new Date(toTime.getTime()+1000*60*60*24);
			Object[] dbArgs = new Object[] {fromTime, toTime };
			DBResultSet rs = dbClient.execSQLQuery(
							"select count(*) as amount from All_Users where lastlogin>=? and lastlogin<=?",
							dbArgs);
			if (rs.next()) {
				result = rs.getInt("amount");
			} else {
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countAllUsersAmount with fromTime=" + fromTime + " toTime=" + toTime, e);
			result = -1;
		}

		return result;
	}
	
	static public Map<String, Integer> getSellingGoldFromAtoB(Date fromTime,Date toTime){
		int result = 0;
		java.util.Map<String, Integer> map = new java.util.HashMap<String, Integer>();
		ArrayList<String> nameList = new ArrayList<String>();
		try {

			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select iname from selling_gold where gtime >= ? and gtime < ? order by id",
							dbArgs);
			while(rs.next()) {
				nameList.add(rs.getString("iname"));
			}
		} catch (Exception e) {
//			logger.error("getSelling_goldFromAtoB with item=" + item + " amount=" + result
//					+ " fromTime=" + fromTime + " toTime=" + toTime, e);
		}
		ArrayList<Integer> amountList = new ArrayList<Integer>();
		try {

			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select amount from selling_gold where gtime >= ? and gtime < ? order by id",
							dbArgs);
			while(rs.next()) {
				result = rs.getInt("amount");
				amountList.add(result);
			}
		} catch (Exception e) {
//			logger.error("getSelling_goldFromAtoB with item=" + item + " amount=" + result
//					+ " fromTime=" + fromTime + " toTime=" + toTime, e);
		}
		
		for(int i =0;i<nameList.size();i++){
			map.put(nameList.get(i),amountList.get(i));
		}
		
		return map;
		
	}
	
	static public Map<String, Integer> getPhonePlatform(Date fromTime,Date toTime){
		java.util.Map<String, Integer> map = new java.util.HashMap<String, Integer>();
		try {
			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select type,amount from dailyuserlevel where ctime>=? and ctime<?  and type in ('AllPlatform','Android','IOS','Nokia','BlackBerry','Other')",
							dbArgs);
			while(rs.next()) {
				map.put(rs.getString("type"),rs.getInt("amount"));
			}
		} catch (Exception e) {
		}
		return map;
	}
	
	static public Map<String, Integer> getPhonePlatformMonthly(Date fromTime,Date toTime){
		java.util.Map<String, Integer> map = new java.util.HashMap<String, Integer>();
		try {
			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select type,amount from dailyuserlevel where ctime>=? and ctime<?  and level=30",
							dbArgs);
			while(rs.next()) {
				map.put(rs.getString("type"),rs.getInt("amount"));
			}
		} catch (Exception e) {
		}
		return map;
	}
/*	
	static public Map<String, Integer> getPhonePlatformMonthly(Date fromTime){
		Date datetemp = new Date(fromTime.getTime()-1000*3600*24*15);
		Date datetemp2 = new Date(datetemp.getTime()-1000*3600*24*15);
		java.util.Map<String, Integer> map = new java.util.HashMap<String, Integer>();
		String mphone = "";
		try {
			Object[] dbArgs = new Object[] {datetemp2,fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select mphone from all_users where lastlogin>=? and lastlogin<=?",
							dbArgs);
			while(rs.next()) {
				mphone = OAStatUtil.getPlatform(rs.getString("mphone"));
				if(map.containsKey(mphone)){
					map.put(mphone, map.get(mphone)+1);
				}else{
					map.put(mphone, 1);
				}
			}
		} catch (Exception e) {
		}
		return map;
	}
*/	
	static public Map<String,Map<String,Integer>> getFreeGiftMap(Date date){
		Map<String,Map<String,Integer>> result = new HashMap<String,Map<String,Integer>>();
		try {

			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient.execSQLQuery(
							"select type,item,amount from freepresent where ftime=?",
							dbArgs);
			String type = "";
			String item = "";
			int amount = 0;
			while(rs.next()) {
				type = rs.getString("type");
				item = rs.getString("item");
				amount = rs.getInt("amount");
				if(result.containsKey(type)){
					result.get(type).put(item,amount);
				}else{
					Map<String,Integer> map = new HashMap<String,Integer>();
					map.put(item, amount);
					result.put(type, map);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	static public ArrayList<String> getItemCountName(){
		ArrayList<String> nameList = new ArrayList<String>();
		try {

			Object[] dbArgs = new Object[] {};
			DBResultSet rs = dbClient.execSQLQuery(
							"select distinct item from itemCountTimes",
							dbArgs);
			while(rs.next()) {
				nameList.add(rs.getString("item"));
			}
		} catch (Exception e) {
//			logger.error("getSelling_goldFromAtoB with item=" + item + " amount=" + result
//					+ " fromTime=" + fromTime + " toTime=" + toTime, e);
		}
		return nameList;
	}
	
	static public Map<String, Integer> getItemCountMap(Date fromTime,Date toTime){
		int result = 0;
		java.util.Map<String, Integer> map = new java.util.HashMap<String, Integer>();
		ArrayList<String> itemList = new ArrayList<String>();
		try {

			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item from itemCountTimes where ctime >= ? and ctime < ? order by id",
							dbArgs);
			while(rs.next()) {
				itemList.add(rs.getString("item"));
			}
		} catch (Exception e) {
//			logger.error("getSelling_goldFromAtoB with item=" + item + " amount=" + result
//					+ " fromTime=" + fromTime + " toTime=" + toTime, e);
		}
		ArrayList<Integer> timesList = new ArrayList<Integer>();
		try {

			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select times from itemCountTimes where ctime >= ? and ctime < ? order by id",
							dbArgs);
			while(rs.next()) {
				result = rs.getInt("times");
				timesList.add(result);
			}
		} catch (Exception e) {
		}
		
		for(int i =0;i<itemList.size();i++){
			map.put(itemList.get(i),timesList.get(i));
		}
		
		return map;
		
	}
	
	static public Map<String, Integer> getUsingFromAtoB(Date fromTime,Date toTime,String type){
		int result = 0;
		java.util.Map<String, Integer> map = new java.util.HashMap<String, Integer>();
		ArrayList<Integer> amountList = new ArrayList<Integer>();
		try {

			Object[] dbArgs = new Object[] {fromTime,toTime,type};
			DBResultSet rs = dbClient.execSQLQuery(
							"select amount from using where utime >= ? and utime < ? and type=? order by id ",
							dbArgs);
			while(rs.next()) {
				result = rs.getInt("amount");
				amountList.add(result);
			}
		} catch (Exception e) {
		}
		ArrayList<String> nameList = new ArrayList<String>();
		try {

			Object[] dbArgs = new Object[] {fromTime,toTime,type};
			DBResultSet rs = dbClient.execSQLQuery(
							"select iname from using where utime >= ? and utime < ? and type=? order by id ",
							dbArgs);
			while(rs.next()) {
				nameList.add(rs.getString("iname"));
			}
		} catch (Exception e) {
		}
		for(int i =0;i<nameList.size();i++){
			map.put(nameList.get(i),amountList.get(i));
		}
		
		return map;
	}
	
	static public int countIndexAmount(Date fTime){
		int result = 0;
		try {

			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select sum(indexp) as amount from mplh where vdate=?",dbArgs);
			if(rs.next()) {
				result = rs.getInt("amount");
			}
		} catch (Exception e) {

		}
		return result;
	}
	
	static public int countMorangeIndexAmount(Date fTime,String flag){
		int result = 0;
		try {
			flag += "%";
			Object[] dbArgs = new Object[] {fTime,flag};
			DBResultSet rs = dbClient.execSQLQuery(
							"select sum(indexp) as amount from mplh where vdate=? and morange like ?",dbArgs);
			if(rs.next()) {
				result = rs.getInt("amount");
			}
		} catch (Exception e) {

		}
		return result;
	}
	
	static public int countMainAmount(Date fTime){
		int result = 0;
		try {

			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select sum(mainp) as amount from mplh where vdate=?",dbArgs);
			if(rs.next()) {
				result = rs.getInt("amount");
			}
		} catch (Exception e) {

		}
		return result;
	}
	
	static public int countMorangeMainAmount(Date fTime,String flag){
		int result = 0;
		try {
			flag += "%";
			Object[] dbArgs = new Object[] {fTime,flag};
			DBResultSet rs = dbClient.execSQLQuery(
							"select sum(mainp) as amount from mplh where vdate=? and morange like ?",dbArgs);
			if(rs.next()) {
				result = rs.getInt("amount");
			}
		} catch (Exception e) {

		}
		return result;
	}
	
	static public int countTotalIndexAmount(Date fTime){
		int result = 0;
		try {

			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select sum(indexp) as amount from mplh where vdate=?",dbArgs);
			if(rs.next()) {
				result = rs.getInt("amount");
			}
		} catch (Exception e) {

		}
		return result;
	}
	
	static public int countPlayAmount(Date fTime){
		int result = 0;
		try {

			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select sum(playp) as amount from mplh where vdate=?",dbArgs);
			if(rs.next()) {
				result = rs.getInt("amount");
			}
		} catch (Exception e) {

		}
		return result;
	}
	
	static public int countMorangePlayAmount(Date fTime,String flag){
		int result = 0;
		try {
			flag += "%";
			Object[] dbArgs = new Object[] {fTime,flag};
			DBResultSet rs = dbClient.execSQLQuery(
							"select sum(playp) as amount from mplh where vdate=? and morange like ?",dbArgs);
			if(rs.next()) {
				result = rs.getInt("amount");
			}
		} catch (Exception e) {

		}
		return result;
	}
	
	
	//
	static public ArrayList<String> getMobilePhoneModelList(Date fTime,String flag){
		ArrayList<String> modelList = new ArrayList<String>();
		try {
			flag += "%";
			Object[] dbArgs = new Object[] {fTime,flag};
			DBResultSet rs = dbClient.execSQLQuery(
							"select model from mplh where vdate=? and morange like ? order by indexp desc,mainp",dbArgs);
			while(rs.next()) {
				modelList.add(rs.getString("model"));
			}
		} catch (Exception e) {

		}
		return modelList;
	}
	
	
	
	
	
	static public ArrayList<Integer> getIndexAmountList(Date fTime,String flag){
		ArrayList<Integer> indexList = new ArrayList<Integer>();
		try {
			flag += "%";
			Object[] dbArgs = new Object[] {fTime,flag};
			DBResultSet rs = dbClient.execSQLQuery(
							"select indexp from mplh where vdate=? and morange like ? order by indexp desc,mainp",
							dbArgs);
			while(rs.next()) {
				indexList.add(rs.getInt("indexp"));
			}
		} catch (Exception e) {

		}
		return indexList;
	}
	
	static public ArrayList<Integer> getMainAmountList(Date fTime,String flag){
		ArrayList<Integer> mainList = new ArrayList<Integer>();
		try {
			flag += "%";
			Object[] dbArgs = new Object[] {fTime,flag};
			DBResultSet rs = dbClient.execSQLQuery(
							"select mainp from mplh where vdate=? and morange like ? order by indexp desc,mainp",
							dbArgs);
			while(rs.next()) {
				mainList.add(rs.getInt("mainp"));
			}
		} catch (Exception e) {

		}
		return mainList;
	}
	
	static public ArrayList<Integer> getPlayAmountList(Date fTime,String flag){
		ArrayList<Integer> playList = new ArrayList<Integer>();
		try {
			flag += "%";
			Object[] dbArgs = new Object[] {fTime,flag};
			DBResultSet rs = dbClient.execSQLQuery(
							"select playp from mplh where vdate=? and morange like ? order by indexp desc,mainp",
							dbArgs);
			while(rs.next()) {
				playList.add(rs.getInt("playp"));
			}
		} catch (Exception e) {

		}
		return playList;
	}
	
	static public java.util.Map<String, Integer> getUVPV(Date fromTime,Date toTime){
		int result = 0;
		java.util.Map<String, Integer> map = new java.util.HashMap<String, Integer>();
		ArrayList<String> pages = OAStatUtil.getItemPageList();
//		ArrayList<Integer> ar = new ArrayList<Integer>();
		try {
			for(int i =0;i<pages.size();i++){
				Object[] dbArgs = new Object[] {pages.get(i),fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select max(amount) as amount from uvpv where item=? and ctime>=? and ctime<?",
						dbArgs);
				if(rs.next()) {
					result = rs.getInt("amount");
					map.put(pages.get(i),result);
				}
			}
		} catch (Exception e) {
//			logger.error("getSellingFromAtoB with item=" + item + " amount=" + result
//					+ " fromTime=" + fromTime + " toTime=" + toTime, e);
		}
		
		return map;
	}
	
	static public java.util.Map<String, Integer> getUVPV_newUser(Date fromTime,Date toTime){
		int result = 0;
		java.util.Map<String, Integer> map = new java.util.HashMap<String, Integer>();
		ArrayList<String> pages = OAStatUtil.getItemNewUserPageList();
//		ArrayList<Integer> ar = new ArrayList<Integer>();
		try {
			for(int i =0;i<pages.size();i++){
				Object[] dbArgs = new Object[] {pages.get(i),fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select max(amount) as amount from new_user_pv where item=? and ctime>=? and ctime<?",
						dbArgs);
				if(rs.next()) {
					result = rs.getInt("amount");
					map.put(pages.get(i),result);
				}
			}
		} catch (Exception e) {
//			logger.error("getSellingFromAtoB with item=" + item + " amount=" + result
//					+ " fromTime=" + fromTime + " toTime=" + toTime, e);
		}
		
		return map;
	}
	
	static public java.util.Map<String, Integer> getCheckInResult(Date fromTime,Date toTime){
		int result = 0;
		java.util.Map<String, Integer> map = new java.util.HashMap<String, Integer>();
	
		try {
				Object[] dbArgs = new Object[] {fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select *  from CheckInCount where stime>=? and stime<?",
						dbArgs);
				if(rs.next()) {
					result = rs.getInt("users");
					map.put("UV",result);
					result = rs.getInt("pv");
					map.put("PV",result);
					result = rs.getInt("everyDay");
					map.put("OneDay",result);
					result = rs.getInt("ThreeDay");
					map.put("ThreeDay",result);
					result = rs.getInt("FiveDay");
					map.put("FiveDay",result);
					result = rs.getInt("SevenDay");
					map.put("SevenDay",result);
					result = rs.getInt("FifDay");
					map.put("FifDay",result);
					result = rs.getInt("UpThirty");
					map.put("UpThirty",result);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		int result1=0;
		String result2=null;
		try 
		{
			Object[] dbArgs = new Object[] {fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
					"select item,amount from freetool where gettype='checkInGift' and fdate>=? and fdate<=? order by item",
					dbArgs);
			while(rs.next()) {
				result1 = rs.getInt("amount");
				result2 = rs.getString("item");
				map.put(result2,result1);
			}
	     } catch (Exception e) {
		         e.printStackTrace();
	       }
		return map;
	}
	
	static public ArrayList<String> getCheckInItem(Date fromTime,Date toTime){
		ArrayList<String> list = new ArrayList<String>();
		try {
				Object[] dbArgs = new Object[] {fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select distinct item from freetool where gettype='checkInGift' and fdate>=? and fdate<=? order by item",
						dbArgs);
				while(rs.next()) {
					list.add(rs.getString("item"));
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	static public ArrayList<Integer> Top200Id(Date fromTime,Date toTime){
		int monetId = 0;
		ArrayList<Integer> id = new ArrayList<Integer>();
	
		try {
				Object[] dbArgs = new Object[] {fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select * from top200 where stime>=? and stime<? order by ranking",
						dbArgs);
				while(rs.next()) {
					monetId = rs.getInt("monetId");
					id.add(monetId);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}
	static public java.util.Map<Integer,Long> Top200Points(Date fromTime,Date toTime){
		Long points = null;
		int monetid = 0;
		java.util.Map<Integer,Long> map = new java.util.HashMap<Integer,Long>();
		try {
				Object[] dbArgs = new Object[] {fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select * from top200 where stime>=? and stime<? order by ranking",
						dbArgs);
				while(rs.next()) {
					monetid = rs.getInt("monetId");
					points = rs.getLong("points");
					map.put(monetid,points);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	static public java.util.Map<Integer,Long> Top200ZhaiyuePoints(Date fromTime,Date toTime){
		Long points = null;
		int monetid = 0;
		java.util.Map<Integer,Long> map = new java.util.HashMap<Integer,Long>();
		try {
				Object[] dbArgs = new Object[] {fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select * from top200 where stime>=? and stime<? order by ranking",
						dbArgs);
				while(rs.next()) {
					monetid = rs.getInt("monetId");
					points = rs.getLong("zhaiyue");
					map.put(monetid,points);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	static public java.util.Map<Integer,Long> Top200fishing(Date fromTime,Date toTime){
		Long points = null;
		int monetid = 0;
		java.util.Map<Integer,Long> map = new java.util.HashMap<Integer,Long>();
		try {
				Object[] dbArgs = new Object[] {fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select * from top200 where stime>=? and stime<? order by ranking",
						dbArgs);
				while(rs.next()) {
					monetid = rs.getInt("monetId");
					points = rs.getLong("fishing");
					map.put(monetid,points);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	static public java.util.Map<Integer,Long> Top200Attack(Date fromTime,Date toTime){
		Long points = null;
		int monetid = 0;
		java.util.Map<Integer,Long> map = new java.util.HashMap<Integer,Long>();
		try {
				Object[] dbArgs = new Object[] {fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select * from top200 where stime>=? and stime<? order by ranking",
						dbArgs);
				while(rs.next()) {
					monetid = rs.getInt("monetId");
					points = rs.getLong("attack");
					map.put(monetid,points);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	static public java.util.Map<Integer,Long> Top200Defense(Date fromTime,Date toTime){
		Long points = null;
		int monetid = 0;
		java.util.Map<Integer,Long> map = new java.util.HashMap<Integer,Long>();
		try {
				Object[] dbArgs = new Object[] {fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select * from top200 where stime>=? and stime<? order by ranking",
						dbArgs);
				while(rs.next()) {
					monetid = rs.getInt("monetId");
					points = rs.getLong("defense");
					map.put(monetid,points);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	static public java.util.Map<Integer,Long> Top200Monster(Date fromTime,Date toTime){
		Long points = null;
		int monetid = 0;
		java.util.Map<Integer,Long> map = new java.util.HashMap<Integer,Long>();
		try {
				Object[] dbArgs = new Object[] {fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select * from top200 where stime>=? and stime<? order by ranking",
						dbArgs);
				while(rs.next()) {
					monetid = rs.getInt("monetId");
					points = rs.getLong("monster");
					map.put(monetid,points);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	static public java.util.Map<Integer,Integer> Top200Abomb(Date fromTime,Date toTime){
		int points = 0;
		int monetid = 0;
		java.util.Map<Integer,Integer> map = new java.util.HashMap<Integer,Integer>();
		try {
				Object[] dbArgs = new Object[] {fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select * from top200 where stime>=? and stime<? order by ranking",
						dbArgs);
				while(rs.next()) {
					monetid = rs.getInt("monetId");
					points = rs.getInt("abomb");
					map.put(monetid,points);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	static public java.util.Map<Integer,Double> Top200Credit(Date fromTime,Date toTime){
		double points = 0.0;
		int monetid = 0;
		java.util.Map<Integer,Double> map = new java.util.HashMap<Integer,Double>();
		try {
				Object[] dbArgs = new Object[] {fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select * from top200 where stime>=? and stime<? order by ranking",
						dbArgs);
				while(rs.next()) {
					monetid = rs.getInt("monetId");
					points = rs.getDouble("credit");
					map.put(monetid,points);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	static public java.util.Map<Integer,Double> Top200Addvalue(Date fromTime,Date toTime){
		double points = 0.0;
		int monetid = 0;
		java.util.Map<Integer,Double> map = new java.util.HashMap<Integer,Double>();
		try {
				Object[] dbArgs = new Object[] {fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select * from top200 where stime>=? and stime<? order by ranking",
						dbArgs);
				while(rs.next()) {
					monetid = rs.getInt("monetId");
					points = rs.getDouble("addvalue");
					map.put(monetid,points);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	static public java.util.Map<Integer,Double> Top200Payment(Date fromTime,Date toTime){
		double points = 0.0;
		int monetid = 0;
		java.util.Map<Integer,Double> map = new java.util.HashMap<Integer,Double>();
		try {
				Object[] dbArgs = new Object[] {fromTime,toTime};
				DBResultSet rs = dbClient.execSQLQuery(
						"select * from top200 where stime>=? and stime<? order by ranking",
						dbArgs);
				while(rs.next()) {
					monetid = rs.getInt("monetId");
					points = rs.getDouble("payment");
					map.put(monetid,points);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	static public java.util.Map<String,Long> PersonalPoints(String type,Date date){
		java.util.Map<String,Long> map = new java.util.HashMap<String,Long>();
		try {
				Object[] dbArgs = new Object[] {type,date};
				DBResultSet rs = dbClient.execSQLQuery(
						"select sname,amount from personalCP where type=? and stime=?",
						dbArgs);
				while(rs.next()) {
					map.put(rs.getString("sname"),rs.getLong("amount"));
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	static public java.util.Map<String,Long> getBuzzPUv(){
		
		return null;
	}
}
