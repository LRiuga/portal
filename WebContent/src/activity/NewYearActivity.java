package activity;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.OAStatUtil;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class NewYearActivity {
	static Logger logger = Logger.getLogger(NewYearActivity.class);
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
	
	public static ArrayList<String> getStringList(Date fromDate,Date toDate){
		ArrayList<String> list = new ArrayList<String>();
		try {
			Object[] dbArgs = new Object[] {fromDate,toDate};
			DBResultSet rs = dbClient081.execSQLQuery(
							"select rtrim(msg) + ',monetid=' + rtrim(monetid) as msg from user_event where server_date>=? and server_date<? " +
							"and (msg like 'action=sell%fish,fishType=%Activity=NewYear%' or msg like 'Callback%Activity=NewYear%' or msg like 'Gold:Abomb,%Activity=NewYear%'" +
							" or msg like 'action=AttackMonster,Use=Weapon,%Activity=NewYear%')",
							dbArgs);
			while(rs.next()){
				list.add(rs.getString("msg"));
			}
		} catch (Exception e) {
			logger.error("getStringList");
		}
		return list;
	}
	
	public static List<Integer> getList(ArrayList<String> logList,String msg1,String msg2){
		List<Integer> list = new ArrayList<Integer>();
		Map<Integer,Integer> map = new HashMap<Integer,Integer>();
		int monetid = 0;
		for(String temp:logList){
			if(temp.contains(msg1)||temp.contains(msg2)){
				monetid = getFileMonetId(temp);
				if(monetid != 0 && !OAStatUtil.isTestAccount(monetid)&&monetid!=20001){
					if(map.containsKey(monetid)){
						map.put(monetid,map.get(monetid)+1);
					}else{
						map.put(monetid,1);
					}
				}
			}
		}
		Set<Integer> idSet = map.keySet();
		for(int id:idSet){
			list.add(map.get(id));
		}
		Collections.sort(list);
		return list;
	}
	
	static public int getFileMonetId(String temp) {
		String id = "";
		if(temp.contains("monetid=")){
			int start = 0;
			start = temp.indexOf("monetid=") + 8;
			temp = temp.substring(start);
		}
		int monetid = 0;
		try{
			monetid = Integer.parseInt(temp);
		}catch(Exception e){
			
		}
		return monetid;
	}
}
