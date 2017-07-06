package tools;

import java.util.Map;
import java.util.Map.Entry;

public class UrlUtil {
	private static String mark = "?";
	
	//map类型的拼接参数
	public static String getUrl(String url,Map<String, String> params){
		checkUrl(url);
		for(Entry<String, String> entry : params.entrySet()){
			url += mark + entry.getKey() + "=" + entry.getValue();
			mark = "&";
		}
		return url;
	}
		
	
	protected static void checkUrl(String url){
		int index = url.lastIndexOf("?");
		if(index!=-1){
			throw new IllegalArgumentException("请传入不带任何参数的URL地址");
		}
	}
}
