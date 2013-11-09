package toolStat;

import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class NewMethod {
	static final Logger logger = Logger.getLogger(NewMethod.class);
	static String dbWriteUrla = null;
	static String dbDriver = null;
	static MoDBRW dbClient = null;

	
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");

			dbWriteUrla = serverConf.getString("dbWriteUrla");
			dbDriver = serverConf.getString("dbDriver");
			dbClient = new MoDBRW(dbWriteUrla,dbDriver);

		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	static public int countNewMethod(String item, Date fromTime,Date toTime) {
		int result = 0;
		try {

			Object[] dbArgs = new Object[] { item, fromTime, toTime };
			DBResultSet rs = dbClient.execSQLQuery(
							"select count(*) as cnt  from user_event where msg like ? and server_date >= ? and server_date<? " +
							"and monetId>50000 and monetId not in (35069284,35894959,35894957,35894960,35894961,35894962)",
							dbArgs);
			if (rs.next()) {
				result = rs.getInt("cnt");
			} else {
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countNewMethod with item=" + item + " fromTime=" + fromTime + " toTime=" + toTime, e);
			result = -1;
		}

		return result;
	}
	
	
	public static void main(String[] args) {

	}

}
