<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>社交</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/jquery.searchableSelect.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" /> 	
<style type="text/css">
.white {
	color: #606060;
	border: solid 1px #b7b7b7;
	background: #fff;
	background: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#ededed));
	background: -moz-linear-gradient(top,  #fff,  #ededed);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#ededed');
}
.white:hover {
	background: #ededed;
	background: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#dcdcdc));
	background: -moz-linear-gradient(top,  #fff,  #dcdcdc);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#dcdcdc');
}

.white:active {
	color: #999;
	background: -webkit-gradient(linear, left top, left bottom, from(#ededed), to(#fff));
	background: -moz-linear-gradient(top,  #ededed,  #fff);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#ffffff');
}
.button {
	display: inline-block;
	zoom: 1; /* zoom and *display = ie7 hack for display:inline-block */
	*display: inline;
	vertical-align: baseline;
	margin: 0 2px;
	outline: none;
	cursor: pointer;
	text-align: center;
	text-decoration: none;
	font: 14px/100% Arial, Helvetica, sans-serif;
	padding: .5em 2em .55em;
	-webkit-border-radius: .5em; 
	-moz-border-radius: .5em;
	border-radius: .5em;
	-webkit-box-shadow: 0 1px 2px rgba(0,0,0,.2);
	-moz-box-shadow: 0 1px 2px rgba(0,0,0,.2);
	box-shadow: 0 1px 2px rgba(0,0,0,.2);
}
.button:hover {
	text-decoration: none;
}
.button:active {
	position: relative;
	top: 1px;
}

.bigrounded {
	-webkit-border-radius: 2em;
	-moz-border-radius: 2em;
	border-radius: 2em;
}
.medium {
	font-size: 12px;
	padding: .4em 1.5em .42em;
}
.small {
	font-size: 11px;
	padding: .2em 1em .275em;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery.searchableSelect.js"></script>
<script type="text/javascript">
$(function(){
	//第一次点击进来的默认值
	var page2=1;
	$.post("${pageContext.request.contextPath}/Social/getCondition.action",function(data){
		var dataObj = eval("("+data+")");
		var list = dataObj.conditionList;
		var optionstring="";
		for(var item in list){
			optionstring += "<option value=\""+ list[item] +"\" >"+ list[item] +"</option>";
		}
		$("#sel").html(optionstring);
	})
	
	
	$("#select").click(function(){
		getData(1);
	
	});
	$('select').searchableSelect();
	function getData(page2){
		$.ajaxSetup({async:false});
		var condition="";
		condition = $(":selected","#sel").val();
		$.post("${pageContext.request.contextPath}/Social/getSocial.action",{page2:page2,condition:condition},function(data){
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var list=dataObj.returnMap.list;
			alert(list);
			$(".page-nav").html(navbar);
			btnclick();
			if(list.length>0){
				drawTable(list);
			}
			else{
				$("#list").html("*暂无数据...");
			}
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
		var table ="<thead class='text-c'>";
		table +="<tr><th>序号</th><th>会员名字</th><th>性别</th><th>年龄</th><th>学校</th><th>手机号</th><th>qq</th><th>类型</th><th>毕业时间</th><th>是否会员</th><th>所在城市</th><th>出生地</th></tr>";
		for(var i=0;i<data.length;i++){
			table +="<tr ><td>";
			table +=i+1;
			table +="</td><td>";
			table +=data[i].name;
			table +="</td><td>";
			table +=data[i].sex;
			table +="</td><td>";
			if(data[i].age==null || data[i].age==0){
				table +="无";
			}else{
				table +=data[i].age;
			}
			
			table +="</td><td>";
			table +=data[i].school;
			table +="</td><td>";
			table +=data[i].phone;
			table +="</td><td>";
			table +=data[i].qq;
			table +="</td><td>";
			if(data[i].student==1){
				table +="学生";
			}else{
				table +="在职";
			}
			table +="</td><td>";
			var JsonDateValue = new Date(data[i].graduateDate);
			table +=JsonDateValue.toLocaleDateString();
			table +="</td><td>";
			if(data[i].flag==1){
				table +="会员";
			}else{
				table +="体验者";
			}
			table +="</td><td>";
			table +=data[i].pname;
			table +="</td><td>";
			if(data[i].psname==null){
				table +="无";
			}else{
				table +=data[i].psname;
			}

			table +="</td></tr>";
		};
		table+="</thead>";
		$("#list").html(table);
	}
})
</script>
</head>
<body>
<div class="wrap" style="padding-left:50px;margin-top:30px">
  <div>
    	<select id="sel">
    	</select>

        <a id="select" class="button white bigrounded">查询</a> 
     </div>
	<div class="mt-20">
		<table id="list" class="table table-border table-bordered table-bg table-hover table-sort">
 		</table>
 		<br/>
 	</div>
	<br/>
	<div class='page-nav' style="padding-right:120px"></div>
</div>
</body>
</html>