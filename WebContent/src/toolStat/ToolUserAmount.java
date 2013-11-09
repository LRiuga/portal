package toolStat;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.OAStatistic;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class ToolUserAmount {
	Connection cn = null;
	CallableStatement cmd = null;
	Statement stmt = null;
	ResultSet rs = null;

	static Logger logger = Logger.getLogger(ToolUserAmount.class);
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
	
	static public Map<Integer,Integer> getToolUserAmountMap(String item,Date date){
		Map<Integer,Integer> result = new HashMap<Integer,Integer>();
		try {
			Object[] dbArgs = new Object[] {date,item};
			DBResultSet rs = dbClient.execSQLQuery(
							"select amount,count(*) as users from tooluseramount where ttime=? and item=? group by amount",
							dbArgs);
			while(rs.next()) {
				result.put(rs.getInt("amount"),rs.getInt("users"));
			}
		} catch (Exception e) {
			logger.error("getToolUserAmountMap with  date=" + date , e);
		}		
		return result;
	}
}
