package tools;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;


public class SummaryTitle {
	/**
	 * <p>生成当前周的标题
	 * @return String 标题字符串
	 */
	public static String getTitle()
	{
		//i=2的时候是周一
		int i=today();
		Date date=new Date();
		SimpleDateFormat simpleDateFormat= new SimpleDateFormat("yyyy/MM/dd");
		String title=null;
		if(i!=1)
		{
			String currentDate=simpleDateFormat.format(new Date(date.getTime()-(i-2)*24*60*60*1000));
			String sevenafter=simpleDateFormat.format(new Date(date.getTime()+(8-i)*24*60*60*1000));
			title=currentDate+"-"+sevenafter;
		}
		if(i==1)//i=1的时候为周末，单独计算
		{
			String currentDate=simpleDateFormat.format(new Date(date.getTime()-6*24*60*60*1000));
			String sevenafter=simpleDateFormat.format(new Date());
			title=currentDate+"-"+sevenafter;
		}
		return title;
	}
	/**
	 * <p>获取<br>相对于传过来的时间的<br>本周标题
	 * @param Date date
	 * @return String
	 * @throws ParseException
	 * @author 刘娈莎
	 */
	public static String getTitleSec(Date date) throws ParseException
	{
		//i=2的时候是周一
		int i=getDay(date);
		SimpleDateFormat simpleDateFormat= new SimpleDateFormat("yyyy/MM/dd");
		String title=null;
		if(i!=1)
		{
			String currentDate=simpleDateFormat.format(new Date(date.getTime()-(i-2)*24*60*60*1000));
			String sevenafter=simpleDateFormat.format(new Date(date.getTime()+(8-i)*24*60*60*1000));
			title=currentDate+"-"+sevenafter;
		}
		if(i==1)//i=1的时候为周末，单独计算
		{
			String currentDate=simpleDateFormat.format(new Date(date.getTime()-6*24*60*60*1000));
			String sevenafter=simpleDateFormat.format(new Date());
			title=currentDate+"-"+sevenafter;
		}
		return title;
	}

	/**
	 * <p>获取上一周标题
	 * @return String 上一周标题
	 */
	public static String getPreWeekTitle()
	{
		//i=2的时候是周一
		int i=today();
		Date date=new Date();
		SimpleDateFormat simpleDateFormat= new SimpleDateFormat("yyyy/MM/dd");
		String title=null;
		if(i!=1)
		{
			String currentDate=simpleDateFormat.format(new Date(date.getTime()-(i-2)*24*60*60*1000-7*24*60*60*1000));
			String sevenafter=simpleDateFormat.format(new Date(date.getTime()+(8-i)*24*60*60*1000-7*24*60*60*1000));
			title=currentDate+"-"+sevenafter;
		}
		if(i==1)//i=1的时候为周末，单独计算
		{
			String currentDate=simpleDateFormat.format(new Date(date.getTime()-6*24*60*60*1000-7*24*60*60*1000));
			String sevenafter=simpleDateFormat.format(new Date(-7*24*60*60*1000));
			title=currentDate+"-"+sevenafter;
		}
		return title;
	}
	/**
	 * <p>获取<br>相对于传过来的时间的<br>上一周标题
	 *  @param String date
	 * @return String
	 * @throws ParseException
	 */
	public static String getPreWeekTitleSec(String date) throws ParseException
	{
		SimpleDateFormat simpleDateFormat= new SimpleDateFormat("yyyy/MM/dd");
		Date dates=simpleDateFormat.parse(date);
		String secontCurrentTime=simpleDateFormat.format(new Date(dates.getTime()-7*24*60*60*1000));
		String secontAfterSevTime=simpleDateFormat.format(new Date(dates.getTime()-1*24*60*60*1000));
		return secontCurrentTime+"-"+secontAfterSevTime;
	}
	/**
	 * <p>获取下一周标题
	 * @return String 下一周标题
	 */
	public static String getNextWeekTitle()
	{
		//i=2的时候是周一
		int i=today();
		Date date=new Date();
		SimpleDateFormat simpleDateFormat= new SimpleDateFormat("yyyy/MM/dd");
		String title=null;
		if(i!=1)
		{
			String currentDate=simpleDateFormat.format(new Date(date.getTime()-(i-2)*24*60*60*1000+7*24*60*60*1000));
			String sevenafter=simpleDateFormat.format(new Date(date.getTime()+(8-i)*24*60*60*1000+7*24*60*60*1000));
			title=currentDate+"-"+sevenafter;
		}
		if(i==1)//i=1的时候为周末，单独计算
		{
			String currentDate=simpleDateFormat.format(new Date(date.getTime()-6*24*60*60*1000+7*24*60*60*1000));
			String sevenafter=simpleDateFormat.format(new Date(+7*24*60*60*1000));
			title=currentDate+"-"+sevenafter;
		}
		return title;
	}
	/**
	 * <p>获取<br>相对于传过来的时间的<br>下一周标题
	 * @param String date
	 * @return String
	 * @throws ParseException
	 */
	public static String getNextWeekTitleSec(String date) throws ParseException
	{
		SimpleDateFormat simpleDateFormat= new SimpleDateFormat("yyyy/MM/dd");
		Date dates=simpleDateFormat.parse(date);
		String secontCurrentTime=simpleDateFormat.format(new Date(dates.getTime()+7*24*60*60*1000));
		String secontAfterSevTime=simpleDateFormat.format(new Date(dates.getTime()+13*24*60*60*1000));
		return secontCurrentTime+"-"+secontAfterSevTime;
	}	
/**
 * <p>获取今天相对于提交周报周期的标题<br>本周四—>下周三（都属于本周）
 * @return String
 * @throws ParseException 
 * @author 刘娈莎
 */
	public static String getWriteTitle() throws ParseException
	{
		String title="";
		int i=today();
		if(i>=5||i==1)
		{
			title=getTitle();
		}
		else{
			title=getPreWeekTitleSec(getTitle());
		}		
		return title;
	}
	/**
	 * <p>获取今天提交周报周期的标题<br>本周四—>下周三（都属于本周）
	 * @return String
	 * @throws ParseException 
	 * @author 刘娈莎
	 */
		public static String getWriteTitle(Date date) throws ParseException
		{
			String title="";
			int i=getDay(date);
			if(i>=5||i==1)
			{
				title=getTitleSec(date);
			}
			else{
				title=getPreWeekTitleSec(getTitleSec(date));
				//title=getTitleSec(date);
			}		
			return title;
		}
	/**
	 * <p>获取当前时间
	 * @return String 当前时间
	 */
	public static String getTime()
	{
		Date date=new Date();
		SimpleDateFormat simpleDateFormat= new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		String currentDate=simpleDateFormat.format(date);
		return currentDate;
	}
	/**
	 * <p>获取今天星期几<br>日 一 二 三 四 五 六<br>&nbsp;1&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;&nbsp;6&nbsp;&nbsp;7
	 * @return int 星期几
	 */
	public static int today()
	{
		Date today=new Date();
		Calendar calendar=Calendar.getInstance();
		calendar.setTime(today);
		return calendar.get(Calendar.DAY_OF_WEEK);
	}
	/**
	 * <p>获取传过来的时间为星期几<br>日 一 二 三 四 五 六<br>&nbsp;1&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;&nbsp;6&nbsp;&nbsp;7
	 * @param Date date
	 * @return int 星期几
	 * @author 刘娈莎
	 */
	public static int getDay(Date date)
	{
		Calendar calendar=Calendar.getInstance();
		calendar.setTime(date);
		return calendar.get(Calendar.DAY_OF_WEEK);
	}

}


