package uvpvStats;

import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class PageAccessTime {
	static final Logger logger = Logger.getLogger(PageAccessTime.class);
	static String dbReadUrls = null;
	static String db081 = null;
	static String dbDriver = null;
	static MoDBRW dbClient = null;
	static MoDBRW dbClient081 = null;
	
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");

			db081 = serverConf.getString("db081");
			dbReadUrls = serverConf.getString("dbReadUrls");
			dbDriver = serverConf.getString("dbDriver");
			
			dbClient = new MoDBRW(dbReadUrls,dbDriver);
			dbClient081 = new MoDBRW(db081,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	//获取page列表
	static public ArrayList<String> getPageList(Date fTime){
		ArrayList<String> pageList = new ArrayList<String>();
		try { 
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from page_accesstime where ptime=? order by maxt desc",
							dbArgs);
			while(rs.next()){
				pageList.add(rs.getString("page"));
			}
		} catch (Exception e) {
			logger.error("getPageList with time=" + fTime);
		}
		return pageList;
	}
	//获取最大访问时间列表
	static public ArrayList<Integer> getMaxList(Date fTime){
		ArrayList<Integer> maxList = new ArrayList<Integer>();
		try { 
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from page_accesstime where ptime=? order by maxt desc",
							dbArgs);
			while(rs.next()){
				maxList.add(rs.getInt("maxt"));
			}
		} catch (Exception e) {
			logger.error("getMaxList with time=" + fTime);
		}
		return maxList;
	}
	
	//获取平均访问时间列表
	static public ArrayList<Integer> getAvrList(Date fTime){
		ArrayList<Integer> avrList = new ArrayList<Integer>();
		try { 
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from page_accesstime where ptime=? order by maxt desc",
							dbArgs);
			while(rs.next()){
				avrList.add(rs.getInt("avrt"));
			}
		} catch (Exception e) {
			logger.error("getAvrList with time=" + fTime);
		}
		return avrList;
	}
	
	//获取最小访问时间列表
	static public ArrayList<Integer> getMinList(Date fTime){
		ArrayList<Integer> minList = new ArrayList<Integer>();
		try { 
			Object[] dbArgs = new Object[] {fTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select * from page_accesstime where ptime=? order by maxt desc",
							dbArgs);
			while(rs.next()){
				minList.add(rs.getInt("mint"));
			}
		} catch (Exception e) {
			logger.error("getMinList with time=" + fTime);
		}
		return minList;
	}
}
