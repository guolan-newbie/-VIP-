<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="utf-8">
	<title>公告管理-Java互助学习VIP群业务运行系统</title>
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/tableTemplet/lib/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>

<script type="text/javascript">
$(function() {
	/*功能:公告——读取数据(页面加载时)
	 *作者:张晓敏
	 *时间:2016-6-11
	 */
	/* $.ajaxSetup({
		  async: false
	});
	$.post("${pageContext.request.contextPath}/notice/getall.action",function(data){
		drawTable(data);
	},"json"); */
	getData("","","","",1);
	
	/*功能:公告——添加数据
	 *作者:
	 *时间:
	 */
	$("#add").click(function() {
		var index=layer.open({
		    type: 2,
		    title:'发布公告',
		    skin: 'layui-layer-lan', //样式类名
		    area: ['726px', '515px'],
		    shift:5,
		    maxmin: true,
		    content: '${pageContext.request.contextPath}/admin/createnotice.jsp',
		    end: function() {
		    	/* $.post("${pageContext.request.contextPath}/notice/getall.action",function(data){
		    		drawTable(data);
		    	},"json"); */
		    	query(1);
		    }
		});				
	});
	
	/*功能:公告——条件查询
	 *作者:张晓敏
	 *时间:2016-6-11
	 */
	$("#query").click(function() {
		/* 防止没有数据导致页码为空的情况 */
		if($("b").text()) {
			query($("b").text());
		}
		else {
			query(1);
		}
	});
	
	/*功能:公告——批量删除数据
	 *作者:张晓敏
	 *时间:2016-6-11
	 */
	$("#deleteAll").click(function() {
		var ids=""; //存储所有ID用的，哪些被选中就存起来
		var i=0; //ID的数量
		$("input[type='checkbox']").each(function(index, element) {
            if(index>0) {
				if($(this).prop("checked")) {
					var id=$(this).val();
					ids+=id;
					i++;
					ids+=",";
				}
			}		
		});
		if(ids.length>1) {
			ids=ids.substring(0,ids.length-1);
			if(!confirm("你确定要删除这" + i +"条记录吗")) {
				return;
			}
			else {
				$.ajaxSetup({async:false});
				$.post("${pageContext.request.contextPath}/notice/delNotices.action",{ids:ids},function() {
					query($("b").text());
				});
			}
		}
	});

});

/*功能:公告——公告置顶
 *作者:
 *时间:
 */
function settop(data){
	var str = data.split("&");
	var title = "";
	if (str[1] == 'settop=1') {
		title = "您确定将这条公告置顶吗？";
	}
	else {
		title = "您确定取消将这条公告置顶吗？";
	}
	layer.confirm(title,{btn:['是','否']},//按钮一的回调函数
			function(index) {
				$.ajaxSetup({async:false});
				$.post("${pageContext.request.contextPath}/notice/updateSettop.action?"+data,function(data) {
					query($("b").text());
					layer.close(index);
			});
	});
}

/*功能:公告——发布公告
 *作者:
 *时间:
 */
function publish(data) {
	var str = data.split("&");
	var title = "";
	if (str[1] == 'status=1') {
		title = "您确定要发布这条公告吗?";
	}
	else {
		title = "您确定取消发布这条公告吗？";
	}
	layer.confirm(title,{btn:['是','否']},//按钮一的回调函数
			function(index) {
				$.ajaxSetup({async:false});
				$.post("${pageContext.request.contextPath}/notice/updatePublish.action?"+data,function(data) {
					query($("b").text());
					layer.close(index);
			});
	});
}

/*功能:公告——修改数据
 *作者:
 *时间:
 *
 *修改:防止跳转到页面，导致显示问题
 *作者：张晓敏
 *时间:2016-6-11
 */
function modify(data) {
	var index=layer.open({
	    type: 2,
	    title:'修改公告',
	    skin: 'layui-layer-lan', //样式类名
	    area: ['726px', '515px'],
	    shift:5,
	    maxmin: true,
	    content: '${pageContext.request.contextPath}/admin/createnotice.jsp?type=1&id='+data,
	    end: function(index) {
	       /* location.href="${pageContext.request.contextPath}/admin/notice.jsp"; */
			query($("b").text());
	    }
	});				
}

/*功能:公告——删除数据
 *作者:张晓敏
 *时间:2016-6-11
 */
function del(data) {
	var id=data;	
	if(!confirm('您确定要删除此条公告吗？')) {
		return;
	}
	else {
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/notice/delNotice.action",{id:id},function() {
			query($("b").text());
		});
	}
}

/*功能:公告——查询数据
 *作者:张晓敏
 *时间:2016-6-11
 */
function query(data) {
	var title = $("[name='title']").val();	/* 公告主题关键字 */
	var type = $("[name='type']").val();	/* 公告类型 */
	var front = $("[name='front']").val();	/* 公告发布最早时间*/
	var after = $("[name='after']").val();	/* 公告发布最晚时间*/
	var page2 = data;						/* 页码*/
	$("#notice").html("");
	getData(title,type,front,after,page2);
}

/*功能:公告——获取数据
 *作者:张晓敏
 *时间:2016-6-11
 */
function getData(title,type,front,after,page2) {
	$.ajaxSetup({
		  async: false
	});
	$.ajax({  
		type: "POST",  
		url: "${pageContext.request.contextPath}/notice/getNoticeByPage.action",  
		data: "title=" + title + "&type=" + type + "&front=" + front + "&after=" + after + "&page2=" + page2,
		success: function(data){  
			var dataObj = eval("("+data+")");
			var navbar = dataObj.returnMap.navbar;
			var tatolCount = dataObj.returnMap.totalCount;
			var list = dataObj.returnMap.list;
			$(".page-nav").html(navbar);
			//alert(navbar);
			$("#num").html(tatolCount);
			drawTable(list);
		},  
		error: function(XMLHttpRequest){  
			$("body").html(XMLHttpRequest.responseText);
 		}  
	});
}

/*功能:公告——显示数据
 *作者:张晓敏
 *时间:2016-6-11
 */
function drawTable(data) {
	
	var line="";
	line=line + "<thead><tr class='text-c'>";
	line=line + "<th width='25'><input type='checkbox' name='' value=''></th>";
	line=line + "<th width='40'>序号</th>";
	line=line + "<th >公告主题</th>";
	//line=line + "<th width='80'>公告类型</th>";	
	line=line + "<th width='80'>公告状态</th>";
	line=line + "<th width='80'>是否置顶</th>";	
	line=line + "<th width='150'>发布时间</th>";
	//line=line + "<th width='150'>失效时间</th>";
	line=line + "<th width='150'>操作</th>";
	line=line + "</tr></thead>";
	
	for(i = 0;i < data.length;i++) {
		
		var datum = "";				/* 公告的资料 */
		var operation = "";			/* 公告的操作 */
		
		var content = "";			/* 内容 */
		var opstatus = "";			/* 操作 */
		var flag = "";				/* 标志量 */
		
		/*if (data[i].type == "1") {
			content = "系统公告";
		}
		else if (data[i].type=="2") {
			content = "会员动态";
		}
		else {
			type = data[i].type;
		}*/
		datum = datum + "<td>" + data[i].title + "</td>";	/* 公告主题 */
		//datum = datum + "<td>" + content + "</td>";			/* 公告类型 */
		operation = operation + "<a style='text-decoration:none' class='ml-5' onclick=modify("+data[i].id+") href='javascript:;' title='编辑'><i class='Hui-iconfont'>&#xe6df;</i></a> ";
		
		if (data[i].status == false) {
			content = "未发布";
			opstatus = " 发布公告";
			flag = 1;
		}
		else {
			content = "已发布";
			opstatus = " 取消发布";
			flag = 0;
		}
		datum = datum + "<td>" + content + "</td>";			/* 公告状态 */
		operation = operation + "<a style='text-decoration:none' class='ml-5' onclick=publish("+"'id="+data[i].id+"&"+"status="+flag+"') href='javascript:;' title='"+opstatus+"'><i class='Hui-iconfont'>&#xe603;</i></a> ";
		
		if (data[i].settop == false) {						
			opstatus = " 设为置顶";
			content = "否";
			flag = 1;
		}
		else {
			opstatus = " 取消置顶";
			content = "是";
			flag = 0;
		}
		datum = datum + "<td>" + content + "</td>";			/* 是否置顶 */
		operation = operation + "<a style='text-decoration:none' class='ml-5' onclick=settop("+"'id="+data[i].id+"&"+"settop="+flag+"') href='javascript:;' title='"+opstatus+"'><i class='Hui-iconfont'>&#xe6d6;</i></a> ";
		
		
		if (data[i].status == false) {
			content = "<td></td>";
		}
		else {
			content = "<td>" + data[i].publishtimeStr + "</td>";
		}
		datum = datum + content;							/* 发布时间 */
		
		//content = "<td>" + data[i].duetimeStr + "</td>";
		//datum = datum + content;							/* 失效时间 */
		operation = operation + "<a style='text-decoration:none' class='ml-5' onclick=del(" + data[i].id + ") href='javascript:;' title='删除'><i class='Hui-iconfont'>&#xe6e2;</i></a>" + "</td>";
		
		line = line + "<tr class='text-c tr'>";			
		line = line + "<td class='noclick'>" + "<input type='checkbox' name='' value='" + data[i].id + "'></td><td>" + (i+1) + "</td>";
		line = line + datum + "<td>" + operation + "</td>";
		line = line + "</tr>";
	}
	$("#notice").html(line);

	/*功能:公告——全选or不选
	 *作者:张晓敏
	 *时间:2016-6-11
	 */
	$("input[type='checkbox']:first").click(function() {
		$("input[type='checkbox']").not(":first").prop("checked",$(this).prop("checked"));
	});
	
	/*功能:公告——选择页面跳转
	 *作者:张晓敏
	 *时间:2016-6-11
	 */
	$(".nav-btn").click(function(){
		query(this.lang);	
	})
}

</script>
</head>
<body>
	<div class="pd-20">
		<div class="text-c"> 			
			日期范围：
			<input type="text" name="front" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'logmax\')||\'%y-%M-%d\'}'})" id="logmin" class="input-text Wdate" style="width:120px;">
			-
			<input type="text" name="after" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'logmax\')||\'%y-%M-%d\'}'})" id="logmax" class="input-text Wdate" style="width:120px;">
			<input type="text" name="title" id="" placeholder=" 公告主题" style="width:250px" class="input-text">
			<button name="" id="query" class="btn btn-success" type="submit"><i class="Hui-iconfont">&#xe665;</i> 查询公告</button>
		</div>
		<div class="cl pd-5 bg-1 bk-gray mt-20"> 
			<span class="l">
				<a href="javascript:;" onclick="deleteall()" class="btn btn-danger radius" id="deleteAll"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> 
				<button name="" id="add" class="btn btn-primary radius" type="submit"><i class="Hui-iconfont">&#xe600;</i> 添加公告</button>
			</span> 
			<span class="r">共有数据：<strong id="num"></strong> 条</span> 
		</div>
		<div class="mt-20">
			<table id="notice" class="table table-border table-bg table-bordered radius"></table>
		</div>
	</div>
	<div class='page-nav' style="padding-right:120px"></div>
	
</body>
</html>