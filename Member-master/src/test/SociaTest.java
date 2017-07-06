package test;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import dto.SocialDTO;
import entity.Member;
import entity.Province;
import entity.Social;
import mapper.SocialMapper;
@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration({"file:WebContent/WEB-INF/applicationContext.xml" }) 
public class SociaTest extends AbstractTransactionalJUnit4SpringContextTests{
	@Resource
	SocialMapper socialMapper;

	@Test
	public void dao(){
		SocialDTO socialDTO = new SocialDTO();
		socialDTO.getPage().setPageSize(5);
		socialDTO.getPage().setCurrentPage(1);
		String sql1="LEFT JOIN province p on m.provid=p.id where m.sex='男' ";
		String sql2="LEFT JOIN province p on e.province=p.id where e.sex='男' ";
		


		List<Social> socials = socialMapper.getSocialsByPage(socialDTO);
		for (Social social : socials) {
			System.out.println(social);
		}
		System.out.println("a");
	}
	
	
	@Test
	public void controller(){
		Member member = new Member();
		String membersql = null;
		String experiencesql = null;
		String shuxin = null;
		Object tiaojian = null;
		ArrayList<Object> list = new ArrayList<>();
		String condition="查询和我性别相同的学员";
		//创建一个dom读取condition.xml中的数据
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		try {
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document dt = db.parse("file:WebContent\\WEB-INF\\condition.xml");
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
			//获得member的类 再对类进行反射 通过string字符串运行member的方法
			member.setSex("男");
			Class class1 = member.getClass();
			Method method = class1.getDeclaredMethod(shuxin);
			//如果shuxin中的字符串为getSex 则为运行tiaojian = member.getSex
			tiaojian = method.invoke(member);
			list.add(tiaojian);
			StringBuffer sql1 = new StringBuffer(membersql);
			StringBuffer sql2 = new StringBuffer(experiencesql);
			sql1.append(list.get(0));
			sql2.append(list.get(0));
			System.out.println(sql1);
			System.out.println(sql2);
			
		} catch (Exception e) {
			// TODO: handle exception
            e.printStackTrace();  
		}

	}
	
	@Test
	public void shengfen(){
		Member member = new Member();
		member.getProvince().setName("zhang");
		Object object = member;
		Class class1 = object.getClass();
		String a = "";
		try {
			Method method = class1.getDeclaredMethod("getProvince");
			object = method.invoke(object);
			Class class2 = object.getClass();
			Method method2 = class2.getDeclaredMethod("getName");
			object = (String) method2.invoke(object);
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("shibai");
		}
		System.out.println(object);


		
		
	}

}
