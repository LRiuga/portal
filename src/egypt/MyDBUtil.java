package egypt;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.MoDBRW;

public class MyDBUtil{
	public static String dburl = null;
	public static String dbDriver = null;
	public static MoDBRW db = null;
	static Logger logger = Logger.getLogger(MyDBUtil.class);
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration("system.properties"));
			Configuration serverConf = settings.subset("service");
			dburl = serverConf.getString("dbReadUrls");
			dbDriver = serverConf.getString("dbDriver");
			db = new MoDBRW(dburl,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
}