package userStats;

import java.util.ArrayList;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class MPModel {
	static final Logger logger = Logger.getLogger(MPModel.class);
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

			db086 = serverConf.getString("db086");
			dbReadUrls = serverConf.getString("dbReadUrls");
			dbDriver = serverConf.getString("dbDriver");
			
			dbClient = new MoDBRW(dbReadUrls,dbDriver);
			dbClient086 = new MoDBRW(db086,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	static public ArrayList<String> getModelList(ArrayList<String> idList){
		ArrayList<String> modelList = new ArrayList<String>();
		DBResultSet rs = null;
		Object[] dbArgs = new Object[] {};
		try {
			for(int i=0;i<idList.size();i++){
				dbArgs = new  Object[]{Integer.parseInt(idList.get(i))};
				rs = dbClient086
				.execSQLQuery(
						"select model  from usermodel where monetid like ?",
						dbArgs);
				//
				
				if(rs.next())
				{
					modelList.add(rs.getString("model"));
				}else{
					modelList.add("未统计");
				}
				
			}
			
			
		} catch (Exception e) {
			logger.error("getModelList ", e);
		}
		return modelList;
	}
	
	public static void main(String args[]){
		ArrayList<String> idList = new ArrayList<String>();
		ArrayList<String> modelList = new ArrayList<String>();
		idList.add("12339011");
		idList.add("29535964");
		modelList = getModelList(idList);
		for(String s:modelList){
			System.out.println(s);
		}
	}
}
