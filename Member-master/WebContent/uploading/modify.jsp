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
	$(function(){
		$("#btn").click(function(){
			 var title=$.trim($("[name='title']").val());
			
			 if(title=="")
			 {
				$("#info").html("图片title不能为空 ");
				return false;
			 }
			 var formData = new FormData($( "#form" )[0]);
			 $.ajax({  
		          url: '${pageContext.request.contextPath}/picture/modify.action',  
		          type: 'POST',  
		          data: formData,  
		          async: false,  
		          cache: false,  
		          contentType: false,  
		          processData: false,  
		          success: function (returndata) {  
		          }
		     });  	
				var index = parent.layer.getFrameIndex(window.name);
				parent.layer.close(index);
		})
		$("input[type=radio][name=cover][value=1]").attr("checked",'checked')
})
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>图片修改</title>
</head>
<body>
<div id="i">
<div id="imgdiv">
图片预览<br />
<img src="${pageContext.request.contextPath}/picture/imageshow.action?id=${param.id}" alt="用户上传图片" width="160" height="200" id="pic">
</div>
<div id=f>
<form  enctype="multipart/form-data" action=""  method="post" id="form">               
      照片名称： <input type="text" id="title" name="title" class="input-xlarge" placeholder="请输入修改内容" value=""/>  
            <input type="hidden" value="${param.id}" name="id"> 
</form>
 <input type="submit" value="提交" id="btn"> 
</div>
</div>
<div id="info"></div>
</body>
</html>