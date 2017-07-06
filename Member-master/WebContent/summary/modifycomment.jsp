<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>修改评论-专注建立IT精英圈子</title>
	

	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>	
<script type="text/javascript">

$(function(){
	    (function ($) {
	        $.getUrlParam = function (name) {
	            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
	            var r = window.location.search.substr(1).match(reg);
	            if (r != null) return unescape(r[2]); return null;
	        }
	    })(jQuery);
	    var id = $.getUrlParam('id');
		var comment="";
		var ue = UE.getEditor('editor',{
			enableAutoSave: false
		});
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/summary/getCommentById.action",{id:id},function(data){
			comment=data.content;
		});		
		ue.ready(function(){
			ue.setContent(comment);
		});				
	 	$("#btn").click(function(){
	 		var contents=UE.getEditor('editor').getContent();
	 		if(contents == ""){
	 			alert("评论内容不能为空");
	 			return false;
	 		}
	 		else{
	 			$.post("${pageContext.request.contextPath}/summary/updateComment.action",{id:id,content:contents},function(data){
	 				if(data=="1"){
	 					layer.msg('修改成功');
	 				}
	 			});
	 		}
 		});
	 	
});

</script>

</head>
<body>
            <!-- 正文 -->
			<div class="content-wrap">
				<div style="">
				    <script id="editor" type="text/plain" style="height: 200px;">
				    </script>
				</div><br>
			    <input type="button" style="margin-left: 400px;" id="btn" value="修改"/>			
			</div>
			<!-- 正文 结束-->

</body>
</html>