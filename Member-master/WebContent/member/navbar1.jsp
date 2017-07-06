<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理后台</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"  rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/navbar/css/index.css" type="text/css" media="screen" />
<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/navbar/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/navbar/js/tendina.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/navbar/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript">
$(function(){
	
	$.post("${pageContext.request.contextPath}/user/checkInitPwd.action",{"pwd":$("#pwd").val()},function(data)
			{
				if(data==1)
				{
					
					location.href = "${pageContext.request.contextPath}/user/modify.jsp";
				}
			})
	//判断密码
	//如果有未查看的评论，就给出layer提示
	$.post("${pageContext.request.contextPath}/summary/checkRemind.action",function(data){
		if(data>0){		
			layer.tips('您有未读的评论，快去看看吧~', '#summary');
		}
	});
	session();
	$("html").click(function() {
		session();
	})
	$(".wrap").load("${pageContext.request.contextPath}/member/infoshow.jsp");	
	$("[title='主页']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/member/infoshow.jsp");
	});	
	$("[title='缴费']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/member/pay.jsp");
	});	
	$("[title='利息市场']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/thanksgiving/restinfo.jsp");
	});	
	$("[title='查看周报']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/member/looksummarys1.jsp");
	});		
	$("[title='值班申请']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/member/lookonduty.jsp");
	});	
	$("[title='会员统计']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/member/statistics.jsp");
	});
	$("[title='会员照片']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/uploading/photowall.jsp");
	});
	$("[title='进度选择']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/course/chooseprogress.jsp");
	});	
	$("[title='会员进度']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/course/progressbycategory.jsp");
	});		
	$("[title='查询人员']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/social/socialinfo1.jsp");
	});
	$("[title='会员信息']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/personal/vipinfo.jsp");
	});
	$("[title='修改密码']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/personal/pwdchange.jsp");
	});
	$("[title='信用信息']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/personal/creditinfo.jsp");
	});	
	$("[title='会员协议']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/personal/vipprotocol.jsp");
	});	
	$("[title='缴费信息']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/member/apiinfoshow.jsp");
	});
	$("[title='值班历史']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/personal/dutyhistory.jsp");
	});
	/* $("[title='值班日志']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/personal/dutylog.jsp");
	}); */
	$("[title='我的周报']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/personal/mysummarys.jsp");
	});
	$("[title='学校信息']").click(function(){
		$(".wrap").load("${pageContext.request.contextPath}/member/schoolInfo.jsp");
	});
	taggleWriteAndModify();
	writeclick();
	modifyclick();
});
var t;
function session() {
	clearTimeout(t);
	$.ajaxSetup({async : false});
	$.post("${pageContext.request.contextPath}/user/checkUserSession.action",function(data) {
		if (data == "1") {
			t = setTimeout("session()", 1000 * 60 * 120);
		} else {
			location.href = "${pageContext.request.contextPath}/user/login.jsp";
		}
	});
}

function exit(){
		if(confirm("确定要退出吗？")) {
			/* $.post("${pageContext.request.contextPath}/user/clearSession.action",function(data) {
				var returnMap = eval("(" + data + ")").returnMap;
				var statusCode = returnMap.statusCode;
				if (statusCode.errNum != 100) {
					layer.msg("<strong style='color:red;'>" + statusCode.errMsg + "</strong>", {icon : 2});
					return ;
				}
				//正式开始处理数据
				window.location.href="${pageContext.request.contextPath}/index.jsp";
			}); */
			$.post("${pageContext.request.contextPath}/user/clearSession.action",function(data) {
				window.location.href="${pageContext.request.contextPath}/index.jsp";
			});
		 }		
}	
function personal(){
	window.open("${pageContext.request.contextPath}/personal/navbar.jsp");
}
function noRoot(){
	if(confirm("您的个人信息还未通过审核，将无权访问此页面，如果信息填写完整，请耐心等待。如果未完整填写请立即填写！"))
	 {
			window.location.href="${pageContext.request.contextPath}/user/register.jsp"; 
	 }
	else
	{
		window.location.href="${pageContext.request.contextPath}/member/navbar1.jsp"; 
	}
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
$(document).ready(function(){
	if($("#root").val() != "0" || $("#root").val() != 0) {
		var title = "添加个人信息";
		if($("#root").val() == 1)
			title = "添加信用信息";
		layer.open({
			title : title,
			closeBtn: 0, //取消关闭按钮
			type: 2,
			area: ['700px', '600px'],
			fix: false, //不固定
			maxmin: true,
			content: '${pageContext.request.contextPath}/user/addInfo.jsp?root=' +  $("#root").val()
		});
	}
});

</script>      	

</head>
<body> 
	<input type="hidden" id="pwd" value="${myuser.pwd}">
	<input type="hidden" id="root" value="${myuser.root}">
    <!--顶部-->
    <div class="top">
            <div style="float: left"><span style="font-size: 16px;line-height: 45px;padding-left: 20px;color: #fff;width:100%;">VIP会员管理中心</span></div>
            <div id="ad_setting" class="ad_setting">
                <a class="ad_setting_a" href="javascript:; ">${myuser.member.name}</a>
                <ul class="dropdown-menu-uu" style="display: none" id="ad_setting_ul">
                    <li class="ad_setting_ul_li"  onclick="personal()"> <a href="javascript:;"><i class="icon-user glyph-icon"></i>个人中心</a> </li>
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
               <a style="cursor:pointer" href="javascript:;" title="主页"><i></i></i><i class="Hui-iconfont">&#xe625;</i>主页</a>                             
            </li>
             <c:if test="${myuser.member.flag}">
            <li class="menu-list">
               <a style="cursor:pointer"><i></i><i class="Hui-iconfont">&#xe63a;</i>费用信息</a>              
                <ul class="child-menu">
                    <li><a style="cursor:pointer" href="javascript:;" title="缴费"><i></i><i></i><i></i>缴费</a></li>
                    <li><a style="cursor:pointer" href="javascript:;" title="利息市场"><i></i><i></i><i></i>利息市场</a></li>
                    <li><a style="cursor:pointer" href="javascript:;" title="缴费信息"><i></i><i></i><i></i>缴费信息</a></li>
                </ul>
               
            </li>
            <li class="menu-list" >
               <a style="cursor:pointer"><i></i><i class="Hui-iconfont">&#xe647;</i><span id="summary">会员周报</span></a>
               
                <ul class="child-menu">
					<li id="taggleWriteAndModify"></li>
                    <li><a style="cursor:pointer" href="javascript:;" title="查看周报"><i></i><i></i><i></i>查看周报</a></li>
                    <li><a style="cursor:pointer" href="javascript:;" title="我的周报"><i></i><i></i><i></i>我的周报</a></li>
                </ul>
             
             </li>
             <li class="menu-list">
               <a style="cursor:pointer" href="javascript:;"><i></i><i class="Hui-iconfont">&#xe623;</i>值班信息</a>
                <ul class="child-menu">
                    <li><a style="cursor:pointer" href="javascript:;" title="值班申请"><i></i><i></i><i></i>值班申请</a></li>
                    <!-- <li><a style="cursor:pointer" href="javascript:;" title="值班日志"><i></i><i></i><i></i>值班日志</a></li> -->
                    <li><a style="cursor:pointer" href="javascript:;" title="值班历史"><i></i><i></i><i></i>值班历史</a></li>
                </ul>
            </li>          
            <li class="menu-list">
               <a style="cursor:pointer"><i></i><i class="Hui-iconfont">&#xe62b;</i>会员信息</a>

                <ul class="child-menu">
                    <li><a style="cursor:pointer" href="javascript:;" title="会员统计"><i></i><i></i><i></i>会员统计</a></li>
                    <li><a style="cursor:pointer" href="javascript:;" title="学校信息"><i></i><i></i><i></i>学校信息</a></li>
                    <li><a style="cursor:pointer" href="javascript:;" title="查询人员"><i></i><i></i><i></i>查询人员</a></li>
                	<li><a style="cursor:pointer" href="javascript:;" title="会员照片"><i></i><i></i><i></i>会员照片</a></li>
                </ul>
            </li>
            <li class="menu-list">
               <a style="cursor:pointer"><i></i><i class="Hui-iconfont">&#xe61c;</i>课程进度</a>
                
                <ul class="child-menu">
                    <li><a style="cursor:pointer" href="javascript:;" title="进度选择"><i></i><i></i><i></i>进度选择</a></li>
                    <li><a style="cursor:pointer" href="javascript:;" title="会员进度"><i></i><i></i><i></i>会员进度</a></li>
                </ul>
            </li>
            <!-- <li class="menu-list" >
               <a style="cursor:pointer" ><i></i><i class="Hui-iconfont">&#xe61e;</i>社交</a>
                <ul class="child-menu">
                    <li><a style="cursor:pointer" href="javascript:;" title="查询人员"><i></i><i></i><i></i>查询人员</a></li>
                </ul>
            </li> -->
            <li class="menu-list" >
               <a style="cursor:pointer" ><i></i><i class="Hui-iconfont">&#xe62c;</i>个人中心</a>
                <ul class="child-menu">
                    <li><a style="cursor:pointer" href="javascript:;" title="会员信息"><i></i><i></i><i></i>会员信息</a></li>
                    <li><a style="cursor:pointer" href="javascript:;" title="信用信息"><i></i><i></i><i></i>信用信息</a></li>
                    <c:if test="${myuser.name!=888}">
                    	<li><a style="cursor:pointer" href="javascript:;" title="修改密码"><i></i><i></i><i></i>修改密码</a></li>
                    </c:if>
                    <li><a style="cursor:pointer" href="javascript:;" title="会员协议"><i></i><i></i><i></i>会员协议</a></li>
                </ul>
            </li>
             </c:if>  
 
 

 	<c:if test="${!myuser.member.flag}">
            <li class="menu-list">
               <a style="cursor:pointer"><i></i><i></i>费用信息</a>
                
                <ul class="child-menu">
                    <li><a style="cursor:pointer" href="javascript:;" title="缴费" onclick="noRoot()"><i></i><i></i><i></i>缴费</a></li>
                    <li><a style="cursor:pointer" href="javascript:;" title="利息市场" onclick="noRoot()"><i></i><i></i><i></i>利息市场</a></li>
                </ul>
      
            </li>
            <li class="menu-list">
               <a style="cursor:pointer"><i></i><i></i>会员周报</a>
                
                <ul class="child-menu">
                    <li><a style="cursor:pointer" href="javascript:;" title="查看周报" onclick="noRoot()"><i></i><i></i><i></i>查看周报</a></li>
                </ul>
                
             </li>
             <li class="menu-list">
               <a style="cursor:pointer"><i></i><i></i>值班信息</a>
               
                <ul class="child-menu">
                    <li><a style="cursor:pointer" href="javascript:;" title="值班申请" onclick="noRoot()"><i></i><i></i><i></i>值班申请</a></li>
                    <%-- <li><a style="cursor:pointer" href="${pageContext.request.contextPath }/ondutylog/getApply.action" title="值班日志" onclick="noRoot()"><i></i><i></i><i></i>值班日志</a></li> --%>
                </ul>
              
            </li>
              
            <li class="menu-list">
               <a style="cursor:pointer"><i></i><i></i>会员信息</a>
               
                 <ul class="child-menu">
                    <li><a style="cursor:pointer" href="javascript:;" title="会员统计" onclick="noRoot()"><i></i><i></i><i></i>会员统计</a></li>
                </ul>
                    
            </li>
            <li class="menu-list">
               <a style="cursor:pointer"><i></i><i class="Hui-iconfont">&#xe61c;</i>课程进度</a>
                
                <ul class="child-menu">
                    <li><a style="cursor:pointer" href="javascript:;" title="进度选择" onclick="noRoot()"><i></i><i></i><i></i>进度选择</a></li>
                    <li><a style="cursor:pointer" href="javascript:;" title="会员进度" onclick="noRoot()"><i></i><i></i><i></i>会员进度</a></li>
                </ul>
      
            </li>
            <!-- <li class="menu-list" >
               <a style="cursor:pointer" ><i></i><i class="Hui-iconfont">&#xe61e;</i>社交</a>
                <ul class="child-menu">
                    <li><a style="cursor:pointer" href="javascript:;" title="查询人员"><i></i><i></i><i></i>查询人员</a></li>
                </ul>
            </li> -->
            <li class="menu-list" >
               <a style="cursor:pointer" href="javascript:;" title="个人中心" onclick="noRoot()"><i></i><i class="Hui-iconfont">&#xe62c;</i>个人中心</a>
                    
            </li>
            </c:if> 
            
             <li class="menu-list">
               <a style="cursor:pointer" href="${pageContext.request.contextPath}/index.jsp"><i></i><i class="Hui-iconfont">&#xe66b;</i>返回首页</a>
            </li>
        </ul>
    </div>
          
    <div class="right-content">
		<div class="wrap" style="padding-left:20px;margin-top:30px"></div>
    </div>
   

</body>
</html>