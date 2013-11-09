package OAStat;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import com.mozat.morange.util.DBResultSet;
import com.mozat.morange.util.MoDBRW;

public class OAStatUtil {
	
	static ArrayList<String> itemName = new ArrayList<String>();
	static ArrayList<Double> itemPrice = new ArrayList<Double>();
	static Map<String,Double> itemPriceMap = new HashMap<String,Double>();
	static Map<String,String> itemTypeMap = new HashMap<String,String>();
	static ArrayList<Double> itemPrice_discount = new ArrayList<Double>();
	static ArrayList<String> itemType = new ArrayList<String>();
	static ArrayList<String> itemPage = new ArrayList<String>();
	static ArrayList<String> newUserItemPage = new ArrayList<String>();
//	static ArrayList<String> using_itemName = new ArrayList<String>();
	static ArrayList<String> attackMonster_itemName = new ArrayList<String>();
	
	Connection cn = null;
	CallableStatement cmd = null;
	Statement stmt = null;
	ResultSet rs = null;

	static Logger logger = Logger.getLogger(OAStatistic.class);
	static String dbReadUrls = null;
	static String dbDriver = null;
	static MoDBRW dbClient = null;
	static String dbWriteUrla = null;
	static MoDBRW dbClient83 = null;
	static {
		try {
			CompositeConfiguration settings = new CompositeConfiguration();
			settings.addConfiguration(new PropertiesConfiguration(
					"system.properties"));
			Configuration serverConf = settings.subset("service");
			dbReadUrls = serverConf.getString("dbReadUrls");
			dbDriver = serverConf.getString("dbDriver");
			dbWriteUrla = serverConf.getString("dbWriteUrla");
			dbClient = new MoDBRW(dbReadUrls,dbDriver);
			dbClient83 = new MoDBRW(dbWriteUrla,dbDriver);
		} catch (Exception e) {
			logger.error("init database error", e);
		}
	}
	
	static ArrayList<Integer> testAccount = new ArrayList<Integer>();
	static{
		testAccount.add(41613689);
		testAccount.add(40192101);
		testAccount.add(35069284);
		testAccount.add(40192396);
		testAccount.add(41522140);
		
		testAccount.add(35210337);
		testAccount.add(35210339);
		testAccount.add(35210340);
		testAccount.add(35210341);
		testAccount.add(35210342);
		testAccount.add(45110860);
	}
	static{
		//avatar(15:0-14)												
		itemName.add("4city");					itemPriceMap.put("4city",2.2); 					itemTypeMap.put("4city","Other");	itemPrice.add(2.2);			itemType.add("25");		itemPrice_discount.add(2.2);
		itemName.add("Romancoliseum");			itemPriceMap.put("Romancoliseum",0.69);			itemTypeMap.put("Romancoliseum","Other");	itemPrice.add(0.69);		itemType.add("22");		itemPrice_discount.add(0.69);
		itemName.add("liberty");				itemPriceMap.put("liberty",0.69); 				itemTypeMap.put("liberty","Other");	itemPrice.add(0.69);		itemType.add("19");		itemPrice_discount.add(0.69);
		itemName.add("greatwall");				itemPriceMap.put("greatwall",0.69);				itemTypeMap.put("greatwall","Other");	itemPrice.add(0.69);		itemType.add("16");		itemPrice_discount.add(0.69);
		itemName.add("EiffelTower");			itemPriceMap.put("EiffelTower",0.69);			itemTypeMap.put("EiffelTower","Other");	itemPrice.add(0.69);		itemType.add("13");		itemPrice_discount.add(0.69);
		itemName.add("Destroy-background");		itemPriceMap.put("Destroy-background",0.69);	itemTypeMap.put("Destroy-background","Other");	itemPrice.add(0.69);		itemType.add("10");		itemPrice_discount.add(0.69);
		itemName.add("Halloween-warehouse");	itemPriceMap.put("Halloween-warehouse",0.22);	itemTypeMap.put("Halloween-warehouse","Other");	itemPrice.add(0.22);		itemType.add("9");		itemPrice_discount.add(0.22);
		itemName.add("Halloween-shipyard");		itemPriceMap.put("Halloween-shipyard",0.22);	itemTypeMap.put("Halloween-shipyard","Other");	itemPrice.add(0.22);		itemType.add("8");		itemPrice_discount.add(0.22);
		itemName.add("Halloween-background");	itemPriceMap.put("Halloween-background",0.22);	itemTypeMap.put("Halloween-background","Other");	itemPrice.add(0.22);		itemType.add("7");		itemPrice_discount.add(0.22);
		itemName.add("Christmas-warehouse");	itemPriceMap.put("Christmas-warehouse",0.22);	itemTypeMap.put("Christmas-warehouse","Other");	itemPrice.add(0.22);		itemType.add("6");		itemPrice_discount.add(0.22);
		itemName.add("Christmas-shipyard");		itemPriceMap.put("Christmas-shipyard",0.22);	itemTypeMap.put("Christmas-shipyard","Other");	itemPrice.add(0.22);		itemType.add("5");		itemPrice_discount.add(0.22);
		itemName.add("Christmas-background");	itemPriceMap.put("Christmas-background",0.22);	itemTypeMap.put("Christmas-background","Other");	itemPrice.add(0.22);		itemType.add("4");		itemPrice_discount.add(0.22);
		itemName.add("pyramid-warehouse");		itemPriceMap.put("pyramid-warehouse",0.22);		itemTypeMap.put("pyramid-warehouse","Other");	itemPrice.add(0.22);		itemType.add("3");		itemPrice_discount.add(0.22);
		itemName.add("pyramid-shipyard");		itemPriceMap.put("pyramid-shipyard",0.22);		itemTypeMap.put("pyramid-shipyard","Other");	itemPrice.add(0.22);		itemType.add("2");		itemPrice_discount.add(0.22);
		itemName.add("pyramid-background");		itemPriceMap.put("pyramid-background",0.22);	itemTypeMap.put("pyramid-background","Other");	itemPrice.add(0.22);		itemType.add("1");		itemPrice_discount.add(0.22);
		
		//crew(8:15-24)
		itemName.add("Sailor");					itemPriceMap.put("Sailor",1.33);		itemTypeMap.put("Sailor","Crew");	itemPrice.add(1.33);		itemType.add("1");		itemPrice_discount.add(1.33);
		itemName.add("Thief");					itemPriceMap.put("Thief",0.99);			itemTypeMap.put("Thief","Crew");	itemPrice.add(0.99);		itemType.add("2");		itemPrice_discount.add(0.99);
		itemName.add("Guard");					itemPriceMap.put("Guard",0.99);			itemTypeMap.put("Guard","Crew");	itemPrice.add(0.99);		itemType.add("3");		itemPrice_discount.add(0.99);
		itemName.add("Prophet");				itemPriceMap.put("Prophet",1.69);		itemTypeMap.put("Prophet","Crew");	itemPrice.add(1.69);		itemType.add("4");		itemPrice_discount.add(1.69);
		itemName.add("Spy");					itemPriceMap.put("Spy",1.33);			itemTypeMap.put("Spy","Crew");		itemPrice.add(1.33);		itemType.add("5");		itemPrice_discount.add(1.33);
		itemName.add("Insurance");				itemPriceMap.put("Insurance",1.33);		itemTypeMap.put("Insurance","Crew");	itemPrice.add(1.33);		itemType.add("6");		itemPrice_discount.add(1.33);
		itemName.add("Robber");					itemPriceMap.put("Robber",0.99);		itemTypeMap.put("Robber","Crew");		itemPrice.add(0.99);		itemType.add("7");		itemPrice_discount.add(0.99);
		itemName.add("Fish Trader");			itemPriceMap.put("Fish Trader",1.33);	itemTypeMap.put("Fish Trader","Crew");	itemPrice.add(1.33);		itemType.add("8");		itemPrice_discount.add(1.33);
		itemName.add("Sliver Net");				itemPriceMap.put("Sliver Net",5.0);		itemTypeMap.put("Sliver Net","Crew");	itemPrice.add(5.0);		    itemType.add("10");		itemPrice_discount.add(5.0);
		itemName.add("Golden Net");				itemPriceMap.put("Golden Net",20.0);	itemTypeMap.put("Golden Net","Crew");	itemPrice.add(20.0);		itemType.add("11");		itemPrice_discount.add(20.0);
		//weapon(8:25-38)		
		itemName.add("MissileAbombcomb");		itemPriceMap.put("MissileAbombcomb",9.99);	itemTypeMap.put("MissileAbombcomb","Attack");	itemPrice.add(9.99);		itemType.add("14");		itemPrice_discount.add(9.9);
		itemName.add("Anti-Abombcomb");			itemPriceMap.put("Anti-Abombcomb",19.99);	itemTypeMap.put("Anti-Abombcomb","Defense");	itemPrice.add(19.99);		itemType.add("13");		itemPrice_discount.add(19.99);
		itemName.add("Anti-Missilecomb");		itemPriceMap.put("Anti-Missilecomb",5.99);	itemTypeMap.put("Anti-Missilecomb","Defense");	itemPrice.add(5.99);		itemType.add("12");		itemPrice_discount.add(5.99);
		itemName.add("a-bomb defense");			itemPriceMap.put("a-bomb defense",6.0);		itemTypeMap.put("a-bomb defense","Defense");	itemPrice.add(6.0);			itemType.add("11");		itemPrice_discount.add(6.0);
		itemName.add("Missile defense");		itemPriceMap.put("Missile defense",2.0);	itemTypeMap.put("Missile defense","Defense");	itemPrice.add(2.0);			itemType.add("10");		itemPrice_discount.add(2.0);
		itemName.add("TBox");					itemPriceMap.put("TBox",6.0);				itemTypeMap.put("TBox","Other");				itemPrice.add(6.0);			itemType.add("9");		itemPrice_discount.add(6.0);
		itemName.add("A-bomb");					itemPriceMap.put("A-bomb",19.99);			itemTypeMap.put("A-bomb","Attack");				itemPrice.add(19.99);		itemType.add("8");		itemPrice_discount.add(19.99);
		itemName.add("big-toolbox");			itemPriceMap.put("big-toolbox",4.69);		itemTypeMap.put("big-toolbox","Toolbox");		itemPrice.add(4.69);		itemType.add("7");		itemPrice_discount.add(4.69);
		itemName.add("middle-toolbox");			itemPriceMap.put("middle-toolbox",2.0);		itemTypeMap.put("middle-toolbox","Toolbox");	itemPrice.add(2.0);			itemType.add("6");		itemPrice_discount.add(2.0);
		itemName.add("small-toolbox");			itemPriceMap.put("small-toolbox",0.39);		itemTypeMap.put("small-toolbox","Toolbox");		itemPrice.add(0.39);		itemType.add("5");		itemPrice_discount.add(0.39);
		itemName.add("shield");					itemPriceMap.put("shield",4.69);			itemTypeMap.put("shield","Defense");			itemPrice.add(4.69);		itemType.add("4");		itemPrice_discount.add(4.69);
		itemName.add("big-missile");			itemPriceMap.put("big-missile",4.69);		itemTypeMap.put("big-missile","Attack");		itemPrice.add(4.69);		itemType.add("3");		itemPrice_discount.add(4.69);
		itemName.add("middle-missile");			itemPriceMap.put("middle-missile",0.59);	itemTypeMap.put("middle-missile","Attack");		itemPrice.add(0.59);		itemType.add("2");		itemPrice_discount.add(0.59);
		itemName.add("small-missile");			itemPriceMap.put("small-missile",0.39);		itemTypeMap.put("small-missile","Attack");		itemPrice.add(0.39);		itemType.add("1");		itemPrice_discount.add(0.39);
		//Combo(6:39-44)
		itemName.add("FishermanCombo");			itemPriceMap.put("FishermanCombo",3.19);	itemTypeMap.put("FishermanCombo","Crew");		itemPrice.add(3.19);		itemType.add("0");		itemPrice_discount.add(3.19);
		itemName.add("PirateCombo");			itemPriceMap.put("PirateCombo",2.49);		itemTypeMap.put("PirateCombo","Crew");			itemPrice.add(2.49);		itemType.add("0");		itemPrice_discount.add(2.49);
		itemName.add("MissileCombo");			itemPriceMap.put("MissileCombo",11.99);		itemTypeMap.put("MissileCombo","Attack");		itemPrice.add(11.99);		itemType.add("0");		itemPrice_discount.add(11.99);
		itemName.add("BigMissileCombo");		itemPriceMap.put("BigMissileCombo",11.99);	itemTypeMap.put("BigMissileCombo","Attack");	itemPrice.add(11.99);		itemType.add("0");		itemPrice_discount.add(11.99);
		itemName.add("ToolboxCombo");			itemPriceMap.put("ToolboxCombo",11.99);		itemTypeMap.put("ToolboxCombo","Toolbox");		itemPrice.add(11.99);		itemType.add("0");		itemPrice_discount.add(11.99);
		itemName.add("BigToolboxCombo");		itemPriceMap.put("BigToolboxCombo",11.99);	itemTypeMap.put("BigToolboxCombo","Toolbox");	itemPrice.add(11.99);		itemType.add("0");		itemPrice_discount.add(11.99);
		//system(3:45-47)
		itemName.add("Defense System 1");		itemPriceMap.put("Defense System 1",3.0);	itemTypeMap.put("Defense System 1","Defense");	itemPrice.add(3.0);			itemType.add("1");		itemPrice_discount.add(3.0);
		itemName.add("Defense System 2");		itemPriceMap.put("Defense System 2",20.0);	itemTypeMap.put("Defense System 2","Defense");	itemPrice.add(20.0);		itemType.add("2");		itemPrice_discount.add(20.0);
		itemName.add("Defense System 3");		itemPriceMap.put("Defense System 3",120.0);	itemTypeMap.put("Defense System 3","Defense");	itemPrice.add(120.0);		itemType.add("3");		itemPrice_discount.add(120.0);
		//Warehouse(3:48-50)
		itemName.add("Warehouse 1");			itemPriceMap.put("Warehouse 1",5.0);		itemTypeMap.put("Warehouse 1","Other");			itemPrice.add(5.0);		    itemType.add("1");		itemPrice_discount.add(5.0);
		itemName.add("Warehouse 2");			itemPriceMap.put("Warehouse 2",50.0);		itemTypeMap.put("Warehouse 2","Other");			itemPrice.add(50.0);		itemType.add("2");		itemPrice_discount.add(50.0);
		itemName.add("Warehouse 3");			itemPriceMap.put("Warehouse 3",150.0);		itemTypeMap.put("Warehouse 3","Other");			itemPrice.add(150.0);		itemType.add("3");		itemPrice_discount.add(150.0);
		//rent ship(3:51-59)
		itemName.add("rentShipA1");				itemPriceMap.put("rentShipA1",1.5);			itemTypeMap.put("rentShipA1","Other");			itemPrice.add(1.5);			itemType.add("221");		itemPrice_discount.add(1.5);
		itemName.add("rentShipA2");				itemPriceMap.put("rentShipA2",2.0);			itemTypeMap.put("rentShipA2","Other");			itemPrice.add(2.0);			itemType.add("222");		itemPrice_discount.add(2.0);
		itemName.add("rentShipA3");				itemPriceMap.put("rentShipA3",2.5);			itemTypeMap.put("rentShipA3","Other");			itemPrice.add(2.5);			itemType.add("223");		itemPrice_discount.add(2.5);
		itemName.add("rentShipB1");				itemPriceMap.put("rentShipB1",3.0);			itemTypeMap.put("rentShipB1","Other");			itemPrice.add(3.0);			itemType.add("231");		itemPrice_discount.add(3.0);
		itemName.add("rentShipB2");				itemPriceMap.put("rentShipB2",5.0);			itemTypeMap.put("rentShipB2","Other");			itemPrice.add(5.0);			itemType.add("232");		itemPrice_discount.add(5.0);
		itemName.add("rentShipB3");				itemPriceMap.put("rentShipB3",7.0);			itemTypeMap.put("rentShipB3","Other");			itemPrice.add(7.0);			itemType.add("233");		itemPrice_discount.add(4.0);
		itemName.add("rentShipC1");				itemPriceMap.put("rentShipC1",15.0);		itemTypeMap.put("rentShipC1","Other");			itemPrice.add(15.0);		itemType.add("241");		itemPrice_discount.add(15.0);
		itemName.add("rentShipC2");				itemPriceMap.put("rentShipC2",20.0);		itemTypeMap.put("rentShipC2","Other");			itemPrice.add(20.0);		itemType.add("242");		itemPrice_discount.add(20.0);
		itemName.add("rentShipC3");				itemPriceMap.put("rentShipC3",25.0);		itemTypeMap.put("rentShipC3","Other");			itemPrice.add(25.0);		itemType.add("243");		itemPrice_discount.add(25.0);
		//ABomb combo(2:60-61)
		itemName.add("5 A-Bomb");				itemPriceMap.put("5 A-Bomb",98.99);			itemTypeMap.put("5 A-Bomb","Attack");			itemPrice.add(98.99);		itemType.add("1");		itemPrice_discount.add(98.99);
		itemName.add("10 A-Bomb");				itemPriceMap.put("10 A-Bomb",195.0);		itemTypeMap.put("10 A-Bomb","Attack");			itemPrice.add(195.0);		itemType.add("2");		itemPrice_discount.add(195.0);
		//Big-Bomb(3:62-64)
		itemName.add("Big-Bomb");				itemPriceMap.put("Big-Bomb",10.0);			itemTypeMap.put("Big-Bomb","Attack");		itemPrice.add(10.0);		itemType.add("15");		itemPrice_discount.add(10.0);
		itemName.add("5 Big-Bomb");				itemPriceMap.put("5 Big-Bomb",48.0);		itemTypeMap.put("5 Big-Bomb","Attack");		itemPrice.add(48.0);		itemType.add("2");		itemPrice_discount.add(48.0);
		itemName.add("10 Big-Bomb");			itemPriceMap.put("10 Big-Bomb",95.0);		itemTypeMap.put("10 Big-Bomb","Attack");	itemPrice.add(95.0);		itemType.add("3");		itemPrice_discount.add(95.0);
		//Super-toolbox(3:65-67)
		itemName.add("Super-toolbox");			itemPriceMap.put("Super-toolbox",10.0);		itemTypeMap.put("Super-toolbox","Toolbox");		itemPrice.add(10.00);		itemType.add("16");		itemPrice_discount.add(10.0);
		itemName.add("5 Super-toolbox");		itemPriceMap.put("5 Super-toolbox",48.0);	itemTypeMap.put("5 Super-toolbox","Toolbox");	itemPrice.add(48.0);		itemType.add("2");		itemPrice_discount.add(48.0);
		itemName.add("10 Super-toolbox");		itemPriceMap.put("10 Super-toolbox",95.0);	itemTypeMap.put("10 Super-toolbox","Toolbox");	itemPrice.add(95.0);		itemType.add("3");		itemPrice_discount.add(95.0);
		//level4 (7:68-74)
		itemName.add("Defense System 4");		itemPriceMap.put("Defense System 4",300.0);		itemTypeMap.put("Defense System 4","Defense");		itemPrice.add(300.0);		itemType.add("4");		itemPrice_discount.add(300.0);
		itemName.add("5_missile_combo");		itemPriceMap.put("5_missile_combo",59.0);		itemTypeMap.put("5_missile_combo","Attack");		itemPrice.add(59.0);		itemType.add("1");		itemPrice_discount.add(59.0);
		itemName.add("10_missile_combo");		itemPriceMap.put("10_missile_combo",118.0);		itemTypeMap.put("10_missile_combo-Bomb","Attack");	itemPrice.add(118.0);		itemType.add("2");		itemPrice_discount.add(118.0);
		itemName.add("5_big_missile_combo");	itemPriceMap.put("5_big_missile_combo",59.0);	itemTypeMap.put("5_big_missile_combo","Attack");	itemPrice.add(59.0);		itemType.add("1");		itemPrice_discount.add(59.0);
		itemName.add("10_big_missile_combo");	itemPriceMap.put("10_big_missile_combo",118.0);	itemTypeMap.put("10_big_missile_combo","Attack");	itemPrice.add(118.0);		itemType.add("2");		itemPrice_discount.add(118.0);
		itemName.add("5_bigtoolbox_combo");		itemPriceMap.put("5_bigtoolbox_combo",59.0);	itemTypeMap.put("5_bigtoolbox_combo","Toolbox");	itemPrice.add(59.0);		itemType.add("1");		itemPrice_discount.add(59.0);
		itemName.add("10_bigtoolbox_combo");	itemPriceMap.put("10_bigtoolbox_combo",118.0);	itemTypeMap.put("10_bigtoolbox_combo","Toolbox");	itemPrice.add(118.0);		itemType.add("2");		itemPrice_discount.add(118.0);
		//100- (2:75-76)
		itemName.add("100 A-Bomb");				itemPriceMap.put("100 A-Bomb",1999.0);			itemTypeMap.put("100 A-Bomb","Attack");			itemPrice.add(1999.0);		itemType.add("3");		itemPrice_discount.add(1999.0);
		itemName.add("100 Super-toolbox");		itemPriceMap.put("100 Super-toolbox",1000.0);	itemTypeMap.put("100 Super-toolbox","Toolbox");	itemPrice.add(1000.0);		itemType.add("4");		itemPrice_discount.add(1000.0);
		//anti comco- (2:77-78)
		itemName.add("10 anti abomb");			itemPriceMap.put("10 anti abomb",199.9);	itemTypeMap.put("10 anti abomb","Defense");		itemPrice.add(199.9);		itemType.add("2");		itemPrice_discount.add(199.9);
		itemName.add("10 anti missile");		itemPriceMap.put("10 anti missile",59.9);	itemTypeMap.put("10 anti missile","Defense");	itemPrice.add(59.9);		itemType.add("2");		itemPrice_discount.add(59.9);
		//icon (6:79-84)
		itemName.add("icon1");					itemPriceMap.put("icon1",30.0);				itemTypeMap.put("icon1","Other");	itemPrice.add(30.0);		itemType.add("1");		itemPrice_discount.add(30.0);
		itemName.add("icon2");					itemPriceMap.put("icon2",30.0);				itemTypeMap.put("icon2","Other");	itemPrice.add(30.0);		itemType.add("2");		itemPrice_discount.add(30.0);
		itemName.add("icon3");					itemPriceMap.put("icon3",30.0);				itemTypeMap.put("icon3","Other");	itemPrice.add(30.0);		itemType.add("3");		itemPrice_discount.add(30.0);
		itemName.add("icon4");					itemPriceMap.put("icon4",30.0);				itemTypeMap.put("icon4","Other");	itemPrice.add(30.0);		itemType.add("4");		itemPrice_discount.add(30.0);
		itemName.add("icon7");					itemPriceMap.put("icon7",30.0);				itemTypeMap.put("icon7","Other");	itemPrice.add(30.0);		itemType.add("7");		itemPrice_discount.add(30.0);
		itemName.add("icon8");					itemPriceMap.put("icon8",30.0);				itemTypeMap.put("icon8","Other");	itemPrice.add(30.0);		itemType.add("8");		itemPrice_discount.add(30.0);
		//lucky crew (1:85)
		itemName.add("lucky crew");				itemPriceMap.put("lucky crew",20.0);		itemTypeMap.put("lucky crew","Crew");	itemPrice.add(20.0);		itemType.add("9");		itemPrice_discount.add(20.0);
		//Abomb + lucky (1:86)
		itemName.add("AbombLucky");				itemPriceMap.put("AbombLucky",20.0);		itemTypeMap.put("AbombLucky","Attack");	itemPrice.add(20.0);		itemType.add("0");		itemPrice_discount.add(20.0);
		//hot combo (8:87-94)
		itemName.add("10 Sailor hot");			itemPriceMap.put("10 Sailor hot",13.3);		itemTypeMap.put("10 Sailor hot","Crew");	itemPrice.add(13.3);		itemType.add("1");		itemPrice_discount.add(13.3);
		itemName.add("10 Prophet hot");			itemPriceMap.put("10 Prophet hot",16.9);	itemTypeMap.put("10 Prophet hot","Crew");		itemPrice.add(16.9);		itemType.add("2");		itemPrice_discount.add(16.9);
		itemName.add("10 FishTrader hot");		itemPriceMap.put("10 FishTrader hot",13.3);		itemTypeMap.put("10 FishTrader hot","Crew");	itemPrice.add(13.3);		itemType.add("3");		itemPrice_discount.add(13.3);
		itemName.add("10 FishmanCombo hot");	itemPriceMap.put("10 FishmanCombo hot",31.9);	itemTypeMap.put("10 FishmanCombo hot","Crew");	itemPrice.add(31.9);		itemType.add("4");		itemPrice_discount.add(31.9);
		itemName.add("100 A-bomb hot");			itemPriceMap.put("100 A-bomb hot",1999.0);		itemTypeMap.put("100 A-bomb hot","Attack");	itemPrice.add(1999.0);		itemType.add("5");		itemPrice_discount.add(1999.0);
		itemName.add("100 supertoolbox hot");	itemPriceMap.put("100 supertoolbox hot",1000.0);	itemTypeMap.put("100 supertoolbox hot","Toolbox");	itemPrice.add(1000.0);		itemType.add("6");		itemPrice_discount.add(1000.0);
		itemName.add("10_bigtoolbox_combo hot");itemPriceMap.put("10_bigtoolbox_combo hot",118.0);	itemTypeMap.put("10_bigtoolbox_combo hot","Toolbox");	itemPrice.add(118.0);		itemType.add("7");		itemPrice_discount.add(118.0);
		itemName.add("10_big_missile_combo hot");itemPriceMap.put("10_big_missile_combo hot",118.0);itemTypeMap.put("10_big_missile_combo hot","Attack"); 	itemPrice.add(118.0);		itemType.add("8");		itemPrice_discount.add(118.0);
		//card(3:95-97)
		itemName.add("Refresh_keeping_card");	itemPriceMap.put("Refresh_keeping_card",6.0);	itemTypeMap.put("Refresh_keeping_card","Other");	itemPrice.add(6.0);			itemType.add("1");		itemPrice_discount.add(6.0);
		itemName.add("Freeze_card");			itemPriceMap.put("Freeze_card",8.0);			itemTypeMap.put("Freeze_card","Other");	itemPrice.add(8.0);			itemType.add("2");		itemPrice_discount.add(8.0);
		itemName.add("fish_change_card");		itemPriceMap.put("fish_change_card",2.0);		itemTypeMap.put("fish_change_card","Other");	itemPrice.add(2.0);			itemType.add("3");		itemPrice_discount.add(2.0);
		//card_AbombLucky(4:98-101)
		itemName.add("Abomb_Freeze");			itemPriceMap.put("Abomb_Freeze",20.0);		itemTypeMap.put("Abomb_Freeze","Attack");		itemPrice.add(20.0);		itemType.add("5");		itemPrice_discount.add(20.0);
		itemName.add("Abomb_Refresh");			itemPriceMap.put("Abomb_Refresh",20.0);		itemTypeMap.put("Abomb_Refresh","Attack");		itemPrice.add(20.0);		itemType.add("4");		itemPrice_discount.add(20.0);
		itemName.add("Lucky_Freeze");			itemPriceMap.put("Lucky_Freeze",20.0);		itemTypeMap.put("Lucky_Freeze","Crew");		itemPrice.add(20.0);		itemType.add("2");		itemPrice_discount.add(20.0);
		itemName.add("Lucky_Refresh");			itemPriceMap.put("Lucky_Refresh",20.0);		itemTypeMap.put("Lucky_Refresh","Crew");		itemPrice.add(20.0);		itemType.add("1");		itemPrice_discount.add(20.0);
		//new_bomb(9:102-110)
		itemName.add("Whirlwind");				itemPriceMap.put("Whirlwind",10.0);			itemTypeMap.put("Whirlwind","Attack");		itemPrice.add(10.0);		itemType.add("17");		itemPrice_discount.add(10.0);
		itemName.add("Fireball");				itemPriceMap.put("Fireball",10.0);			itemTypeMap.put("Fireball","Attack");		itemPrice.add(10.0);		itemType.add("18");		itemPrice_discount.add(10.0);
		itemName.add("Thunderbolt");			itemPriceMap.put("Thunderbolt",10.0);		itemTypeMap.put("Thunderbolt","Attack");	itemPrice.add(10.0);		itemType.add("19");		itemPrice_discount.add(10.0);
		itemName.add("5 Whirlwind");			itemPriceMap.put("5 Whirlwind",48.0);		itemTypeMap.put("5 Whirlwind","Attack");	itemPrice.add(48.0);		itemType.add("2");		itemPrice_discount.add(48.0);
		itemName.add("5 Fireball");				itemPriceMap.put("5 Fireball",48.0);		itemTypeMap.put("5 Fireball","Attack");		itemPrice.add(48.0);		itemType.add("2");		itemPrice_discount.add(48.0);
		itemName.add("5 Thunderbolt");			itemPriceMap.put("5 Thunderbolt",48.0);		itemTypeMap.put("5 Thunderbolt","Attack");	itemPrice.add(48.0);		itemType.add("2");		itemPrice_discount.add(48.0);
		itemName.add("10 Whirlwind");			itemPriceMap.put("10 Whirlwind",95.0);		itemTypeMap.put("10 Whirlwind","Attack");	itemPrice.add(95.0);		itemType.add("3");		itemPrice_discount.add(95.0);
		itemName.add("10 Fireball");			itemPriceMap.put("10 Fireball",95.0);		itemTypeMap.put("10 Fireball","Attack");	itemPrice.add(95.0);		itemType.add("3");		itemPrice_discount.add(95.0);
		itemName.add("10 Thunderbolt");			itemPriceMap.put("10 Thunderbolt",95.0);	itemTypeMap.put("10 Thunderbolt","Attack");	itemPrice.add(95.0);		itemType.add("3");		itemPrice_discount.add(95.0);
		//message_bomb(2:111-112)
		itemName.add("MessageBomb");			itemPriceMap.put("MessageBomb",0.0);		itemTypeMap.put("MessageBomb","Attack");	itemPrice.add(0.0);			itemType.add("20");		itemPrice_discount.add(0.0);
		itemName.add("MessageMissile");			itemPriceMap.put("MessageMissile",0.0);		itemTypeMap.put("MessageMissile","Attack");	itemPrice.add(0.0);			itemType.add("21");		itemPrice_discount.add(0.0);
		//crew combo(20:113-132)
		itemName.add("Sailor5");				itemPriceMap.put("Sailor5",6.65);			itemTypeMap.put("Sailor5","Crew");	itemPrice.add(6.65);		itemType.add("0");		itemPrice_discount.add(6.65);
		itemName.add("Sailor10");				itemPriceMap.put("Sailor10",13.3);			itemTypeMap.put("Sailor10","Crew");	itemPrice.add(13.3);		itemType.add("0");		itemPrice_discount.add(13.3);
		itemName.add("Thief5");					itemPriceMap.put("Thief5",4.95);			itemTypeMap.put("Thief5","Crew");	itemPrice.add(4.95);		itemType.add("0");		itemPrice_discount.add(4.95);
		itemName.add("Thief10");				itemPriceMap.put("Thief10",9.9);			itemTypeMap.put("Thief10","Crew");	itemPrice.add(9.9);			itemType.add("0");		itemPrice_discount.add(9.9);
		itemName.add("Guard5");					itemPriceMap.put("Guard5",4.95);			itemTypeMap.put("Guard5","Crew");	itemPrice.add(4.95);		itemType.add("0");		itemPrice_discount.add(4.95);
		itemName.add("Guard10");				itemPriceMap.put("Guard10",9.9);			itemTypeMap.put("Guard10","Crew");	itemPrice.add(9.9);		itemType.add("0");		itemPrice_discount.add(9.9);
		itemName.add("Prophet5");				itemPriceMap.put("Prophet5",8.45);			itemTypeMap.put("Prophet5","Crew");	itemPrice.add(8.45);		itemType.add("0");		itemPrice_discount.add(8.45);
		itemName.add("Prophet10");				itemPriceMap.put("Prophet10",16.9);			itemTypeMap.put("Prophet10","Crew");	itemPrice.add(16.9);		itemType.add("0");		itemPrice_discount.add(16.9);
		itemName.add("Spy5");					itemPriceMap.put("Spy5",6.65);				itemTypeMap.put("Spy5","Crew");		itemPrice.add(6.65);		itemType.add("0");		itemPrice_discount.add(6.65);
		itemName.add("Spy10");					itemPriceMap.put("Spy10",13.3);				itemTypeMap.put("Spy10","Crew");	itemPrice.add(13.3);		itemType.add("0");		itemPrice_discount.add(13.3);
		itemName.add("Insurance5");				itemPriceMap.put("Insurance5",6.65);		itemTypeMap.put("Insurance5","Crew");	itemPrice.add(6.65);		itemType.add("0");		itemPrice_discount.add(6.65);
		itemName.add("Insurance10");			itemPriceMap.put("Insurance10",13.3);		itemTypeMap.put("Insurance10","Crew");	itemPrice.add(13.3);		itemType.add("0");		itemPrice_discount.add(13.3);
		itemName.add("Robber5");				itemPriceMap.put("Robber5",4.95);			itemTypeMap.put("Robber5","Crew");		itemPrice.add(4.95);		itemType.add("0");		itemPrice_discount.add(4.95);
		itemName.add("Robber10");				itemPriceMap.put("Robber10",9.9);			itemTypeMap.put("Robber10","Crew");		itemPrice.add(9.9);			itemType.add("0");		itemPrice_discount.add(9.9);
		itemName.add("Fish Trader5");			itemPriceMap.put("Fish Trader5",6.65);		itemTypeMap.put("Fish Trader5","Crew");	itemPrice.add(6.65);		itemType.add("0");		itemPrice_discount.add(6.65);
		itemName.add("Fish Trader10");			itemPriceMap.put("Fish Trader10",13.3);		itemTypeMap.put("Fish Trader10","Crew");	itemPrice.add(13.3);		itemType.add("0");		itemPrice_discount.add(13.3);
		itemName.add("FishmanCombo5");			itemPriceMap.put("FishmanCombo5",15.95);	itemTypeMap.put("FishmanCombo5","Crew");	itemPrice.add(15.95);		itemType.add("0");		itemPrice_discount.add(15.95);
		itemName.add("FishmanCombo10");			itemPriceMap.put("FishmanCombo10",31.9);	itemTypeMap.put("FishmanCombo10","Crew");	itemPrice.add(31.9);		itemType.add("0");		itemPrice_discount.add(31.9);
		itemName.add("PirateCombo5");			itemPriceMap.put("PirateCombo5",12.45);		itemTypeMap.put("PirateCombo5","Crew");		itemPrice.add(12.45);		itemType.add("0");		itemPrice_discount.add(12.45);
		itemName.add("PirateCombo10");			itemPriceMap.put("PirateCombo10",24.9);		itemTypeMap.put("PirateCombo10","Crew");	itemPrice.add(24.9);		itemType.add("0");		itemPrice_discount.add(24.9);
		//Olympic combo (6:133-138)
		itemName.add("OlympicAbomb");			itemPriceMap.put("OlympicAbomb",20.0);		itemTypeMap.put("OlympicAbomb","Attack");	itemPrice.add(20.0);		itemType.add("0");		itemPrice_discount.add(20.0);
		itemName.add("OlympicAbomb10");			itemPriceMap.put("OlympicAbomb10",200.0);	itemTypeMap.put("OlympicAbomb10","Attack");	itemPrice.add(200.0);		itemType.add("0");		itemPrice_discount.add(200.0);
		itemName.add("OlympicTbox");			itemPriceMap.put("OlympicTbox",7.0);		itemTypeMap.put("OlympicTbox","Other");		itemPrice.add(7.0);			itemType.add("0");		itemPrice_discount.add(7.0);
		itemName.add("OlympicTbox10");			itemPriceMap.put("OlympicTbox10",70.0);		itemTypeMap.put("OlympicTbox10","Other");	itemPrice.add(70.0);		itemType.add("0");		itemPrice_discount.add(70.0);
		itemName.add("OlympicThief");			itemPriceMap.put("OlympicThief",3.0);		itemTypeMap.put("OlympicThief","Crew");		itemPrice.add(3.0);			itemType.add("0");		itemPrice_discount.add(3.0);
		itemName.add("OlympicThief10");			itemPriceMap.put("OlympicThief10",30.0);	itemTypeMap.put("OlympicThief10","Crew");	itemPrice.add(30.0);		itemType.add("0");		itemPrice_discount.add(30.0);
		//Olympic-background(1:139)
		itemName.add("Olympic-background");		itemPriceMap.put("Olympic-background",0.0);		itemTypeMap.put("OlympicThief10","Other");	itemPrice.add(0.0);			itemType.add("32");		itemPrice_discount.add(0.0);
		//defense system(4:140-143)
		itemName.add("Defense System 1-12");	itemPriceMap.put("Defense System 1-12",5.0);	itemTypeMap.put("Defense System 1-12","Defense");	itemPrice.add(5.0);			itemType.add("5");		itemPrice_discount.add(5.0);
		itemName.add("Defense System 1-30");	itemPriceMap.put("Defense System 1-30",10.0);	itemTypeMap.put("Defense System 1-30","Defense");	itemPrice.add(10.0);		itemType.add("9");		itemPrice_discount.add(10.0);
		itemName.add("Defense System 2-12");	itemPriceMap.put("Defense System 2-12",30.0);	itemTypeMap.put("Defense System 2-12","Defense");	itemPrice.add(30.0);		itemType.add("6");		itemPrice_discount.add(30.0);
		itemName.add("Defense System 2-30");	itemPriceMap.put("Defense System 2-30",60.0);	itemTypeMap.put("Defense System 2-30","Defense");	itemPrice.add(60.0);		itemType.add("10");		itemPrice_discount.add(60.0);
		//defense system(1:144)
		itemName.add("checkin");				itemPriceMap.put("checkin",1.99);				itemTypeMap.put("checkin","Other");					itemPrice.add(1.99);		itemType.add("0");		itemPrice_discount.add(1.99);
		//Olympic combo (1:145)
		itemName.add("OlympicAbomb100");		itemPriceMap.put("OlympicAbomb100",2000.0);		itemTypeMap.put("OlympicAbomb100","Attack");		itemPrice.add(2000.0);		itemType.add("0");		itemPrice_discount.add(2000.0);
		//world monster (2:146-147)
		itemName.add("WorldMonsterStrengUp");	itemPriceMap.put("WorldMonsterStrengUp",3.0);	itemTypeMap.put("WorldMonsterStrengUp","Other");	itemPrice.add(2000.0);		itemType.add("0");		itemPrice_discount.add(2000.0);
		itemName.add("summonMonster");			itemPriceMap.put("summonMonster",50.0);			itemTypeMap.put("summonMonster","Other");			itemPrice.add(2000.0);		itemType.add("0");		itemPrice_discount.add(2000.0);
		
		//Page(主要的) 
		itemPage.add("uv");
		itemPage.add("index.jsp");
		itemPage.add("luckyDraw.jsp");
		itemPage.add("hotShop.jsp");
		itemPage.add("weapons.jsp");
		itemPage.add("crews.jsp");
		itemPage.add("weaponTypes.jsp");
		itemPage.add("crewTypes.jsp");
		itemPage.add("activityMissionList.jsp");
		
		newUserItemPage.add("index.jsp");
		newUserItemPage.add("newUser.jsp");
		newUserItemPage.add("main.jsp");
		newUserItemPage.add("competition.jsp");
		newUserItemPage.add("friendBay.jsp");
		newUserItemPage.add("friends.jsp");
		newUserItemPage.add("noticeBoard.jsp");
		newUserItemPage.add("rank.jsp");
		newUserItemPage.add("search.jsp");
		newUserItemPage.add("missionList.jsp");
		newUserItemPage.add("attendance.jsp");
		newUserItemPage.add("warehouseAction.jsp");
		newUserItemPage.add("sellShip.jsp");
		newUserItemPage.add("shipyard.jsp");
		newUserItemPage.add("warehouse.jsp");
		
//		//Olympic-background
//		using_itemName.add("Royalty-background");
//		using_itemName.add("Olympic-background");
//		//avatar(15:0-14)												
//		using_itemName.add("Romancoliseum");			
//		using_itemName.add("liberty");				
//		using_itemName.add("greatwall");				
//		using_itemName.add("EiffelTower");			
//		using_itemName.add("Destroy-background");		
//		using_itemName.add("Halloween-warehouse");	
//		using_itemName.add("Halloween-shipyard");		
//		using_itemName.add("Halloween-background");	
//		using_itemName.add("Christmas-warehouse");	
//		using_itemName.add("Christmas-shipyard");		
//		using_itemName.add("Christmas-background");	
//		using_itemName.add("pyramid-warehouse");		
//		using_itemName.add("pyramid-shipyard");		
//		using_itemName.add("pyramid-background");		
//		
//		//crew(8:15-24)
//		using_itemName.add("Sailor");
//		using_itemName.add("Thief");		
//		using_itemName.add("Guard");		
//		using_itemName.add("Prophet");	
//		using_itemName.add("Spy");		
//		using_itemName.add("Insurance");	
//		using_itemName.add("Robber");		
//		using_itemName.add("Fish Trader");
//		using_itemName.add("Sliver Net");	
//		using_itemName.add("Golden Net");	
//		//weapon(8:25-38)		
//		using_itemName.add("a-bomb defense");	
//		using_itemName.add("Missile defense");		
//		using_itemName.add("TBox");					
//		using_itemName.add("A-bomb");					
//		using_itemName.add("big-toolbox");			
//		using_itemName.add("middle-toolbox");			
//		using_itemName.add("small-toolbox");			
//		using_itemName.add("shield");					
//		using_itemName.add("big-missile");			
//		using_itemName.add("middle-missile");			
//		using_itemName.add("small-missile");			
//		using_itemName.add("Big-bomb");		
//		//Super-toolbox(3:65-67)
//		using_itemName.add("Super-toolbox");		
//		//lucky crew (1:85)
//		using_itemName.add("lucky crew");			
//		//card(3:95-97)
//		using_itemName.add("Refresh_keeping_card");	
//		using_itemName.add("Freeze_card");			
//		using_itemName.add("fish_change_card");		
//		//new bomb
//		using_itemName.add("Whirlwind");	
//		using_itemName.add("Fireball");
//		using_itemName.add("Thunderbolt");
//		//message bomb
//		using_itemName.add("MessageBomb");	
//		using_itemName.add("MessageMissile");
		
		//attackmonster
		attackMonster_itemName.add("A-bomb");
		attackMonster_itemName.add("big-toolbox");
		attackMonster_itemName.add("middle-toolbox");
		attackMonster_itemName.add("small-toolbox");
		attackMonster_itemName.add("big-missile");
		attackMonster_itemName.add("middle-missile");
		attackMonster_itemName.add("small-missile");			
		attackMonster_itemName.add("Big-bomb");	
		attackMonster_itemName.add("Super-toolbox");
		attackMonster_itemName.add("Whirlwind");	
		attackMonster_itemName.add("Fireball");
		attackMonster_itemName.add("Thunderbolt");
		
		
	}
	
	static public boolean isTestAccount(int monetid){
		boolean flag = false;
		if(testAccount.contains(monetid)){
			flag = true;
		}else if(monetid<50000){
			flag = true;
		}
		return flag;
	}
	
	static public double countTotalCreditSelling(Map<String,Integer> selling,Map<String,Double> price,ArrayList<String> itemName){
		double totalCredit = 0;
		String item = "";
			for(int i=0;i<itemName.size();i++){
				item = itemName.get(i);
				if(selling.containsKey(item)&&price.containsKey(item)){
					if(selling.get(item)>0){
						totalCredit += selling.get(itemName.get(i))*price.get(itemName.get(i));
					}
				}
			}
		return totalCredit;
	}
	
	static public double countTotalCreditSellingDaily(Map<String,Double> credit,ArrayList<String> itemName){
		double totalCredit = 0;
			for(int i=0;i<itemName.size();i++){
				if(credit.get(itemName.get(i)) == null || credit.get(itemName.get(i)) ==0){
					
				}else{
					if(credit.get(itemName.get(i))>0){
						totalCredit += credit.get(itemName.get(i));
					}
				}
			}
		return totalCredit;
	}
	
	static public double countCheckinSellingDaily(Map<String,Double> credit,ArrayList<String> itemName){
		double totalCredit = 0;
		String item = "";
		for(int i=144;i<=144;i++){
			item = itemName.get(i);
			if(credit.get(item) == null || credit.get(item) ==0){
				
			}else{
				if(credit.get(item)>0){
					totalCredit += credit.get(item);
				}
			}
		}
		return totalCredit;
	}
	
	static public double countWarehouseSellingDaily(Map<String,Double> credit,ArrayList<String> itemName){
		double totalCredit = 0;
		for(int i=48;i<=50;i++){
			if(credit.get(itemName.get(i)) == null || credit.get(itemName.get(i)) ==0){
				
			}else{
				if(credit.get(itemName.get(i))>0){
					totalCredit += credit.get(itemName.get(i));
				}
			}
		}
		return totalCredit;
	}
	
	static public double countIconSellingDaily(Map<String,Double> credit,ArrayList<String> itemName){
		double totalCredit = 0;
		for(int i=79;i<=84;i++){
			if(credit.get(itemName.get(i)) == null || credit.get(itemName.get(i)) ==0){
				
			}else{
				if(credit.get(itemName.get(i))>0){
					totalCredit += credit.get(itemName.get(i));
				}
			}
		}
		return totalCredit;
	}
	
	static public double countHotShopSellingDaily(Map<String,Double> credit,ArrayList<String> itemName){
		double totalCredit = 0;
		for(int i=85;i<=101;i++){
			if(credit.get(itemName.get(i)) == null || credit.get(itemName.get(i)) ==0){
				
			}else{
				if(credit.get(itemName.get(i))>0){
					totalCredit += credit.get(itemName.get(i));
				}
			}
		}
		for(int i=133;i<=138;i++){
			if(credit.get(itemName.get(i)) == null || credit.get(itemName.get(i)) ==0){
				
			}else{
				if(credit.get(itemName.get(i))>0){
					totalCredit += credit.get(itemName.get(i));
				}
			}
		}
		for(int i=145;i<=145;i++){
			if(credit.get(itemName.get(i)) == null || credit.get(itemName.get(i)) ==0){
				
			}else{
				if(credit.get(itemName.get(i))>0){
					totalCredit += credit.get(itemName.get(i));
				}
			}
		}
		return totalCredit;
	}
	
	static public double countWeaponCreditSellingDaily(Map<String,Double> credit,ArrayList<String> itemName){
		double totalCredit = 0;
		
		for(int i=140;i<=143;i++){
			if(credit.get(itemName.get(i)) == null || credit.get(itemName.get(i)) ==0){
				
			}else{
				if(credit.get(itemName.get(i))>0){
					totalCredit += credit.get(itemName.get(i));
				}
			}
		}
		
		for(int i=102;i<=110;i++){
			if(credit.get(itemName.get(i)) == null || credit.get(itemName.get(i)) ==0){
				
			}else{
				if(credit.get(itemName.get(i))>0){
					totalCredit += credit.get(itemName.get(i));
				}
			}
		}
		
		for(int i=60;i<=78;i++){
			if(credit.get(itemName.get(i)) == null || credit.get(itemName.get(i)) ==0){
				
			}else{
				if(credit.get(itemName.get(i))>0){
					totalCredit += credit.get(itemName.get(i));
				}
			}
		}
			
		for(int i=25;i<=47;i++){
			if(i!=39&&i!=40)
			{
				if(credit.get(itemName.get(i)) == null || credit.get(itemName.get(i)) ==0){
					
				}else{
					if(credit.get(itemName.get(i))>0){
						totalCredit += credit.get(itemName.get(i));
					}
				}
			}
		}
		return totalCredit;
	}
	
	static public double countAttackCreditSellingDaily(Map<String,Double> credit,ArrayList<String> itemName){
		double totalCredit = 0;
		
		return totalCredit;
	}
	
	static public double countRentShipCreditSellingDaily(Map<String,Double> credit,ArrayList<String> itemName){
		double totalCredit = 0;
		String item = "";
		for(int i=51;i<=59;i++){
			item = itemName.get(i);
			if(credit.get(item) == null || credit.get(item) ==0){
				
			}else{
				if(credit.get(item)>0){
					totalCredit += credit.get(item);
				}
			}                                              
		}
		return totalCredit;
	}
	
	static public double countCrewCreditSellingDaily(Map<String,Double> credit,ArrayList<String> itemName){
		double totalCredit = 0;
		String item = "";
		for(int i=15;i<=24;i++){
			if(credit.get(itemName.get(i)) == null || credit.get(itemName.get(i)) ==0){
			}else{
				if(credit.get(itemName.get(i))>0){
					totalCredit += credit.get(itemName.get(i));
				}
			}
		}
		if(credit.get("PirateCombo")!=null){
			if( credit.get("PirateCombo")>0){
				totalCredit += credit.get("PirateCombo");	
			}
						
		}
		if(credit.get("FishermanCombo")!=null){
			if(credit.get("FishermanCombo")>0){
				totalCredit += credit.get("FishermanCombo");
			}
		}
		for(int i=113;i<=132;i++){
			item = itemName.get(i);
			if(credit.get(item) == null || credit.get(item) ==0){
				
			}else{
				if(credit.get(item)>0){
					totalCredit += credit.get(item);
				}
			}                                              
		}
		return totalCredit;
	}
	
	public static double getTypeSelling(Map<String,Double> creditMap,String type){
		double selling = 0;
		if(type.equals("All")){
//			Set<String> set = itemTypeMap.keySet();
//			for(String item:set){
//				if(creditMap.containsKey(item)){
//					selling += creditMap.get(item);
//				}
//			}
			Set<String> set = creditMap.keySet();
			for(String item:set){
				selling += creditMap.get(item);
			}
		}else{
			Set<String> set = itemTypeMap.keySet();
			for(String item:set){
				if(itemTypeMap.get(item).equals(type)){
					if(creditMap.containsKey(item)){
						selling += creditMap.get(item);
					}
				}
			}
		}
		return selling;
	}
	
	static public double countAvatarCreditSellingDaily(Map<String,Double> credit,ArrayList<String> itemName){
		double totalCredit = 0;
			for(int i=0;i<=14;i++){
				if(credit.get(itemName.get(i)) == null || credit.get(itemName.get(i)) ==0){
				}else{
					if(credit.get(itemName.get(i))>0){
						totalCredit += credit.get(itemName.get(i));
					}
				}
			}
		return totalCredit;
	}
	
	
	static public String getPercent(int a,int b){
		double rate = 0.0;
		DecimalFormat df = new DecimalFormat("0.00");
		rate = ((double)a)/((double)b);
		return df.format(rate);
	}
	
	static public ArrayList<String> getItemNameList(Date date1,Date date2){
		ArrayList<String> itemList = new ArrayList<String>();
		try {
			Object[] dbArgs = new Object[] {date1,date2};
			DBResultSet rs = dbClient.execSQLQuery(
							"select distinct item from daustocks where stime>=? and stime<=? order by item",
							dbArgs);
			while(rs.next()) {
				itemList.add(rs.getString("item"));
			}
		} catch (Exception e) {
			logger.error("getItemNameList with date1=" + date1, e);
		}
		return itemList;
	}
	
	static public ArrayList<String> getItemNameListFrom167(Date date1,Date date2){
		ArrayList<String> itemList = new ArrayList<String>();
		try {
			Object[] dbArgs = new Object[] {date1,date2};
			DBResultSet rs = dbClient.execSQLQuery(
							"select distinct iname from selling where stime>=? and stime<=? order by iname",
							dbArgs);
			while(rs.next()) {
				itemList.add(rs.getString("iname"));
			}
		} catch (Exception e) {
			logger.error("getItemNameListFrom167 with date1=" + date1, e);
		}
		return itemList;
	}
	
	static public ArrayList<String> getItemNameListUsingFrom167(Date date1,Date date2){
		ArrayList<String> itemList = new ArrayList<String>();
		try {
			Object[] dbArgs = new Object[] {date1,date2};
			DBResultSet rs = dbClient.execSQLQuery(
							"select distinct iname from using where utime>=? and utime<=? order by iname",
							dbArgs);
			while(rs.next()) {
				itemList.add(rs.getString("iname"));
			}
		} catch (Exception e) {
			logger.error("getItemNameListFrom167 with date1=" + date1, e);
		}
		return itemList;
	}
	
//	static public ArrayList<String> getattackMonsterItemNameList(){
//		return attackMonster_itemName;
//	}
	
	static public ArrayList<Double> getItemPriceList(){
		return itemPrice;
	}
	
	static public ArrayList<Double> getItemPriceDiscountList(){
		return itemPrice_discount;
	}
	
	static public ArrayList<String> getItemTypeList(){
		return itemType;
	}
	
	static public Map<String,String> getNameTypeMap(){
		return itemTypeMap;
	}
	
//	static public Map<String,Double> getitemPrice_discount(){
//		java.util.Map<String, Double> map = new java.util.HashMap<String,Double>();
//		
//		ArrayList<String> nameList = new ArrayList<String>();
//		ArrayList<Double> priceList = new ArrayList<Double>();
//		
//		nameList = getItemNameList();
//		priceList = getItemPriceDiscountList();
//		
//		if(nameList.size()==priceList.size()){
//			for(int i=0;i<nameList.size();i++){
//				map.put(nameList.get(i),priceList.get(i));
//			}
//		}
//		return map;
//	}
	
	static public ArrayList<String> getItemPageList(){
		return itemPage;
	}
	
	static public ArrayList<String> getItemNewUserPageList(){
		return newUserItemPage;
	}
	
	static public Date getDate(int dex){
		Date date = new Date();
		Calendar rightNow = Calendar.getInstance();
		GregorianCalendar gc = new GregorianCalendar(rightNow
				.get(Calendar.YEAR), rightNow.get(Calendar.MONTH),
				rightNow.get(Calendar.DAY_OF_MONTH));
		gc.add(Calendar.DATE, dex);
		date = (Date) gc.getTime();	
		return date;
	}
	
	static public Date getUserMinDate(String monetid){
		Date date = new Date();
		try {
			Object[] dbArgs = new Object[] {monetid};
			DBResultSet rs = dbClient.execSQLQuery(
							"select min(server_date) as min from user_event where monetid=?",
							dbArgs);
			while(rs.next()) {
				date = rs.getDate("min");
			}
		} catch (Exception e) {
			logger.error("getUserMinDate with monetid=" + monetid, e);
		}
		return date;
	}
	
	static public Date getUserMaxDate(String monetid){
		Date date = new Date();
		try {
			Object[] dbArgs = new Object[] {monetid};
			DBResultSet rs = dbClient.execSQLQuery(
							"select max(server_date) as max from user_event where monetid=?",
							dbArgs);
			while(rs.next()) {
				date = rs.getDate("max");
			}
		} catch (Exception e) {
			logger.error("getUserMaxDate with monetid=" + monetid, e);
		}
		return date;
	}
	
	public static Date convertDate(String adateStrteStr) {
		java.util.Date date = new Date();
		String format = "yyyy-MM-dd";
		try {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
			date = simpleDateFormat.parse(adateStrteStr);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return date;
	}
	
	public static String DateConvert(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String datestr = "";
		datestr = sdf.format(date);
		return datestr;
	}
	
	static public ArrayList<Date> compareDate(Date t1,Date t2,Date d1,Date d2){
		ArrayList<Date> dayList = new ArrayList<Date>();
		if(t2.compareTo(d2)>=0){
			if(t1.compareTo(d2)>=0){
				dayList.add(t1);
				dayList.add(t2);
			}else if(t1.compareTo(d1)>=0){
				dayList.add(d2);
				dayList.add(t2);
			}else{
				dayList.add(t1);
				dayList.add(d1);
				dayList.add(d2);
				dayList.add(t2);
			}
		}else if(t2.compareTo(d1)>=0){
			if(t1.compareTo(d1)>=0){
				
			}else{
				dayList.add(t1);
				dayList.add(d1);
			}
		}else{
			dayList.add(t1);
			dayList.add(t2);
		}
		
		return dayList;
	}
	
	static public ArrayList<Integer> getWeaponAmount(ArrayList<Integer> itemSell,ArrayList<Integer> itemGold){
		ArrayList<Integer> amount = new ArrayList<Integer>();
		for(int i=0;i<11;i++){
			amount.add(0);
		}
		for(int i=0;i<17;i++){
			if(i == 0){
				amount.set(6,itemSell.get(1)*4);
			}else
			if(i == 1){
				amount.set(6,itemSell.get(2)*3+amount.get(6));
				amount.set(5,itemSell.get(2)*5);
				amount.set(4,itemSell.get(2)*10);
			}else
			if(i == 2){
				amount.set(2,(itemSell.get(3) + itemGold.get(0))*4);
			}else
			if(i == 3){
				amount.set(2,(itemSell.get(4)+itemGold.get(1))*3+amount.get(2));
				amount.set(1,(itemSell.get(4)+itemGold.get(1))*5);
				amount.set(0,(itemSell.get(4)+itemGold.get(1))*10);
			}else if(i == 6){
				amount.set(0,itemSell.get(7)+itemGold.get(4)+amount.get(0));
			}else if(i == 7){
				amount.set(1,itemSell.get(8)+itemGold.get(5)+amount.get(1));
			}else if(i == 8){
				amount.set(2,itemSell.get(9)+itemGold.get(6)+amount.get(2));
			}else if(i == 9){
				amount.set(3,itemSell.get(10)+itemGold.get(7));
			}else if(i == 10){
				amount.set(4,itemSell.get(11)+amount.get(4));
			}else if(i == 11){
				amount.set(5,itemSell.get(12)+amount.get(5));
			}else if(i == 12){
				amount.set(6,itemSell.get(13)+amount.get(6));
			}else if(i == 13){
				amount.set(7,itemSell.get(14));
			}else if(i == 14){
				amount.set(8,itemSell.get(15));
			}else if(i == 15){
				amount.set(9,itemSell.get(16));
			}else if(i == 16){
				amount.set(10,itemSell.get(17));
			}
			
		}
		
		return amount;
	}
	
	public static String getPlatform(String phone){
		//BB
		Pattern bbp1 = Pattern.compile("\\d{1,}_.{1,}");
		Pattern bbp2 = Pattern.compile("BlackBerry.{1,}");
		Matcher bbm1 = bbp1.matcher(phone);
		Matcher bbm2 = bbp2.matcher(phone);
		
		//Android
		Pattern androidp1 = Pattern.compile("HTC/.{1,}");
		Pattern androidp2 = Pattern.compile("GT-.{1,}");
		Pattern androidp3 = Pattern.compile("HUAWEI/.{1,}");
		Pattern androidp4 = Pattern.compile("Acer/.{1,}");
		Pattern androidp5 = Pattern.compile(".*LG-.{1,}");
		Pattern androidp6 = Pattern.compile("[mM]otorola.{1,}");
		Pattern androidp7 = Pattern.compile("[sS][aA][mM][sS][uU][nN][gG].{1,}");
		Pattern androidp8 = Pattern.compile("Sony_{0,1}Ericsson.{1,}");
		Matcher androidm1 = androidp1.matcher(phone);
		Matcher androidm2 = androidp2.matcher(phone);
		Matcher androidm3 = androidp3.matcher(phone);
		Matcher androidm4 = androidp4.matcher(phone);
		Matcher androidm5 = androidp5.matcher(phone);
		Matcher androidm6 = androidp6.matcher(phone);
		Matcher androidm7 = androidp7.matcher(phone);
		Matcher androidm8 = androidp8.matcher(phone);
		
		//IOS
		Pattern iosp1 = Pattern.compile("iOS/.{1,}");
		Matcher iosm1 = iosp1.matcher(phone);
		
		//nokia
		Pattern nokiap1 = Pattern.compile("[Nn][oO][Kk][iI][Aa].{1,}");
		Matcher nokiam1 = nokiap1.matcher(phone);
		
		if(bbm1.matches()||bbm2.matches()){
			return "BlackBerry";
		}else if(androidm1.matches()||androidm2.matches()||androidm3.matches()
				||androidm4.matches()||androidm5.matches()||androidm6.matches()
					||androidm7.matches()||androidm8.matches()){
			return "Android";
		}else if(iosm1.matches()){
			return "IOS";
		}else if(nokiam1.matches()){
			return "Nokia";
		}else{
			return "Other";
		}
	}
	
	public static int getSum(ArrayList<Integer> list){
		int result = 0;
		
		for(int i:list){
			result += i;
		}
		
		return result;
	}

	public static Map<Date,Integer> checkExceptionValue(Map<Date,Double> source){
		Map<Date,Integer> result = new HashMap<Date,Integer>();
		List<Double> valueList = new ArrayList<Double>();
		double _up4;
		double _up4_real;
		int _up4_maybe;
		double _down4;
		double _down4_real;
		int _down4_maybe;
		double _mid;
		double _mid_real;
		int _mid_maybe;
		
		double highException = 0;
		double lowException = 0;
		
		Set<Date> dates = source.keySet();
		for(Date date:dates){
			valueList.add(source.get(date));
		}
		
		DecimalFormat df = new DecimalFormat("0");
		
		Collections.sort(valueList);
		
		_down4_real = (valueList.size()+1.0)/4-1;
		_down4_maybe = Integer.parseInt(df.format(Math.floor(_down4_real)));
		
		_mid_real = (valueList.size()+1.0)/2-1;
		_mid_maybe = Integer.parseInt(df.format(Math.floor(_mid_real)));
		
		_up4_real = 3*(valueList.size()+1.0)/4-1;
		_up4_maybe = Integer.parseInt(df.format(Math.floor(_up4_real)));
		
		_up4 = valueList.get(_up4_maybe)+(valueList.get(_up4_maybe+1)-valueList.get(_up4_maybe))*(_up4_real-_up4_maybe);
		_mid = valueList.get(_mid_maybe)+(valueList.get(_mid_maybe+1)-valueList.get(_mid_maybe))*(_mid_real-_mid_maybe);
		_down4 = valueList.get(_down4_maybe)+(valueList.get(_down4_maybe+1)-valueList.get(_down4_maybe))*(_down4_real-_down4_maybe);
		
		highException = _mid + (_up4-_mid)*1.5;
		lowException = _mid + (_down4-_mid)*1.5;
		
		double tempValue;
		for(Date date:dates){
			tempValue = source.get(date);
			if(tempValue>=highException){
				result.put(date, 1);
			}else if(tempValue<=lowException){
				result.put(date, 2);
			}else{
				result.put(date, 0);
			}
		}
		
		return result;
	}
	
	public static Date StringToDateHMS(String dateString){
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			return dateFormat.parse(dateString);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static void main(String args[]){
		double _up4;
		double _up4_real;
		int _up4_maybe;
		double _down4;
		double _down4_real;
		int _down4_maybe;
		double _mid;
		double _mid_real;
		int _mid_maybe;
		
		DecimalFormat df = new DecimalFormat("0");
		
		List<Double> valueList = new ArrayList<Double>();
		valueList.add(6.0);
		valueList.add(47.0);
		valueList.add(49.0);
		valueList.add(15.0);
		valueList.add(42.0);
		valueList.add(41.0);
		valueList.add(7.0);
		valueList.add(39.0);
		valueList.add(40.0);
		valueList.add(40.0);
		valueList.add(36.0);
		
		Collections.sort(valueList);
		
		_down4_real = (valueList.size()+1.0)/4-1;
		_down4_maybe = Integer.parseInt(df.format(Math.floor(_down4_real)));
		_mid_real = (valueList.size()+1.0)/2-1;
		_mid_maybe = Integer.parseInt(df.format(Math.floor(_mid_real)));
		_up4_real = 3*(valueList.size()+1.0)/4-1;
		_up4_maybe = Integer.parseInt(df.format(Math.floor(_up4_real)));
		
		for(int i=0;i<valueList.size();i++){
			System.out.println(valueList.get(i));
		}
		System.out.println("_up4_real="+_up4_real);
		System.out.println("_mid_real"+_mid_real);
		System.out.println("_down4_real="+_down4_real);
		
		_up4 = valueList.get(_up4_maybe)+(valueList.get(_up4_maybe+1)-valueList.get(_up4_maybe))*(_up4_real-_up4_maybe);
		_mid = valueList.get(_mid_maybe)+(valueList.get(_mid_maybe+1)-valueList.get(_mid_maybe))*(_mid_real-_mid_maybe);
		_down4 = valueList.get(_down4_maybe)+(valueList.get(_down4_maybe+1)-valueList.get(_down4_maybe))*(_down4_real-_down4_maybe);
		
		System.out.println("_up4="+_up4);
		System.out.println("_mid"+_mid);
		System.out.println("_down4="+_down4);
	}
}
