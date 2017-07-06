<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>
<script type="text/javascript" src="../uploadPreview/uploadPreview.min.js"></script>
<style type="text/css">
#imgdiv{padding-left:100px;margin:10}
#f{padding-top:50px;}
#i{margin:20px;}
</style>
<script type="text/javascript">
//解决在ie等的浏览器上预览失败的模块
	 window.onload = function () { 
            new uploadPreview({ UpBtn: "studentPhoto", DivShow: "imgdiv", ImgShow: "pic"});
     }

	 $.ajaxSetup({async:false});
	  var maxsize = 2*1024*1024;
	  var errMsg = "上传的图片不能超过4M！！！";
	  var tipMsg = "您的浏览器暂可能不支持计算上传文件的大小，确保上传文件不要超过4M，建议使用IE、FireFox、Chrome浏览器。";
	  var  browserCfg = {};
	  var ua = window.navigator.userAgent;
	  if (ua.indexOf("MSIE")>=1){
	  	 browserCfg.ie = true;
	  }
	  else if(ua.indexOf("Firefox")>=1){
	  	 browserCfg.firefox = true;
	  }
	  else if(ua.indexOf("Chrome")>=1){
	  	 browserCfg.chrome = true;
	  }
	 function checkfile() {
		 var obj_file = document.getElementById("studentPhoto");
		 var filesize = 0;
		 if(browserCfg.firefox || browserCfg.chrome ){
		      filesize = obj_file.files[0].size;
		 }
		 else{
		       document.getElementById("info").innerHTML=tipMsg;
		       return false;
		 }
		 if(filesize==-1){
		       document.getElementById("info").innerHTML=tipMsg;
		       return false;
		 }
		 else if(filesize>maxsize){
			  document.getElementById("info").innerHTML=errMsg;
		      return false;
		    }
	 else{
		 document.getElementById("info").innerHTML="图片大小合格";
	      return;
	    }
	 }
	 function check() {
		 document.getElementById("info").innerHTML="";
		 return;
	 }
	$(function(){	
		$("#button").click(function(){
			    var file =$("#studentPhoto").val();
			     if(file==""){				   
			      $("#info").html("请先选择上传文件");
			      return false;
			     }  						  						
			 var title=$.trim($("[name='title']").val());
			 if(title=="")
			 {
				$("#info").html("图片title不能为空 ");
				return false;
			 }
			 var formData = new FormData($("#form" )[0]);
			 $.ajax({  
		          url: '${pageContext.request.contextPath}/picture/add.action',  
		          type: 'POST',  
		          data: formData,  
		          async: false,  
		          cache: false,  
		          contentType: false,  
		          processData: false,  
		          success: function (returndata) {    
						var index = parent.layer.getFrameIndex(window.name);
						parent.layer.close(index);
		          }
		     });  	
			
		})
})
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>图片上传</title>
</head>
<body>
<div id=i>
<div id="imgdiv">
图片预览<br />
<img src="${pageContext.request.contextPath}/images/4.jpg" alt="用户上传图片" width="160" height="200" id="pic">
</div>
<div id="f">
<form  enctype="multipart/form-data" action="" method="post" id="form">                           
          照片名称： <input type="text" id="title" name="title" onclick="checkfile()" class="input-xlarge"  placeholder="必填项"/>
              <input type="file" id="studentPhoto" name="studentPhoto" onclick="check()" />        
     <input type="hidden" value="0" name="cover">
</form> 
   <input type="submit" value="提交" id="button">  
</div>
</div>

<div id="info"></div>
</body>
</html>