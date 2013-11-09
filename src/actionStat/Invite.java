package actionStat;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import OAStat.OAStatistic;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class Invite {
	Connection cn = null;
	CallableStatement cmd = null;
	Statement stmt = null;
	ResultSet rs = null;

	static Logger logger = Logger.getLogger(OAStatistic.class);
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
	
	public static ArrayList<Object> getDateStats(Date fromTime){
		ArrayList<Object> oneDay = new ArrayList<Object>();
		
		try {

			Object[] dbArgs = new Object[] {fromTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from invite where itime = ?",
							dbArgs);
			if(rs.next()) {
				oneDay.add(rs.getInt("invitep"));
				oneDay.add(rs.getInt("ipuser"));
				oneDay.add(rs.getInt("sendc"));
				oneDay.add(rs.getInt("suser"));
				oneDay.add(rs.getInt("accessuser"));
				oneDay.add(rs.getDate("itime"));
			}else{
				oneDay.add(0);
				oneDay.add(0);
				oneDay.add(0);
				oneDay.add(0);
				oneDay.add(0);
				oneDay.add(0);
			}
		} catch (Exception e) {
			logger.error("getDateStats with  fromTime=" + fromTime , e);
		}
		return oneDay;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
