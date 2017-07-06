<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分期信息-Java互助学习VIP群业务运行系统</title>
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/style.css?time=20161215" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	body{margin:0 auto;}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>
<script type="text/javascript">
$(function(){
	//创建26个字母数组
	var a = new Array("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"); 
	var line="";
	for(var i=0;i<a.length;i++){
		line+="<a class='num'  value='" + a[i] + "' id='" + a[i] +"'><font size=5px>" + a[i] + "</font></a>&nbsp;&nbsp;";
	}
	//控制隐藏和显示div
	var current=document.getElementById("menu1"); 
   	if($("#member").val()=="")  
     {  
       current.style.display="none";  
     }
   	var name=null;
	$("#tag").append(line);
	$(".num").click(function(){
		//var theEvent = window.event || arguments.callee.caller.arguments[0]; 
		//alert(theEvent.target.id)
		$(".num").css("color","#BFBFBF");
		$(this).css("color","#212122");
		var letter=$(this).text();
		getName(letter);
		function getName(letter){
			//alert(letter);
			var name=null;
			$("#tabsC").html("");
			$.post("${pageContext.request.contextPath}/member/getAllNames.action",{letter:letter},function(data){
				$("#tabsC").append("<ul>")
				for(var i=0;i<data.length;i++){
					//$("#tabsC").append("<li><a href=${pageContext.request.contextPath}/member/setMember.action?name=" + data[i] + "><span>" + data[i] + "</span></a></li>");	
					$("#tabsC").append("<li><a href='javascript:void(0)' class='setMember'><span>" + data[i] + "</span></a></li>");
					
				}
				$("#tabsC").append("</ul>")
				//设置选中会员的id
				$(".setMember").on('click',function(){
					$("#tabsC li a span").css("color","#212122")
					$(this).children("span").css("color","red");
					current.style.display="block"; 
					var reStripTags = /<\/?.*?>/g;
					var textOnly = this.innerHTML.replace(reStripTags, ''); //只有文字的结果
					name=textOnly;
					$("#tabsC2").html("");
					$.post("${pageContext.request.contextPath}/member/setMember.action",{name:name},function(data){
						$("#menu1 a").css("color","#BFBFBF")
						$("#baseinfo").css("color","#212122")
						$(".showinfo").load("${pageContext.request.contextPath}/admin/memberbaseinfo.jsp");
					})
					
				})

			})
		}
	})
	$.ajaxSetup ({

    cache: false //关闭AJAX相应的缓存

	});
	$("#feeinfo").click(function(){
		var id=$("#member").val();
		//alert(id);
		$(".showinfo").html("");
		$("#menu1 a").css("color","#BFBFBF")
		$(this).css("color","#212122");
		$(".showinfo").load("${pageContext.request.contextPath}/member/apiinfoshow.jsp");
	})
	$("#baseinfo").click(function(){
		$(".showinfo").html("");
		$("#menu1 a").css("color","#BFBFBF")
		$(this).css("color","#212122");
		$(".showinfo").load("${pageContext.request.contextPath}/admin/memberbaseinfo.jsp");
	})
	$("#summaryinfo").click(function(){
		$(".showinfo").html("");
		$("#menu1 a").css("color","#BFBFBF")
		$(this).css("color","#212122");
		$(".showinfo").load("${pageContext.request.contextPath}/admin/lookpersonalsum.jsp");
	})
	$("#protocol").click(function(){
		$(".showinfo").html("");
		$("#menu1 a").css("color","#BFBFBF")
		$(this).css("color","#212122");
		$(".showinfo").load("${pageContext.request.contextPath}/personal/vipprotocol.jsp");
	})
	
})
</script>
</head>
<body>
<div id="tag" style="padding-right:50px;">
</div>
<div id="msg"></div>
<div id="tabsC" style="margin-bottom:20px;"></div>
<div id="tabsC2" style="margin-bottom:20px;"></div>
<div id="menu1">
	<a id="baseinfo">基本信息</a>
	<a id="summaryinfo">周报信息</a>
	<a id="feeinfo">缴费信息</a>
	<a id="protocol">培训协议</a>
	<input type="hidden" id="member" value="${myuser.member}">
</div>
<div class="showinfo" style="margin-left:0;padding-left:10px;margin-top:30px;">
</div>
</body>
</html>