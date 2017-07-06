<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理后台</title>
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/images/icon/H~ui_ICON_1.0.8/iconfont.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/navbar/css/index.css"
	type="text/css" media="screen" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/navbar/js/tendina.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/navbar/js/common.js"></script>
<script type="text/javascript">
	$(function() {
		//关闭AJAX相应的缓存
		$.ajaxSetup({cache : false});
		
		session();
		
		$("html").click(function() {
			session();
		})
		$("#wrap").load(getAnchor());
		
		$(".menuItem").click(function() {
			$("#wrap").load("${pageContext.request.contextPath}" + $(this).attr("href").substring(1));
		});
	});
	var t;
	function session() {
		clearTimeout(t);
		$.ajaxSetup({async : false});
		$.post("${pageContext.request.contextPath}/admin/checkAdminSession.action",function(data) {
			if (data == "1") {
				t = setTimeout("session()", 1000 * 60 * 120);
			} else {
				location.href = "${pageContext.request.contextPath}/user/login.jsp";
			}
		});
	}
	
	function exit() {
		if (confirm("确定要退出吗？")) {
			$.post("${pageContext.request.contextPath}/user/clearSession.action",function() {
				window.location.href = "${pageContext.request.contextPath}/index.jsp";
			});
		}
	}
	
	function AdminInfo() {
		layer.open({
			type : 2,
			title : '权限管理',
			area : [ '900px', '600px' ],
			shift : 1,
			maxmin : true,
			content : '${pageContext.request.contextPath}/admin/adminInfo.jsp',
			end : function() {
				location.reload();
			}
		});
	}
	
	function modifyChmod() {
		layer.open({
			type : 2,
			title : '权限管理',
			area : [ '600px', '350px' ],
			shift : 1,
			maxmin : true,
			content : '${pageContext.request.contextPath}/admin/showAllAdmin.jsp',
		});
	}
	
	function getAnchor() {
		var anchor = window.location.hash;
		if(anchor == "" || anchor == "#") {
			if ($("#mem").val() != 0) {
				return "${pageContext.request.contextPath}/admin/lookmemberinformation.jsp";
			} else {
				return "${pageContext.request.contextPath}/admin/check.jsp";
			}
		}
		return "${pageContext.request.contextPath}" + anchor.substring(1);
	}
</script>


</head>
<body>
	<!--顶部-->
	<div class="top">
		<div style="float: left">
			<span style="font-size: 16px; line-height: 45px; padding-left: 20px; color: #fff; width: 100%;">VIP会员管理中心</span>
		</div>
		<div id="ad_setting" class="ad_setting">
			<a class="ad_setting_a" href="javascript:; ">${admin1.realname}</a>
			<ul class="dropdown-menu-uu" style="display: none" id="ad_setting_ul">
				<li class="ad_setting_ul_li" onclick="AdminInfo()">
				<a href="javascript:;">
					<i class="icon-signout glyph-icon"></i> 
					<span class="font-bold">个人信息</span>
				</a>
				</li>
				<!-- 管理员权限判断 1为超级管理员  -->
				<c:if test="${sessionScope.admin.authority == 1 }">
					<li class="ad_setting_ul_li" onclick="modifyChmod()">
						<a href="javascript:;">
							<i class="icon-signout glyph-icon"></i> 
							<span class="font-bold">权限管理</span> 
						</a>
					</li>
				</c:if>
				<li class="ad_setting_ul_li" onclick="exit()">
					<a href="javascript:;">
						<i class="icon-signout glyph-icon"></i> 
						<span class="font-bold">退出</span>
					</a>
				</li>
			</ul>
			<img class="use_xl" src="${pageContext.request.contextPath}/navbar/images/right_menu.png" />
		</div>
	</div>
	<!--顶部结束-->
	<!--菜单-->
	<div class="left-menu" style="float: left;">
		<ul id="menu">
			<li class="menu-list">
				<a style="cursor: pointer">
					<i></i><i class="Hui-iconfont">&#xe6cc;</i>会员管理
				</a>
				<ul>
					<li><a href="#/admin/check.jsp" class="menuItem" title="会员审核"><i></i><i></i><i></i>会员审核</a></li>
					<li><a href="#/admin/infomanagement.jsp" class="menuItem" title="信息管理"><i></i><i></i><i></i>信息管理</a></li>
					<li><a href="#/admin/assistantsetup.jsp" class="menuItem" title="会员基础设置"><i></i><i></i><i></i>基础设置</a></li>
					<li><a href="#/admin/membercommunication.jsp" class="menuItem" title="沟通信息"><i></i><i></i><i></i>沟通信息</a></li>
					<li><a href="#/admin/checkimage1.jsp" class="menuItem" title="图片管理"><i></i><i></i><i></i>图片管理</a></li>
					<li><a href="#/admin/initpwd.jsp" class="menuItem" title="密码管理"><i></i><i></i><i></i>密码管理</a></li>
					<li><a href="#/admin/lookmemberinformation.jsp" class="menuItem" title="详细信息"><i></i><i></i><i></i>详细信息</a></li>
					<li><a href="#/uploading/photowall.jsp" class="menuItem" title="会员照片"><i></i><i></i><i></i>会员照片</a></li>
				</ul>
			</li>
				
			<li class="menu-list">
				<a style="cursor: pointer">
					<i></i><i class="Hui-iconfont">&#xe62b;</i>体验管理
				</a>
				<ul>
					<li><a href="#/admin/experiencer/manageExperience.jsp" class="menuItem" title="体验用户"><i></i><i></i><i></i>体验用户</a></li>
					<li><a href="#/admin/expassistantsetup.jsp" class="menuItem" title="体验者基础设置"><i></i><i></i><i></i>基础设置</a></li>
					<li><a href="#/admin/experiencer/allInformation.jsp" class="menuItem" title="体验者详细信息"><i></i><i></i><i></i>详细信息</a></li>
					<li><a href="#/admin/clue/clueManagement.jsp" class="menuItem" title="跟踪管理"><i></i><i></i><i></i>跟踪管理</a></li>
					<li><a href="#/admin/experiencer/monthlyMembership.jsp" class="menuItem" title="月入会员" ><i></i><i></i><i></i>月入会员</a></li>
				</ul>
			</li>
			
			<li class="menu-list"><a style="cursor: pointer" href="#/admin/allcommunications.jsp" class="menuItem" title="沟通汇总"><i></i><i class="Hui-iconfont">&#xe6d0;</i>沟通汇总</a></li>
			<li class="menu-list">
				<a style="cursor: pointer">
					<i></i><i class="Hui-iconfont">&#xe647;</i>周报管理
				</a>
				<ul>
					<li><a href="#/admin/looksummarys.jsp" class="menuItem" title="周报管理"><i></i><i></i><i></i>周报管理</a></li>
					<li><a href="#/admin/dailyLog/dailyLogs.jsp" class="menuItem" title="工作日志"><i></i><i></i><i></i>工作日志</a></li>
				</ul>
			</li>
			<li class="menu-list">
				<a style="cursor: pointer">
					<i></i><i class="Hui-iconfont">&#xe63a;</i>费用管理
				</a>
				<ul>
					<li><a href="#/admin/feedetailTwo.jsp" class="menuItem" title="缴费审核"><i></i><i></i><i></i>缴费审核</a></li>
					<li><a href="#/admin/feepay.jsp" class="menuItem" title="应缴费用"><i></i><i></i><i></i>应缴费用</a></li>
					<li><a href="#/admin/fee.jsp" class="menuItem" title="缴费信息"><i></i><i></i><i></i>缴费信息</a></li>
					<li><a href="#/thanksgiving/restinfo.jsp" class="menuItem" title="利息市场"><i></i><i></i><i></i>利息市场</a></li>
					<li><a href="#/admin/calculator.jsp" class="menuItem" title="费用计算"><i></i><i></i><i></i>费用计算</a></li>
					<!-- <li><a href="javascript:;" title="费用统计"><i></i><i></i><i></i>费用统计</a></li> -->
					<li><a href="#/admin/fee2.jsp" class="menuItem" title="缴费信息"><i></i><i></i><i></i>缴费信息2</a></li>
				</ul>
			</li>
			<li class="menu-list">
				<a style="cursor: pointer" href="#/admin/history.jsp" class="menuItem" title="来访记录">
					<i></i><i class="Hui-iconfont">&#xe70c;</i>来访记录
				</a>
			</li>
			<li class="menu-list">
				<a style="cursor: pointer" href="#/admin/notice.jsp" class="menuItem" title="公告管理">
					<i></i><i class="Hui-iconfont">&#xe63b;</i>公告管理
				</a>
			</li>
			<li class="menu-list">
				<a style="cursor: pointer" href="#/admin/dutymanagement.jsp" class="menuItem" title="值班管理">
					<i></i><i class="Hui-iconfont">&#xe623;</i>值班管理
				</a>
			</li>
			<li class="menu-list">
				<a style="cursor: pointer">
					<i></i><i class="Hui-iconfont">&#xe61c;</i>课程进度
				</a>
				<ul>
					<li><a href="#/admin/coursesmanage1.jsp" class="menuItem" title="课程管理"><i></i><i></i><i></i>课程管理</a></li>
					<li><a href="#/admin/setcategory.jsp" class="menuItem" title="专业设置"><i></i><i></i><i></i>专业设置</a></li>
					<li><a href="#/course/progressbycategory.jsp" class="menuItem" title="会员进度"><i></i><i></i><i></i>会员进度</a></li>
				</ul>
			</li>
			<li class="menu-list">
				<a style="cursor: pointer" href="${pageContext.request.contextPath}/index.jsp">
					<i></i><i class="Hui-iconfont">&#xe66b;</i>返回首页
				</a>
			</li>
		</ul>
	</div>
	<div class="right-content">
		<div id="wrap" style="padding-left: 50px; margin-top: 30px"></div>
		<input type="hidden" id="mem" value="${myuser.member.id}" />
	</div>
</body>
</html>