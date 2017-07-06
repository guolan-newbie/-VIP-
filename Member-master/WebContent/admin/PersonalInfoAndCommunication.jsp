<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- 
增加功能：显示会员的个人信息和沟通信息
          作者：巨李岗
          时间：2016-10-21
 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<style type="text/css">
tr{
	text-align: center;
}
table.imagetable {
font-family: verdana,arial,sans-serif;
font-size:11px;
color:#333333;
border-width: 1px;
border-color: #999999;
border-collapse: collapse;
}
table.imagetable th {
background:#b5cfd2 url('cell-blue.jpg');
border-width: 1px;
padding: 8px;
border-style: solid;
border-color: #999999;
}
table.imagetable td {
background:#dcddc0 url('cell-grey.jpg');
border-width: 1px;
padding: 8px;
border-style: solid;
border-color: #999999;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script language="javascript">
$(function(){
	$.ajaxSetup({async:false});
	(function ($) {
        $.getUrlParam = function (name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
    })(jQuery);
	var userID=$.getUrlParam('userID');
	var userType=$.getUrlParam('userType');
	var userName;
	
	//时间传过来是乱码，需要处理
	function add0(m){return m<10?'0'+m:m }
	function formatTime(shijianchuo)
	{
	//shijianchuo是整数，否则要parseInt转换
	var time = new Date(shijianchuo);
	var y = time.getFullYear();
	var m = time.getMonth()+1;
	var d = time.getDate();
	var h = time.getHours();
	var mm = time.getMinutes();
	var s = time.getSeconds();
	return y+'-'+add0(m)+'-'+add0(d)+' '+add0(h)+':'+add0(mm)+':'+add0(s);
	}
	function formatDate(shijianchuo)
	{
	//shijianchuo是整数，否则要parseInt转换
	var time = new Date(shijianchuo);
	var y = time.getFullYear();
	var m = time.getMonth()+1;
	var d = time.getDate();
	return y+'-'+add0(m)+'-'+add0(d);
	}
	//alert(userID);
	//alert(userType);
	
	if(userType=="experience")
	{
		//显示体验者的信息
		$.post("${pageContext.request.contextPath}/experience/getExperienceById.action",{"id":userID},function(data){
			//alert(data);
			//alert(data.name);
			userName=data.name;
			//alert(userName);
			$("#userInfo").append("<tr><th>序号</th><th>用户名</th><th>真实姓名</th><th>学校</th><th>联系电话</th><th>公司名称</th><th>毕业时间</th></tr>");
			$("#userInfo").append("<tr><td>"+1+"</td><td>"+data.num+"</td><td>"+data.name+"</td><td>"+data.school+"</td><td>"+data.phone+"</td><td>"+data.company+"</td><td>"+formatDate(data.graduateDate)+"</td></tr>");
		});
		//显示体验者的沟通信息
		$.post("${pageContext.request.contextPath}/experience/getCommunicationByEid.action",{"eid":userID},function(data){
			//alert(data[1].content);
			$("#communication").append("<tr><th style='width: 30px'>序号</th><th style='width: 40px'>姓名</th><th style='width: 30px'>时间</th><th style='width: 40px'>老师</th><th>内容</th></tr>");
				for(i=0;i<data.length;i++)
				{
					$("#communication").append("<tr><td>"+(i+1)+"</td><td>"+userName+"</td><td>"+(new Date(data[i].time)).pattern("yyyy-MM-dd")+"</td><td>"+data[i].admin.realname+"</td><td style=\"text-align:left;\">"+data[i].content+"</td></tr>");
				}
		});
	}
	if(userType=="member")
	{
		//显示会员的信息
		$.post("${pageContext.request.contextPath}/member/getMemberById.action",{"member.id":userID},function(data){
			//alert(data);
			//alert(data.name);
			userName=data.name;
			$("#userInfo").append("<tr><th>序号</th><th>用户名</th><th>真实姓名</th><th>学校</th><th>联系电话</th><th>公司名称</th><th>毕业时间</th></tr>");
			$("#userInfo").append("<tr><td>"+1+"</td><td>"+data.user.name+"</td><td>"+data.name+"</td><td>"+data.school+"</td><td>"+data.mobile+"</td><td>"+data.company+"</td><td>"+formatDate(data.graduateDate)+"</td></tr>");
		});
		//显示会员的沟通信息
		$.post("${pageContext.request.contextPath}/communication/getCommunicationByMid.action",{"mid":userID},function(data){
			//alert(data[1].content);
			$("#communication").append("<tr><th style='width: 30px'>序号</th><th style='width: 40px'>姓名</th><th style='width: 30px'>时间</th><th style='width: 40px'>老师</th><th>内容</th></tr>");
				for(i=0;i<data.length;i++)
				{
					$("#communication").append("<tr><td>"+(i+1)+"</td><td>"+userName+"</td><td>"+(new Date(data[i].time)).pattern("yyyy-MM-dd")+"</td><td>"+data[i].admin.realname+"</td><td>"+data[i].content+"</td></tr>");
				}
		});
	}
});
</script>
</head>
<body>
个人信息 
<table id="userInfo" class="table table-border table-bg table-bordered radius" style="width: 100%">
<!-- 序号，用户名，真实姓名，学校，联系电话，公司名称，毕业时间，类型（在职或。。） -->
</table>
沟通信息
<table id="communication" class="table table-border table-bg table-bordered radius" style="width: 100%">
<!-- 序号，会员姓名，沟通时间，沟通老师，沟通内容 -->

</table>

</body>
</html>