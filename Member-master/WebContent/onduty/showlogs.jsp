<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
		<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
		<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css" />
				<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<title>值班日志</title>
<script type="text/javascript">
$(function(){
	//获取url中的参数Oid,type
    (function ($) {
        $.getUrlParam = function (name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
    })(jQuery);
    var oid = $.getUrlParam('oid');
    var type = $.getUrlParam('type');
    $.post("${pageContext.request.contextPath}/ondutylog/getLogs.action?oid="+oid,function(data){
		if(data==""||data==null)
			return;
		for(var i=0;i<data.length;i++){
			var condiv=$("<div>").addClass("condiv").appendTo($("#contentdiv"));
			var title=$("<p>").addClass("title").appendTo(condiv);
			$("<p>"+data[i].formatTime+"</p>").addClass("title").appendTo(title);
			$("<span>"+"被帮助者姓名："+data[i].beHelpedName+"</span>").addClass("condivtil").appendTo(title);
			$("<br>").appendTo(title);
			$("<span>"+"被帮助者QQ："+data[i].beHelpedQQ+"</span>").addClass("condivtil").appendTo(title);
			$("<br>").appendTo(title);
			$("<span>"+"被帮助者个人情况："+data[i].beHelpedInfo+"</span>").addClass("condivtil").appendTo(title);
			$("<br>").appendTo(title);
			$("<span>"+"问题描述："+data[i].qustionDescription+"</span>").addClass("condivtil").appendTo(title);
			$("<br>").appendTo(title);
			$("<span>"+"解决情况："+data[i].solutionReport+"</span>").addClass("condivtil").appendTo(title);
			$("<br>").appendTo(condiv);
			var link;
			var iconspan;
			var iconspaniner;
			if(type=="admin")
			{
				if(data[i].flag==1)
				{
					link=$("<a>").attr({href:"javascript:;",style:"color: red;"}).appendTo(condiv);
				}
				else
				{
					link=$("<a>").attr({href:"${pageContext.request.contextPath}/ondutylog/checkLogById.action?id="+data[i].id}).appendTo(condiv);
				}				
				iconspan=$("<span>").addClass("condivicon").appendTo(link);
				iconspaniner=$("<span>").attr({style:"font-size: 14px;"}).addClass("glyphicon glyphicon-eye-open").appendTo(iconspan);
			}else{
				iconspan=$("<span>").addClass("condivicon").appendTo(condiv);
				iconspaniner=$("<span>").attr({style:"font-size: 14px;"}).addClass("glyphicon glyphicon-eye-open").appendTo(iconspan);
			}
			
			$("<span>"+" 提交于 "+data[i].formatSubmitTime+"</span>").addClass("icon1iner").appendTo(iconspaniner)
			$("<hr>").appendTo(condiv);
		}
		
		
	});
    //$("#back").click(function(){
    	//history.back(-1);
    //	location.href="${pageContext.request.contextPath}/admin/dutymanagement.jsp";
    //});
});
</script>
</head>
<body>
		<div class="mywridiv">
			<span class="mywridivspan">值班日志</span>
		</div>
		<div id="contentdiv" style="margin-top: -23px;word-break: break-all;">
			<hr color="#00CCFF" style="height: 3px;" />
		</div>
		<!-- 
		<div class="container">
			<button class="btn btn-default col-md-3 col-md-push-1" type="button" id="back">返回</button>
		</div>
		 -->
</body>
</html>