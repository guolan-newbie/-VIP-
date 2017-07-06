<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改图片</title>
<style type="text/css">
		#visits{margin-left:50px;margin-top:20px;width:750px;text-align:center;}
		h3,nav{margin-left:50px}
		nav{font-size:16px;}
		#footer{margin-left:50px;}
</style>
<script type="text/javascript">
$(function(){
	$.ajaxSetup({
		  async: false
	});
	var uid=${myuser.id};
	$.post("${pageContext.request.contextPath}/picture/get.action",{uid:uid,pageno:$("#page").val()},function(data){	
		$("#visits").append("<tr><td>序号</td><td>图片名称</td><td>图片预览</td><td>审核状态</td><td>修改</td><td>删除</td><td>图片分享</td></tr>");
		for(i=0;i<data.length;i++)
		{
			var id=(data[i].id);
			var title=(data[i].title);
			if((data[i].flag)==true)
			{
				f="已审核 (不得改动)";
			}
			if((data[i].flag)==false)
				{
					f="未审核";
				}
			var line="";
			line=line+"<tr>";
			line=line + "<td>" + (i+1) + "</td>";
			line=line + "<td>" + title + "</td>";	
			line=line + "<td><a href='javascript:void(0)' class='preview' lang="+id +">预览</a></td>";
			line=line + "<td>" + f + "</td>";
			//要是用户被审核，则用户不得修改
			if (data[i].flag){
				line=line + "<td><a href='javascript:void(0)' disabled='true' lang="+id +">修改</a></td>";
				line=line + "<td><a href='javascript:void(0)' disabled='true' lang="+id +">删除</a></td>";
			}
			else{			
				line=line + "<td><a href='javascript:void(0)' class='show' lang="+id +">修改</a></td>";
				line=line + "<td><a href='javascript:void(0)' class='delete' lang="+id +">删除</a></td>";
			}
			if (data[i].share){
				line=line + "<td><a href='javascript:void(0)' class='noshare' lang="+id +">取消分享</a></td>";
			}
			else{
				line=line + "<td><a href='javascript:void(0)' class='share' lang="+id +">分享</a></td>";
			}
			line=line+"</tr>";
			$("#visits").append(line);
		}
 },"json");
	$(".show").click(function(){
				  
	});
	$(".share").click(function(){
		var id = this.lang;
		layer.confirm('您确定要分享图片吗?',{btn:['是','否']},//按钮一的回调函数
				function(){
					$.post("${pageContext.request.contextPath}/picture/key.action?share=1&id="+id,function(data){
					location.href="${pageContext.request.contextPath}/uploading/allphoto.jsp";
				});
		});
	});	
	$(".noshare").click(function(){
		var id = this.lang;
		layer.confirm('您确定要取消分享图片吗?',{btn:['是','否']},//按钮一的回调函数
				function(){
					$.post("${pageContext.request.contextPath}/picture/key.action?share=0&id="+id,function(data){
					location.href="${pageContext.request.contextPath}/uploading/allphoto.jsp";
				});
		});
	});	
	$(".delete").click(function(){
		var id = this.lang;
		layer.confirm('您确定要删除吗?',{btn:['是','否']},//按钮一的回调函数
				function(){
					$.post("${pageContext.request.contextPath}/picture/delete.action?id="+id,function(data){
					location.href="${pageContext.request.contextPath}/uploading/allphoto.jsp";
				});
		});
	});	
	$(".preview").click(function(){
		var id = this.lang;
		layer.config({
		    extend: 'extend/layer.ext.js'
		}); 
		$.getJSON('${pageContext.request.contextPath}/picture/getpic.action?id='+id, function(json){
			layer.ready(function(){
			    layer.photos({
			        photos: json
			    });
			})
		}); 
	});	
});
</script>
</head>
<body>
<h3>用户图片信息</h3>
<div>
<table class="table table-bordered" id="visits"></table>
</div>
<div>
<c:choose>
	<c:when test="${param.pageno==''}">
		<input type="hidden" id="page" value="1"> 
	</c:when>
	<c:when test="${param.pageno==null}">
		<input type="hidden" id="page" value="1"> 
	</c:when>
	<c:when test="${param.pageno!=null}">
		<input type="hidden" id="page" value="${param.pageno+1}"> 
	</c:when>
</c:choose>
</div>
<div id="footer">
<a href="${pageContext.request.contextPath}/uploading/allphoto.jsp?pageno=1">首 页</a>&nbsp;|&nbsp;	
<a href="${pageContext.request.contextPath}/uploading/allphoto.jsp?pageno=${param.pageno-1}">上一页</a>&nbsp;|&nbsp;
<a href="${pageContext.request.contextPath}/uploading/allphoto.jsp?pageno=${param.pageno+1}">下一页</a>&nbsp;|&nbsp;
<a id="pagecount" href="${pageContext.request.contextPath}/uploading/allphoto.jsp?pageno=${pagecount}">尾页</a>&nbsp;|&nbsp;
<c:choose>
	<c:when test="${param.pageno==null}">
		当前第1页
	</c:when>
	<c:when test="${param.pageno!=null}">
		<strong>当前第${param.pageno+1}页/总共<span id="pageCount">${pagecount}</span>页</strong>
	</c:when>
</c:choose>	
&nbsp;|&nbsp;
<a href="${pageContext.request.contextPath}/member/infoshow.jsp">用户信息</a>&nbsp;|&nbsp;
</div>
</body>
</html>