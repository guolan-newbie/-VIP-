package tools;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 获取随机数工具类
 * 
 * @author 刘娈莎 日期： 2016年11月20日
 *
 */
public class RandomNumberUtils {
	/** 格式化月份+日期(无间隔) */
	private static final DateFormat FORMAT_MONTH_AND_DAY_NO_SPACING = new SimpleDateFormat("MMdd");

	/**
	 * <p>
	 * Title: getLongRandomNumber
	 * </p>
	 * <p>
	 * Description: 获取年月日时分秒+4位随机数字符串（共18位）
	 * </p>
	 * 
	 * @author 刘娈莎 日期： 2016年11月20日
	 *
	 * @return String 返回18位随机数字符串
	 */
	public static String getLongRandomNumber() {
		return DateFormatUtils.dateTimeFormatNoSpacing(new Date()) + getFourDigitsRandomNumberString();
	}

	/**
	 * <p>
	 * Title: getShortRandomNumber
	 * </p>
	 * <p>
	 * Description: 获取月份+日期+4位随机数字符串（共8位）
	 * </p>
	 * 
	 * @author 刘娈莎 日期： 2016年11月20日
	 *
	 * @return String 返回8位随机数字符串
	 */
	public static String getShortRandomNumber() {
		return FORMAT_MONTH_AND_DAY_NO_SPACING.format(new Date()) + getFourDigitsRandomNumberString();
	}

	/**
	 * <p>
	 * Title: getFourDigitsRandomNumberString
	 * </p>
	 * <p>
	 * Description: 获取4位随机数字符串
	 * </p>
	 * 
	 * @author 刘娈莎 日期： 2016年11月20日
	 *
	 * @return String 返回4位随机数字符串
	 */
	public static String getFourDigitsRandomNumberString() {
		return String.format("%04d", (int) (Math.random() * 10000));
	}
}
