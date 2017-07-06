package tools;

import java.security.MessageDigest;

import java.util.Random;


import entity.User;

public class MD5SaltUtils {
	/**
	 * 作者：郑建彬
	 * 功能：MD5+salt算法
	 *
	 * 
	 */
	//MD5+salt
	public static String encode(String rawPassword,String salt)
	{
		String result=null;
		try {
			MessageDigest md=MessageDigest.getInstance("MD5");
			result=encoder16(md.digest((addSalt(rawPassword,salt).getBytes("UTF-8"))));
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}
	static User addUserSalt(String salt)
	{
		User user=new User();
		user.setSalt(salt);
		return user;
	}
	//转换为16位字符串
	static String encoder16(byte[] b)
	{
		String ret = "";  
	    for (int i = 0; i < b.length; i++) {  
	        String hex = Integer.toHexString(b[ i ] & 0xFF);  
	    if (hex.length() == 1) {  
	        hex = '0' + hex;  
	    }  
	     ret += hex;  
	  }  
	  return ret;  
	}
	static String addSalt(String password,String salt)
	{
		if(password == null)
		{
			password=null;;
		}
		if(salt == null || "".equals(salt))
		{
			return password;
		}
		else {
			return password+salt.toString();
		}
	}
	//随机生一个8位salt
	public static String randomCreateSalt()
	{
		String strArray="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%&123456";
		Random random=new Random();
		StringBuffer stringBuffer=new StringBuffer();
		for(int i=0;i<8;i++)
		{
			int randomNum=random.nextInt(strArray.length());
			stringBuffer.append(strArray.charAt(randomNum));
		}
		return stringBuffer.toString();
	}
	public static String randomCreatePwd()
	{
		String strArray="abcdefghijklmnopqrstuvwxyz1234567890";
		Random random=new Random();
		StringBuffer stringBuffer=new StringBuffer();
		for(int i=0;i<10;i++)
		{
			int randomNum=random.nextInt(strArray.length());
			stringBuffer.append(strArray.charAt(randomNum));
		}
		return stringBuffer.toString();
	}
}
