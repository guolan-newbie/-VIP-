package visitListener;


import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;


import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import dao.VisitDAO;
import entity.History;
import entity.User;
import entity.Visitor;
import tools.HttpRequestDeviceUtils;


/**
 * Application Lifecycle Listener implementation class listener
 *
 */
@WebListener
public class listener implements ServletContextListener, HttpSessionListener, ServletRequestListener {
	Visitor visitor=new Visitor();
	History history=new History();
	HttpServletRequest request;
	HttpSession session;
	ServletContext application;
	VisitDAO visitDAO;
	/**
     * Default constructor. 
     */
    public listener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see HttpSessionListener#sessionCreated(HttpSessionEvent)
     */
    
//    WebApplicationContext webApplicationContext = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
    public void sessionCreated(HttpSessionEvent arg0)  { 
//         // TODO Auto-generated method stub
//    	System.out.println("+++=========================================================================");
//    	session=arg0.getSession();
//    	visitor.setIp(request.getRemoteAddr());
//    	//获取用户来着的网页的
//    	//通过抽象的私有方法得到Spring容器中Bean的实例。  
//    	visitor.setComfrom(request.getServletPath());
//    	
//    	System.out.println(visitor.getVisitTime());
//    	int id=0;
//    	try {
//			 id=visitDAO.addvisit(visitor);
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//    	visitor.setId(id);
//    	session.setAttribute("visitor", visitor);
//    	@SuppressWarnings("unchecked")
//		HashMap<String,Visitor> map=(HashMap<String, Visitor>) application.getAttribute("online");
//    	map.put(session.getId(),visitor);
    }
	/**
     * @see ServletRequestListener#requestDestroyed(ServletRequestEvent)
     */
    private Object getObjectFromApplication(ServletContext servletContext,String beanName){  
        //通过WebApplicationContextUtils 得到Spring容器的实例。  WebApplicationContext webApplicationContext = (WebApplicationContext) servletContext.getAttribute(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
        ApplicationContext application=WebApplicationContextUtils.getWebApplicationContext(servletContext);  
        //返回Bean的实例。  
        return application.getBean(beanName);  
    }  
    public void requestDestroyed(ServletRequestEvent arg0)  { 
         // TODO Auto-generated method stub
    }
	/**
     * @see ServletRequestListener#requestInitialized(ServletRequestEvent)
     */
    public void requestInitialized(ServletRequestEvent arg0)  { 
//         // TODO Auto-generated method stub
//    	 request=(HttpServletRequest) arg0.getServletRequest();
//    	 //判断是否为手机用户，返回的是boolean型
//    	 boolean flag=HttpRequestDeviceUtils.isMobileDevice(request);
//    	 session=request.getSession();
//    	 visitor=(Visitor)session.getAttribute("visitor"); 
//		 if(flag==false){
//			 visitor.setAgent(flag);
//		  	}
//		 visitor.setVisitTime(new Date());
//		 visitor.setAgent(true);
//    	 history.setVisitor(visitor);
//    	 history.setUrl(visitor.getComfrom());
//    	 history.setVisitTime(visitor.getVisitTime());
//    	 history.setAgent(visitor.getAgent());
//    	 System.out.println("这是设置访问的uid");
//    	 User user=(User)session.getAttribute("myuser");
//    	 visitor.setUser(user);
//    	 try {
//			visitDAO.addvisit(visitor);
//			visitDAO.addhistory(history);
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
    }
	/**
     * @see HttpSessionListener#sessionDestroyed(HttpSessionEvent)
     */
    public void sessionDestroyed(HttpSessionEvent arg0)  { 
//         // TODO Auto-generated method stub
// 	//用户离开的时候，把该用户从在线用户表中删除
    	@SuppressWarnings("unchecked")
    	HashMap<String, Visitor> map=(HashMap<String, Visitor>) application.getAttribute("online");
    	Visitor visitor=map.get(arg0.getSession().getId());
    	if(visitor == null) {
    		return ;
    	}
    	visitor.setLeftTime(new Date());
		visitDAO.update(visitor);
//    	//设置访客用户的uid
//    	User user=(User)session.getAttribute("myuser");
//    	visitor.setUser(user);
//    	visitors.setLeftTime(new Date());
//    	System.out.println(visitor.getLeftTime());
//    	try {
//			visitDAO.addvisit(visitors);
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//    	//删除之前，把数据库的离开的时间给设置上来
    	
    }
	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent arg0)  { 
         // TODO Auto-generated method stub
    }
	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent arg0)  { 
//         // TODO Auto-generated method stub
    	 String beanName="visitDAO";
    	 visitDAO=(VisitDAO) this.getObjectFromApplication(arg0.getServletContext(),beanName);  
    	 application=arg0.getServletContext();
    	 HashMap<String,Visitor> map=new HashMap<String,Visitor>();
    	 application.setAttribute("online",map);
    }
}
