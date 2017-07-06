package controller;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.apache.log4j.Logger;
import org.apache.poi.util.SystemOutLogger;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import dao.PictureDAO;
import dao.UserDAO;
import dto.CommunicationDTO;
import dto.PictureDTO;
import entity.Admin;
import entity.Communication;
import entity.Member;
import entity.Picture;
import entity.StatusCode;
import entity.User;
import tools.Authentication;
import tools.Json;
import tools.NavigationBar;
import tools.Paging;
import tools.ReturnJson;
@Controller
@RequestMapping("/picture")
public class PictureController {
	private static Logger logger = Logger.getLogger(PictureController.class);
	@Resource
	PictureDAO pictureDAO;
	@Resource
	UserDAO userDAO;
	int pageSize=15;
	
	/*
	 * 功能：获得用户未审核的图片
	 * 修改：
	 * 修改内容：getuserpicture.action改成getUserPicture.action
	 * 作者：刘文启
	 * 日期：2016-04-23
	 */
	@ResponseBody
    @RequestMapping("/getUserPicture.action") 
	public List<Picture> getUserPicture(int uid,HttpSession session,int pageno){
		List<Picture> picture=pictureDAO.getUserPicture(uid);
		session.setAttribute("uid", uid);
		return pages(pageno, session, picture);
	}
	/*
	 * 功能：获得用户未审核的图片
	 * 说明：为了统一分页逻辑重新写了一个
	 * 作者：刘娈莎
	 * 日期：2016-05-12
	 * 
	 * 修改：把只取非封面图片改为非封面和封面都取
	 * 作者：刘娈莎
	 * 日期：2016-05-12
	 */
	@ResponseBody
    @RequestMapping("/getUserPictureByPage.action") 
	public String getUserPictureByPage(HttpServletRequest request,PictureDTO pictureDTO,int page2){
		//List<Picture> list=pictureDAO.getUserPictureByPage(pictureDTO);
		System.out.println(pictureDTO);
		int newpage;
		pictureDTO.getPage().setCurrentPage(page2);
		newpage=page2;
		List<Picture> list=pictureDAO.getUserPictureByPage(pictureDTO);
		//当删除某页最后一天记录时，要往前一页取值
		if(list.size()==0)
		{
			newpage=page2-1;
			if(newpage==0)
			{
				newpage=1;
			}
			pictureDTO.getPage().setCurrentPage(newpage);		
			list=pictureDAO.getUserPictureByPage(pictureDTO);
		}
		String url=request.getContextPath()+"/picture/getUserPictureByPage.action";
		int btnCount=5;
		int pageCount=pictureDTO.getPage().getTotalPage();
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		System.out.println(str);
		HashMap<String, Object> returnMap= new HashMap<String, Object>();
		returnMap.put("navbar", str);
		//returnMap.put("totalCount", userDTO.getPage().getTotalCount());
		returnMap.put("list", list);
		JSONObject json=new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();	
	}
	/*
	 * 功能：通过图片的Id获得用户的图片
	 * 修改：
	 * 修改内容：getone.action改成getOne.action
	 * 作者：刘文启
	 * 日期：2016-04-23
	 * 
	 */
	@ResponseBody
    @RequestMapping("/getOne.action") 
	public Picture getOne(int id){
		return pictureDAO.getOne(id);
	}
	/*
	 * 功能：通过图片的Id删除用户的图片
	 * 修改：返回值由/uploading/photo改为空
	 * 作者：刘娈莎
	 * 日期：2016-05-12
	 * 
	 */
	@ResponseBody
	@RequestMapping("/delete.action") 
	public String delete(int id){
		 pictureDAO.delete(id);
		 return null;
	 }

	/*
	 * 功能：获得需要审核的图片
	 * 修改：
	 * 修改内容：getflag.action改成getFlag.action
	 * 作者：刘文启
	 * 日期：2016-04-23
	 * 
	 */
	@ResponseBody
    @RequestMapping("/getFlag.action")  
	public  List<Picture> getFlag(int pageno,HttpSession session){	
		List<Picture> picture=pictureDAO.getFlag();
		return pages(pageno, session, picture);
	}
	/*
	 * 功能：获得需要审核的图片
	 * 说明：为了统一分页逻辑重新写了一个
	 * 作者：刘娈莎
	 * 日期：2016-05-12
	 * 
	 */
	@ResponseBody
    @RequestMapping("/getFlagByPage.action")  
	public String getFlagByPage(HttpServletRequest request,HttpSession session,PictureDTO pictureDTO,int page2){	
		//List<Picture> list=pictureDAO.getFlagByPage(pictureDTO);
		System.out.println(pictureDTO);
		int newpage;
		pictureDTO.getPage().setCurrentPage(page2);
		newpage=page2;
		List<Picture> list=pictureDAO.getFlagByPage(pictureDTO);
		//当删除某页最后一天记录时，要往前一页取值
		if(list.size()==0)
		{
			newpage=page2-1;
			if(newpage==0)
			{
				newpage=1;
			}
			pictureDTO.getPage().setCurrentPage(newpage);		
			list=pictureDAO.getFlagByPage(pictureDTO);
		}
		String url=request.getContextPath()+"/picture/getFlagByPage.action";
		int btnCount=5;
		int pageCount=pictureDTO.getPage().getTotalPage();
		String str = NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
		System.out.println(str);
		HashMap<String, Object> returnMap= new HashMap<String, Object>();
		returnMap.put("navbar", str);
		//returnMap.put("totalCount", userDTO.getPage().getTotalCount());
		returnMap.put("list", list);
		JSONObject json=new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();	
	}
	/*
	 * 功能：这是用户获得封面的信息，用于显示封面
	 * 作者：
	 * 日期：
	 * 
	 * 修改：将原本只返回photo字段改为返回整个picture对象
	 * 作者：刘娈莎
	 * 日期：2016-09-09
	 */
	@ResponseBody
	  @RequestMapping("/getCover.action")  
	    public Picture getCover(HttpServletRequest request,HttpServletResponse response, HttpSession session,int id) throws IOException {  
	        Picture picture=new Picture();
	        picture.setUid(id);
	        picture=pictureDAO.getCover(picture);	        
	        return picture; 
	  }
	  

	//=============================分割线=================================
		/*
		 * 作者:农大辉
		 * 作用:添加图片(先把图片存到服务器上，然后再读服务器上，读成二进制文件存入数据库）
		 * 日期：
		 * 
		 * 修改：把图片存入服务器的代码注释掉，只保留数据库中的二进制数据
		 * 作者：刘娈莎
		 * 日期：2016-03-25
		 * 
		 * 修改：封面图片只可以存一张，新提交会把之前的删掉
		 * 作者：刘娈莎
		 * 日期：2016-09-06
		 */
	 @RequestMapping("/add.action")
		public String addPicture(String title,HttpServletRequest request,HttpSession session,int cover) throws IOException{

			     CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext()); //获取前台提交图片  
		         session = request.getSession(true);  
		         User user=(User) session.getAttribute("myuser");//从session中取出当前登录用户
		         //String path = "";// 文件路径  
		         Picture picture=new Picture();
		         String fileName="";
		         

		         if (multipartResolver.isMultipart(request)) // 判断 request  
		                                                    // 是否有文件上传,即多部分请求...  
		         {  
		            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) (request);  
		            Iterator<String> iter = multiRequest.getFileNames(); 
		            
		            while (iter.hasNext()) {  
		                MultipartFile file = multiRequest.getFile(iter.next());  
		                fileName = "upload" +""+ file.getOriginalFilename();// 获取文件名称  	                
		                byte data[]=file.getBytes();
		                picture.setPhoto(data);
		                //String path1 = request.getSession().getServletContext().getRealPath("/");// 获取服务器的路径  
		                //path = path1 + "" + fileName;// 拼接文件路径  
		                //File localFile = new File(path);  
		                //file.transferTo(localFile);// 图片上传至 服务器  	        	     
		            } 
		        //FileInputStream is = new FileInputStream(path);  
		        //FileInputStream is = new FileInputStream(newFile);
//		        int i = is.available(); // 得到文件大小  
//	            byte data[] = new byte[i];  
//	            is.read(data); //读数据  
//	            is.close(); 
	           

	            picture.setUser(user);
	            picture.setUrl(fileName);
	            
	            boolean usercover=false;
	            if(cover==1)
	            	//先删除之前的封面
	            {	pictureDAO.deleteUserCover(user.getId());
	            	usercover=true;
	            	picture.setCover(usercover);
	            	title="封面";
	            }else
	            {
	            	picture.setCover(usercover);
	            }
	            picture.setTitle(title);
	            picture.setTime(new Date());
	            session.setAttribute("myuser", user); 
	        	pictureDAO.addPicture(picture);
	    	    int conut=(int) session.getAttribute("conut");
	            conut=pictureDAO.count(user.getId());
	            int uid=user.getId();
	            int allcount=pictureDAO.allcount(uid);	
				session.setAttribute("allconut",allcount);
	            session.setAttribute("conut", conut);
	        	//File file =new File(path);  //图片在服务器上的地址
	        	//session.setAttribute("file",file);
	 //         file.delete();//删除上传至服务器的文件  
	            session.setAttribute("picture", picture);	 	  
		}   
		        return "/member/infoshow"; 
	}
	 
    /*
     * 功能：这是修改用户图片的信息
     * 修改：
     * 修改内容：modify.action改成modifyPicture.action
     * 作者：刘文启
	 * 日期：2016-04-23
	 * 
	 */
	@RequestMapping("/modifyPicture.action")
	public String modifyPicture(@RequestParam(value="title") String title, int id,HttpServletRequest request,HttpSession session){ 
		    User user=(User) session.getAttribute("myuser");//从session中取出当前登录用户
		    Picture picture=pictureDAO.getOne(id);
            picture.setId(id);
            picture.setUid(user.getId());     
            picture.setTitle(title);
            picture.setTime(new Date());     
            pictureDAO.modifyPicture(picture);
            session.setAttribute("picture", picture);
            int conut=(int) session.getAttribute("conut");
            conut=pictureDAO.count(user.getId());
            session.setAttribute("conut", conut);
	        return "/uploading/allphoto";
	}
    /*
     * 功能：管理员点击审核了以后，设置用户的flag为true
     * 
     * 修改：把返回值由/uploading/isflag改为空
     * 作者：刘娈莎
	 * 日期：2016-05-12
	 * 
	 * 修改：添加删除之前已审核照片的功能
     * 作者：刘娈莎
	 * 日期：2016-12-06
	 * 
	 */
	@ResponseBody
	@RequestMapping("/flag.action")
	public String flag(int id,HttpServletRequest request,HttpSession session) throws IOException{		
            Picture picture=pictureDAO.getOne(id);//获得当前审核的用户，然后设置用户的flag
            pictureDAO.deleteCheckedUserCover(picture.getUid());
            picture.setId(id);
            picture.setFlag(true);
            pictureDAO.flag(picture);
	        return null;
	}
	@RequestMapping("/key.action")
	public String key(int id,int share,HttpServletRequest request,HttpSession session) throws IOException{
            Picture picture=pictureDAO.getOne(id);//获得当前分享的用户，然后设置用户的key
            picture.setId(id);
            if(share==1)
            {		
            	picture.setShare(true);
            }
            if(share==0)
            {	
            	picture.setShare(false);
            }     
            pictureDAO.modifykey(picture);
            return "/uploading/photo";
	}
	 /** 
     * 读取数据库文件并且显示 
     * @param request 
     * @param response 
     * @param session 
     * @return 
	 * @throws IOException 
	 * 修改：
	 * 修改内容：imageshow.action改成userImage.action
	 * 作者：刘文启
	 * 日期：2016-04-23
	 * 
     */ 
	@ResponseBody
    @RequestMapping("/userImage.action")  
    public String userImage(HttpServletRequest request,HttpServletResponse response, HttpSession session,int id) throws IOException {  
        session = request.getSession(true);    
        response.setContentType("image/*"); // 设置返回的文件类型  
        OutputStream toClient=null;
        Picture picture=new Picture();
        picture.setId(id);
        toClient = response.getOutputStream(); 
        picture=(Picture) pictureDAO.getOne(picture.getId());
        if(picture.getPhoto()!=null){  
            toClient.write(picture.getPhoto());  
            toClient.close();  
        }  
        return null;  
    }  
	//通过用户的Id获得用户的所有的图片
	/*
	 * 修改：
	 * 修改内容：get.action改成allphoto.action
	 * 作者：刘文启
	 * 日期：2016-04-23
	 * 
	 */
	@ResponseBody
    @RequestMapping("/allphoto.action")  
	public List<Picture> allphoto(int uid,int pageno,HttpSession session){
		List<Picture> picture=pictureDAO.getPicture(uid);
		return pages(pageno, session, picture);
	}
	//这是分页的代码
	private List<Picture> pages(int pageno, HttpSession session, List<Picture> picture) {
		int pageCount=Paging.pageCount(picture.size(), pageSize);
		//这是传入的页码的
		int datasize=picture.size();
		if(pageno>pageCount)
		{
			pageno=pageCount;	
		}
		if(pageno<=0)
		{
			pageno=1;
		}
		session.setAttribute("pagecount", pageCount);
		Paging<Picture> paging = new Paging<>();
		return paging.paging(picture, pageSize, pageno);
	}
	 //用户显示图片的预览
	 @RequestMapping("/getpic.action")
	 public String  getpic(int id,HttpServletRequest request,HttpServletResponse response) throws IOException{
		Picture picture=pictureDAO.getOne(id);
		String url=picture.getUrl();
		String path=request.getContextPath();
		path=path+url;
		String json=Json.getjson(path);
		PrintWriter out;
		out=response.getWriter();
		out.println(json);
		return null;	 
	 }
		/*
		 * 功能：获取所有已审核用户的封面头像
		 * 作者：刘娈莎
		 * 日期：2016-09-06
		 * 
		 * 修改：不取图片的二进制文件，图片文件单独取
		 * 作者：刘娈莎
		 * 日期：2016-09-08
		 */
		@ResponseBody
	    @RequestMapping("/getAllUserCoverByPage.action")  
		public String getAllUserCoverByPage(HttpSession session,HttpServletRequest request,PictureDTO pictureDTO,int page2){
			int newpage;
			pictureDTO.getPage().setCurrentPage(page2);
			newpage=page2;		
			List<User> list=pictureDAO.getAllUserCoverByPage(pictureDTO);		
			//当删除某页最后一天记录时，要往前一页取值
			if(list.size()==0)
			{
				newpage=page2-1;
				if(newpage==0)
				{
					newpage=1;
				}
				pictureDTO.getPage().setCurrentPage(newpage);
				list=pictureDAO.getAllUserCoverByPage(pictureDTO);
			}	
//			//将二进制文件转化为base64字符串
//			for(int i=0;i<list.size();i++){
//				if(list.get(i).getPicture()!=null){
//					String json = new String(Base64.encodeBase64(list.get(i).getPicture().getPhoto()));
//					//System.out.println(json);
//					list.get(i).getPicture().setPhotoString(json);
//				}
//			}
			String url=request.getContextPath()+"/picture/getAllUserCoverByPage.action";
			int btnCount=5;
			int pageCount=pictureDTO.getPage().getTotalPage();
			String str=NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
			HashMap<String, Object> returnMap=new HashMap<String, Object>();
			returnMap.put("navbar", str);
			returnMap.put("list", list);
			returnMap.put("totalCount", pictureDTO.getPage().getTotalCount());
			JSONObject json=new JSONObject();
			json.put("returnMap", returnMap);
			return json.toString();
		}
		/*
		 * 功能：获取所有已审核的在当前学校的用户的封面头像
		 * 作者：刘娈莎
		 * 日期：2016-12-01
		 */
		@ResponseBody
	    @RequestMapping("/getAllUserCoverInThisSchoolByPage.action")  
		public String getAllUserCoverInThisSchoolByPage(HttpSession session,HttpServletRequest request,PictureDTO pictureDTO,int page2){
			int newpage;
			pictureDTO.getPage().setCurrentPage(page2);
			newpage=page2;		
			List<User> list=pictureDAO.getAllUserCoverInThisSchoolByPage(pictureDTO);		
			//当删除某页最后一天记录时，要往前一页取值
			if(list.size()==0)
			{
				newpage=page2-1;
				if(newpage==0)
				{
					newpage=1;
				}
				pictureDTO.getPage().setCurrentPage(newpage);
				list=pictureDAO.getAllUserCoverInThisSchoolByPage(pictureDTO);
			}	
//			//将二进制文件转化为base64字符串
//			for(int i=0;i<list.size();i++){
//				if(list.get(i).getPicture()!=null){
//					String json = new String(Base64.encodeBase64(list.get(i).getPicture().getPhoto()));
//					//System.out.println(json);
//					list.get(i).getPicture().setPhotoString(json);
//				}
//			}
			String url=request.getContextPath()+"/picture/getAllUserCoverInThisSchoolByPage.action";
			int btnCount=5;
			int pageCount=pictureDTO.getPage().getTotalPage();
			String str=NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
			HashMap<String, Object> returnMap=new HashMap<String, Object>();
			returnMap.put("navbar", str);
			returnMap.put("list", list);
			returnMap.put("totalCount", pictureDTO.getPage().getTotalCount());
			JSONObject json=new JSONObject();
			json.put("returnMap", returnMap);
			return json.toString();
		}
		/*
		 * 功能：通过id获取某张图片
		 * 作者：刘娈莎
		 * 日期：2016-09-06
		 * 
		 * 修改:改变传图片的方式
		 * 作者:张晓敏
		 * 日期:2016-10-09
		 */
		@RequestMapping("/getPictureByid.action")
		public void  getPictureByid(int id,HttpServletRequest request,HttpServletResponse response) throws IOException{
			byte[] photo = pictureDAO.getOne(id).getPhoto();
			response.setContentType("image/jpeg");  
		    response.setCharacterEncoding("utf-8");
			OutputStream outputStream=response.getOutputStream();  
            outputStream.write(photo);    
            outputStream.close();
		}
		/*
		 * 功能：判断是否有未审核的照片
		 * 作者：张晨旭
		 * 日期：2016-12-16
		 */
		@ResponseBody
		@RequestMapping(value = "/isFlag.action", method = RequestMethod.POST)
		public String isFlag(HttpSession session) {
			ReturnJson returnJson = new ReturnJson();
			returnJson.setStatusCode(Authentication.checkUser(session));
			if (returnJson.getStatusCode().getErrNum() != 100) {
				return returnJson.returnJson();
			}
			User user = (User) session.getAttribute("myuser");
			if(!pictureDAO.getUserFlagPicture(user.getId())){
				returnJson.put("flag", 1);
			}
			return returnJson.returnJson();
		}


		/*
		 * 功能：添加封面图片
		 * 作者：刘娈莎
		 * 日期：2016-09-08
		 * 
		 * 修改：上传照片，在有未审核照片的时候删除旧的未审核照片
		 * 作者：张晨旭
		 * 日期：2016-12-16
		 */
		@ResponseBody
		 @RequestMapping("/addCover.action")
		 public String  addCover(HttpServletRequest request,HttpServletResponse response,HttpSession session,Picture picture) throws IOException{
		    //防止非法操作
			User user = (User) session.getAttribute("myuser");
			ReturnJson returnJson = new ReturnJson();
			returnJson.setStatusCode(Authentication.checkUser(session));
			if (returnJson.getStatusCode().getErrNum() != 100) {
				return returnJson.returnJson();
			}
		    
		    if(!pictureDAO.getUserFlagPicture(user.getId())){
				//判断有未审核的照片，是否删除之前的照片
	            pictureDAO.deleteUserFlagCover(user.getId());
		    }
            picture.setUser(user);
			picture.setTitle("封面");
			picture.setCover(true);
			picture.setTime(new Date());
			String str=picture.getPhotoString();
			String[] strs=str.split("base64,");
			String base64String=strs[1];
			//System.out.println(base64String);
			byte[] data=Base64.decodeBase64(base64String);
			picture.setPhoto(data);
	        pictureDAO.addPicture(picture);
			return returnJson.returnJson(); 
		 }
		@ResponseBody
		@RequestMapping("/addAdminCover")
		public String addAdminCover(Picture picture,HttpSession session){
			int uid = ((Admin)session.getAttribute("admin")).getId();
			picture.setTime(new Date());
			picture.setUid(uid);
			String str=picture.getPhotoString();
			String[] strs=str.split("base64,");
			String base64String=strs[1];
			byte[] data=Base64.decodeBase64(base64String);
			picture.setPhoto(data);
			if(pictureDAO.getPicture(uid).size()==0){
				picture.setCover(false);
				picture.setTitle("管理员相片");
				pictureDAO.addAdminCover(picture);				
			} else {
				pictureDAO.modifyAdminCover(picture);
			}
			return null;
		}
		@ResponseBody
		@RequestMapping("/getAdminCover")
		public Picture getAdminCover(HttpSession session)
		{
			int uid = ((Admin)session.getAttribute("admin")).getId();
			List<Picture> list = pictureDAO.getPicture(uid);
			if(list != null && list.size() > 0) {
				return list.get(0);
			}
			return null;
		}
		/*
		 * 功能：获得所有未审核的照片
		 * 作者：张晨旭
		 * 日期：2016-12-16
		 * 
		 */
		@ResponseBody
	    @RequestMapping("/getAllFlagUserCoverByPage.action")  
		public String getAllFlagUserCoverByPage(HttpSession session,HttpServletRequest request,PictureDTO pictureDTO,int page2){
			int newpage;
			pictureDTO.getPage().setCurrentPage(page2);
			newpage=page2;		
			List<Picture> list=pictureDAO.getFlagByPage(pictureDTO);	
			//当删除某页最后一天记录时，要往前一页取值
			if(list.size()==0)
			{
				newpage=page2-1;
				if(newpage==0)
				{
					newpage=1;
				}
				pictureDTO.getPage().setCurrentPage(newpage);
				list=pictureDAO.getFlagByPage(pictureDTO);
			}	
			String url=request.getContextPath()+"/picture/getAllFlagUserCoverByPage.action";
			int btnCount=5;
			int pageCount=pictureDTO.getPage().getTotalPage();
			String str=NavigationBar.classNavBar(url, btnCount, newpage, pageCount);
			HashMap<String, Object> returnMap=new HashMap<String, Object>();
			returnMap.put("navbar", str);
			returnMap.put("list", list);
			returnMap.put("totalCount", pictureDTO.getPage().getTotalCount());
			JSONObject json=new JSONObject();
			json.put("returnMap", returnMap);
			return json.toString();
		}
}

