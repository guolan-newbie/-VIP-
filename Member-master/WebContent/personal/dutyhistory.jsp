<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VIP值班-Java互助学习VIP群业务运行系统</title>
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	

<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/tableTemplet/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/tableTemplet/lib/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/tableTemplet/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript">
var url1 = "/onduty/getAll.action";
var url2 = "/onduty/getbyname.action";
function drawTable(data,navbar){
	var mid="${myuser.member.id}";
	var status="";
	var line="";
	if(data==""){
		return;	
	}
	line=line + "<thead>";
	line=line + "<tr class='text-c'>";
	line=line + "<th>序号</th>";
	line=line + "<th>会员姓名</th>";
	line=line + "<th>值班日期</th>";	
	line=line + "<th>开始时间</th>";	
	line=line + "<th>结束时间</th>";
	line=line + "<th>申请时间</th>";	
	line=line + "<th>审核状态</th>";
	line=line + "<th>审核时间</th>";
	line=line + "<th width='120px'>操作</th>";
	line=line + "</tr>";
	line=line + "</thead>";
	line=line + "<tbody>";
	for(i=0;i<data.length;i++){
		var flag=data[i].flag;
		var read=data[i].read;
		line=line + "<tr class='text-c'>";			
		line=line + "<td>" + (i+1) + "</td>";
		line=line + "<td>"+data[i].name+"</td>";
		var start = data[i].start.split(" ");
		line=line + "<td>"+start[0]+"</td>";
		line=line + "<td>"+start[1]+"</td>";
		var end = data[i].end.split(" ");
		line=line + "<td>"+end[1]+"</td>";
		line=line + "<td>"+data[i].time+"</td>";
		line=line + "<td class='td-status'><a herf='#' class='flag' lang='"+data[i].id+"'>"
		if(flag==1){
			line=line +"<span class='label label-success radius'>" + show(flag) + "</span></a></td>";
		}
		else{
			line=line +"<span class='label label-danger radius'>" + show(flag) + "</span></a></td>";
		}
		line=line + "<td>"+time(read)+"</td>";
		line=line + "<td class='f-14 td-manage'><a herf='#' title='查看' style='text-decoration:none' class='look' lang='"+data[i].id+"'><i class='Hui-iconfont'>&#xe623;</i></a>";
		if(mid==data[i].mid){
			line=line + "┆&nbsp;&nbsp;<a herf='#' class='writelog' lang='"+data[i].id+"'>编写日志</a>";
		}
		line=line + "</td></tr>";	
	}
	line=line + "</tbody>";
	$("#onduty").html(line);
	$("#navbar").html(navbar);
	$(".look").click(function(){
		var e=$(this);
		//e.html("");
		var l = this.lang
		layer.open({
			  type: 2,
			  title: '查看值班日志',
			  area: ['800px', '500px'],
			 // closeBtn: 0, //不显示关闭按钮
			  shift: 1,
			  maxmin: true,
			  shade: 0.5, //开启遮罩关闭
			  content: "${pageContext.request.contextPath}/onduty/showlogs.jsp?oid=" + this.lang + "&type=member",
			  end: function(){
			    }
		});
	});
	$(".nav-btn").click(function(){
		page2=this.lang;
		showAll(page2,$("#mid").val(),$("#logmin").val(),$("#logmax").val());
	});
	$(".writelog").click(function(){
		layer.open({
			  type: 2,
			  title: '查看值班日志',
			  area: ['800px', '500px'],
			 // closeBtn: 0, //不显示关闭按钮
			  shift: 1,
			  maxmin: true,
			  shade: 0.5, //开启遮罩关闭
			  content: "${pageContext.request.contextPath}/onduty/write.jsp?oid=" + this.lang + "&type=member",
			  end: function(){
					layer.close();
			    }
			});
		});
}
function getData(page,mid,start,end){
	var status="";
	$.post("${pageContext.request.contextPath}/onduty/getAll.action",{page2:page,mid:mid,start:start,end:end},function(data){
	var dataObj = eval("("+data+")");
	var navbar=dataObj.returnMap.navbar;
	var tatolCount=dataObj.returnMap.totalCount;
	var list=dataObj.returnMap.list;
	drawTable(list,navbar);
	})
	
}
function changeflag(e,l,url){
	var line="";
	line = line + "<select style='width:90px;height:26px;margin:0px;' name='change' onchange='select("+$(this)+","+l+")'>";
	line = line + "<option value='0'>-请选择-</option>";
	line = line + "<option value='1'>通过</option>";
	line = line + "<option value='-1'>不通过</option>";
	line = line + "</select>";
	e.append(line);
	$('[name=change]').change(function(){
		select($(this),l,url);
	});
}
function query(url){
	$("#info").html("");
	var start = $("[name='date1']").val();
	var end =  $("[name='date2']").val();
	var type = $("[name='type']").val();
	var mid=$("#mid").val();
	$("#onduty").html("");
	$.post("${pageContext.request.contextPath}/onduty/getAll.action",{mid:mid,start:start,end:end,type2:type},function(data){
		var dataObj = eval("("+data+")");
		var navbar=dataObj.returnMap.navbar;
		var tatolCount=dataObj.returnMap.totalCount;
		var list=dataObj.returnMap.list;
		drawTable(list,navbar);
	});
}
//显示所有值班日志
function showAll(page,mid,start,end){
	getData(page,mid,start,end);
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
$(function(){
	var page=1;
	$.ajaxSetup({
		  async: false
	});
	showAll(page,$("#mid").val());
	/*这里是根据时间段和类型回调数据.
	*/
	$("#query").click(function(){
		query(url1);
	});
	/**
	*这里是隐藏或弹出窗口.
	*/
	$("#add").click(function(){
		if($("#hha").css("display")!="none"){
			$("#hha").css("display","none");
		}else{
			$("#hha").css("display","");		
		}
	});
});
</script>



</head>
<body>


<%--<c:if test="${admin==null}">
	<jsp:forward page="../user/login.jsp"></jsp:forward>
	</c:if> --%>
<div class="pd-20">
	<div class="text-c">
	选择查看日期：
    <input type="text" name="date1" id="logmin" class="span2 input-text Wdate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'logmax\')||\'%y-%M-%d\'}'})" style="width:120px;">
    -
    <input type="text" name="date2" id="logmax" class="span2 input-text Wdate" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'logmin\')}',maxDate:'%y-%M-%d'})" style="width:120px;">
    值班信息：
	<span class="select-box inline">
    <select class="select" name="type">
		<option value="0">未审核</option>
		<option value="1">全部</option>
	</select>
    </span>
    <button id="query" class="btn btn-success" type="submit"><i class="Hui-iconfont">&#xe665;</i>查询</button>
</div>
</div>

<div style="display:none;padding-left:600px;padding-top:20px;" id="hha">
<div id="info" style="margin-left : 20px;"></div>
</div>

<div id="info" style="margin-left:20px; padding-left:200px;"></div>
<div class="pd-20">
<div class="mt-20">
<table id="onduty" class="table table-border table-bordered table-bg table-hover table-sort">
</table>
</div>
</div>
<br>
<div  id="navbar" class='page-nav' style="margin-right:4%;"></div>
<input type="hidden" id="mid" value="${myuser.member.id}">
</body>
</html>


