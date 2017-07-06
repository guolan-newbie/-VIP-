package tools;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 格式化时间工具类
 * 
 * @author 刘娈莎 日期： 2016年11月20日
 *
 */
public class DateFormatUtils {
	/** 格式化日期 */
	private static final DateFormat FORMAT_DATE = new SimpleDateFormat("yyyy-MM-dd");
	/** 格式化时间 */
	private static final DateFormat FORMAT_TIME = new SimpleDateFormat("HH:mm:ss");
	/** 格式化日期+时间 */
	private static final DateFormat FORMAT_DATE_TIME = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	/** 格式化日期(无间隔) */
	private static final DateFormat FORMAT_DATE_NO_SPACING = new SimpleDateFormat("yyyyMMdd");
	/** 格式化时间(无间隔) */
	private static final DateFormat FORMAT_TIME_NO_SPACING = new SimpleDateFormat("HHmmss");
	/** 格式化日期+时间(无间隔) */
	private static final DateFormat FORMAT_DATE_TIME_NO_SPACING = new SimpleDateFormat("yyyyMMddHHmmss");

	/**
	 * <p>
	 * Title: dateFormat
	 * </p>
	 * <p>
	 * Description: 格式化时间，返回年月日字符串
	 * </p>
	 * 
	 * @author 刘娈莎 日期： 2016年11月20日
	 *
	 * @param date
	 *            Date 传入Date类型的时间
	 * @return String 年月日字符串
	 */
	public static String dateFormat(Date date) {
		return FORMAT_DATE.format(date);
	}

	/**
	 * <p>
	 * Title: timeFormat
	 * </p>
	 * <p>
	 * Description: 格式化时间，返回时分秒字符串
	 * </p>
	 * 
	 * @author 刘娈莎 日期： 2016年11月20日
	 *
	 * @param date
	 *            Date 传入Date类型的时间
	 * @return String 时分秒字符串
	 */
	public static String timeFormat(Date date) {
		return FORMAT_TIME.format(date);
	}

	/**
	 * <p>
	 * Title: dateTimeFormat
	 * </p>
	 * <p>
	 * Description: 格式化时间，返回年月日 时分秒字符串
	 * </p>
	 * 
	 * @author 刘娈莎 日期： 2016年11月20日
	 *
	 * @param date
	 *            Date 传入Date类型的时间
	 * @return String 年月日 时分秒字符串
	 */
	public static String dateTimeFormat(Date date) {
		return FORMAT_DATE_TIME.format(date);
	}

	/**
	 * <p>
	 * Title: dateFormat
	 * </p>
	 * <p>
	 * Description: 格式化时间，返回年月日（无间隔）字符串
	 * </p>
	 * 
	 * @author 刘娈莎 日期： 2016年11月20日
	 *
	 * @param date
	 *            Date 传入Date类型的时间
	 * @return String 年月日（无间隔）字符串
	 */
	public static String dateFormatNoSpacing(Date date) {
		return FORMAT_DATE_NO_SPACING.format(date);
	}

	/**
	 * <p>
	 * Title: timeFormat
	 * </p>
	 * <p>
	 * Description: 格式化时间，返回时分秒（无间隔）字符串
	 * </p>
	 * 
	 * @author 刘娈莎 日期： 2016年11月20日
	 *
	 * @param date
	 *            Date 传入Date类型的时间
	 * @return String 时分秒（无间隔）字符串
	 */
	public static String timeFormatNoSpacing(Date date) {
		return FORMAT_TIME_NO_SPACING.format(date);
	}

	/**
	 * <p>
	 * Title: dateTimeFormat
	 * </p>
	 * <p>
	 * Description: 格式化时间，返回年月日 时分秒（无间隔）字符串
	 * </p>
	 * 
	 * @author 刘娈莎 日期： 2016年11月20日
	 *
	 * @param date
	 *            Date 传入Date类型的时间
	 * @return String 年月日 时分秒（无间隔）字符串
	 */
	public static String dateTimeFormatNoSpacing(Date date) {
		return FORMAT_DATE_TIME_NO_SPACING.format(date);
	}

	/**
	 * <p>
	 * Title: dateTimeFormat
	 * </p>
	 * <p>
	 * Description: 格式化字符串，将时间字符串格式化成Date
	 * </p>
	 * 
	 * @author 张晓敏 日期： 2017年2月21日
	 *
	 * @param string
	 *            String 需要格式化的时间字符串
	 * @return Date 当字符串不合法时，返回null，否者返回对应的时间
	 */
	public static Date dateParse(String string) {
		try {
			return FORMAT_DATE.parse(string);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}
}
