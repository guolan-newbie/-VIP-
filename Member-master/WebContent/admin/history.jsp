<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>来访历史-Java互助学习VIP群业务运行系统</title>
	
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" /> 		
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>		
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
 

<script type="text/javascript">
$(function(){
	//第一次点击进来的默认值
	var page2=1;
	getData(page2);
	function getData(page2){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/visit/getVisitorByPage.action",{page2:page2},function(data){
			//alert(data);
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var list=dataObj.returnMap.list;
			$(".page-nav").html(navbar);
			btnclick();
			drawTable(list);
		})
		
	}	
	//分页按钮点击事件
	function btnclick(){
		$(".nav-btn").click(function(){
			page2=this.lang;
			getData(page2);
		})
	}
	function drawTable(data){
		var line="";
		line=line + "<thead class='text-c'>"
		line=line + "<tr>";
		line=line + "<th>序号</th>";
		line=line + "<th>真实姓名</th>";
		line=line + "<th>来访时间</th>";
		line=line + "<th>离开时间</th>";
		line=line + "<th>用户类型</th>";
		line=line + "</tr>";
		line=line + "</thead>"
		for(i=0;i<data.length;i++){
				line=line + "<tbody class='text-c'>"				
				line=line + "<tr>"
				line=line + "<td>" + (i+1)+ "</td>";
				line=line + "<td>" + (data[i].memAndExp.name) + "</td>";
				line=line + "<td>" + (data[i].formatVisitTime) + "</td>";
				var leftTime="在线";
				if(data[i].formatLeftTime!=null)
				{
					leftTime=data[i].formatLeftTime;
				}
				line=line + "<td>" + leftTime + "</td>";			
				var userType=(data[i].agent);
				if(userType==true){
					userType="手机用户";
				}
				if(userType==false){
					userType="电脑用户";
				}
				line=line + "<td>" + userType + "</td>";		
				
				line=line + "</tr>";
				line=line + "</tbody>"

		}
		$("#visits").html(line);
	}	
})	

</script>

</head>
<body>
    <h1 style="text-align:center">用户历史访问记录</h1>
	<div class="cl pd-5 bg-1 bk-gray mt-20" id="title">
		<span style="color:#F5FAFE">1</span> 
	</div>
	<div class="mt-20">
		<table class="table table-border table-bg table-bordered radius" id="visits">
		</table>
	</div>
	<br/>
	<div class='page-nav' style="padding-right:120px"></div>
</body>
</html>