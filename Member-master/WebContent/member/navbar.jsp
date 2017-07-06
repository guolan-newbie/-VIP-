<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员中心</title>
<link
	href="${pageContext.request.contextPath}/resources/uikit-2.25.0/css/uikit.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/uikit-2.25.0/css/uikit.gradient.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/uikit-2.25.0/css/uikit.almost-flat.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/bootstrap-3.3.0/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/uikit-2.25.0/js/uikit.min.js"></script>
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/uikit-2.25.0/js/components/sticky.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap-3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript">
$(function(){
	session();
	$("html").click(function() {
		session();
	})
	$("#content").load("${pageContext.request.contextPath}/member/infoshow.jsp");	
	$("[title='主页']").click(function(){
		$("#content").load("${pageContext.request.contextPath}/member/infoshow.jsp");
	});	
	$("[title='缴费']").click(function(){
		$("#content").load("${pageContext.request.contextPath}/member/pay.jsp");
	});	
	$("[title='利息市场']").click(function(){
		$("#content").load("${pageContext.request.contextPath}/thanksgiving/restinfo.jsp");
	});	
	$("[title='查看周报']").click(function(){
		$("#content").load("${pageContext.request.contextPath}/member/looksummarys.jsp");
	});		
	$("[title='值班申请']").click(function(){
		$("#content").load("${pageContext.request.contextPath}/member/lookonduty.jsp");
	});	
	$("[title='会员统计']").click(function(){
		$("#content").load("${pageContext.request.contextPath}/member/statistics.jsp");
	});
	$("[title='会员照片']").click(function(){
		$("#content").load("${pageContext.request.contextPath}/uploading/photowall.jsp");
	});
	$("[title='进度选择']").click(function(){
		$("#content").load("${pageContext.request.contextPath}/course/chooseprogress.jsp");
	});	
	$("[title='会员进度']").click(function(){
		$("#content").load("${pageContext.request.contextPath}/course/progressbycategory.jsp");
	});		
	$("[title='查询人员']").click(function(){
		$("#content").load("${pageContext.request.contextPath}/social/socialinfo.jsp");
	});
	$("[title='会员信息']").click(function(){
		$("#content").load("${pageContext.request.contextPath}/personal/vipinfo.jsp");
	});
	$("[title='修改密码']").click(function(){
		$("#content").load("${pageContext.request.contextPath}/personal/pwdchange.jsp");
	});
	$("[title='信用信息']").click(function(){
		$("#content").load("${pageContext.request.contextPath}/personal/creditinfo.jsp");
	});	
	$("[title='会员协议']").click(function(){
		$("#content").load("${pageContext.request.contextPath}/personal/vipprotocol.jsp");
	});	
	$("[title='缴费信息']").click(function(){
		$("#content").load("${pageContext.request.contextPath}/member/apiinfoshow.jsp");
	});
	$("[title='值班历史']").click(function(){
		$("#content").load("${pageContext.request.contextPath}/personal/dutyhistory.jsp");
	});
	$("[title='我的周报']").click(function(){
		$("#content").load("${pageContext.request.contextPath}/personal/mysummarys.jsp");
	});
	taggleWriteAndModify();
	writeclick();
	modifyclick();
	exit();
	noRoot();
});
var t;
function session() {
	clearTimeout(t);
	$.ajaxSetup({
		async : false
	});
	$.post("${pageContext.request.contextPath}/user/checkUserSession.action",function(data) {
		var returnMap = eval("(" + data + ")").returnMap;
		var statusCode = returnMap.statusCode;
		if(statusCode.errNum != 100) {
			location.href = "${pageContext.request.contextPath}/user/login.jsp";
			return ;
		} else {
			t = setTimeout("session()", 1000 * 60 * 15);
		}
	})
}
function exit(){
	$("#exit").click(function(){
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
	})		
}
function taggleWriteAndModify(){
	$.ajaxSetup({ async : false });
	$.post("${pageContext.request.contextPath}/summary/checkIsRepeatByTit.action",function(data){
		if(data=="1")
		{
			$("#taggleWriteAndModify").html("<a href='javascript:;' title='编写周报'>编写周报</a>");
		}else{
			$("#taggleWriteAndModify").html("<a href='javascript:;' title='修改周报'>修改周报</a>");
		}
	
	});
	modifyclick();
}
	
function writeclick(){
		$("[title='编写周报']").click(function(){
			$("#content").load("${pageContext.request.contextPath}/summary/write.jsp");
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
				$("#content").load("${pageContext.request.contextPath}/summary/modify.jsp");
			}
		});

	});
}
//可能到时候要删除，所以写在最下面，具体的细节也不做修改了
//判断信息是否填写完整
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
//判断信息是否通过审核
function noRoot(){
$("#mobileSidebar a,#pcSidebar a").click(function(){
	if($("#flag").val()=="false"){
		if(confirm("您的个人信息还未通过审核，将无权访问此页面，如果信息填写完整，请耐心等待。如果未完整填写请立即填写！"))
		 {
				window.location.href="${pageContext.request.contextPath}/user/register.jsp"; 
		 }
		else
		{
			window.location.href="${pageContext.request.contextPath}/member/navbar.jsp"; 
		}
	}
})
	
}
</script>
</head>
<body>
	<input type="hidden" id="root" value="${myuser.root}">
	<input type="hidden" id="flag" value="${myuser.member.flag}">
	<div class="uk-container uk-container-center uk-margin-top uk-margin-large-bottom">
	<!-- 顶部菜单栏 -->
	<nav class="uk-navbar">
		<ul class="uk-navbar-nav">
			<li><a href="javascript:;" class="hidden-md hidden-lg" data-uk-offcanvas="{target:'#mobileSidebar'}"><i class="uk-icon-bars uk-icon-medium"></i></a></li>
			<li><a href="javascript:;">VIP会员管理中心</a></li>
		</ul>
		<div class="uk-navbar-flip hidden-sm hidden-xs">
			<ul class="uk-navbar-nav">
				<li class="uk-parent" data-uk-dropdown><a href="">${myuser.member.name}</a>
					<div class="uk-dropdown uk-dropdown-navbar" style="width: 100px">
						<ul class="uk-nav uk-nav-navbar">
							<li><a href="javascript:;" class="uk-text-large" id="exit"><i class="uk-icon-sign-out"></i><i>退出</i></a></li>
						</ul>
					</div>
				</li>
			</ul>
		</div>
	</nav>
	<!-- 侧边栏+内容 -->
	<div class="uk-grid uk-margin-top">

	<!-- 电脑侧边栏 -->

<div id="pcSidebar" class="hidden-sm hidden-xs uk-width-2-10" >
		<div class="uk-panel uk-panel-box" data-uk-sticky="{top:35}">
			<ul class="uk-nav uk-nav-side uk-nav-parent-icon" data-uk-nav>
				<li><a href="javascript:;" title="主页"><i class="uk-icon-home"></i>&nbsp;主页</a></li>
				<li class="uk-parent"><a href="#"><i class="uk-icon-money"></i>&nbsp;费用信息</a>
					<ul class="uk-nav-sub">
						<li><a href="javascript:;" title="缴费">缴费</a></li>
						<li><a href="javascript:;" title="利息市场">利息市场</a></li>
						<li><a href="javascript:;" title="缴费信息">缴费信息</a></li>
					</ul>
				</li>
				<li class="uk-parent"><a href="#"><i class="uk-icon-file-text "></i>&nbsp;会员周报</a>
					<ul class="uk-nav-sub">
						<li id="taggleWriteAndModify"></li>
						<li><a href="javascript:;" title="查看周报">查看周报</a></li>
						<li><a href="javascript:;" title="我的周报">我的周报</a></li>
					</ul>
				</li>
				<li class="uk-parent"><a href="#"><i class="uk-icon-list"></i>&nbsp;值班信息</a>
					<ul class="uk-nav-sub">
						<li><a href="javascript:;" title="值班申请">值班申请</a></li>
						<li><a href="javascript:;" title="值班历史">值班历史</a></li>
					</ul>
				</li>
				<li class="uk-parent"><a href="#"><i class="uk-icon-users"></i>&nbsp;会员信息</a>
					<ul class="uk-nav-sub">
						<li><a href="javascript:;" title="会员统计">会员统计</a></li>
						<li><a href="javascript:;" title="查询人员">查询人员</a></li>
						<li><a href="javascript:;" title="会员照片">会员照片</a></li>
					</ul>
				</li>
				<li class="uk-parent"><a href="#"><i class="uk-icon-signal"></i>&nbsp;课程进度</a>
					<ul class="uk-nav-sub">
						<li><a href="javascript:;" title="进度选择">进度选择</a></li>
						<li><a href="javascript:;" title="会员进度">会员进度</a></li>
					</ul>
				</li>
				<li class="uk-parent"><a href="#"><i class="uk-icon-user"></i>&nbsp;个人中心</a>
					<ul class="uk-nav-sub">
						<li><a href="javascript:;" title="会员信息">会员信息</a></li>
						<li><a href="javascript:;" title="信用信息">信用信息</a></li>
						<li><a href="javascript:;" title="修改密码">修改密码</a></li>
						<li><a href="javascript:;" title="会员协议">会员协议</a></li>
					</ul>
				</li>
				<li class="uk-nav-divider"></li>
				<li><a href="${pageContext.request.contextPath}/index.jsp"><i class="uk-icon-reply"></i>&nbsp;返回首页</a></li>
			</ul>
		</div>
	</div>
	<!-- 内容 -->
	    <div class="uk-width-8-10" id="content">
	    </div>
</div>
</div>
	<!-- 手机侧边栏 -->
	<div id="mobileSidebar" class="uk-offcanvas">
	    <div class="uk-offcanvas-bar">
			<h3 class="uk-panel-title">Nav side in panel</h3>
			<ul class="uk-nav uk-nav-side uk-nav-parent-icon" data-uk-nav>
				<li class="uk-active"><a href="#">Active</a></li>
				<li class="uk-parent"><a href="#">Parent</a>
					<ul class="uk-nav-sub">
						<li><a href="#">Sub item</a></li>
						<li><a href="#">Sub item</a>
							<ul>
								<li><a href="#">Sub item</a></li>
								<li><a href="#">Sub item</a></li>
							</ul></li>
					</ul></li>
				<li class="uk-parent"><a href="#">Parent</a>
					<ul class="uk-nav-sub">
						<li><a href="#">Sub item</a></li>
						<li><a href="#">Sub item</a></li>
					</ul></li>
				<li><a href="#">Item</a></li>
				<li class="uk-nav-header">Header</li>
				<li class="uk-parent"><a href="#"><i class="uk-icon-star"></i>Parent</a></li>
				<li><a href="#"><i class="uk-icon-twitter"></i> Item</a></li>
				<li class="uk-nav-divider"></li>
				<li><a href="#"><i class="uk-icon-rss"></i> Item</a></li>
			</ul>
		</div>
	</div>
</body>
</html>