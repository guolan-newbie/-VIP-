<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VIP值班-Java互助学习VIP群业务运行系统</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css" />

<link href="${pageContext.request.contextPath}/css/looksummary.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/datePicker/WdatePicker.js"></script>

<style type="text/css">
	input[type='text']{margin-top:10px;}
	.btn{margin-left:10px;}
	#onduty{width:1000px;margin-left:20px;margin-top:10px;}
	#onduty{margin-left:200px;}
	.title{margin-left:20px;}
	#nav{font-size:16px;}
	#nav,#users,#footer,#down{margin-left:50px;}
	#wrap{margin-left:110px;}
</style>
</head>
<body>
	<c:if test="${myuser.member==null }">
	<c:redirect url="/user/login.jsp" />
	</c:if>
	<div style="padding-left:300px">
<table class="title" style="padding-left:300px">
<tr><td>值班日期:</td><td><input type="text" name="date" id="date"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true})"></td><td>值班信息:</td><td><select  style="margin-top:10px;" name="type">
		<option value="0">我的值班申请</option>
		<option value="1">会员值班申请</option>
	</select></td>
<td><input class="btn"type="button" id="query" value="查询"/></td><td><input class="btn" type="button" id="add" value="我要申请"/></td>
</tr>
</table>
</div>
<div style="display:none;padding-left:300px;" id="hha">
<table class="title" style="padding-left:165px">
<tr><td>选择值班时间:</td><td><input type="text" class="span2"  name="startdate" id="startdate"  readonly="readonly"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-{%d+2}' })"></td>
	<td><input class="span1" type="text" readonly name="starttime" id="starttime"  onfocus="WdatePicker({dateFmt:'H:mm',minDate:'8:30',maxDate:'21:30',onpicked:function(){endtime.focus()} })">~</td>
	<td><input class="span1" type="text" readonly name="endtime" id="endtime"  onfocus="WdatePicker({dateFmt:'H:mm',minDate:'10',maxDate:'23:30'})"></td>
	<td><input class="btn"  type="button" id="apply" value="申请"/></td></tr>
</table>
<div id="info" style="margin-left : 20px;"></div>
</div>
<table id="onduty" class="table table-border table-bordered table-bg table-hover table-sort">
</table>
<div align="center" id="navbar"><input type="hidden" id="mid" value="${myuser.member.id}"></div>
</body>
<script type="text/javascript">
function drawTable(data,url){
	if(data=="")
		return;
	var status="";
	var line="";
	line=line + "<tr>";
	line=line + "<td>序号</td>";
	line=line + "<td>会员姓名</td>";
	line=line + "<td>值班开始时间</td>";	
	line=line + "<td>值班结束时间</td>";
	line=line + "<td>申请时间</td>";	
	line=line + "<td>审核状态</td>";
	line=line + "<td>审核时间</td>";
	line=line + "<td>查看值班日志</td>";
	line=line + "</tr>";
	for(i=0;i<data.length-1;i++){
		var flag=data[i].flag;
		var read=data[i].read;
		line=line + "<tr>";			
		line=line + "<td>" + (i+1) + "</td>";
		line=line + "<td>"+data[i].name+"</td>";
		line=line + "<td>"+data[i].start+"</td>";
		line=line + "<td>"+data[i].end+"</td>";
		line=line + "<td>"+data[i].time+"</td>";
		line=line + "<td>"+show(flag)+"</td>";
		line=line + "<td>"+time(read)+"</td>";
		line=line + "<td class='f-14 td-manage'><a herf='#' title='查看' style='text-decoration:none' class='look' lang='"+data[i].id+"'><i class='Hui-iconfont'>&#xe623;</i></a>&nbsp;&nbsp;|";
		if($("#mid").val()==data[i].mid)
		line=line + "<a herf='#' class='log' lang='"+data[i].id+"'>编辑</a>";
		
		line=line + "</td></tr>";	
	}
	var size = data[data.length-1].size;
	var page = data[data.length-1].page;
	$("#onduty").html(line);
	navbar(url,size,page); 
	$(".nav").click(function(){
		var hr = "${pageContext.request.contextPath}" + this.lang;
		$.post(hr,function(data){
			drawTable(data,url);
		});
	});
	$(".look").one("click",function(){
		var e=$(this);
		e.html("");
		var l = this.lang
		location.href="${pageContext.request.contextPath}/onduty/showlogs.jsp?oid=" + this.lang + "&type=admin";
	});
}
function navbar(url,size,page){
	var date = $("[name='date']").val();
	var type = $("[name='type']").val();
	$("#navbar").html("");
	$.post('${pageContext.request.contextPath}/onduty/navbar.action',{url:url,date:date,type1:type,size:size,page:page},function(data){
		$("#navbar").html(data);
	});
}
function show(flag){
	if(flag==1){
		status="已通过";
	}else if(flag==-1){
		status="未通过";
	}else{
		status="未审核";
	}
	return status;
}
function time(read){
	if(read==null){
		read="";
	}
	return read;
}
function check(e,f){
	var a = e.split(":");
	var b = f.split(":");
	var c = b[0]-a[0];
	var d = b[1]-a[1];
	if(d>0){
		if(c>=2&&c<4)
			return 1;
	}else if(d<0){
		if(c>=3&&c<5)
			return 1;
	}else{
		if(c>=2&&c<=4)
			return 1;
	}
}
$(function(){
	var url = "/onduty/query.action";
	$.ajaxSetup({
		  async: false
	});
	showAll(url);
	$("#apply").click(function(){
		$("#info").html("");
		var starttime=$("[name='starttime']").val();
		var endtime=$("[name='endtime']").val();
		var date = $("[name='startdate']").val();
		if(starttime==null){
			$("#info").html("*请选择值班时间后再进行提交");
		}
		var status = check(starttime,endtime);
		if(!status==1){
			$("#info").html("*每次值班时间不少于两个小时且不能超过四个小时");
			return;
		}
		starttime = date+" "+starttime;
		endtime = date+" "+endtime;
		var arr = starttime.split(/[- :]/);	
		var start = new Date(arr[0], arr[1]-1, arr[2], arr[3], arr[4]); 
		arr = endtime.split(/[- :]/);
		var end = new Date(arr[0], arr[1]-1, arr[2], arr[3], arr[4]); 
		$.ajaxSetup({async: false});
		$.post("${pageContext.request.contextPath}/onduty/add.action",{"start":start,"end":end},function(data){
			showOnduty();
			//location.href='${pageContext.request.contextPath}/member/navbar1.jsp'; 
		})
	
	});
	$("#query").click(function(){
		var date = $("[name='date']").val();
		var type = $("[name='type']").val();
		$("#onduty").html("");
		$.post("${pageContext.request.contextPath}/onduty/get.action",{date:date,type1:type},function(data){
			drawTable(data,url);
		});
		showLog();
	});
	$("#add").click(function(){
		if($("#hha").css("display")!="none"){
			$("#hha").css("display","none");
		}else{
			$("#hha").css("display","");		
		}
	});
	$("#return").click(function(){
		location.href='${pageContext.request.contextPath}/member/infoshow.jsp';
	});
});
//显示本人值班信息
function showOnduty(){
		var date = $("[name='date']").val();
		var type = $("[name='type']").val();
		$("#onduty").html("");
		$.post("${pageContext.request.contextPath}/onduty/getOndutyByMid.action",function(data){
			var url="";
			drawTable(data,url);
		});
		showLog();
	};
//显示所有值班日志
function showAll(url){
	$("#info").html("");
	$("#onduty").html("");
	$.post("${pageContext.request.contextPath}/onduty/query.action",function(data){
		drawTable(data,url);
		showLog();
	});
}
	
function showLog(){
	$(".log").click(function(){
		location.href='${pageContext.request.contextPath}/onduty/write.jsp?oid='+this.lang+"&type=member";
	});
}
</script>
</html>