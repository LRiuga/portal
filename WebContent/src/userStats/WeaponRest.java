package userStats;

import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.OAStatUtil;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class WeaponRest {
	static final Logger logger = Logger.getLogger(WeaponRest.class);
	static String dbReadUrls = null;
	static String db086 = null;
	static String dbDriver = null;
	static MoDBRW dbClient = null;
	static MoDBRW dbClient086 = null;
	
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");

			db086 = serverConf.getString("db086");
			dbReadUrls = serverConf.getString("dbReadUrls");
			dbDriver = serverConf.getString("dbDriver");
			
			dbClient = new MoDBRW(dbReadUrls,dbDriver);
			dbClient086 = new MoDBRW(db086,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	static public DBResultSet getUserWeaponRest(String monetid){
		DBResultSet rs = null;
		try {

			Object[] dbArgs = new Object[] { monetid};
			rs = dbClient086
					.execSQLQuery(
							"select typeId  from weapon where status = 0  and ownerid=? order by typeId desc",
							dbArgs);
		} catch (Exception e) {
			logger.error("getUserWeaponRest with monetid=" + monetid);
		}
		return rs;
	}
	
	static public ArrayList<String> analyzeRsItem(String msg){
		ArrayList<String> item = new ArrayList<String>();
		String type = msg;
		if(type.equals("16")){
			item.add("Super-toolbox");
			item.add("10.0");
		}else
		if(type.equals("15")){
			item.add("Big-Bomb");
			item.add("10.0");
		}else
		if(type.equals("11")){
			item.add("a-bomb defense");
			item.add("6.0");
		}else
		if(type.equals("10")){
			item.add("Missile defense");
			item.add("2.0");
		}else
			if(type.equals("9")){
				item.add("TBox");
				item.add("6.0");
			}else if(type.equals("8")){
				item.add("A-bomb");
				item.add("19.99");
			}else if(type.equals("7")){
				item.add("big-toolbox");
				item.add("4.69");
			}else if(type.equals("6")){
				item.add("middle-toolbox");
				item.add("2.0");
			}else if(type.equals("5")){
				item.add("small-toolbox");
				item.add("0.39");
			}else if(type.equals("4")){
				item.add("shield");
				item.add("4.69");
			}else if(type.equals("3")){
				item.add("big-missile");
				item.add("4.69");
			}else if(type.equals("2")){
				item.add("middle-missile");
				item.add("0.59");
			}else if(type.equals("1")){
				item.add("small-missile");
				item.add("0.39");
			}else{
				item = null;
			}
		
		return item;
	}
	
	static public void deleteUserWeaponRest(String monetid){
		try {

					Object[] dbArgs1 = new Object[] { monetid};
					dbClient.execSQLUpdate(
								"delete from user_weapon_rest where monetid=?",
								dbArgs1);
			
		} catch (Exception e) {
			logger.error("setUserWeaponRest with monetid=" + monetid);
		}
	}
	
	static public void setUserWeaponRest(DBResultSet rs,String monetid){
		try {
			while(rs.next()){
				ArrayList<String> item = analyzeRsItem(rs.getInt("typeId").toString());
				if( item!=null && item.get(0) != ""){
						
				Object[] dbArgs = new Object[] { monetid, item.get(0),Double.parseDouble(item.get(1))};
				dbClient.execSQLUpdate(
							"insert into user_weapon_rest(monetid,item,price) values(?,?,?)",
							dbArgs);
				}
			}
		} catch (Exception e) {
			logger.error("setUserWeaponRest with monetid=" + monetid);
		}
	}
	
	static public int countWeaponRest(String monetid){
		int result = 0;
		try {
			Object[] dbArgs = new Object[] {monetid};
			DBResultSet rs = dbClient.execSQLQuery(
							"select count(*) as amount from user_weapon_rest where monetid like ?",
							dbArgs);
			if(rs.next()){
				result = rs.getInt("amount");
			}else{
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countWeaponRest with monetid=" + monetid);
		}
		return result;
	}
	

	/////
	static public Double countWeaponRestAmount(String monetid){
		Double result = 0.0;
		try {
			Object[] dbArgs = new Object[] {monetid};
			DBResultSet rs = dbClient.execSQLQuery(
							"select sum(price) as amount from user_weapon_rest where monetid like ?",
							dbArgs);
			if(rs.next()){
				result = rs.getDouble("amount");
			}else{
				result = 0.0;
			}
		} catch (Exception e) {
			logger.error("countWeaponRestAmount with monetid=" + monetid);
		}
		return result;
	}
	
	static public ArrayList<String> getWeaponRestItem(String monetid){
		ArrayList<String> itemList = new ArrayList<String>();
		try {
			Object[] dbArgs = new Object[] {monetid};
			DBResultSet rs = dbClient.execSQLQuery(
							"select item as item from user_weapon_rest where monetid like ?",
							dbArgs);
			while(rs.next()){
				itemList.add(rs.getString("item"));
			}
		} catch (Exception e) {
			logger.error("getWeaponRestItem with monetid=" + monetid);
		}
		return itemList;
	}
	
	
	public static void main(String[] args) {
//		Date ftime = new Date(111,7,26);
//		Date ttime = new Date(111,7,29);
		setUserWeaponRest(getUserWeaponRest("17007"),"17007");
//		System.out.println(countCreditTool("17005",ftime,ttime));
//		System.out.println(countCreditAmount("17005",ftime,ttime));
		
//		String msg = "Callback : Add crewTypeId = 8";
//		ArrayList<String> list = analyzeRsItem(msg);
//		for(String it:list){
//			System.out.println(it);
//		}
		
		Date fromTime = OAStatUtil.convertDate("2011-08-19");
		System.out.println(fromTime);
	}
}
