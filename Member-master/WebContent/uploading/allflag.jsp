<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" /> 	
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户图片</title>
<script type="text/javascript">
$(function(){
	//第一次点击进来的默认值
	var page2=1;
	//获取url中的参数id
    (function ($) {
        $.getUrlParam = function (name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
    })(jQuery);
	var uid=$.getUrlParam('id');
	getData(page2);
	function getData(page2){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/picture/getUserPictureByPage.action",{uid:uid,page2:page2},function(data){	
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var list=dataObj.returnMap.list;
			$(".page-nav").html(navbar);
			btnclick();
			drawTable(list);
			showclick();
		})
		
	}	
	//分页按钮点击事件
	function btnclick(){
		$(".nav-btn").click(function(){
			page2=this.lang;
			getData(page2);
		})
	}
	function showclick(){
		$(".show").click(function(){
			var id=this.lang;
			var index=layer.open({
				type:2,
			    title:'用户图片审核',
			    area: ['500px', '350px'],
			    shift:5,
			    maxmin: true,
			    content: '${pageContext.request.contextPath }/uploading/isflag.jsp?id=' + id,
			    end: function(){
			    	getData(page2);
		    	}
			});
		});
	}
	function drawTable(data){
		var line="";
		line=line + "<thead class='text-c'>"
		line=line + "<tr>";
		line=line + "<th>序号</th>";
		line=line + "<th>图片名称</th>";
		line=line + "<th>查看</th>";
		line=line + "</tr>";
		line=line + "</thead>"
		for(i=0;i<data.length;i++){
			line=line + "<tbody class='text-c'>"				
			line=line + "<tr>"
			line=line + "<td>" + (i+1) + "</td>";
			line=line + "<td>" + (data[i].title) + "</td>";
			line=line + "<td><a href='javascript:void(0)' class='show' lang="+ (data[i].id) +">查看</a></td>";
			line=line + "</tr>";
			line=line + "</tbody>"
		}
		$("#visits").html(line);
	}	
 })
</script>
</head>
<body>
	<h1 style="text-align:center">用户图片</h1>
	<div class="wrap" style="padding-left:180px;margin-top:30px">
	<div class="mt-20">
		<table class="table table-border table-bg table-bordered radius" id="visits">
		</table>	
	</div>
	</div>
	<br>
	<div class='page-nav' style="padding-right:120px"></div>
</body>
</html>