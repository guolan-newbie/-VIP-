package controller;

import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.jws.soap.SOAPBinding.Use;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.JSONObject;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import dao.MemberDAO;
import dao.PictureDAO;
import dao.SocialDAO;
import dao.UserDAO;
import dto.SocialDTO;
import entity.Experience;
import entity.Member;
import entity.Picture;
import entity.Social;
import entity.User;
import entity.UserInfo;
import tools.Authentication;
import tools.NavigationBar;
import tools.ReturnJson;

@Controller
@RequestMapping("/Social")
public class SocialController {
	@Resource
	SocialDAO socialDAO;
	@Resource
	PictureDAO pictureDAO;
	@Resource
	MemberDAO MemberDAO;
	@Resource
	UserDAO userDAO;
	/*
	 * 功能:获取满足同个条件的人员
	 * 作者:王温迪
	 * 日期2016-8-10
	 */
	@ResponseBody
	@RequestMapping("/getSocial.action")
	public String getSocial(HttpServletRequest request,HttpSession session,String condition,int page2,SocialDTO socialDTO){
		ReturnJson returnJson = new ReturnJson();
		returnJson.setStatusCode(Authentication.checkUser(session));
		if (returnJson.getStatusCode().getErrNum() != 100) {
			return returnJson.returnJson();
		}

		String membersql = "";
		String experiencesql = "";
		String shuxin = "";
		Object tiaojian = null;
		//存放get到的用户参数
		List<Object> tjlist = new ArrayList<>();
		//创建一个dom读取condition.xml中的数据
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		try {
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document dt = db.parse(request.getServletContext().getRealPath("/WEB-INF/condition.xml"));
			Element element = dt.getDocumentElement();
			NodeList nodeList = element.getChildNodes();
			//获取所有的子node
			for (int i = 0; i < nodeList.getLength(); i++) {
				//得到第i个node
				Node node1 = nodeList.item(i);
				//循环到有condition标签的node 则运行下面的代码
				if ("condition".equals(node1.getNodeName())) {
					//判断这个condition标签的名字是否和前端传过来的条件一样 
					if (node1.getAttributes().getNamedItem("name").getNodeValue().equals(condition)) {
						//获得node下的所有子标签
						NodeList nodeDetail = node1.getChildNodes();
						for (int j = 0; j < nodeDetail.getLength(); j++) {
							//获得第i个子标签
							Node detail = nodeDetail.item(j);
							//如果子标签为sql1则把里面的内容放入到sql1中
							if ("sql1".equals(detail.getNodeName())) {
									membersql = detail.getTextContent();
								}else if ("sql2".equals(detail.getNodeName())) {
									experiencesql = detail.getTextContent();
								}else if ("shuxin".equals(detail.getNodeName())) {
									shuxin = detail.getTextContent();
								}
						}
					}
				}
			}
			
		} catch (Exception e) {
			// TODO: handle exception
            e.printStackTrace();  
		}
		//通过session得到member用户
			User myuser = (User) session.getAttribute("myuser");
			Member user = myuser.getMember();
			//为了防止出现身份证有人乱填 使用try catch 要是有错误 直接设置年龄为0
			try {
				String sfz = user.getUserInfo().getIdNo();
				String birthday = sfz.substring(6,10);
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy");
				String nowyear = simpleDateFormat.format(new Date());
				int age = Integer.parseInt(nowyear)-Integer.parseInt(birthday);
				user.setAge(age);
				
			} catch (Exception e) {
				// TODO: handle exception
				user.setAge(0);
			}

		try {
			String[] shuxins = shuxin.split(",");
			for (int i = 0; i < shuxins.length; i++) {
				/*
				 * 因为有些get方法是get一个对象再get这个对象的方法 如getProvince().getName
				 * 这样的话需要做一个循环先得到 Province 再反射Province使用getName方法
				 * 若指定字符串中没有该字符则系统返回-1 
				 * 
				 */
				if (shuxins[i].indexOf(".") != -1) {
					//先用object接收user  再把object反射 使用method来实现
					Object object = null;
					object = user;
					Class class1;
					String[] shuxins1 = shuxins[i].split("\\.");
					for (int j = 0; j < shuxins1.length; j++) {
						class1 = object.getClass();
						Method method = class1.getDeclaredMethod(shuxins1[j]);
						object = method.invoke(object);
					}
					tjlist.add(object);
				}
				else {
					//通过反射实现使用字符串来运行方法
					Class class1 = user.getClass();
					Method method = class1.getDeclaredMethod(shuxins[i]);
					//如果shuxin中的字符串为getSex 则为运行tiaojian = member.getSex
					tiaojian = method.invoke(user);
					//把获得条件加入到arraylist中 后面使用list调用条件
					tjlist.add(tiaojian);
				}
				//因为字符串加字符串不会添加''号 会导致sql语句出错 所以判断得到的tiaojian为字符串的时候 通过代码设置''
				if (tjlist.get(i).getClass().getName().equals("java.lang.String")) {
					StringBuffer buffer = new StringBuffer();
					buffer.append("'");
					buffer.append(tjlist.get(i));
					buffer.append("'");
					tjlist.set(i, buffer.toString()); 
				}
				//如果得到是Date类型比如graduateDate则获取时间的年份
				if (tjlist.get(i).getClass().getName().equals("java.util.Date")) {
					Date date = (Date) tjlist.get(i);
					//获取得到时间的年份
					Calendar cl = Calendar.getInstance();
					cl.setTime(date);
					int year = cl.get(Calendar.YEAR);
					//因为后面需要做字符串替换 所以需要把数字转换为字符串
					String stringyear = String.valueOf(year);
					//因为原先get出来的是date类型 需要把arraylist中的删掉 再把前面转换好的string类型的年份放入到arraylist中
					tjlist.set(i, stringyear);
					
				}
				shuxins[i]+="$";
				//因为replace是生成一个替换后的字符串 所以需要一个新的String来接收
				if (tjlist.get(i).getClass().getName().equals("java.lang.Integer")) {
					tjlist.set(i, String.valueOf(tjlist.get(i)));
				}
				
				membersql = membersql.replace(shuxins[i],(CharSequence) tjlist.get(i));
				experiencesql = experiencesql.replace(shuxins[i],(CharSequence) tjlist.get(i));

			}

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		//设置分页功能
		int newpage;
		//把前端传过来的页数放入到newpage中 newpage代表要显示第几页的数据 再把membersql和experiencesql语句放入到DTO中一起传到mapper中 放入到sql语句里
		newpage = page2;
		socialDTO.setSql1(membersql);
		socialDTO.setSql2(experiencesql);
		socialDTO.getPage().setCurrentPage(newpage);
		List<Social> socials = socialDAO.getSocialsPage(socialDTO);
		
		//当删除某页最后一天记录时，要往前一页取值
		if(socials.size()==0)
		{
			newpage=page2-1;
			if(newpage==0)
			{
				newpage=1;
			}
			//把新的当前页传入 重新获取数据
			socialDTO.getPage().setCurrentPage(newpage);
			socials = socialDAO.getSocialsPage(socialDTO);
		}
		String url=request.getContextPath()+"/Social/getSocial.action";
		//设置按钮数
		int btnCount=5;
		//获得总页数
		int pageCount=socialDTO.getPage().getTotalPage();
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		returnJson.put("navbar", str);
		returnJson.put("list", socials);		
		return returnJson.returnJson();
	}
	
	
	/*
	 * 功能:页面加载以后读取xml中的条件到前端
	 * 作者:王温迪
	 * 日期2016-8-24
	 */
	@ResponseBody
	@RequestMapping("/getCondition.action")
	public String getCondition(HttpServletRequest request,HttpSession session){
		ReturnJson returnJson = new ReturnJson();
		returnJson.setStatusCode(Authentication.checkUser(session));
		if (returnJson.getStatusCode().getErrNum() != 100) {
			return returnJson.returnJson();
		}
		ArrayList<String> conditionList = new ArrayList<String>();
		//创建一个dom读取condition.xml中的数据
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		try {
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document dt = db.parse(request.getServletContext().getRealPath("/WEB-INF/condition.xml"));
			Element element = dt.getDocumentElement();
			NodeList nodeList = element.getChildNodes();
			//获取所有的子node
			for (int i = 0; i < nodeList.getLength(); i++) {
				//得到第i个node
				Node node1 = nodeList.item(i);
				//循环到有condition标签的node 则运行下面的代码
				if ("condition".equals(node1.getNodeName())) {
					//把condition标签的name 也就是前端需要显示的数据放入到condition中 再放入到arraylist中
					String condition =node1.getAttributes().getNamedItem("name").getNodeValue();
					conditionList.add(condition);
				}
			}
			
		} catch (Exception e) {
			// TODO: handle exception
            e.printStackTrace();  
		}
		returnJson.put("conditionList", conditionList);		
		return returnJson.returnJson();
		
	}
	
	

}
