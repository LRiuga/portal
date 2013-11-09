package activity;

import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class CharmStats {
	static Logger logger = Logger.getLogger(CharmStats.class);
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
	
	public static int getAmount(Date fromTime,Date toTime,String type){
		int result = 0;
		Object[] dbArgs = null;
		DBResultSet rs = null;
		try {
			if(type.equals("All")){
				dbArgs = new Object[] {fromTime,toTime};
				rs = dbClient081.execSQLQuery(
						"select sum(charmPoint) as amount from CharmLog where actionTime>=? and actionTime<? and monetid>50000",
						dbArgs);
			}else{
				dbArgs = new Object[] {fromTime,toTime,type};
				rs = dbClient081.execSQLQuery(
						"select sum(charmPoint) as amount from CharmLog where actionTime>=? and actionTime<? and info=?  and monetid>50000",
						dbArgs);
			}
			if(rs.next()){
				result = rs.getInt("amount");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static int getUsers(Date fromTime,Date toTime,String type){
		int result = 0;
		Object[] dbArgs = null;
		DBResultSet rs = null;
		try {
			if(type.equals("All")){
				dbArgs = new Object[] {fromTime,toTime};
				rs = dbClient081.execSQLQuery(
						"select count(distinct monetid) as amount from CharmLog where actionTime>=? and actionTime<? and monetid>50000",
						dbArgs);
			}else{
				dbArgs = new Object[] {fromTime,toTime,type};
				rs = dbClient081.execSQLQuery(
						"select count(distinct monetid) as amount from CharmLog where actionTime>=? and actionTime<? and info=? and monetid>50000",
						dbArgs);
			}
			if(rs.next()){
				result = rs.getInt("amount");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static int getMaxAmountPU(Date fromTime,Date toTime,String type){
		int result = 0;
		Object[] dbArgs = null;
		DBResultSet rs = null;
		try {
			if(type.equals("All")){
				dbArgs = new Object[] {fromTime,toTime};
				rs = dbClient081.execSQLQuery(
						"select top 1 sum(charmPoint) as amount from CharmLog where actionTime>=? and actionTime<? and monetid>50000 group by monetid order by amount desc",
						dbArgs);
			}else{
				dbArgs = new Object[] {fromTime,toTime,type};
				rs = dbClient081.execSQLQuery(
						"select top 1 sum(charmPoint) as amount from CharmLog where actionTime>=? and actionTime<? and monetid>50000 and info=? group by monetid order by amount desc",
						dbArgs);
			}
			if(rs.next()){
				result = rs.getInt("amount");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static int getMaxAmountPU_GiftLow(Date fromTime,Date toTime){
		int result = 0;
		Object[] dbArgs = null;
		DBResultSet rs = null;
		try {
			
			dbArgs = new Object[] {fromTime,toTime};
			rs = dbClient081.execSQLQuery(
					"select top 1 sum(charmPoint) as amount from CharmLog where actionTime>=? and actionTime<? and monetid>50000 and info='gift' group by monetid order by amount",
					dbArgs);
			
			if(rs.next()){
				result = rs.getInt("amount");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static ArrayList<Long> getSortedList(){
		ArrayList<Long> list = new ArrayList<Long>();
		
			try {
				Object[] dbArgs = new Object[] {};
				DBResultSet rs = dbClient081.execSQLQuery(
								"select charmpoint from charm where monetid>50000 and charmpoint>0 order by charmpoint desc",
								dbArgs);
				while(rs.next()){
					list.add(rs.getLong("charmpoint"));
				}
			} catch (Exception e) {
				logger.error("StatsTotalTicket");
			}
		return list;
	}
}
