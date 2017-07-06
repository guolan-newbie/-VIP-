<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>周报所属</title>
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/style.css?time=20161215" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	body{
	 	min-height: 90%;
		margin:0 auto;
		font-family: "Microsoft Yahei","Hiragino Sans GB","Helvetica Neue",Helvetica,tahoma,arial,"WenQuanYi Micro Hei",Verdana,sans-serif,"\5B8B\4F53";
	}
	span{width: 36px;font-size:11px}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>
<script type="text/javascript">
$(function(){
	//创建26个字母数组
	var a = new Array("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"); 
	var line="";
	for(var i=0;i<a.length;i++){
		line+="<a href='javascript:void(0)' class='num'  value='" + a[i] + "' id='" + a[i] +"'><font size=5px>" + a[i] + "</font></a>&nbsp;&nbsp;";
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
				$("#tabsC").append("<li><a href='javascript:void(0)' class='setMember'><span>所有人</span></a></li>");
				$("#tabsC").append("</ul>")
				$(".setMember").on('click',function(){

					var reStripTags = /<\/?.*?>/g;
					var textOnly = this.innerHTML.replace(reStripTags, ''); //只有文字的结果
					var index = parent.layer.getFrameIndex(window.name);
					parent.$("#scopetext").val(textOnly);
		            parent.layer.close(index);
				})

			})
		}
	})
	$(".setMember").on('click',function(){
		var reStripTags = /<\/?.*?>/g;
		var textOnly = this.innerHTML.replace(reStripTags, ''); //只有文字的结果
		var index = parent.layer.getFrameIndex(window.name);
		parent.$("#scopetext").val(textOnly);
        parent.layer.close(index);
	})
})
</script>
</head>
<body>

<div id="tag" style="padding: 10px 0px 5px 40px;float: left;">
</div>
<div id="msg"></div>
<div id="tabsC" style="padding: 0 0 20px 10px;width: 98%;"></div>
<div id="tabsC2" style="margin-bottom:20px;"></div>
</body>
</html>