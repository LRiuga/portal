package activity;

import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class PhoneTicket {
	static Logger logger = Logger.getLogger(PhoneTicket.class);
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
	
	//get total user
	public static int StatsTotalUser(String type,Date fromDate,Date toDate){
		int number = 0;
		
		if(type=="All"){
			try {
				Object[] dbArgs = new Object[] {fromDate,toDate};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select count(distinct monetid) as amount from applicant where ticketTime>=? and ticketTime<?",
								dbArgs);
				while(rs.next()){
					number = rs.getInt("amount");
				}
			} catch (Exception e) {
				logger.error("StatsTotalUser");
			}
		}else{
			try {
				Object[] dbArgs = new Object[] {fromDate,toDate,type};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select count(distinct monetid) as amount from applicant where ticketTime>=? and ticketTime<? and ticketType=?",
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
	
	public static int StatsTotalAmount(String type,Date fromDate,Date toDate){
		int number = 0;
		
		if(type=="All"){
			try {
				Object[] dbArgs = new Object[] {fromDate,toDate};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select count(*) as amount from applicant where ticketTime>=? and ticketTime<?",
								dbArgs);
				while(rs.next()){
					number = rs.getInt("amount");
				}
			} catch (Exception e) {
				logger.error("StatsTotalUser");
			}
		}else{
			try {
				Object[] dbArgs = new Object[] {fromDate,toDate,type};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select count(*) as amount from applicant where ticketTime>=? and ticketTime<? and ticketType=?",
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
	//get total amount
	public static int StatsTotalAvatar(String type,Date fromDate,Date toDate){
		int number = 0;
		
		if(type=="All"){
			try {
				Object[] dbArgs = new Object[] {fromDate,toDate};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select count(*) as amount from applicant where server_date>=? and server_date<? and msg like 'action=getGift,from=checkInGift,item=Ticket,%'",
								dbArgs);
				while(rs.next()){
					number = rs.getInt("amount");
				}
			} catch (Exception e) {
				logger.error("StatsTotalTicket");
			}
		}else{
			try {
				Object[] dbArgs = new Object[] {fromDate,toDate,type};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select count(*) as amount from applicant where server_date>=? and server_date<? and msg like 'action=getGift,from=checkInGift,item=Ticket,%' and msg like 'weaponType="+type+"'",
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
	
	//get total amount
	public static int StatsSingleMax(String type,Date fromDate,Date toDate){
		int number = 0;
		
		if(type=="All"){
			try {
				Object[] dbArgs = new Object[] {fromDate,toDate};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select top 1 monetid,count(*) as amount from ticket where ticketTime>=? and ticketTime<? group by monetid order by amount desc",
								dbArgs);
				while(rs.next()){
					number = rs.getInt("amount");
				}
			} catch (Exception e) {
				logger.error("StatsTotalTicket");
			}
		}else{
			try {
				Object[] dbArgs = new Object[] {fromDate,toDate,type};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select top 1 monetid,count(*) as amount from ticket where ticketTime>=? and ticketTime<? and ticketType=? group by monetid order by amount desc",
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
	
	//get total amount
	public static ArrayList<Integer> getSortedList(){
		ArrayList<Integer> list = new ArrayList<Integer>();
		
			try {
				Object[] dbArgs = new Object[] {};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select monetid,count(*) as amount from ticket group by monetid order by amount desc",
								dbArgs);
				while(rs.next()){
					list.add(rs.getInt("amount"));
				}
			} catch (Exception e) {
				logger.error("StatsTotalTicket");
			}
		return list;
	}
	
	public static void main(String[] args) {

	}

}
