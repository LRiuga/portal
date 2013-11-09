package util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBCutil {
//测试服务器13
	
  	static String url = "jdbc:sqlserver://192.168.50.13:1433;DatabaseName=OceanAge";
	static String userName = "sa";
	static String password = "mozat01";
	
//实际服务器
	/*	
	static String url = "jdbc:sqlserver://192.168.6.81:1433;DatabaseName=OceanAge";
	static String userName = "mozone";
	static String password = "morangerunmozone";
	*/		
	static Connection cn = null;
	static CallableStatement cmd = null;
	static Statement stmt = null;
	static ResultSet rs = null;
	
	public static Connection getConnection() throws SQLException{
		cn = DriverManager.getConnection(url,userName,password);
		return cn;
	}
	
	public static void close(){
		
		try
	    {
	        if(cmd != null)
	        {
	            cmd.close();
	            cmd = null;
	        }
	        if(cn != null)
	        {
	            cn.close();
	            cn = null;
	        }
	        if(stmt != null){
	        	stmt.close();
	        }
	        if(rs != null){
	        	rs.close();
	        }
	    }
	    catch(Exception e)
	    {
	        e.printStackTrace();
	    }
	}
	
}
