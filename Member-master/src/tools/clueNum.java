package tools;

public class clueNum {
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
			newNum="XS0001";
		}
		else{
			String numPart=num.replaceAll("[a-zA-Z]", "");
			int number=Integer.parseInt(numPart);
			number=number+1;
			if(number<10)
			{
				newNum="XS000"+number;
			}
			else if(number<100)
			{
				newNum="XS00"+number;
			}
			else if(number<1000)
			{
				newNum="XS0"+number;
			}
			else if(number<10000)
			{
				newNum="XS"+number;
			}
		}
		return newNum;
	}
}
