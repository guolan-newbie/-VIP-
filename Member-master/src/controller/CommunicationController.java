package controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import dao.CommunicationDAO;
import dto.CommunicationDTO;
import entity.Communication;
import entity.Visitor;
import tools.NavigationBar;


@Controller
@RequestMapping("/communication")
public class CommunicationController {
	private static Logger logger = Logger.getLogger(CommunicationController.class);
	@Resource
	CommunicationDAO communicationDAO;

	/*
	 * 功能:获取全部沟通信息
	 * 作者:刘娈莎
	 * 日期2016-6-6
	 */	
	@ResponseBody
	@RequestMapping("/getCommunicationInfoByPage.action")
	public String getCommunicationInfoByPage(HttpServletRequest request,HttpSession session,CommunicationDTO communicationDTO,int page2){
		int newpage;
		communicationDTO.getPage().setCurrentPage(page2);
		newpage=page2;		
		List<Communication> list=communicationDAO.getCommunicationInfoByPage(communicationDTO);		
		//当删除某页最后一天记录时，要往前一页取值
		if(list.size()==0)
		{
			newpage=page2-1;
			if(newpage==0)
			{
				newpage=1;
			}
			communicationDTO.getPage().setCurrentPage(newpage);
			list=communicationDAO.getCommunicationInfoByPage(communicationDTO);
		}		
		//设置时间格式
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for(int i=0;i<list.size();i++)
		{
			Communication communication=list.get(i);
			communication.setFormatTime(df.format(communication.getTime()));
		}
		
		String url=request.getContextPath()+"/communication/getCommunicationInfoByPage.action";
		int btnCount=5;
		int pageCount=communicationDTO.getPage().getTotalPage();
		String str=NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		HashMap<String, Object> returnMap=new HashMap<String, Object>();
		returnMap.put("navbar", str);
		returnMap.put("list", list);
		JSONObject json=new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();
	}	
	
	/*
	 * 功能:根据memberID获取沟通信息
	 * 作者:巨李岗
	 * 日期2016-10-18
	 */	
	@ResponseBody
	@RequestMapping("/getCommunicationByMid.action")
	public List<Communication> getCommunicationByMid(int mid)
	{
		System.out.println(communicationDAO.getCommunicationByMid(mid));
		return communicationDAO.getCommunicationByMid(mid);	
		
	}
	
	/*
	 * 功能:根据experienceID获取沟通信息
	 * 作者:巨李岗
	 * 日期2016-10-18
	 */	
	
	@ResponseBody
	@RequestMapping("/getCommunicationByEid.action")
	public List<Communication> getCommunicationByEid(int eid)
	{
		return communicationDAO.getCommunicationByEid(eid);	
	}
	@RequestMapping("/getCommunicationByCid.action")
	public List<Communication> getCommunicationByCid(int cid)
	{
		return communicationDAO.getCommunicationByCid(cid);	
	}
}
