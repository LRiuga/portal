package billingStat;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import util.MyUtil;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class RealtimeSearch {
	static final Logger logger = Logger.getLogger(RealtimeSearch.class);
	static String dbReadUrls = null;
	static String dbWriteUrla = null;
	static String dbDriver = null;
	static String dbConfig = null;
	static MoDBRW dbClient = null;
	static MoDBRW dbClient83 = null;
	static MoDBRW dbClient_config = null;
	static String ccuUrl = null;
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");

			dbWriteUrla = serverConf.getString("dbWriteUrla");
			dbReadUrls = serverConf.getString("dbReadUrls");
			dbConfig = serverConf.getString("dbConfig");
			dbDriver = serverConf.getString("dbDriver");
			ccuUrl =  serverConf.getString("ccuUrl");
			
			dbClient = new MoDBRW(dbReadUrls,dbDriver);
			dbClient83 = new MoDBRW(dbWriteUrla,dbDriver);
			dbClient_config = new MoDBRW(dbConfig,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	static public int getTopupAmount(){
		Date date = new Date();
		Calendar fromWhen = Calendar.getInstance();
		fromWhen.setTime(new Date());
		GregorianCalendar gc = new GregorianCalendar(fromWhen
				.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
				.get(Calendar.DAY_OF_MONTH));
		gc.add(Calendar.DATE,0);
		date = (Date) gc.getTime();
		try {
			int money = 0;
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient83.execSQLQuery("select sum(amount)/100 as amount from callbackstc where date>=?",
							dbArgs);
			while(rs.next()){
				money += rs.getInt("amount");
			}
			if(money>0){
				return money;
			}
		} catch (Exception e) {
			logger.error("getTopupAmount");
		}
		return -1;
	}
	
	static public int getTopupUser(){
		Date date = new Date();
		Calendar fromWhen = Calendar.getInstance();
		fromWhen.setTime(new Date());
		GregorianCalendar gc = new GregorianCalendar(fromWhen
				.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
				.get(Calendar.DAY_OF_MONTH));
		gc.add(Calendar.DATE,0);
		date = (Date) gc.getTime();
		try {
			int user = 0;
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient83.execSQLQuery("select count(distinct monet_id) as amount from callbackstc where date>=?",
							dbArgs);
			if(rs.next()){
				user = rs.getInt("amount");
			}
			if(user>0){
				return user;
			}
		} catch (Exception e) {
			logger.error("getTopupUser");
		}
		return -1;
	}
	
	public static ArrayList<String> getCCUList_Realtime(){
		ArrayList<String> list = new ArrayList<String>();
		for(int i=-1;i<1;i++){
			Calendar fromWhen = Calendar.getInstance();
			fromWhen.setTime(new Date());
			GregorianCalendar gc = new GregorianCalendar(fromWhen
					.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
					.get(Calendar.DAY_OF_MONTH));
				gc.add(Calendar.DATE,i);
				Date date = (Date) gc.getTime();
			String path = MyUtil.DateToString(date)+".txt";
			
			if((new File(path)).isFile()){
				BufferedReader br;
				try {
					br = new BufferedReader(new FileReader(path));
					String temp = null;
					temp = br.readLine();
					while (temp != null) {
						String[] string = temp.split(",");
//						if(MyUtil.isMonetid(string[1])){
							list.add(MyUtil.DateToString(date)+" "+string[0]);
							System.out.println(MyUtil.DateToString(date)+" "+string[0]+"!!!"+string[1]);
//						}
						temp = br.readLine();
					}
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
	public static Map<String,Integer> getCCU_Realtime(){
		Map<String,Integer> map = new HashMap<String,Integer>();
		for(int i=-1;i<1;i++){
			Calendar fromWhen = Calendar.getInstance();
			fromWhen.setTime(new Date());
			GregorianCalendar gc = new GregorianCalendar(fromWhen
					.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
					.get(Calendar.DAY_OF_MONTH));
				gc.add(Calendar.DATE,i);
				Date date = (Date) gc.getTime();
				String path = ccuUrl + "\\" +MyUtil.DateToString(date)+".txt";
			if((new File(path)).isFile()){
				BufferedReader br;
				try {
					br = new BufferedReader(new FileReader(path));
					String temp = null;
					temp = br.readLine();
					while (temp != null) {
						String[] string = temp.split(",");
						if(MyUtil.isMonetid(string[1].trim())){
							map.put(MyUtil.DateToString(date)+" "+string[0],Integer.parseInt(string[1].trim()));
							System.out.println(MyUtil.DateToString(date)+" "+string[0]+"!!!!!"+string[1]);
						}
						temp = br.readLine();
					}
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return map;
	}
	
	static public int getNewUser(){
		Date date = new Date();
		Calendar fromWhen = Calendar.getInstance();
		fromWhen.setTime(new Date());
		GregorianCalendar gc = new GregorianCalendar(fromWhen
				.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
				.get(Calendar.DAY_OF_MONTH));
		gc.add(Calendar.DATE,0);
		date = (Date) gc.getTime();
		try {
			int user = 0;
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient83.execSQLQuery("select count(distinct monetid) as amount from fisher where newuserflag>=?",
							dbArgs);
			if(rs.next()){
				user = rs.getInt("amount");
			}
			if(user>0){
				return user;
			}
		} catch (Exception e) {
			logger.error("getNewUser");
		}
		return -1;
	}
	
	static public Map<String,Integer> getBuybyCreditItems(){
		Map<String,Integer> itemMap = new HashMap<String,Integer>();
		Date date = new Date();
		Calendar fromWhen = Calendar.getInstance();
		fromWhen.setTime(new Date());
		GregorianCalendar gc = new GregorianCalendar(fromWhen
				.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
				.get(Calendar.DAY_OF_MONTH));
		gc.add(Calendar.DATE,0);
		date = (Date) gc.getTime();
		try {
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient83.execSQLQuery("select msg from user_event where server_date>=? and msg like 'action=ReduceMoney,%'",
							dbArgs);
			//ArrayList<String> itemList = new ArrayList<String>();
			while(rs.next()){
				String msg = rs.getString("msg");
				String itemName = "";
				
				itemName = MyUtil.getValueOfKey(msg,"ItemName","]");
				if(itemMap.containsKey(itemName)){
					itemMap.put(itemName, itemMap.get(itemName)+1);
				}else{
					itemMap.put(itemName, 1);
				}
			}
			return itemMap;
		} catch (Exception e) {
			logger.error("getBuybyCreditItems");
		}
		return null;
	}

	
	static public Map<String,Integer> getShopItemPrice(){
		try {
			Map<String,Integer> pirceMap = new HashMap<String,Integer>();
			Object[] dbArgs = new Object[] {};
			DBResultSet rs = dbClient_config.execSQLQuery("select itemCreditText,creditPrice from shopitem where ((itemtype='crew' or itemtype='FishTackle') and itemAmount=1 ) or (itemtype='weapon' and (itemtypeid>21 or (itemtypeid>4 and itemtypeid<8) or itemtypeid=16)and itemamount=1) or (itemtype='other' and itemamount=1 and itemtypeid=1) or (itemtype='General' and creditPrice>0) or itemtype='Speaker' or itemtype='TribeIcon' or itemtype='AutoFishing'",dbArgs);
			while(rs.next()){
				String text = rs.getString("itemCreditText");
				int price = rs.getInt("creditPrice");
				pirceMap.put(text, price);
			}
			return pirceMap;
		} catch (Exception e) {
			logger.error("getShopItemPrice");
		}
		return null;
	}
	
	static public Map<String,Set<String>> getShopItemType(){
		try {
			Map<String,Set<String>> nameMap = new HashMap<String,Set<String>>();
			Object[] dbArgs = new Object[] {};
			DBResultSet rs = dbClient_config.execSQLQuery("select itemType,itemCreditText from shopitem where ((itemtype='crew' or itemtype='FishTackle') and itemAmount=1 ) or (itemtype='weapon' and (itemtypeid>21 or (itemtypeid>4 and itemtypeid<8) or itemtypeid=16)and itemamount=1) or (itemtype='other' and itemamount=1 and itemtypeid=1) or (itemtype='General' and creditPrice>0) or itemtype='Speaker' or itemtype='TribeIcon' or itemtype='AutoFishing'",dbArgs);
			while(rs.next()){
				String type = rs.getString("itemType");
				String text = rs.getString("itemCreditText");
				if(nameMap.containsKey(type)){
					Set<String> set = nameMap.get(type);
					set.add(text);
					nameMap.put(type, set);
				}else{
					Set<String> set = new HashSet<String>();
					set.add(text);
					nameMap.put(type, set);
				}
				
			}
			return nameMap;
		} catch (Exception e) {
			logger.error("getShopItemName");
		}
		return null;
	}
	static public int getBuybyCreditUser(){
		Date date = new Date();
		Calendar fromWhen = Calendar.getInstance();
		fromWhen.setTime(new Date());
		GregorianCalendar gc = new GregorianCalendar(fromWhen
				.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
				.get(Calendar.DAY_OF_MONTH));
		gc.add(Calendar.DATE,0);
		date = (Date) gc.getTime();
		try {
			int user = 0;
			Object[] dbArgs = new Object[] {date};
			DBResultSet rs = dbClient83.execSQLQuery("select count(distinct monetid) as amount from user_event where server_date>=? and msg like 'action=ReduceMoney,%'",
							dbArgs);
			if(rs.next()){
				user = rs.getInt("amount");
			}
			if(user>0){
				return user;
			}
		} catch (Exception e) {
			logger.error("getBuybyCreditUser");
		}
		return -1;
	}
	
	public static void main(String[] args) {
		/*Date date = new Date();
		Calendar fromWhen = Calendar.getInstance();
		fromWhen.setTime(new Date());
		GregorianCalendar gc = new GregorianCalendar(fromWhen
				.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
				.get(Calendar.DAY_OF_MONTH));
		gc.add(Calendar.DATE,0);
		date = (Date) gc.getTime();
		System.out.println("date"+date);*/
		
		String abc ="1,2,3";
		String a [] = abc.split(",");
		System.out.println(a[1]);
	}
}

