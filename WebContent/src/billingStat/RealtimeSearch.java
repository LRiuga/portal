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

import util.DBUtil;
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
			settings.addConfiguration(new PropertiesConfiguration("system.properties"));
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
			DBResultSet rs = DBUtil.serverDB.execSQLQuery("select sum(amount)/100 as amount from callbackstc where date>=?",dbArgs);
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
			DBResultSet rs = DBUtil.serverDB.execSQLQuery("select count(distinct monet_id) as amount from callbackstc where date>=?",
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
			String path = ccuUrl +"\\" + MyUtil.DateToString(date)+".txt";
			
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
			DBResultSet rs = DBUtil.serverDB.execSQLQuery("select count(distinct monetid) as amount from fisher where newuserflag>=?",
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
		GregorianCalendar gc = new GregorianCalendar(fromWhen.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen.get(Calendar.DAY_OF_MONTH));
		gc.add(Calendar.DATE,0);
		date = (Date) gc.getTime();
		try {
			DBResultSet rs = DBUtil.db.execSQLQuery("select * from itembuy where btime >= ? and server= ?",new Object[] {date,DBUtil.serverStr});
			while(rs.next()){
				String itemName = rs.getString("item");
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
			//DBResultSet rs = dbClient_config.execSQLQuery("select itemCreditText,creditPrice from shopitem where ((itemtype='crew' or itemtype='FishTackle') and itemAmount=1 ) or (itemtype='weapon' and (itemtypeid>21 or (itemtypeid>4 and itemtypeid<8) or itemtypeid=16)and itemamount=1) or (itemtype='other' and itemamount=1 and itemtypeid=1) or (itemtype='General' and creditPrice>0) or itemtype='Speaker' or itemtype='TribeIcon' or itemtype='AutoFishing'",dbArgs);
			DBResultSet rs = dbClient_config.execSQLQuery("select itemCreditText,creditPrice from shopitem where itemCreditText in('big-toolbox','D1','D2','D3','D4','M1','M2','M2*10','M3','M3*10','M4','M4*10','M5','M5*5','M6','M6*5','M7','M7*5','M8','M8*3','M9','M9*3','middle-toolbox','small-toolbox','super-toolbox','T1','T2','T3','AutoFishing2Hrs','AutoFishing3Hrs','AutoFishing4Hrs','AutoFishing6Hrs','AutoFishing8Hrs','Fish_Trader','Guard','Insurance','Prophet','Robber','Spy','Thief','Sailor','AbomasnowTransfigurationCard15','AbomasnowTransfigurationCard3','CharmanderTransfigurationCard15','CharmanderTransfigurationCard3','RaichuTransfigurationCard15','RaichuTransfigurationCard3','CheckIn','CheckIn*5','SMALL_SPEAKER','SMALL_SPEAKER_10','BIG_SPEAKER','BIG_SPEAKER_10','Freeze_card','Refresh_keeping_card','SummonCard','TribeIcon1','TribeIcon2','TribeIcon7','TribeIcon8')",dbArgs);
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
		Map<String,Set<String>> nameMap = new HashMap<String,Set<String>>();
		Set<String> misslle = new HashSet<String>();
		for(int i=1;i<=9;i++){
			misslle.add("M"+i);
		}
		misslle.add("M2*10");misslle.add("M3*10");misslle.add("M4*10");misslle.add("M5*5");misslle.add("M6*5");misslle.add("M7*5");misslle.add("M8*3");misslle.add("M9*3");
		nameMap.put("Missile", misslle);
		
		Set<String> tbomb = new HashSet<String>();
		for(int i=1;i<=4;i++){
			tbomb.add("T"+i);
		}
		nameMap.put("Tbomb", tbomb);
		
		Set<String> defense = new HashSet<String>();
		for(int i=1;i<=4;i++){
			defense.add("D"+i);
		}
		nameMap.put("Defense", defense);
		
		Set<String> lucky = new HashSet<String>();
		lucky.add("checkin");lucky.add("checkin*5");lucky.add("EquipmentLuckyDraw");
		nameMap.put("LuckyDraw", lucky);
		
		Set<String> card = new HashSet<String>();
		card.add("Freeze_card");card.add("Refresh_keeping_card");card.add("SummonCard");
		nameMap.put("Card", card);
		
		Set<String> crew = new HashSet<String>();
		crew.add("Sailor");crew.add("Thief");crew.add("Prophet");crew.add("Insurance");
		crew.add("Fish_Trader");crew.add("Guard");crew.add("Robber");crew.add("Spy");
		nameMap.put("Crew", crew);
		
		Set<String> other = new HashSet<String>();
		other.add("TribeIcon1");
		other.add("TribeIcon2");
		other.add("TribeIcon7");
		other.add("TribeIcon8");
		nameMap.put("Other", other);
		
		Set<String> autoFishing = new HashSet<String>();
		autoFishing.add("AutoFishing2Hrs");
		autoFishing.add("AutoFishing3Hrs");
		autoFishing.add("AutoFishing4Hrs");
		autoFishing.add("AutoFishing6Hrs");
		autoFishing.add("AutoFishing8Hrs");
		nameMap.put("AutoFishing", autoFishing);
		
		
		Set<String> speaker = new HashSet<String>();
		speaker.add("BIG_SPEAKER");
		speaker.add("BIG_SPEAKER_10");
		speaker.add("SMALL_SPEAKER");
		speaker.add("SMALL_SPEAKER_10");
		nameMap.put("Speaker", speaker);
		
		Set<String> pet = new HashSet<String>();
		pet.add("AbomasnowTransfigurationCard15");
		pet.add("AbomasnowTransfigurationCard3");
		pet.add("CharmanderTransfigurationCard15");
		pet.add("CharmanderTransfigurationCard3");
		pet.add("RaichuTransfigurationCard15");
		pet.add("RaichuTransfigurationCard3");
		nameMap.put("Pet", pet);
		return nameMap;
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
			DBResultSet rs = DBUtil.db.execSQLQuery("select count(distinct monetid) amount from itembuy where btime >=? and server = ?",new Object[] {date,DBUtil.serverStr});
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
		String abc ="1,2,3";
		String a [] = abc.split(",");
		System.out.println(a[1]);
	}
}

