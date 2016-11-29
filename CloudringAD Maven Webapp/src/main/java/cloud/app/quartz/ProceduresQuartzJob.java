package cloud.app.quartz;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;



public class ProceduresQuartzJob {
	Logger logger = Logger.getLogger(this.getClass());
	private SimpleDateFormat dsf = new SimpleDateFormat("yyyy-MM-dd");

	
	public void toJob(){
		Map<String,Object> param=new HashMap<String, Object>();
		Date now=new Date();
		String statTime=dsf.format(now);
		String weekendTime=dsf.format(getDate(now, -6));
		String monthendTime=dsf.format(getDate(now, -29));
		param.put("statTime", statTime);
		param.put("weekendTime", weekendTime);
		param.put("monthendTime", monthendTime);
		try {
			
		} catch (Exception e) {
			logger.debug(e);			
		}
		
	}

	
	/**
	   *求时间的前一天或下一天时间
	   * @param date
	   * @param day
	   * @return
	   */
	  public static Date getDate(Date date,int day){
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			calendar.add(Calendar.DAY_OF_MONTH, day);
			Date date1 = new Date(calendar.getTimeInMillis());
			return date1;
		}
}
