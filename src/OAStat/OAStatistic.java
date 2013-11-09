package OAStat;

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

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class OAStatistic {
	Connection cn = null;
	CallableStatement cmd = null;
	Statement stmt = null;
	ResultSet rs = null;

	static Logger logger = Logger.getLogger(OAStatistic.class);
	static String db086 = null;
	static String dbConfig = null;
	static String dbDriver = null;
//	static String[] dbReadUrls = null;
	static MoDBRW dbClient = null;
	static MoDBRW dbClient_config = null;
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");

			db086 = serverConf.getString("db086");
			dbConfig = serverConf.getString("dbConfig");
//			dbReadUrls = new String[] {serverConf.getString("dbReadUrls")};
			dbDriver = serverConf.getString("dbDriver");

			dbClient = new MoDBRW(db086,dbDriver);
			dbClient_config = new MoDBRW(dbConfig,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}

	static public int countSellingFromAtoB(String item, Date fromTime,
			Date toTime) {
		int result = 0;
		try {

			Object[] dbArgs = new Object[] { item, fromTime, toTime };
			DBResultSet rs = dbClient
					.execSQLQuery(
							"select count(*) as cnt  from user_event where msg like ? and server_date >= ? and server_date<? and monetId>50000 and monetId not in (35069284,35894959,35894957,35894960,35894961,35894962)",
							dbArgs);
			if (rs.next()) {
				result = rs.getInt("cnt");
			} else {
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countSellingFromAtoB with item=" + item
					+ " fromTime=" + fromTime + " toTime=" + toTime, e);
			result = -1;
		}

		return result;
	}
	
	static public int countSellingUsers(String item,ArrayList<String> userList) {
		int result = 0;
		StringBuffer sb = new StringBuffer();
		for(int i=0;i<userList.size();i++){
			if(i<userList.size()-1){
				sb.append(userList.get(i));
				sb.append(",");
			}else{
				sb.append(userList.get(i));
			}
		}
		String ids = sb.toString();
		try {
			String sql = "select count(*) as cnt  from user_event where msg like '" + item +"' and monetid in(" + ids + ")";
			Object[] dbArgs = new Object[] {};
			DBResultSet rs = dbClient
					.execSQLQuery(sql,dbArgs);
			if (rs.next()) {
				result = rs.getInt("cnt");
			} else {
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countSellingUsers with item=" + item, e);
			result = -1;
		}

		return result;
	}
	
	static public int countSellingTotalUser(String item, Date fromTime,
			Date toTime) {
		int result = 0;
		try {

			Object[] dbArgs = new Object[] { item, fromTime, toTime };
			DBResultSet rs = dbClient.execSQLQuery(
							"select count(amount) as amount from ( select Count(monetid) as amount from user_event where msg like ? and server_date>=? and server_date<?  and monetId>50000 and monetId not in (35069284,35894959,35894957,35894960,35894961,35894962) group by monetid)a",
							dbArgs);
			if (rs.next()) {
				result = rs.getInt("amount");
			} else {
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countSellingTotalUser with item=" + item
					+ " fromTime=" + fromTime + " toTime=" + toTime, e);
			result = -1;
		}

		return result;
	}
	
	static public int countSellingTotalUser(String item1,String item2, Date fromTime,
			Date toTime) {
		int result = 0;
		try {

			Object[] dbArgs = new Object[] { item1,item2, fromTime, toTime };
			DBResultSet rs = dbClient.execSQLQuery(
							"select count(amount) as amount from ( select Count(monetid) as amount from user_event where (msg like ? or msg like ?) and server_date>=? and server_date<?  and monetId>50000 and monetId not in (35069284,35894959,35894957,35894960,35894961,35894962) group by monetid)a",
							dbArgs);
			if (rs.next()) {
				result = rs.getInt("amount");
			} else {
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countSellingTotalUser with fromTime=" + fromTime + " toTime=" + toTime, e);
			result = -1;
		}

		return result;
	}
	
	static public int countSellingTotalUser(String item1,String item2,String item3,Date fromTime,
			Date toTime) {
		int result = 0;
		try {

			Object[] dbArgs = new Object[] { item1,item2,item3,fromTime, toTime };
			DBResultSet rs = dbClient.execSQLQuery(
							"select count(amount) as amount from ( select Count(monetid) as amount from user_event where (msg like ? or msg like ? or msg like ?) and server_date>=? and server_date<?  and monetId>50000 and monetId not in (35069284,35894959,35894957,35894960,35894961,35894962) group by monetid)a",
							dbArgs);
			if (rs.next()) {
				result = rs.getInt("amount");
			} else {
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countSellingTotalUser with fromTime=" + fromTime + " toTime=" + toTime, e);
			result = -1;
		}

		return result;
	}
	
	static public int CountChangeStatus(String item,Date fromTime,
			Date toTime) {
		int result = 0;
		try {

			Object[] dbArgs = new Object[] {item,fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select Count(*) as amount from user_event where msg like ?  and server_date>=? and server_date<?  and monetId>50000 and monetId not in (35069284,35894959,35894957,35894960,35894961,35894962)",
							dbArgs);
			if (rs.next()) {
				result = rs.getInt("amount");
			} else {
				result = 0;
			}
		} catch (Exception e) {
			logger.error("CountChangeStatus with fromTime=" + fromTime + " toTime=" + toTime, e);
			result = -1;
		}

		return result;
	}
	
	static public int CountChangeStatusUsers(String item,Date fromTime,
			Date toTime) {
		int result = 0;
		try {

			Object[] dbArgs = new Object[] {item,fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select Count(distinct monetid) as amount from user_event where msg like ?  and server_date>=? and server_date<?  and monetId>50000 and monetId not in (35069284,35894959,35894957,35894960,35894961,35894962)",
							dbArgs);
			if (rs.next()) {
				result = rs.getInt("amount");
			} else {
				result = 0;
			}
		} catch (Exception e) {
			logger.error("CountChangeStatus with fromTime=" + fromTime + " toTime=" + toTime, e);
			result = -1;
		}

		return result;
	}
	
	static public int CountChangeStatusMaxAmount(String item,Date fromTime,
			Date toTime) {
		int result = 0;
		try {

			Object[] dbArgs = new Object[] {item,fromTime,toTime};
			DBResultSet rs = dbClient.execSQLQuery(
							"select top 1 count(*) as amount from user_event where msg like ? and server_date>=? and server_date<?  and monetId>50000 and monetId not in (35069284,35894959,35894957,35894960,35894961,35894962) group by monetid order by amount desc",
							dbArgs);
			if (rs.next()) {
				result = rs.getInt("amount");
			} else {
				result = 0;
			}
		} catch (Exception e) {
			logger.error("CountChangeStatus with fromTime=" + fromTime + " toTime=" + toTime, e);
			result = -1;
		}

		return result;
	}
	
	static public ArrayList<String> getShopItem() {
		ArrayList<String> list = new ArrayList<String>();
		try {
			Object[] dbArgs = new Object[] {};
			DBResultSet rs = dbClient_config.execSQLQuery(
							"select itemid,itemcredittext from shopitem where (((itemtype='crew' and itemtypeid<9) or (itemtype='FishTackle' and itemtypeid<>3)) and itemAmount=1 ) or (itemtype='weapon' and (itemtypeid>21 or (itemtypeid>4 and itemtypeid<8) or itemtypeid=16)and itemamount=1) or (itemtype='other' and itemamount=1 and itemtypeid=1) or itemtype='General' or itemtype='Speaker' or itemtype='TribeIcon' order by itemtype,itemtypeid",
							dbArgs);
			while(rs.next()) {
				list.add(rs.getString("itemcredittext"));
			}
		} catch (Exception e) {
			logger.error("", e);
		}
		return list;
	}
	
	static public ArrayList<String> getShopItemUsing() {
		ArrayList<String> list = new ArrayList<String>();
		try {
			Object[] dbArgs = new Object[] {};
			DBResultSet rs = dbClient_config.execSQLQuery(
							"select itemid,itemcredittext from shopitem where ((((itemtype='crew' and itemtypeid<9) or (itemtype='FishTackle' and itemtypeid<>3)) and itemAmount=1 ) or (itemtype='weapon' and (itemtypeid>21 or (itemtypeid>4 and itemtypeid<8) or itemtypeid=16)and itemamount=1) or itemtype='Speaker') and itemAmount=1 order by itemtype,itemtypeid",
							dbArgs);
			while(rs.next()) {
				list.add(rs.getString("itemcredittext"));
			}
		} catch (Exception e) {
			logger.error("", e);
		}
		return list;
	}
	
	
	static public Map<String,Integer> getNamePrice(){
		Map<String,Integer> priceMap = new HashMap<String,Integer>();
		try {
			Map<String,Integer> pirceMap = new HashMap<String,Integer>();
			Object[] dbArgs = new Object[] {};
			DBResultSet rs = dbClient_config.execSQLQuery("select itemType,itemTypeId,itemAmount,itemCreditText,creditPrice from shopitem where (((itemtype='crew' and itemtypeid<9) or itemtype='FishTackle') and itemAmount=1 ) or (itemtype='weapon' and (itemtypeid>21 or (itemtypeid>4 and itemtypeid<8) or itemtypeid=16)and itemamount=1) or (itemtype='other' and itemamount=1 and itemtypeid=1) or itemtype='General' or itemtype='Speaker' or itemtype='TribeIcon'",dbArgs);
			while(rs.next()){
				pirceMap.put(rs.getString("itemCreditText"),rs.getInt("creditPrice"));
			}
			return pirceMap;
		} catch (Exception e) {
			logger.error("getNamePrice");
		}
		return null;
	}
	
	static public ArrayList<String> getShopGoldItem() {
		ArrayList<String> list = new ArrayList<String>();
		try {
			Object[] dbArgs = new Object[] {};
			DBResultSet rs = dbClient_config.execSQLQuery(
							"select itemid,itemcredittext from shopitem where itemtype='weapon' and itemtypeid>21and goldPrice>0",
							dbArgs);
			while(rs.next()) {
				list.add(rs.getString("itemcredittext"));
			}
		} catch (Exception e) {
			logger.error("", e);
		}
		return list;
	}
	
	static public int countSellingMaxUser(String item, Date fromTime,
			Date toTime) {
		int result = 0;
		try {

			Object[] dbArgs = new Object[] { item, fromTime, toTime };
			DBResultSet rs = dbClient.execSQLQuery(
							"select top 1 * from (select Count(monetid) as amount from user_event where msg like ? and server_date>=? and server_date<?  and monetId>50000 and monetId not in (35069284,35894959,35894957,35894960,35894961,35894962) group by monetid)a order by amount desc",
							dbArgs);
			if (rs.next()) {
				result = rs.getInt("amount");
			} else {
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countSellingMaxUser with item=" + item
					+ " fromTime=" + fromTime + " toTime=" + toTime, e);
			result = -1;
		}

		return result;
	}
	
	static public int countSellingMaxUser(String item1,String item2,Date fromTime,
			Date toTime) {
		int result = 0;
		try {

			Object[] dbArgs = new Object[] { item1,item2,fromTime, toTime };
			DBResultSet rs = dbClient.execSQLQuery(
							"select top 1 * from (select Count(monetid) as amount from user_event where (msg like ? or msg like ?)and server_date>=? and server_date<?  and monetId>50000 and monetId not in (35069284,35894959,35894957,35894960,35894961,35894962) group by monetid)a order by amount desc",
							dbArgs);
			if (rs.next()) {
				result = rs.getInt("amount");
			} else {
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countSellingMaxUser with fromTime=" + fromTime + " toTime=" + toTime, e);
			result = -1;
		}

		return result;
	}
	
	static public int countSellingMaxUser(String item1,String item2,String item3,Date fromTime,
			Date toTime) {
		int result = 0;
		try {

			Object[] dbArgs = new Object[] { item1,item2,item3,fromTime, toTime };
			DBResultSet rs = dbClient.execSQLQuery(
							"select top 1 * from (select Count(monetid) as amount from user_event where (msg like ? or msg like ? or msg like ?)and server_date>=? and server_date<?  and monetId>50000 and monetId not in (35069284,35894959,35894957,35894960,35894961,35894962) group by monetid)a order by amount desc",
							dbArgs);
			if (rs.next()) {
				result = rs.getInt("amount");
			} else {
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countSellingMaxUser with fromTime=" + fromTime + " toTime=" + toTime, e);
			result = -1;
		}

		return result;
	}
	
	static public int countSellingMinUser(String item, Date fromTime,
			Date toTime) {
		int result = 0;
		try {

			Object[] dbArgs = new Object[] { item, fromTime, toTime };
			DBResultSet rs = dbClient.execSQLQuery(
							"select top 1 * from (select Count(monetid) as amount from user_event where msg like ? and server_date>=? and server_date<?  and monetId>50000 and monetId not in (35069284,35894959,35894957,35894960,35894961,35894962) group by monetid)a order by amount",
							dbArgs);
			if (rs.next()) {
				result = rs.getInt("amount");
			} else {
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countSellingMinUser with item=" + item
					+ " fromTime=" + fromTime + " toTime=" + toTime, e);
			result = -1;
		}

		return result;
	}

	static public int countSellingMinUser(String item1,String item2,Date fromTime,
			Date toTime) {
		int result = 0;
		try {

			Object[] dbArgs = new Object[] { item1,item2,fromTime, toTime };
			DBResultSet rs = dbClient.execSQLQuery(
							"select top 1 * from (select Count(monetid) as amount from user_event where (msg like ? or msg like ?) and server_date>=? and server_date<?  and monetId>50000 and monetId not in (35069284,35894959,35894957,35894960,35894961,35894962) group by monetid)a order by amount",
							dbArgs);
			if (rs.next()) {
				result = rs.getInt("amount");
			} else {
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countSellingMinUser with fromTime=" + fromTime + " toTime=" + toTime, e);
			result = -1;
		}

		return result;
	}
	
	static public int countSellingMinUser(String item1,String item2,String item3,Date fromTime,
			Date toTime) {
		int result = 0;
		try {

			Object[] dbArgs = new Object[] { item1,item2,item3,fromTime, toTime };
			DBResultSet rs = dbClient.execSQLQuery(
							"select top 1 * from (select Count(monetid) as amount from user_event where (msg like ? or msg like ? or msg like ?) and server_date>=? and server_date<?  and monetId>50000 and monetId not in (35069284,35894959,35894957,35894960,35894961,35894962) group by monetid)a order by amount",
							dbArgs);
			if (rs.next()) {
				result = rs.getInt("amount");
			} else {
				result = 0;
			}
		} catch (Exception e) {
			logger.error("countSellingMinUser with fromTime=" + fromTime + " toTime=" + toTime, e);
			result = -1;
		}

		return result;
	}
	
	
	
//	static public void setSellingFromA(String item,int sellingAmount,Date fromTime) {
//		try {
//
//			Object[] dbArgs = new Object[] {item,sellingAmount,fromTime};
//			dbClient.execSQLUpdate(
//							"insert into selling(iname,amount,stime)values (?,?,?)",
//							dbArgs);
//			
//		} catch (Exception e) {
//			logger.error("setSellingFromAtoB with item=" + item + " amount=" + sellingAmount
//					+ " fromTime=" + fromTime, e);
//		}
//
//	}
	
//	static public void setUsingFromA(String item,int usingAmount,Date fromTime) {
//		try {
//
//			Object[] dbArgs = new Object[] {item,usingAmount,fromTime};
//			dbClient.execSQLUpdate(
//							"insert into using(iname,amount,utime)values (?,?,?)",
//							dbArgs);
//			
//		} catch (Exception e) {
//			logger.error("setUsingFromAtoB with item=" + item + " amount=" + usingAmount
//					+ " fromTime=" + fromTime, e);
//		}
//
//	}

//	static public int getSellingFromAtoB(String item,Date fromTime,Date toTime){
//		int result = 0;
//		try {
//
//			Object[] dbArgs = new Object[] {item,fromTime,toTime};
//			DBResultSet rs = dbClient.execSQLQuery(
//							"select amount from selling where iname = ? and stime >= ? and stime < ?",
//							dbArgs);
//			while(rs.next()) {
//				result = rs.getInt("amount");
//			}
//		} catch (Exception e) {
//			logger.error("getSellingFromAtoB with item=" + item + " amount=" + result
//					+ " fromTime=" + fromTime + " toTime=" + toTime, e);
//		}
//		
//		return result;
//	}
//	
//	static public int getUsingFromAtoB(String item,Date fromTime,Date toTime){
//		int result = 0;
//		try {
//
//			Object[] dbArgs = new Object[] {item,fromTime,toTime};
//			DBResultSet rs = dbClient.execSQLQuery(
//							"select amount from using where iname = ? and utime >= ? and utime < ?",
//							dbArgs);
//			while(rs.next()) {
//				result = rs.getInt("amount");
//			}
//		} catch (Exception e) {
//			logger.error("getUsingFromAtoB with item=" + item + " amount=" + result
//					+ " fromTime=" + fromTime + " toTime=" + toTime, e);
//		}
//		
//		return result;
//	}
	
	public static void main(String[] args) {
		try {
			// String writeUrl =
			// "jdbc:sqlserver://192.168.50.13:1433;DatabaseName=OceanAge;user=sa;password=mozat01";
			// String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
			//			
			// MoDBRW dbClient = new MoDBRW(writeUrl,driver);
			// Object[] dbArgs = new Object[]{"2011/8/10","2011/8/12"};
			// DBResultSet rs =
			// dbClient.execSQLQuery("select count(*) as cnt from user_event where msg='Callback Credit:TBox=a-bomb' and server_date between ? and ? ",dbArgs);
			//	
			// if(rs.next()){
			// int result = rs.getInt("cnt");
			// System.out.println("the amount is :" + result);
			// }else{
			// System.out.println("the amount ");
			// }
			Date fromTime = new Date(111, 7, 14);
			Date toTime = new Date(111, 7, 16);
			Date date = new Date();

			System.out.println(fromTime);
			System.out.println(toTime);
			System.out.println(new java.sql.Timestamp(((java.util.Date) toTime)
					.getTime()));
			System.out.println(new java.sql.Timestamp(((java.util.Date) date)
					.getTime()));

			int result = OAStatistic.countSellingFromAtoB(
					"Callback : add avatarType = 22", fromTime, toTime);
			System.out.println("the amount ttt =" + result);
//			OAStatistic.setSellingFromA("testest",result,fromTime);
		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

}
