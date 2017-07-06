<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>修改周报-专注建立IT精英圈子</title>
	

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
    		var id;
			$.post("${pageContext.request.contextPath}/summary/getCurrentSummary.action",function(data){	
				id=data.id;
				//alert(id);
				ue.ready(function(){
						ue.setContent(data.content);
					});					
			});
    		$("#btn").click(function(){
    			var contents=UE.getEditor('editor').getContent();
    			if(contents == "" ){
    				alert("周报内容不能为空");
    				return false;
    			}
    			$.ajaxSetup({async:false}); 
     			$.post("${pageContext.request.contextPath}/summary/updateSummary.action",{content:contents,id:id},function(data){
     				if(data=="1")
 					{
     					layer.msg('修改成功',{
    					    icon: 1,
    					    time: 1000
    					});	
 					}else{
       					layer.open({
      					  type: 2,
      					  title: '登录',
      					  area: ['600px', '361px'],
      					  closeBtn: 1, //显示关闭按钮
      					  shift: 1,
      					  shade: 0.5, //开启遮罩关闭
      					  content: '${pageContext.request.contextPath}/summary/login.jsp?state=2&contents='+contents+'&id='+id,
      					  end: function(){
							  
							  $.post("${pageContext.request.contextPath}/summary/updateSummary.action",{"content":contents},function(data){
							  if(data=="1"){
  	  	     					parent.layer.msg('修改成功', {
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
								  parent.layer.msg('未修改成功', {
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

</script>

</head>
<body>

            <!-- 正文 -->
			<div class="content-wrap">
				<input type="hidden" value="${CONTENT}" id="contc">
				<br><br><br>
				<div style="">
				    <script id="editor" type="text/plain" style="height: 300px;">
				    </script>
				</div><br>
			    <input type="button" style="margin-left: 650px;" id="btn" value="修改"/>			
			</div>
			<!-- 正文 结束-->



   





</body>
</html>