package OAStat;

import org.apache.log4j.Logger;
public class UsedLog {

	static Logger log = Logger.getLogger(UsedLog.class);
	
	static public void LogNormal(String msg)
	{
		log.info(msg);
	}
	
	static public void LogNormal(Throwable e)
	{
		log.info("Exception: ", e);
	}
}