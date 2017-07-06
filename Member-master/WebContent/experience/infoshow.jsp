<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>信息展示-Java互助学习VIP群业务运行系统</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
	
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript">

$(function(){
	$.post("${pageContext.request.contextPath}/notice/noticeExperience.action",function(data){
		if(data=="1"){
			$("#notice").attr("src","${pageContext.request.contextPath}/images/notice.gif");
			$(".nodata").html("有新公告啦！")
		}else{
		$("#notice").attr("src","${pageContext.request.contextPath}/images/notice.png");
		}
	});
	//layer层打开系统公告
	$("#notice").click(function(){
			var index=layer.open({
				type:2,
			    title:'系统公告',
			    area: ['810px', '563px'],
			    shift:5,
			    maxmin: true,
			    content: '${pageContext.request.contextPath }/notice/experiencenotice.jsp',
			    end: function(){
				       location.href="${pageContext.request.contextPath}/experience/navbar.jsp";
				}
			});	
	});	
});
</script>

</head>
<body>
<div class="pd-20" style="padding-top:20px;">
  <p class="f-20 text-success">欢迎登录VIP会员系统！<img src="${pageContext.request.contextPath}/images/notice.png" id="notice" ></p>
  <p class="nodata" style="padding-top:10px;color:red;font-size:40px;"></p>
 <!-- 
 <p>登录次数：18 </p>
  <p>上次登录IP：222.35.131.79.1  上次登录时间：2014-6-14 11:19:55</p>
  -->
  <table class="table table-border table-bg table-bordered radius">
    <thead>
      <tr>
        <th colspan="2" scope="col">登录信息</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>登录时间 </td>
        <td>${SYSTEMINFO.formateTime }</td>
      </tr>
      <tr>
        <td>IP地址</td>
        <td>${SYSTEMINFO.ip }</td>
      </tr>
      <tr>
        <td>端口 </td>
        <td>${SYSTEMINFO.port }</td>
      </tr>
      <tr>
        <td>浏览器 </td>
        <td>${SYSTEMINFO.browser }</td>
      </tr>
	        <tr>
        <td>系统用户名 </td>
        <td>${SYSTEMINFO.systemUserName }</td>
      </tr>
      <tr>
        <td>当前SessionID </td>
        <td>${SYSTEMINFO.sessionId }</td>
      </tr>
    </tbody>
  </table>
</div>
</body>
</html>