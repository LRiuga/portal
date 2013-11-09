package userStats;

import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class MissionStats {
	static final Logger logger = Logger.getLogger(MissionStats.class);
	static String dbReadUrls = null;
	static String dbDriver = null;
	static MoDBRW dbClient = null;
	
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");

			dbReadUrls = serverConf.getString("dbReadUrls");
			dbDriver = serverConf.getString("dbDriver");
			
			dbClient = new MoDBRW(dbReadUrls,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	static public ArrayList<Integer> getMissionTotalData(Date ftime){
		ArrayList<Integer> list = new ArrayList<Integer>();
		DBResultSet rs = null;
		try {
			Object[] dbArgs = new Object[] {ftime};
			rs = dbClient.execSQLQuery(
							"select rUser,rMission,rMax,rMin,fUser,fMission,fMax,fMin from missionStats where mTime=?",
							dbArgs);
			if(rs.next()){
				list.add(rs.getInt("rUser"));
				list.add(rs.getInt("rMission"));
				list.add(rs.getInt("rMax"));
				list.add(rs.getInt("rMin"));
				list.add(rs.getInt("fUser"));
				list.add(rs.getInt("fMission"));
				list.add(rs.getInt("fMax"));
				list.add(rs.getInt("fMin"));
			}else{
				list.add(0);
				list.add(0);
				list.add(0);
				list.add(0);
				list.add(0);
				list.add(0);
				list.add(0);
				list.add(0);
			}
		} catch (Exception e) {
			logger.error("getData with ftime=" + ftime, e);
		}
		return list;
	}
	
	static public java.util.Map<Integer,ArrayList<Integer>> getSingleMission(Date ftime){
		java.util.Map<Integer,ArrayList<Integer>> map = new java.util.HashMap<Integer,ArrayList<Integer>>();
		
		DBResultSet rs = null;
		try {
			Object[] dbArgs = new Object[] {ftime};
			rs = dbClient.execSQLQuery(
							"select typeid,receive,finish from singleMission where stime=?",
							dbArgs);
			while(rs.next()){
				ArrayList<Integer> list = new ArrayList<Integer>();
				list.add(rs.getInt("receive"));
				list.add(rs.getInt("finish"));
				map.put(rs.getInt("typeid"),list);
			}
		} catch (Exception e) {
			logger.error("getSingleMission with ftime=" + ftime, e);
		}
		return map;
	}
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
