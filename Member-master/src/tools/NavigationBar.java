package tools;

import java.util.Map;
import java.util.Set;

public class NavigationBar {

	private static final StringBuilder HttpSession = null;
	/**
	 * <p>生成分页导航条字符串
	 * @param url 页面url
	 * @param btnCount 要显示的按钮数
	 * @param page 当前页码
	 * @param pageCount 总页数
	 * @return String 导航条字符串
	 * @author 陈泽帆
	 */
	//正常分页导航条
	public static String NavBar(String url,int btnCount,int page,int pageCount){
		String mark="?";
		StringBuilder str=new StringBuilder();
		int start=page-btnCount/2;
		int end=page+btnCount/2;
		if(url.contains("?")){
			mark="&";
		}
		if(btnCount%2==0){
			end--;
		}
		if(start<=0){
			start=1;
			end=start+btnCount-1;
		}
		if(end>pageCount){
			end=pageCount;
			start=end-btnCount+1;
		}
		if(start<=0){
			start=1;
		}
		str.append("<a href='"+url+mark+"page="+1+"'>");
		str.append("首页");
		str.append("</a>");
		str.append("&nbsp;&nbsp;");
		for(int i=start;i<=end;i++){
			str.append("<a href='"+url+mark+"page="+i+"'>");
			if(i==page){
			str.append("<font color='red'><b>");
			str.append(i);
			str.append("</b></font>");
			}
			else {
				str.append(i);
			}
			str.append("</a>");
			str.append("&nbsp;&nbsp;");			
		}
		str.append("<a href='"+url+mark+"page="+pageCount+"'>");
		str.append("尾页");
		str.append("</a>");
		str.append("&nbsp;&nbsp;");
		str.append("共"+pageCount+"页");
		return str.toString();
	}
	/**
	 * <p>生成<br>有病的<br>分页导航条字符串
	 * @param url 页面url
	 * @param btnCount 要显示的按钮数
	 * @param page 当前页码
	 * @param pageCount 总页数
	 * @return String 导航条字符串
	 * @author 陈泽帆
	 */
	//有病分页导航条
	public static String sickNavBar(String url,int btnCount,int page,int pageCount){
		String mark="?";
		StringBuilder str=new StringBuilder();
		int start=page-btnCount/2;
		int end=page+btnCount/2;
		if(url.contains("?")){
			mark="&";
		}
		if(btnCount%2==0){
			end--;
		}
		if(start<=0){
			start=1;
			end=start+btnCount-1;
		}
		if(end>pageCount){
			end=pageCount;
			start=end-btnCount+1;
		}
		if(start<=0){
			start=1;
		}
		str.append("<a href='#' class='nav' lang='"+url+mark+"page="+1+"'>");
		str.append("首页");
		str.append("</a>");
		str.append("&nbsp;&nbsp;");
		for(int i=start;i<=end;i++){
			str.append("<a href='#' class='nav' lang='"+url+mark+"page="+i+"'>");
			if(i==page){
			str.append("<font color='red'><b>");
			str.append(i);
			str.append("</b></font>");
			}
			else {
				str.append(i);
			}
			str.append("</a>");
			str.append("&nbsp;&nbsp;");			
		}
		str.append("<a href='#' class='nav' lang='"+url+mark+"page="+pageCount+"'>");
		str.append("尾页");
		str.append("</a>");
		str.append("&nbsp;&nbsp;");
		str.append("共"+pageCount+"页");
		return str.toString();
	}
	/**
	 * <p>生成<br>有样式的<br>分页导航条字符串
	 * @param url 页面url
	 * @param btnCount 要显示的按钮数
	 * @param page 当前页码
	 * @param pageCount 总页数
	 * @return String 导航条字符串
	 * @author 刘娈莎
	 */
	//有样式的分页导航条
		public static String classNavBar(String url,int btnCount,int page,int pageCount){
			StringBuilder str=new StringBuilder();
			int start=page-btnCount/2;
			int end=page+btnCount/2;
			if(btnCount%2==0){
				end--;
			}
			if(start<=0){
				start=1;
				end=start+btnCount-1;
			}
			if(end>pageCount){
				end=pageCount;
				start=end-btnCount+1;
			}
			if(start<=0){
				start=1;
			}
			str.append("<a href='javascript:;'  class='nav-btn' lang='"+1+"'>");
			str.append("<button type='button'>");
			str.append("首页");
			str.append("</button>");
			str.append("</a>");
			str.append("&nbsp;&nbsp;");
			for(int i=start;i<=end;i++){
				str.append("<a href='javascript:;' class='nav-btn' lang='"+i+"'>");
				if(i==page){
				str.append("<button type='button'  id='btn-currentpage'>");
				str.append("<font color='red'><b>");
				str.append(i);
				str.append("</b></font>");
				str.append("</button>");
				}
				else {
					str.append("<button type='button'>");				
					str.append(i);				
					str.append("</button>");
				}
				str.append("</a>");
				str.append("&nbsp;&nbsp;");			
			}
			str.append("<a href='javascript:;'  class='nav-btn' lang='"+pageCount+"'>");
			str.append("<button type='button'>");
			str.append("尾页");
			str.append("</button>");
			str.append("</a>");
			str.append("&nbsp;&nbsp;");
			str.append("共"+pageCount+"页");
			return str.toString();
		}
		
}
