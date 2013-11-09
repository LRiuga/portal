package newUserBehavior;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class NewUserCP {
	static final Logger logger = Logger.getLogger(NewUserCP.class);
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
	
	static public int countNewUserAmount(Date fTime){
		int result = 0;
		try {
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select count(*) as amount from new_user_behavior where cdate=?",
							dbArgs);
			if(rs.next()){
				result = rs.getInt("amount");
			}else{
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countNewUserAmount with time=" + fTime);
		}
		return result;
	}
	
	static public int countNewMorangeNewUserAmount(Date fTime){
		int result = 0;
		try {
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select count(*) as amount from new_user_behavior where cdate=? and morange like '6%'",
							dbArgs);
			if(rs.next()){
				result = rs.getInt("amount");
			}else{
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countNewUserAmount with time=" + fTime);
		}
		return result;
	}
	
	static public int countNewUserHome(Date fTime){
		int result = 0;
		try {
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select count(*) as amount from new_user_behavior where home='1' and cdate=?",
							dbArgs);
			if(rs.next()){
				result = rs.getInt("amount");
			}else{
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countNewUserHome with time=" + fTime);
		}
		return result;
	}
	
	static public int countNewMorangeNewUserHome(Date fTime){
		int result = 0;
		try {
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select count(*) as amount from new_user_behavior where home='1' and cdate=? and morange like '6%'",
							dbArgs);
			if(rs.next()){
				result = rs.getInt("amount");
			}else{
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countNewUserHome with time=" + fTime);
		}
		return result;
	}
	
	static public int countNewUserPlay(Date fTime){
		int result = 0;
		try {
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select count(*) as amount from new_user_behavior where opt='1' and cdate=?",
							dbArgs);
			if(rs.next()){
				result = rs.getInt("amount");
			}else{
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countNewUserPlay with time=" + fTime);
		}
		return result;
	}
	
	static public int countNewMorangeNewUserPlay(Date fTime){
		int result = 0;
		try {
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select count(*) as amount from new_user_behavior where opt='1' and cdate=? and morange like '6%'",
							dbArgs);
			if(rs.next()){
				result = rs.getInt("amount");
			}else{
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countNewUserPlay with time=" + fTime);
		}
		return result;
	}

	static public ArrayList<String> getOldMorangeNewUserIDList(Date fTime){
		ArrayList<String> idList = new ArrayList<String>();
		try { 
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from new_user_behavior where opt = '0' and cdate=? and morange like '5%' order by home,mphone",
							dbArgs);
			while(rs.next()){
				idList.add(rs.getString("monetid"));
			}
		} catch (Exception e) {
			logger.error("getOldMorangeNewUserIDList with time=" + fTime);
		}
		return idList;
	}
	
	static public ArrayList<String> getNewMorangeNewUserIDList(Date fTime){
		ArrayList<String> idList = new ArrayList<String>();
		try { 
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from new_user_behavior where opt = '0' and cdate=? and morange like '6%' order by home,mphone",
							dbArgs);
			while(rs.next()){
				idList.add(rs.getString("monetid"));
			}
		} catch (Exception e) {
			logger.error("getNewMorangeNewUserIDList with time=" + fTime);
		}
		return idList;
	}
	
	static public ArrayList<String> getOldMorangeNewUserMorangeList(Date fTime){
		ArrayList<String> mpList = new ArrayList<String>();
		try { 
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from new_user_behavior where opt = '0' and cdate=? and morange like '5%' order by home,mphone",
							dbArgs);
			while(rs.next()){
				mpList.add(rs.getString("morange"));
			}
		} catch (Exception e) {
			logger.error("getOldMorangeNewUserMorangeList with time=" + fTime);
		}
		return mpList;
	}
	
	static public ArrayList<String> getNewMorangeNewUserMorangeList(Date fTime){
		ArrayList<String> mpList = new ArrayList<String>();
		try { 
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from new_user_behavior where opt = '0' and cdate=? and morange like '6%' order by home,mphone",
							dbArgs);
			while(rs.next()){
				mpList.add(rs.getString("morange"));
			}
		} catch (Exception e) {
			logger.error("getNewMorangeNewUserMorangeList with time=" + fTime);
		}
		return mpList;
	}
	
	static public ArrayList<String> getOldMorangeNewUserMphoneList(Date fTime){
		ArrayList<String> mpList = new ArrayList<String>();
		try { 
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from new_user_behavior where opt = '0' and cdate=? and morange like '5%' order by home,mphone",
							dbArgs);
			while(rs.next()){
				mpList.add(rs.getString("mphone"));
			}
		} catch (Exception e) {
			logger.error("getOldMorangeNewUserMphoneList with time=" + fTime);
		}
		return mpList;
	}
	
	static public ArrayList<String> getNewMorangeNewUserMphoneList(Date fTime){
		ArrayList<String> mpList = new ArrayList<String>();
		try { 
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from new_user_behavior where opt = '0' and cdate=? and morange like '6%' order by home,mphone",
							dbArgs);
			while(rs.next()){
				mpList.add(rs.getString("mphone"));
			}
		} catch (Exception e) {
			logger.error("getNewMorangeNewUserMphoneList with time=" + fTime);
		}
		return mpList;
	}
	
	static public ArrayList<Integer> getNewMorangeNewUserHomeList(Date fTime){
		ArrayList<Integer> homeList = new ArrayList<Integer>();
		try { 
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from new_user_behavior where opt = '0' and cdate=? and morange like '6%' order by home ",
							dbArgs);
			while(rs.next()){
				homeList.add(rs.getInt("home"));
			}
		} catch (Exception e) {
			logger.error("getNewMorangeNewUserHomeList with time=" + fTime);
		}
		return homeList;
	}
	
	static public ArrayList<Integer> getOldMorangeNewUserHomeList(Date fTime){
		ArrayList<Integer> homeList = new ArrayList<Integer>();
		try { 
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from new_user_behavior where opt = '0' and cdate=? and morange like '5%' order by home ",
							dbArgs);
			while(rs.next()){
				homeList.add(rs.getInt("home"));
			}
		} catch (Exception e) {
			logger.error("getOldMorangeNewUserHomeList with time=" + fTime);
		}
		return homeList;
	}
	
	static public ArrayList<Integer> getNewMorangeNewUserPlayList(Date fTime){
		ArrayList<Integer> playList = new ArrayList<Integer>();
		try { 
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from new_user_behavior where opt = '0' and cdate=? and morange like '6%' order by home ",
							dbArgs);
			while(rs.next()){
				playList.add(rs.getInt("opt"));
			}
		} catch (Exception e) {
			logger.error("getNewMorangeNewUserPlayList with time=" + fTime);
		}
		return playList;
	}
	
	static public ArrayList<Integer> getOlrMorangeNewUserPlayList(Date fTime){
		ArrayList<Integer> playList = new ArrayList<Integer>();
		try { 
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from new_user_behavior where opt = '0' and cdate=? and morange like '5%' order by home ",
							dbArgs);
			while(rs.next()){
				playList.add(rs.getInt("opt"));
			}
		} catch (Exception e) {
			logger.error("getOlrmorangeNewUserPlayList with time=" + fTime);
		}
		return playList;
	}
	
	public static void main(String args[]){
		Date fTime = new Date();
		Date tTime = new Date();
		
		Calendar fromWhen = Calendar.getInstance();
		fromWhen.setTime(fTime);
		GregorianCalendar gc = new GregorianCalendar(fromWhen
				.get(Calendar.YEAR), fromWhen.get(Calendar.MONTH), fromWhen
				.get(Calendar.DAY_OF_MONTH));
		gc.add(Calendar.DATE, -1);
		fTime = (Date) gc.getTime();
		
		System.out.println(countNewUserAmount(fTime));
		System.out.println(countNewUserHome(fTime));
		System.out.println(countNewUserPlay(fTime));
	}
}
