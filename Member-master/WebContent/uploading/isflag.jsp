<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户审核</title>
<script type="text/javascript">
$(function(){
	$.ajaxSetup({
		  async: false
	});
	var id=${param.id}
	$("#btn").click(function(){
		$.post("${pageContext.request.contextPath}/picture/flag.action",{id:id},function(data){
			layer.msg('审核成功', {
			    icon: 1,
			    time: 1000
			}, function(){
 				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index);
			});
		})
	})
	$("#delete").click(function(){
		var id=${param.id}
		layer.confirm('您确定要删除这张图片吗？',{btn:['是','否']},//按钮一的回调函数
				function(){
					$.post("${pageContext.request.contextPath}/picture/delete.action",{id:id},function(data){
					layer.closeAll('dialog');
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index);
					});
		});
	})
 })
</script>
</head>
<body>
<table class="table table-bordered"><tr><td>       
    <input type="button" value="通过审核" id="btn" name="pictureid">  
    <input type="button" value="删除图片" id="delete">
</td>
<td>
<div id="imgdiv">
图片预览<br />
<img src="${pageContext.request.contextPath}/picture/userImage.action?id=${param.id}" alt="用户图片" width="160" height="200" id="pic">
</div>
</td>
</tr>
</table>
</body>
</html>