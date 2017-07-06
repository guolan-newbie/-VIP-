<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<style type="text/css">
	.title,.op{margin-left:20px;}
	.content{margin-left:10px;}
</style>
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.all.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/lang/zh-cn/zh-cn.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
	
<script type="text/javascript" src="${pageContext.request.contextPath}/tableTemplet/lib/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>
<script type="text/javascript">
$(function(){
	var ue = UE.getEditor('editor');
	var id=$("#id").val();
	if (id != ""){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/notice/get.action?id="+id,function(data){
			$("[name='title']").val(data.title);
			ue.ready(function(){
						ue.setContent(data.content);
					});		
		},"json");
	}
	
	$("#btn").click(function(){
		var contents=UE.getEditor('editor').getContent();
		if(contents == "" ){
			alert("公告内容不能为空");
			return false;
		}
		var title=$.trim($("[name='title']").val());
		
		if (id != ""){
			$.ajaxSetup({async:false});
			$.post("${pageContext.request.contextPath}/notice/add.action?id="+id,{content:contents,title:title},function(){
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index);
			});
		}
		else{
			$.ajaxSetup({async:false});
			$.post("${pageContext.request.contextPath}/notice/add.action",{content:contents,title:title},function(){
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index);
			});
		}
	});

});
</script>
</head>
<body>
<br/>
<input type="hidden" value="${param.id}" id="id">
<table class="title">
	<tr><td>公告主题</td><td><input type="text" name="title"></td></tr>
</table>
<br>
	<span class="content">公告内容</span>
		
		<div class="content">
		    <script id="editor" type="text/plain" style="height: 260px;">
		    </script>
		</div><br>
	    <input class="op" type="button" id="btn" value="保存" width="10px" height="10px"/>
</body>
</html>