package userStats;

import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class Playable {
	static final Logger logger = Logger.getLogger(Playable.class);
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

			dbReadUrls = serverConf.getString("dbReadUrls");
			dbDriver = serverConf.getString("dbDriver");
			
			dbClient = new MoDBRW(dbReadUrls,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	public static ArrayList<String> getVersion(){
		ArrayList<String> versions = new ArrayList<String>();
		versions.add("old");
		versions.add("4tab");
		versions.add("Squares");
		return versions;
	}
	
	static public ArrayList<Integer> getList(String type,String morange,Date pdate){
		ArrayList<Integer> list = new ArrayList<Integer>();
		DBResultSet rs = null;
		Object[] dbArgs = new Object[] {type,morange,pdate};
		try {
				rs = dbClient.execSQLQuery(
						"select indexa,main,play from playableStat where type=? and morange like ? and pdate = ?",
						dbArgs);
				if(rs.next())
				{
					list.add(rs.getInt("indexa"));
					list.add(rs.getInt("main"));
					list.add(rs.getInt("play"));
				}else{
					list.add(0);
					list.add(0);
					list.add(0);
				}
		} catch (Exception e) {
			logger.error("getModelList ", e);
		}
		return list;
	}
}
