package tools;

public class experienceNum {
	/*
	 * 修改：添加一个为空null的判断
	 * 作者：刘娈莎
	 * 日期：2016-7-13
	 * 
	 * 修改：将判断条件num==""改为num.equals("")
	 * 作者：刘娈莎
	 * 日期：2016-7-13
	 */
	public static String getNum(String num)
	{
		String newNum="";
		if(num==null)
		{
			newNum="TY0001";
		}
		else{
			String numPart=num.replaceAll("[a-zA-Z]", "");
			int number=Integer.parseInt(numPart);
			number=number+1;
			if(number<10)
			{
				newNum="TY000"+number;
			}
			else if(number<100)
			{
				newNum="TY00"+number;
			}
			else if(number<1000)
			{
				newNum="TY0"+number;
			}
			else if(number<10000)
			{
				newNum="TY"+number;
			}
		}
		return newNum;
	}
}
