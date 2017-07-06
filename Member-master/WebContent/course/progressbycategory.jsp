<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
	<title>会员进度-Java互助学习VIP群业务运行系统</title>
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/loading-bar-style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>

<script type="text/javascript">
$(function() {
	var id;
	var page2=1;
	//获取专业
$.post("${pageContext.request.contextPath}/course/getcategory.action",function(data){
	if(data.length>0){
		showdata(data);
		$(".category").eq(0).addClass('active');
		id=data[0].id;
		getData(page2,id);
	}
	categoryclick();
});
function categoryclick(){
	$(".category").click(function(){
			id=this.lang;	
			$(".category").siblings().removeClass('active'); // 删除其他兄弟元素的样式
			$(this).addClass('active'); // 添加当前元素的样式
			getData(page2,id);
	});
}
function showdata(data){
	var line="";
	for(i=0;i<data.length;i++){
		if(i!=data.length-1)
		{
			line=line + "<a herf='#' style='text-decoration:none' class='category' lang='"+data[i].id+"'><i class='Hui-iconfont'>&#xe647;</i>"+data[i].title+"</a>&nbsp;|&nbsp;";
		}
		else
		{
			line=line + "<a herf='#' style='text-decoration:none' class='category' lang='"+data[i].id+"'><i class='Hui-iconfont'>&#xe647;</i>"+data[i].title+"</a>";
		}
	}
	$(".l").append(line);
}
	function getData(page2,id) {
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/courseandpro/getCategoryCourseandproByPage.action",{page2:page2,caid:id},function(data){
			//alert(data);
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var tatolCount = dataObj.returnMap.totalCount;
			var list=dataObj.returnMap.list;
			$(".page-nav").html(navbar);
			$("#num").html(tatolCount);
			drawTable(list);
			btnclick();
			lookprogressclick();
		});
	}
	//完成度查看点击事件
	function lookprogressclick(){
		$(".lookprogress").click(function(){
			var arr=this.lang.split(",");
			var id=arr[0];
			var identityType=arr[1];
			var caid=arr[2];
			layer.open({
			    type: 2,
			    title:'查看进度',
			    area: ['800px', '500px'],
			    shift:1,
			    shade: 0.5, //开启遮罩关闭
			    content: '${pageContext.request.contextPath}/course/lookprogress.jsp?id='+id+'&identityType='+identityType+'&caid='+caid,
			    end: function() {    	
			    }
			});					
		})
	}
	//分页按钮点击事件
	function btnclick(){
		$(".nav-btn").click(function(){
			page2=this.lang;
			getData(page2,id);
		})
	}
	function drawTable(data) {	
		var line="";
		line=line + "<thead><tr class='text-c'>";
		line=line + "<th width='40'>序号</th>";
		line=line + "<th width='40'>用户名</th>";
		line=line + "<th width='40'>真实姓名</th>";
		line=line + "<th width='40'>小助手</th>";
		line=line + "<th width='40'>完成度</th>";
		line=line + "<th width='40'>查看详情</th>";
		line=line + "</tr></thead>";
		line=line + "<tbody>"
		var assistant="";
		for(i = 0;i < data.length;i++) {
			//alert(data[i].id);
			if(data[i].admin!=null){
				assistant=data[i].admin.realname;
			}
			loadbar="";
			loadbar+="<div class='loading-bar'>";
			loadbar+="<div class='amount blue' style='width: "+data[i].proportion+"%'>";
			loadbar+="<div class='loaded'>";
			loadbar+=data[i].proportion+"%";
			loadbar+="</div>";
			loadbar+="<div class='lines'></div>";
			loadbar+="</div>";
			loadbar+="</div>";
			
			line=line + "<tr class='text-c'>"
			line=line + "<td>" + (i+1) + "</td>";
			line=line + "<td>" + data[i].memAndExp.num + "</td>";
			line=line + "<td>" + data[i].memAndExp.name + "</td>";
			line=line + "<td>" + assistant + "</td>";
			line=line + "<td>" + loadbar + "</td>";
			line=line + "<td>" + "<a class='lookprogress' lang='"+data[i].meid+","+data[i].identityType+","+data[i].caid+"'>查看</a>" + "</td>";
			line=line + "</tr>";
			line=line + "</tbody>"
		}
		$("#courses").html(line);
	}	
});
</script>
<style type="text/css">
.active{color:red}
</style>
</head>
<body>
	<h1 style="text-align:center">会员进度</h1>
	<div class="pd-20">
		<div class="cl pd-5 bg-1 bk-gray mt-20"> 
			<span class="l" style="font-size:20px"></span> 
			<span class="r">共有数据：<strong id="num"></strong> 条</span> 
		</div>
		<div class="mt-20">
			<table id="courses" class="table table-border table-bg table-bordered radius"></table>
		</div>
	</div>
	<div class='page-nav' style="padding-right:120px"></div>
	
</body>
</html>