<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>编写周报-专注建立IT精英圈子</title>
		<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript">

$(function(){
    		var ue = UE.getEditor('editor',{
    			enableAutoSave: false
    		});
    		ue.ready(function(){
					ue.setContent(data.content);
			});
    		$("#btn").click(function(){
    			var contents=UE.getEditor('editor').getContent();
    			if(contents == "" ){
    				alert("周报内容不能为空");
    				return false;
    			}
    			$.ajaxSetup({async:false});
     			$.post("${pageContext.request.contextPath}/summary/addSummary.action",{"content":contents},function(data){
     				if(data=="1"){
	     					layer.msg('保存成功', {
	    					    icon: 1,
	    					    time: 1000
	    					});
	     					taggleWriteAndModify();
     				}else if(data=="2"){
	     					layer.msg('别点啦~~ 已经提交过了', {
	    					    icon: 1,
	    					    time: 1000
	     					});
	     					taggleWriteAndModify();
     				}
       				else{
       					layer.open({
    					  type: 2,
    					  title: '登录',
    					  area: ['600px', '361px'],
    					  closeBtn: 1, //显示关闭按钮
    					  shift: 1,
    					  shade: 0.5, //开启遮罩关闭
    					  content: '${pageContext.request.contextPath}/summary/login.jsp?state=1&id=0&contents='+contents,
    					  end: function(){
							  
							  $.post("${pageContext.request.contextPath}/summary/updateSummary.action",{"content":contents},function(data){
							  if(data=="1"){
	  	     					parent.layer.msg('保存成功', {
		    					    icon: 1,
		    					    time: 1000
		    					});
		     					var time=null;
		  		 					time=setInterval(function(){
		    	     				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		    						parent.layer.close(index);
		    					},1000);
							  }
							  else
							  {
								  parent.layer.msg('未保存成功', {
		    					    icon: 1,
		    					    time: 1000
		    					});
							  }
							  });
							  
    					    }
    					});
       				}
    			});
    		});

});
function taggleWriteAndModify(){
	$.ajaxSetup({ async : false });
	$.post("${pageContext.request.contextPath}/summary/checkIsRepeatByTit.action",function(data){
		if(data=="1")
		{
			$("#taggleWriteAndModify").html("<a style='cursor:pointer' href='javascript:;' title='编写周报'><i></i><i></i><i></i>编写周报</a>");
		}else{
			$("#taggleWriteAndModify").html("<a style='cursor:pointer' href='javascript:;' title='修改周报'><i></i><i></i><i></i>修改周报</a>");
		}
	
	});
	modifyclick();
}
</script>

</head>
<body>
	<c:if test="${myuser.member==null && experience==null}">
	<c:redirect url="/user/login.jsp" />
	</c:if>
		<input type="hidden" value="0" id="contc">
		<div style="background-color:#EEEEEE; width: 703px;height: 50px; border-radius: 6px; position: relative;">
		<span style="font-weight: 600; color:#666666;position: relative;left: 20px; top: 17px;">编写周报<span/>
		</div>
		<div style="">
		    <script id="editor" type="text/plain" style="height: 300px;">
		    </script>
		</div><br>
	    <input type="button" style="margin-left: 650px;" id="btn" value="保存"/>
           
</body>
</html>