package activity;


import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class BugReport {
	static Logger logger = Logger.getLogger(BugReport.class);
	static String dbDriver = null;
	static String dbWriteUrla = null;
	static MoDBRW dbClient188 = null;
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");
			dbWriteUrla = serverConf.getString("dbWriteUrla");
			dbDriver = serverConf.getString("dbDriver");

			dbClient188 = new MoDBRW(dbWriteUrla,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	public static DBResultSet getResult(String sql,Object[] object){
		//int result = 0;
		DBResultSet rs = null;
		try {
				rs = dbClient188.execSQLQuery(sql,object);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}
}
