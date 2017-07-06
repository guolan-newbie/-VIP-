<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="utf-8">
	<title>会员进度-Java互助学习VIP群业务运行系统</title>
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>

<script type="text/javascript">
$(function() {
	var page2=1;
	getData(page2);
	function getData(page2) {
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/courseandpro/getCourseandproByPage.action",{page2:page2},function(data){
			//alert(data);
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var tatolCount = dataObj.returnMap.totalCount;
			var list=dataObj.returnMap.list;
			$(".page-nav").html(navbar);
			$("#num").html(tatolCount);
			drawTable(list);
			btnclick();
			setcategoryclick();
		});
	}
	//完成度查看点击事件
	function setcategoryclick(){
		$(".setcategory").click(function(){
			var arr=this.lang.split(",");
			var id=arr[0];
			var identityType=arr[1];
			layer.open({
			    type: 2,
			    title:'选择专业',
			    area: ['300px', '500px'],
			    shift:1,
			    shade: 0.5, //开启遮罩关闭
			    content: '${pageContext.request.contextPath}/course/choosecategory.jsp?id='+id+'&identityType='+identityType,
			    end: function() {    	
			    getData(page2);
			    }
			});				
		})
	}
	//分页按钮点击事件
	function btnclick(){
		$(".nav-btn").click(function(){
			page2=this.lang;
			getData(page2);
		})
	}
	function drawTable(data) {	
		var line="";
		line=line + "<thead><tr class='text-c'>";
		line=line + "<th width='40'>序号</th>";
		line=line + "<th width='40'>用户名</th>";
		line=line + "<th width='40'>真实姓名</th>";
		line=line + "<th width='40'>小助手</th>";
		line=line + "<th width='40'>已学专业</th>";
		line=line + "<th width='40'>专业设置</th>";	
		line=line + "</tr></thead>";
		line=line + "<tbody>"
		var assistant="";
		for(i = 0;i < data.length;i++) {
			//alert(data[i].id);
			if(data[i].admin!=null){
				assistant=data[i].admin.realname;
			}
			var categorytitles="";
			for(j=0;j<data[i].categorys.length;j++){
				if(categorytitles==""){
					categorytitles+=data[i].categorys[j].title;
				}else{
					categorytitles+=",";
					categorytitles+=data[i].categorys[j].title;
				}
				
				
			}
			line=line + "<tr class='text-c'>"
			line=line + "<td>" + (i+1) + "</td>";
			line=line + "<td>" + data[i].num + "</td>";
			line=line + "<td>" + data[i].name + "</td>";
			line=line + "<td>" + assistant + "</td>";
			line=line + "<td>" + categorytitles + "</td>";
			line=line + "<td>" + "<a class='setcategory' lang='"+data[i].id+","+data[i].identityType+"'>设置</a>" + "</td>";
			line=line + "</tr>";
			line=line + "</tbody>"
		}
		$("#courses").html(line);
	}	
});
</script>
</head>
<body>
	<h1 style="text-align:center">会员专业设置</h1>
	<div class="pd-20">
		<div class="cl pd-5 bg-1 bk-gray mt-20"> 
			<span class="r">共有数据：<strong id="num"></strong> 条</span> 
		</div>
		<div class="mt-20">
			<table id="courses" class="table table-border table-bg table-bordered radius
"></table>
		</div>
	</div>
	<div class='page-nav' style="padding-right:120px"></div>
	
</body>
</html>