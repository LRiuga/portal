package util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class UserManagement {
	Connection cn = null;
	CallableStatement cmd = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	String userName;
	String psw;
	int limit;

	static Logger logger = Logger.getLogger(UserManagement.class);
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
	
	public UserManagement(String userName,String psw,int limit){
		this.userName = userName;
		this.psw = psw;
		this.limit = limit;
	}
	
	public static ArrayList<UserManagement> getAllUser(){
		ArrayList<UserManagement> userList = new ArrayList<UserManagement>();
		try {
			Object[] dbArgs = new Object[] {};
			DBResultSet rs = dbClient.execSQLQuery(
							"select userName,psw,limit from login where limit<3 and limit>0 order by limit",
							dbArgs);
			while(rs.next()) {
				userList.add(new UserManagement(rs.getString("userName"),rs.getString("psw"),rs.getInt("limit")));
			}
		} catch (Exception e) {
			logger.error("UserManagement ", e);
		}
		return userList;
	}
	
	public static void deleteUser(String userName){
		try {
			Object[] dbArgs = new Object[] {userName};
			dbClient.execSQL("delete from login where userName=?",dbArgs);
		} catch (Exception e) {
			logger.error("deleteUser ", e);
		}
	}
	
	public static void addUser(String userName,String psw,int limit){
		try {
			Object[] dbArgs = new Object[] {userName,psw,limit};
			dbClient.execSQL("insert into login values (?,?,?)",dbArgs);
		} catch (Exception e) {
			logger.error("addUser ", e);
		}
	}
	
	public String getUserNmae(){
		return this.userName;
	}
	
	public int getLimit(){
		return this.limit;
	}
}
