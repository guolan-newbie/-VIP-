<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.all.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<style type="text/css">
	.title,.op{margin-left:20px;}
	.content{margin-left:10px;}
</style>
<script>
$(function(){
	var ue = UE.getEditor('editor');
	$("#sub").click(function(){
		var contents=UE.getEditor('editor').getContent();
		if(contents == "" ){
			alert("公告内容不能为空");
			return false;
		}
		if($("[name='title']").val().length==0)
			{
				$("[name='title']").focus;
				alert("请输入公告主题");
				return false;
			}
		if($("[name='type']").val().length==0)
		{
			$("[name='type']").focus;
			alert("请输入公告类型");
			return false;
		}
		$.ajaxSetup({async:false});
			var titles=$.trim($("[name='title']").val());
			var types=$.trim($("[name='type']").val());
			var duetimes=$.trim($("[name='duetime']").val());
			if(duetimes=="")
				{
					var data=new Data();
					data.setDate(data.getData()+7);	
				}
			alert(1);
			$.post("${pageContext.request.contextPath}/notice/add.action",{content:contents,title:titles,type:types,duetime:duetimes},function(){
			layer.msg('保存成功', {
			    icon: 1,
			    time: 1000
			}, function(){
 				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index);
			});
		});
	});
	return true;
});  	
</script>
</head>
<body>
<br/>
<span class="content">增加公告信息</span>
<hr style="border:1px dashed #ccc;" color="#DDDDDD" class="add">
<form method="post">
<table class="title">
	<tr><td>公告主题</td><td><input type="text" name="title"></td></tr>
	<tr><td>公告类型</td><td><input type="text" name="type"></td></tr>
	<tr><td>失效时间</td><td><input type="text" name="duetime"></td></tr>
</table>

<br>
	<span class="content">公告内容</span>
		
		<div class="content">
		    <script id="editor" type="text/plain" style="height: 300px;">
		    </script>
		</div>
		<input class="op" type="submit" id="sub" value="保存" width="10px" height="10px"/>
		</form>
</body>
</html>