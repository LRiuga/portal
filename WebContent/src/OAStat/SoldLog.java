package OAStat;

import org.apache.log4j.Logger;
public class SoldLog {

	static Logger log = Logger.getLogger(SoldLog.class);
	
	static public void LogNormal(String msg)
	{
		log.info(msg);
	}
	
	static public void LogNormal(Throwable e)
	{
		log.info("Exception: ", e);
	}
}