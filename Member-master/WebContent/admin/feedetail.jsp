<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>预览与缴费-Java互助学习VIP群业务运行系统</title>
<style type="text/css">
	#period{width:550px;margin-left:270px;}
	#accountlog{width:550px;}
	#previewWindow{float:left;}
	#title,#return{margin-left:20px;}
	#info,#saveit{float:left;}
	#amount,#time,#due{width:80px;}
</style>
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript">
$(function(){
	//获取url中的参数id
    (function ($) {
        $.getUrlParam = function (name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
    })(jQuery);
	var id=$.getUrlParam('id');
	$("#mid").attr("lang", $.getUrlParam('id'));
	initData();
	function initData(){
		$.ajaxSetup({
			async: false
		});	
		$("#period").html("");
		$("#accountlog").html("");
		/* 提取数据显示待审核的交费信息表格 */
		$.post("${pageContext.request.contextPath}/member/getLog.action",{id:id},function(data){
			var dataObj = eval("("+data+")");
			var list=dataObj.returnMap.list;
			drawLog(list);
		},"json");
		
		/* 提取数据显示分期信息表格 */
		$.post("${pageContext.request.contextPath}/member/fetchPeriod.action",{id:id},function(data){	
			var dataObj = eval("("+data+")");
			var list=dataObj.returnMap.list;
			var member=dataObj.returnMap.member;
			drawTable(list);
			$("#name").html(member.name);
			if(member.student=="true"){
				$("#studentType").html("学生");				
			}else{
				$("#studentType").html("工作");	
			}
			$("#registerTime").html(member.formatTime);
		},"json");

		/* 为待审核交费信息表格的按钮注册事件 */
		$(".button").click(function(){
			layer.msg("<strong>请到主页-->费用管理-->缴费审核中操作</strong>", {icon: 0});
			/* $.post("${pageContext.request.contextPath}/member/checkLog.action",
			{id:id,accountlogID:this.lang},function(data){
				initData();
			});	 */		
		});					
		$(".button2").click(function(){
			layer.msg("<strong>请到主页-->费用管理-->缴费审核中操作</strong>", {icon: 0});
			/* $.post("${pageContext.request.contextPath}/member/deleteLog.action",
			{id:id,accountlogID:this.lang},function(data){
				initData();
			});	 */		
		});	
		$(".revoke").click(function(){
			layer.confirm('您确定要撤销这笔缴费?', {
				btn: ['重要','奇葩'] //按钮
				}, function(){
					layer.msg('的确很重要', {icon: 1});
				}, function(){
					layer.msg('也可以这样', {
						time: 20000, //20s后自动关闭
				    	btn: ['明白了', '知道了']
				  	});
			});
		});
	}
	function drawTable(data){
		var line="";
		line=line + "<tr>";
		line=line + "<td>序号</td>";
		line=line + "<td>交费日期</td>";
		line=line + "<td>交费金额</td>";
		line=line + "<td>上期余额</td>";
		line=line + "</tr>";
		var restAmount=0;
		for(i=0;i<data.length;i++){
			line=line + "<tr>";			
			line=line + "<td>" + (i+1) + "</td>";		
			line=line + "<td>" + data[i].formateDuetime + "</td>";
			line=line + "<td>" + data[i].amount + "</td>";
			line=line + "<td>" + data[i].restAmount + "</td>";
			restAmount = restAmount + parseFloat(data[i].restAmount);
			line=line + "</tr>";		
		}
		$("#period").html(line);
		$("#restAmount").html(restAmount);
	}
	
	function drawLog(data)
	{
		var myline = "";
		myline=myline + "<tr>";
		myline=myline + "<td>序号</td>";
		myline=myline + "<td>交费日期</td>";
		myline=myline + "<td>交费金额</td>";
		myline=myline + "<td>审核</td>";
		myline=myline + "<td>删除</td>";
		myline=myline + "</tr>";
		for(i=0;i<data.length;i++){
			myline=myline + "<tr>";			
			myline=myline + "<td>" + (i+1) + "</td>";			
			myline=myline + "<td>" + data[i].formatDate + "</td>";
			myline=myline + "<td>" + data[i].amount + "</td>";
			myline=myline + "<td> <input type='button' class='button' lang='"+data[i].id+"' value='审核'> </td>";
			myline=myline + "<td> <input type='button' class='button2' lang='"+data[i].id+"' value='删除'> </td>";
			myline=myline + "</tr>";		
		}
		if(data.length>0){
			$("#accountlog").html(myline);
		}		
	}
});
function recovery(){
	var url = "${pageContext.request.contextPath}/admin/feerevoke.jsp?mid=" + $("#mid").attr("lang");
	layer.open({
		type: 2,
		area: ['700px', '530px'],
		fix: false, //不固定
		maxmin: true,
		content: url
	});
}
</script>
</head>
<body>


<c:if test="${admin==null}">
	<jsp:forward page="/user/login.jsp"></jsp:forward>
</c:if>
<br/>
<br/>
<div id="title" style="padding-left:250px">
姓名：<span id="name"></span>&nbsp;&nbsp;
类型：<span id="studentType"></span>
<br/>
<table id="accountlog" class="table table-bordered">
</table>
<br/>
注册日期:<span id="registerTime"></span>&nbsp;&nbsp;
未交本金合计：<span id="restAmount"></span>&nbsp;&nbsp;
<input type='button' id='mid' value='缴费纠错' onclick=recovery() lang='' class='btn btn-danger'>
<br/>
<br/>
</div>
<table id="period" class="table table-bordered">
</table>
</body>
</html>