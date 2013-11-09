package util;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Map;

public class HighChartUtil {
	public static String getxAxis(ArrayList<String> list){
		if(!list.isEmpty()){
			StringBuffer sb = new StringBuffer();
			for(String string:list){
				sb.append("'"+string+"'");
				sb.append(",");
			}
			return sb.substring(0,sb.length()-1);
		}else{
			return null;
		}
		
	}
	
	public static String getxAxis(ArrayList<String> list,Map<String,Double> map){
		DecimalFormat df = new DecimalFormat("0.00");
		if(!list.isEmpty()){
			StringBuffer sb = new StringBuffer();
			for(String string:list){
				if(map.containsKey(string)){
					sb.append(df.format(map.get(string)));
					sb.append(",");
				}else{
					sb.append(0);
					sb.append(",");
				}
			}
			return sb.substring(0,sb.length()-1);
		}else{
			return null;
		}
		
	}
}
