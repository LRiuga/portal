package util;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.MoDBRW;

public class DBUtil{
	static String dburl = null;
	static String serverDBURL = null;
	static String dbDriver = null;
	static String dburlconf = null;
	static String protal1dbUrl = null;
	
	public static String serverStr = null;
	public static MoDBRW db = null;
	public static MoDBRW serverDB = null;
	public static MoDBRW protal1DB = null;
	public static MoDBRW dbconf = null;
	static Logger logger = Logger.getLogger(DBUtil.class);
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration("system.properties"));
			Configuration serverConf = settings.subset("service");
			
			serverStr = serverConf.getString("str");
			dburl = serverConf.getString("dbReadUrls");
			
			//protal1dbUrl = serverConf.getString("protal1db");
			//serverDBURL = serverConf.getString("dbWriteUrla");
			
			dbDriver = serverConf.getString("dbDriver");
			db = new MoDBRW(dburl,dbDriver);
			//protal1DB = new MoDBRW(protal1dbUrl,dbDriver);
			//serverDB = new MoDBRW(serverDBURL,dbDriver);
			
			dburlconf = serverConf.getString("db188conf");
			dbconf = new MoDBRW(dburlconf,dbDriver);
			
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
}