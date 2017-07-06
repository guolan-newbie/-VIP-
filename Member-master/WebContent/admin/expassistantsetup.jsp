<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>基础设置-Java互助学习VIP群业务运行系统</title>
		
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
  
 <style type="text/css">
</style>   
    
    
<script type="text/javascript">
$(function(){
	//第一次点击进来的默认值
	var page2=1;
	getData(page2);
	function getData(page2){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/experience/getExperienceByPage.action",{page2:page2},function(data){
			//alert(data);
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var list=dataObj.returnMap.list;
			$(".page-nav").html(navbar);
			btnclick();
			drawTable(list);
			summarytdclick();
			setupclick();
			resetclick();
		})
		
	}	
	function drawTable(data){
		var line="";
		line=line + "<thead class='text-c'>";
		line=line + "<tr>";
		line=line + "<th>序号</th>";
		line=line + "<th>会员编号</th>";
		line=line + "<th>会员姓名</th>";
		line=line + "<th>是否需要写周报</th>";
		line=line + "<th>小助手姓名</th>";
		line=line + "<th>操作</th>";
		line=line + "</tr>";
		line=line + "</thead>";
		
		for(i=0;i<data.length;i++){
			line=line + "<tbody class='text-c'>"
			line=line + "<tr>";
			line=line + "<td>" + (i+1) + "</td>";
			line=line + "<td>" + data[i].num + "</td>";
			line=line + "<td class = 'name'>" + data[i].name + "</td>";
			line=line +"<td class='td-status' lang='"+ data[i].id +"'>";
			if(data[i].summaryflag == '1')
			{
				line=line+"<span class='label label-danger radius'>需要</span>";
			}else{
				line=line+"<span class='label label-success radius'>不需要</span>";
			}
			line=line +"</td>";	
			if(data[i].admin!=null){
				line=line + "<td>" + data[i].admin.realname + "</td>";
			}else{
				line=line + "<td>" + "" + "</td>";
			}			
			line=line + "<td>";	
			line=line + "<a href='javascript:void(0)' lang='" + data[i].id + "," + data[i].name +"' class='setup' >设置</a>";
			line=line + "&nbsp;&nbsp;";
			line=line + "<a href='javascript:void(0)' lang='" + data[i].id +"' class='reset' >重置</a>";
			line=line + "</td>";
			line=line + "</tr>";
			line=line + "</tbody>";

		}
		$("#users").html(line);
	}	
	//分页按钮点击事件
	function btnclick(){
		$(".nav-btn").click(function(){
			page2=this.lang;
			getData(page2);
		})
	}	
	//周报标记td点击事件
	function summarytdclick(){
		$(".td-status").click(function(){
			id=this.lang;
			var msg = ""
			//alert($(this).children("span").text());
			if($(this).children("span").text() == "需要") {
				msg = "你确定要设置\"不需要\"提交周报？";
			} else {
				msg = "你确定要设置\"需要\"提交周报？";
			}
			layer.confirm(msg, {
				  btn: ['确定', '取消']
				}, function(index, layero){
					$.post("${pageContext.request.contextPath}/experience/toggleSummryflag.action",{id:id},function(){
						getData(page2);
						layer.closeAll();
					})
				});
		})
	}
	function setupclick(){
		$(".setup").click(function(){
			var data=this.lang.split(",");
			var id=data[0];
			var name=data[1];
			//alert(id);
			//alert(name);
			layer.open({
				  type: 2,
				  title: '设置小助手',
				  area: ['600px', '361px'],
				 // closeBtn: 0, //不显示关闭按钮
				  shift: 1,
				  shade: 0.5, //开启遮罩关闭
				  content: '${pageContext.request.contextPath}/admin/expassistantselect.jsp?id='+id+'&name='+name,
				  end: function(){
					  getData(page2);
				    }
				});

		});
	}	
	function resetclick(){
		$(".reset").click(function(){
			var id=this.lang;
			$.post("${pageContext.request.contextPath}/experience/resetExpAssistant.action",{id:id},function(){
				getData(page2);
			});			
		})
	}	
});	
</script>

</head>
<body>
	<h1 style="text-align:center">体验者基础设置</h1>
	<div class="cl pd-5 bg-1 bk-gray mt-20" id="title"> 
		<span style="color:#F5FAFE">1</span> 
	</div>
	<div class="mt-20">
		<table id="users" class="table table-border table-bg table-bordered radius">
 		</table>
 	</div>
 	<br>
	<div class='page-nav' style="padding-right:120px"></div>
</body>
</html>