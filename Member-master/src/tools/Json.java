package tools;





//这是用户的Layer的弹出图片的json
public class Json {
	public static String getjson(String path)
	{
		StringBuffer buffer=new StringBuffer();
		String line="";
		line=line+"{";
		line=line+"\"data\":";
		line=line+"[";
			line=line+"{";
			line=line+"\"src\":\""+path+",";
			line=line+"\"area\": [638, 851]";
			line=line+"}";
			
		line=line+"]";
		line=line+"}";
	    String string=buffer.append(line).toString();
	    System.out.println("这是json"+string);
		return string;
	}
}
