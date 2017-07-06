<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看周报</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui1.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript">
$(function(){
	//第一次点击进来的默认值
	var checkType="all";
	var ownerType="my";
	var weekType="all";
	var title;
	var page2=1;
	/*
	去除返回的功能
	//从查看返回
	//获取url中的参数,以便返回
    (function ($) {
        $.getUrlParam = function (name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
    })(jQuery);
	if($.getUrlParam('page2')!=null)
	{
	    page2 = $.getUrlParam('page2');
	    ownerType = $.getUrlParam('ownerType');	
	    checkType = $.getUrlParam('checkType');
	    weekType = $.getUrlParam('weekType');
	    setWeekTypeCheck(weekType);
	    title = $.getUrlParam('title');
	}
	*/
	setWeekTypeCheck(weekType);
	getData(checkType,ownerType,weekType,title,page2);
	$("#search-summary").click(function(){
		checkType=$("[name='checkType']").val();
		weekType=$("[name='weekType']").val();
		title=$("[name='title']").val();
		page2=1;
		//设置weekType
		if($("#weekType-1").is(":checked"))
		{
			//alert($("#weekType-1").val());
			weekType=$("#weekType-1").val();
		}
		if($("#weekType-2").is(":checked"))
		{
			//alert($("#weekType-2").val());
			weekType=$("#weekType-2").val();
		}
		if($("#weekType-3").is(":checked"))
		{
			//alert($("#weekType-3").val());
			weekType=$("#weekType-3").val();
		}
		if($("#weekType-4").is(":checked"))
		{
			//alert($("#weekType-4").val());
			weekType=$("#weekType-4").val();
		}
		//alert(checkType);
		//alert(ownerType);
		//alert(weekType);
		//alert(title);
		//alert(page2);
		getData(checkType,ownerType,weekType,title,page2);
	})	

	function setWeekTypeCheck(weekType)
	{
		if(weekType=="all"){
			$("#weekType-1").attr("checked",true);
		}
		if(weekType=="previous"){
			$("#weekType-2").attr("checked",true);
		}
		if(weekType=="current"){
			$("#weekType-3").attr("checked",true);
		}
		if(weekType=="next"){
			$("#weekType-4").attr("checked",true);
		}
	}
	
	function getData(checkType,ownerType,weekType,title,page2){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/summary/getSummarysByPage1.action",{checkType:checkType,ownerType:ownerType,weekType:weekType,title:title,page2:page2},function(data){
			//alert(data);
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var tatolCount=dataObj.returnMap.totalCount;
			var list=dataObj.returnMap.list;
			var title=dataObj.returnMap.title;
			var titleTip=dataObj.returnMap.titleTip;
			$("#titleTip").html(titleTip);
			$(".page-nav").html(navbar);
			btnclick();
			$("#TATOLCOUNT").html(tatolCount);
			$("[name='title']").val(title);
			drawTable(list);
		//	trclick();
			titclick();
		})
		
	}	
	function btnclick(){
		$(".nav-btn").click(function(){
			page2=this.lang;
			getData(checkType,ownerType,weekType,title,page2);
		})
	}	
	//查看周报	
	function showSum(sid){	
			//location.href="${pageContext.request.contextPath}/summary/membersumcomment1.jsp?page2="+page2+"&ownerType="+ownerType+"&checkType="+checkType+"&weekType="+weekType+"&title="+title+"&id="+id;
			//window.open("${pageContext.request.contextPath}/summary/membersumcomment1.jsp?id="+id);
		layer.open({
			  type: 2,
			  title: '查看周报',
			  area: ['800px', '500px'],
			 // closeBtn: 0, //不显示关闭按钮
			  shift: 1,
			  shade: 0.5, //开启遮罩关闭
			  content: '${pageContext.request.contextPath}/summary/membersumcomment1.jsp?id='+sid,
			  end: function(){
				  getData(checkType,ownerType,weekType,title,page2);
			    }
		});
	}

	function titclick(){
		$(".tit").click(function(){
			var id=this.lang;
			showSum(id);
		})
	}

	function trclick(){
		//火狐对last不支持，在不该被点的td里面机上noclick的class
		//$("tr td:not(':first,:last')").click(function(){
		$("tr td:not(.noclick)").click(function(){
			var id=this.parentNode.lang;
			showSum(id);
		})
	}

	function drawTable(data){
		var line="";
		line=line + "<thead>";
		line=line + "<tr class='text-c'>";
		line=line + "<th width='25'><input type='checkbox' name='' value=''></th>";
		line=line + "<th width='80'>序号</th>";
		line=line + "<th width='80'>会员姓名</th>";
		line=line + "<th width='180'>周报标题</th>";	
		line=line + "<th width='150'>提交时间</th>";
		line=line + "<th width='60'>状态</th>";
		line=line + "<th width='150'>操作</th>";
		line=line + "</tr>";
		line=line + "</thead>";
		line=line + "<tbody>";
		for(i=0;i<data.length;i++){
			line=line + "<tr class='text-c tr' lang='"+data[i].id+"'>";
			line=line + "<td class='noclick'>" + "<input type='checkbox' name='' value=''>" + "</td>";
			line=line + "<td>" + (i+1) + "</td>";
			line=line + "<td>" + data[i].name + "</td>";
			line=line + "<td>" + data[i].title + "</td>";
			line=line + "<td>" + data[i].time + "</td>";
			line=line +"<td class='td-status'>";
			if(data[i].ischeckval == '0')
			{
				line=line+"<span class='label label-danger radius'>未审核</span>";
			}else{
				line=line+"<span class='label label-success radius'>已审核</span>";
			}
			line=line +"</td>";	
			line=line + "<td class='noclick'><a href='javascript:void(0)' class='tit' lang='"+data[i].sid+"'>查看</a></td>";
			line=line + "</tr>";
				
		}
		line=line + "</tbody>";
		$("#period").html(line);
	}
           
});	

</script>
</head>
<body>

	<div class="text-c"> 
	<form id="">
		审核状态：
		<span class="select-box inline">
			<select name="checkType" class="select">
				<option value="all">不限</option>
				<option value="checked">已审核</option>
				<option value="nonchecked">未审核</option>
			</select>
		</span>&nbsp; &nbsp;
		周报所属：
		<input type="radio" id="weekType-1" name="weekType" value="all">
		<label for="weekType-1">全部</label>&nbsp;
		<input type="radio" id="weekType-2" name="weekType" value="previous">
		<label for="weekType-2">向前一周</label>&nbsp;
		<input type="radio" id="weekType-3" name="weekType" value="current">
		<label for="weekType-3">本周</label>&nbsp;
		<input type="radio" id="weekType-4" name="weekType" value="next">
		<label for="weekType-4">向后一周</label>&nbsp; &nbsp;
		<input type="hidden" name="title" value="">
		<button name="" id="search-summary" class="btn btn-success" type="button"><i class="Hui-iconfont">&#xe665;</i> 搜周报</button>
	</form>
	</div>
	<div class="cl pd-5 bg-1 bk-gray mt-20" id="title"> 
	<span style="margin-left:180px;" id="titleTip"></span>
	<span class="r">共有数据：<strong id="TATOLCOUNT"></strong> 条</span> </div>
	<div class="mt-20">
		<table class="table table-border table-bordered table-bg table-hover table-sort" id="period">
		</table>	
	</div>
	<br>
<div class='page-nav' style="margin-right:4%;"></div>

</body>
</html>