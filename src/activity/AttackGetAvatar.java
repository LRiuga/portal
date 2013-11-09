package activity;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class AttackGetAvatar {
	static Logger logger = Logger.getLogger(AttackGetAvatar.class);
	static String dbDriver = null;
	static String dbWriteUrla = null;
	static MoDBRW dbClient081 = null;
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");
			dbWriteUrla = serverConf.getString("dbWriteUrla");
			dbDriver = serverConf.getString("dbDriver");

			dbClient081 = new MoDBRW(dbWriteUrla,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	
	//get total amount
	public static int StatsTotalAvatar(int type,Date fromDate,Date toDate){
		int number = 0;
		
		if(type==0){
			try {
				Object[] dbArgs = new Object[] {fromDate,toDate};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select count(*) as amount from user_event where server_date>=? and server_date<? and msg like 'TicketGetRomaAavatar,avatarType=22,%'",
								dbArgs);
				while(rs.next()){
					number = rs.getInt("amount");
				}
			} catch (Exception e) {
				logger.error("StatsTotalTicket");
			}
		}else{
			try {
				Object[] dbArgs = new Object[] {fromDate,toDate};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select count(*) as amount from user_event where server_date>=? and server_date<? and msg like 'TicketGetRomaAavatar,avatarType=22,%weaponType="+type+",'",
								dbArgs);
				while(rs.next()){
					number = rs.getInt("amount");
				}
			} catch (Exception e) {
				logger.error("StatsTotalAvatar");
			}
		}
		
		return number;
	}
	
	//get total user
	public static int StatsTotalUser(int type,Date fromDate,Date toDate){
		int number = 0;
		
		if(type==0){
			try {
				Object[] dbArgs = new Object[] {fromDate,toDate};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select count(distinct monetid) as amount from user_event where server_date>=? and server_date<? and msg like 'TicketGetRomaAavatar,avatarType=22,%'",
								dbArgs);
				while(rs.next()){
					number = rs.getInt("amount");
				}
			} catch (Exception e) {
				logger.error("StatsTotalUser");
			}
		}else{
			try {
				Object[] dbArgs = new Object[] {fromDate,toDate};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select count(distinct monetid) as amount from user_event where server_date>=? and server_date<? and msg like 'TicketGetRomaAavatar,avatarType=22,%weaponType="+type+",'",
								dbArgs);
				while(rs.next()){
					number = rs.getInt("amount");
				}
			} catch (Exception e) {
				logger.error("StatsTotalUser");
			}
		}
		
		return number;
	}
	
	//get max amount
	public static int StatsAvatarMax(int type,Date fromDate,Date toDate){
		int number = 0;
		
		if(type==0){
			try {
				Object[] dbArgs = new Object[] {fromDate,toDate};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select top 1 monetid,count(*) as amount from user_event where server_date>=? and server_date<? and msg like 'TicketGetRomaAavatar,avatarType=22,%' group by monetid order by amount desc",
								dbArgs);
				while(rs.next()){
					number = rs.getInt("amount");
				}
			} catch (Exception e) {
				logger.error("StatsAvatarMax");
			}
		}else{
			try {
				Object[] dbArgs = new Object[] {fromDate,toDate};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select top 1 monetid,count(*) as amount from user_event where server_date>=? and server_date<? and msg like 'TicketGetRomaAavatar,avatarType=22,%weaponType="+type+",'" +" group by monetid order by amount desc",
								dbArgs);
				while(rs.next()){
					number = rs.getInt("amount");
				}
			} catch (Exception e) {
				logger.error("StatsTotalTicket");
			}
		}
		
		return number;
	}
	
	
	//get total list
	public static ArrayList<Integer> getSortedList(Date fromDate,Date toDate){
		ArrayList<Integer> list = new ArrayList<Integer>();
		
			try {
				Object[] dbArgs = new Object[] {fromDate,toDate};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select monetid,count(*) as amount from user_event where server_date>=? and server_date<? and msg like 'TicketGetRomaAavatar,avatarType=22,%' group by monetid order by amount desc",
								dbArgs);
				while(rs.next()){
					list.add(rs.getInt("amount"));
				}
			} catch (Exception e) {
				logger.error("getSortedList");
			}
		return list;
	}

	
	//get all
	//get total amount
	public static Map<Integer,Vector<String>> GetAllMsg(Date fromDate,Date toDate){
		Map<Integer,Vector<String>> map = new HashMap<Integer, Vector<String>>();
			try {
				Object[] dbArgs = new Object[] {fromDate,toDate};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select monetid,msg from user_event where server_date>=? and server_date<? and msg like 'TicketGetRomaAavatar,avatarType=22,%'",
								dbArgs);
				while(rs.next()){
					if(map.containsKey(rs.getInt("monetid"))){
						Vector<String> vt = map.get(rs.getInt("monetid"));
						vt.add(rs.getString("msg"));
						map.put(rs.getInt("monetid"),vt);
					}else{
						Vector<String> vt = new Vector<String>();
						vt.add(rs.getString("msg"));
						map.put(rs.getInt("monetid"),vt);
					}
				}
			} catch (Exception e) {
				logger.error("StatsTotalTicket");
			}
		return map;
	}
	
	//get total amount
	public static int StatsTotalAvatar(int type,Date fromDate,Date toDate,Map<Integer,Vector<String>> map){
		int number = 0;
		
		Set<Integer> monetids = map.keySet();
		if(type==0){
			for(int monetid:monetids){
				number += map.get(monetid).size();
			}
		}else{
			for(int monetid:monetids){
				Vector<String> vt = map.get(monetid);
				for(String msg:vt){
					if(msg.contains("weaponType="+type+",")){
						number++;
					}
				}
			}
		}
		return number;
	}
	
	//get total user
	public static int StatsTotalUser(int type,Date fromDate,Date toDate,Map<Integer,Vector<String>> map){
		int number = 0;
		Set<Integer> monetids = map.keySet();
		Set<Integer> tempSet = new HashSet();
		if(type==0){
			number = monetids.size();
		}else{
			for(int monetid:monetids){
				Vector<String> vt = map.get(monetid);
				for(String msg:vt){
					if(msg.contains("weaponType="+type+",")){
						tempSet.add(monetid);
					}
				}
			}
			number = tempSet.size();
		}
		
		return number;
	}
	
	//get total user
	public static int StatsAvatarMax(int type,Date fromDate,Date toDate,Map<Integer,Vector<String>> map){
		Map<Integer,Integer> tempMap = new HashMap<Integer, Integer>();
		int max = 0;
		Set<Integer> monetids = map.keySet();
		if(type==0){
			for(int monetid:monetids){
				if(map.get(monetid).size()>max){
					max = map.get(monetid).size();
				}
			}
		}else{
			for(int monetid:monetids){
				Vector<String> vt = map.get(monetid);
				for(String msg:vt){
					if(msg.contains("weaponType="+type+",")){
						if(tempMap.containsKey(monetid)){
							tempMap.put(monetid,tempMap.get(monetid)+1);
							
						}else{
							tempMap.put(monetid,1);
						}
						if(tempMap.get(monetid)>max){
							max = tempMap.get(monetid);
						}
					}
				}
			}
		}
		
		return max;
	}
}
