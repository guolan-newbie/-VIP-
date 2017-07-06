<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心</title>	
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"  rel="stylesheet">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>		
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<style>
*{
	margin:0;
	padding:0;
	list-style:none;
}
.grnavbar{
	width:100%;
	height:30px;
	line-height:30px;
	margin-top:20px;
	background:#636871;
}
.grnavbar li a{ color:#fff; text-decoration:none; display:block; float:left; height:30px; line-height:30px; padding:0px 50px; font-size:15px;background:#636871;}
.grnavbar li a:hover{ background:#4b505a;}
.grnavbar li{float:left;position:relative; height:30px; line-height:30px;}
.grnavbar li .second{position:absolute;left:0;display:none;}
.grmenu{margin-left:32%;}
#tip{font-size:16px;color:red;}
#tips{margin-left:31%;}
</style>
<script type="text/javascript">
$(function(){
	var show = 0; // 默认值为0，二级菜单向下滑动显示；值为1，则二级菜单向上滑动显示
	if(show ==0){
		$('.grnavbar li').hover(function(){
			$('.second',this).css('top','30px').show();
		},function(){
			$('.second',this).hide();
		});
	}else if(show ==1){
		$('.grnavbar li').hover(function(){
			$('.second',this).css('bottom','30px').show();
		},function(){
			$('.second',this).hide();
		});
	}
	$(".grwrap").load("${pageContext.request.contextPath}/personal/vipinfo.jsp");
	$("[title='会员信息']").click(function(){
		$(".grwrap").load("${pageContext.request.contextPath}/personal/vipinfo.jsp");
	});
	$("[title='修改密码']").click(function(){
		$(".grwrap").load("${pageContext.request.contextPath}/personal/pwdchange.jsp");
	});
	$("[title='信用信息']").click(function(){
		$(".grwrap").load("${pageContext.request.contextPath}/personal/creditinfo.jsp");
	});	
	$("[title='会员协议']").click(function(){
		$(".grwrap").load("${pageContext.request.contextPath}/personal/vipprotocol.jsp");
	});	
	$("[title='缴费信息']").click(function(){
		$(".grwrap").load("${pageContext.request.contextPath}/member/apiinfoshow.jsp");
	});
	$("[title='利息市场']").click(function(){
		$(".grwrap").load("${pageContext.request.contextPath}/personal/restinfo.jsp");
	});
	$("[title='值班历史']").click(function(){
		$(".grwrap").load("${pageContext.request.contextPath}/personal/dutyhistory.jsp");
	});
	$("[title='值班日记']").click(function(){
		$(".grwrap").load("${pageContext.request.contextPath}/personal/dutylog.jsp");
	});
	$("[title='我的周报']").click(function(){
		$(".grwrap").load("${pageContext.request.contextPath}/personal/mysummarys.jsp");
	});
})
</script>
</head>
<body>
<div class="grnavbar">
	<div class="grmenu">
		<ul id="grmenu">
			<li class="li">
				<a class="nav_cell"><i></i><i></i>个人信息</a>&nbsp&nbsp丨&nbsp&nbsp
					<div class="second" style="z-index:2;">
						<ul>
							<li><a href="javascript:;" title="会员信息">会员信息</a> </li>
							<li><a href="javascript:;" title="信用信息">信用信息</a> </li>
							<li><a href="javascript:;" title="修改密码">修改密码</a> </li>
							<li><a href="javascript:;" title="会员协议">会员协议</a> </li>
						</ul>
					</div>
			</li>
			<li class="li">
				<a class="nav_cell"><i></i><i></i>费用信息</a>&nbsp&nbsp丨&nbsp&nbsp
					<div class="second" style="z-index:2;">
					<ul>
						<li><a href="javascript:;" title="缴费信息">缴费信息</a> </li>
					</ul>
					</div>
			</li>
			<li class="li">
				<a class="nav_cell" href="javascript:;" title="我的周报"><i></i><i></i>我的周报</a>&nbsp&nbsp丨&nbsp&nbsp
			</li>
			<li class="li">
				<a class="nav_cell"><i></i><i></i>我的值班</a>
				<div class="second" style="z-index:2;">
					<ul>
						<li><a href="javascript:;" title="值班历史">值班历史</a> </li>
						<li><a href="javascript:;" title="值班日记">值班日志</a> </li>
					</ul>
				</div>
			</li>
		</ul>
	</div>
</div>

	<c:if test="${myuser.member.flag}">
    <div class="content">
		<div class="grwrap" style="padding-left:50px;margin-top:50px; margin-bottom:50px; z-index:1;"></div>
    </div>
    </c:if>
     <c:if test="${!myuser.member.flag}">
    <div id="tips">
		<p></p>
		<div><hr>
		<br/>
		<h3>亲，为了更好的学习，能够了解更多的信息资讯：<br/>
		请点击这里：<a class="hoverfont" href="${pageContext.request.contextPath}/user/register.jsp">完善注册信息</a>
		</h3><h5>(只有信息填写完整，才能通过审核哦！！！)</h5>
		<br/>
			<p></p>
				<div><hr></div>
		<span id="tip">如果您的信息填写完整，请耐心等待，用户正在审核中...</span>
		</div>
		</div>
	</c:if>
</body>
</html>