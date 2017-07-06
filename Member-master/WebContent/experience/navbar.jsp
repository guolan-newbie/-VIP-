<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理后台</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/navbar/css/index.css" type="text/css" media="screen" />
<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/navbar/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/navbar/js/tendina.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/navbar/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript">
$(function(){
	$(".wrap").load("${pageContext.request.contextPath}/experience/infoshow.jsp");	
	$("[title='主页']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/experience/infoshow.jsp");
	});	
	$("[title='查看周报']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/member/looksummarys.jsp");
	});	
	$("[title='进度选择']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/course/chooseprogress.jsp");
	});	
	$("[title='会员进度']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/course/progressbycategory.jsp");
	});
	$("[title='我的周报']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/personal/mysummarys.jsp");
	});
	taggleWriteAndModify();
	writeclick();
	modifyclick();								
});

function exit(){
	if(confirm("确定要退出吗？"))
	 {
		$.post("${pageContext.request.contextPath}/user/clearSession.action",function(data) {
			var returnMap = eval("(" + data + ")").returnMap;
			var statusCode = returnMap.statusCode;
			if (statusCode.errNum != 100) {
				layer.msg("<strong style='color:red;'>" + statusCode.errMsg + "</strong>", {icon : 2});
				return ;
			}
			//正式开始处理数据
			window.location.href="${pageContext.request.contextPath}/index.jsp";
		});
	 }		
}	
function personal(){
	window.open("${pageContext.request.contextPath}/personal/navbar.jsp");
}

function taggleWriteAndModify(){
	$.ajaxSetup({ async : false });
	$.post("${pageContext.request.contextPath}/summary/checkIsRepeatByTit.action",function(data){
		if(data=="1")
		{
			$("#taggleWriteAndModify").html("<a style='cursor:pointer' href='javascript:;' title='编写周报'><i></i><i></i><i></i>编写周报</a>");
		}else{
			$("#taggleWriteAndModify").html("<a style='cursor:pointer' href='javascript:;' title='修改周报'><i></i><i></i><i></i>修改周报</a>");
		}
	
	});
	modifyclick();
}
	
function writeclick(){
		$("[title='编写周报']").click(function(){
			$(".wrap").load("${pageContext.request.contextPath}/summary/write.jsp");
		});
}
	
function modifyclick(){
	$("[title='修改周报']").click(function(){
		//判断是否管理员是否审核，审核则layer弹出不用修改		
		$.post("${pageContext.request.contextPath}/summary/isCheckSum.action",function(data){
			if(data == 1)
			{
				layer.msg('已经通过审核，不用修改了', {
				    icon: 1,
				    time: 2000
				});				
			}
			else{				
				$(".wrap").load("${pageContext.request.contextPath}/summary/modify.jsp");
			}
		});

	});
}
</script>      	

</head>
<body>
    <!--顶部-->
    <div class="top">
            <div style="float: left"><span style="font-size: 16px;line-height: 45px;padding-left: 20px;color: #fff;width:100%;">VIP会员管理中心</span></div>
            <div id="ad_setting" class="ad_setting">
                <a class="ad_setting_a" href="javascript:; ">${experience.name}</a>
                <ul class="dropdown-menu-uu" style="display: none" id="ad_setting_ul">
                    <li class="ad_setting_ul_li" onclick="exit()"> <a href="javascript:;"><i class="icon-signout glyph-icon"></i> <span class="font-bold">退出</span> </a> </li>
                </ul>
                <img class="use_xl" src="${pageContext.request.contextPath}/navbar/images/right_menu.png" />
            </div>
    </div>
    <!--顶部结束-->
    <!--菜单-->

    <div class="left-menu">
        <ul id="menu">
        <li class="menu-list">
               <a style="cursor:pointer" href="javascript:;" title="主页"><i></i><i></i>主页</a>                             
            </li>
            <li class="menu-list">
               <a style="cursor:pointer"><i></i><i></i>周报</a>
               
                <ul class="child-menu">
					<li id="taggleWriteAndModify"></li>
                    <li><a style="cursor:pointer" href="javascript:;" title="查看周报"><i></i><i></i>查看周报</a></li>
                    <li><a style="cursor:pointer" href="javascript:;" title="我的周报"><i></i><i></i><i></i>我的周报</a></li>
                </ul>
             
             </li>
             <li class="menu-list">
               <a style="cursor:pointer"><i></i><i></i>课程进度</a>
                
                <ul class="child-menu">
                    <li><a style="cursor:pointer" href="javascript:;" title="进度选择" onclick="noRoot()"><i></i><i></i>进度选择</a></li>
                    <li><a style="cursor:pointer" href="javascript:;" title="会员进度" onclick="noRoot()"><i></i><i></i>会员进度</a></li>
                </ul>
      
            </li>
             <li class="menu-list">
               <a style="cursor:pointer" href="${pageContext.request.contextPath}/index.jsp"><i></i><i></i>返回首页</a>
            </li>
        </ul>
    </div>
          
    <div class="right-content">
		<div class="wrap" style="padding-left:50px;margin-top:30px"></div>
    </div>
   

</body>
</html>