<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jslib/myfile.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<style type="text/css">
.main {
	width: 800px;
	margin-left: 25%;
}

.img {
	width: 198px;
	height: 198px;
}

.controls {
	float: left;
}

#info {
	margin-left: 60px;
	color: red;
	font-size: 16px;
}
</style>
<script type="text/javascript">
$(function(){
	getMeb();
	getCover();
	function getCover(){
		$.ajaxSetup({async: false});
		$.post("${pageContext.request.contextPath}/picture/getCover.action",{"id":$("#uid").val()},function(data){
			if(data!=""){
				$("#imgdiv").html("<a href='javascript:void(0)' class='setcover'><img src='data: image/jpeg;base64,"+data.photo+"' alt='用户头像' class='img'>");
			}
			
		});
	}
	$("#uploading").click(function(){
		$.ajaxSetup({ async : false });
			layer.open({
			    type: 2,
			    title:'图片上传',
			    area: ['450px', '520px'],
			    shift:5,
			    maxmin: true,
			    content: '${pageContext.request.contextPath}/uploading/uploading.jsp',
			    end: function(){
				      // location.href="${pageContext.request.contextPath}/personal/navbar.jsp";
				    }
			});			
	});
	$("#image").click(function(){
		var uid = ${myuser.id};
		var allconut=${allconut};
		if(allconut==0)
			{
			 layer.msg('请上传图片');		
			}
		else{
			//location.href="${pageContext.request.contextPath}/uploading/photo.jsp?uid="+uid;
		}
	});	
	$(".setcover").click(function(){
			$.ajaxSetup({ async : false });
			//先判断是否有未审核的照片,遵循代码重构规范
			$.post("${pageContext.request.contextPath}/picture/isFlag.action",function(data) {
				var returnMap = eval("(" + data + ")").returnMap;
				var statusCode = returnMap.statusCode;
				if(statusCode.errNum != 100) {
					layer.msg("<strong style='color:red;'>" + statusCode.errMsg + "</strong>", {icon : 2});
					return ;
				}
				if(returnMap.flag == 1){
					layer.confirm('您有照片未审核,是否上传新照片覆盖待审核的照片？', {
						  btn: ['是','否'] //按钮
						}, function(){
						  layer.msg('请上传新照片', {icon: 1});
								photo();
						}, function(){
						  var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
						  parent.layer.close(index); //再执行关闭 	
						});
				}else{
					photo();
				}
			});

	});
	function photo(){
		layer.open({
		    type: 2,
		    title:'封面设置',
		    area: ['700px', '550px'],
		    shift:5,
		    maxmin: true,
		    content: '${pageContext.request.contextPath}/uploading/setcover1.jsp',
		    end: function(){
		    	layer.msg('新上传照片需要管理员审核才能显示，请耐心等待！',{time:3000});	
		    	//getCover();
			    }
		});
	}
	
	//设置小助手
	function getMeb(){
		$.ajaxSetup({async: false});
		$.post("${pageContext.request.contextPath}/member/getMemberById.action",{"id":$("#id").val()},function(data){
			if(data.admin!=null){
				$(".assist").html("<td>学习小助手:</td><td>"+data.admin.realname+"</td>");
			}	
		});
	}
	//编辑资料
	$(".btn").click(function(){
		$("#name").html("<input type='text' placeholder='必填项' value='${myuser.member.name}' name='name' >");
		$("#school").html("<input type='text' placeholder='必填项' value='${myuser.member.school}' name='school'> ");
		$("#company").html("<input type='text' placeholder='必填项' value='${myuser.member.company}' name='company'> ");
		$("#mobile").html("<input type='text' placeholder='必填项' value='${myuser.member.mobile}' name='mobile'> ");
		$("#graduateDate").html("<input type='text' placeholder='必填项' value="+$("#graduateDate").text()+" name='graduateDate'> ");
		$("#btn").html("<input class='btn' type='button' value='保存信息' id='save'>");
		$("#save").click(function(){
			var name=$.trim($("[name='name']").val());
			var mobile=$.trim($("[name='mobile']").val());
			var reg=/[\u4e00-\u9fa5]+/;
			var regTel=/^0[\d]{2,3}-[\d]{7,8}$/;
			var regMobile = /^0?1[3|4|5|8|7][0-9]\d{8}$/;				
			var regDate=/^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/; 
			if (name=="" || mobile==""){
				$("#info").html("真实姓名和移动电话不能为空");
				return false;
			}
			var tflag = regTel.test(mobile);
			var mflag = regMobile.test(mobile);
			if (!(tflag||mflag)){
				$("#info").html("移动电话输入不合法");
				return false;
			}			
			if(!regDate.test($("[name='graduateDate']").val()))
			{
				$("#info").html("日期输入不合法,例: 2000-07-15");
				return false;
			}
			$.ajaxSetup({async: false});
			$.post("${pageContext.request.contextPath}/member/updateMember1.action",{"id":$("#id").val(),"uid":$("#uid").val(),"name":name,
				"company":$("[name='company']").val(),"mobile":mobile,"sex":$("#sex").text(),"school":$("[name='school']").val(),
				"graduateDate":$("[name='graduateDate']").val()},function(data){
					if(data==1)
						{
							layer.msg('保存成功',{
								icon:1,
								time:600,
								end: function(){
								       //location.href="${pageContext.request.contextPath}/personal/navbar.jsp";
							    }
							})
						}
					else{
						layer.msg('登录过期，请重新登录',{
							icon:0
						})
					}
			});
		});
	});
});
</script>
</head>
<body>
	<div class="main">
		${myuser.member.admin.realname } <input type="hidden" id="uid"
			value="${myuser.id}"> <input type="hidden" id="id"
			value="${myuser.member.id}">
		<table>
			<tr>
				<td width="500px;">
					<h1>会员信息</h1>
					<table class="table table-hover">
						<tr>
							<td>用户名:</td>
							<td>${myuser.name}</td>
						</tr>
						<tr>
							<td>真实姓名:</td>
							<td id="name">${myuser.member.name}</td>
						</tr>
						<tr>
							<td>性别:</td>
							<td id="sex">${myuser.member.sex}</td>
						</tr>
						<tr>
							<td>学校:</td>
							<td id="school">${myuser.member.school}</td>
						</tr>
						<tr>
							<td>工作单位:</td>
							<td id="company">${myuser.member.company}</td>
						</tr>
						<tr>
							<td>移动电话:</td>
							<td id="mobile">${myuser.member.mobile}</td>
						</tr>
						<tr>
							<td>是否毕业:</td>
							<td><c:if test="${myuser.member.student=='true'}">未毕业</c:if>
								<c:if test="${myuser.member.student=='false'}">已毕业</c:if></td>
						</tr>
						<tr>
							<td>毕业时间:</td>
							<td id="graduateDate"><fmt:formatDate
									value="${myuser.member.graduateDate}" pattern="yyyy-MM-dd" /></td>
						</tr>
						<tr>
							<td>注册时间:</td>
							<td id=""><fmt:formatDate value="${myuser.member.time}"
									pattern="yyyy-MM-dd" /></td>
						</tr>
						<tr class="assist"></tr>
					</table> <!-- 去掉编辑功能
		    <div class="controls" id="btn">  
                <input class="btn" type="button" value="编辑信息">
            </div>
 	 -->
					<div id="info" class="controls"></div>
				</td>
				<td>
					<div style="margin-left: 30px">
						<div id="imgdiv">
							<c:choose>
								<c:when test="${myuser.member.sex=='男'}">
									<a class="setcover"><img
										src="${pageContext.request.contextPath}/images/user_male.png"
										alt="用户头像" class="img"></a>
								</c:when>
								<c:otherwise>
									<a class="setcover"><img
										src="${pageContext.request.contextPath}/images/user_female.png"
										alt="用户头像" class="img"></a>
								</c:otherwise>
							</c:choose>
							<!--  	<br />
		<c:if test="${conut==0}"><a href="#" class="setcover"><img src="${pageContext.request.contextPath}/images/22.jpg" alt="用户上传图片" class="img" id="imageshow"></a></c:if>
		<c:if test="${conut!=0}"><img src="${pageContext.request.contextPath}/picture/getCover.action?id=${myuser.id}" class="img"  alt="用户上传图片"  id="imageshow"></c:if>
		-->
						</div>
						<div id="cnav" style="margin-top: 15px; margin-left: 100px;">
							<a class="setcover">设置头像</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<!-- <a href="#" id="uploading">图片上传</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="#" id="image">用户相册</a> -->
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>