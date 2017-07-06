<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"  rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>		
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<style type="text/css">
.main{margin-left:5%;margin-right:5%;}
#info,#tip{font-size:16px;color:red;}
#info{margin-left:140px;}
.controls{float:left;}
</style>
<script type="text/javascript">
$(function(){
	getData();
})
//获取数据
function getData(){	
	$.post("${pageContext.request.contextPath}/userinfo/getUserInfoByUid.action",{uid:$("#uid").val()},function(data){
		var line="";
		line+="<tr>";
		line+="<td>身份证号:</td>";
		line+="<td id='idNo'>"+data.idNo+"</td>";
		line+="</tr>";
		line+="<tr>";
		line+="<td>常用qq号码:</td>";
		line+="<td id='qqNo'>"+data.qqNo+"</td>";
		line+="</tr>";
		line+="<tr>";
		line+="<td>支付宝账号:</td>";
		line+="<td  id='payAccount'>"+data.payAccount+"</td>";
		line+="</tr>";
		line+="<tr>";
		line+="<td>家庭联系人:</td>";
		line+="<td id='contactName'>"+data.contactName+"</td>";
		line+="</tr>";
		line+="<tr>";
		line+="<td>与家庭联系人关系:</td>";
		line+="<td id='relation'>"+data.relation+"</td>";
		line+="</tr>";
		line+="<tr>";
		line+="<td>家庭联系人手机:</td>";
		line+="<td id='contactMobile'>"+data.contactMobile+"</td>";
		line+="</tr>";
		line+="<tr>";
		line+="<td>本人收件地址:</td>";
		line+="<td id='address'>"+data.address+"</td>";
		line+="</tr>";
		$(".table-hover").html(line);
		btnclick(data);
	});		
}
//编辑资料
function btnclick(data){
	var idNo=data.idNo;
	var qqNo=data.qqNo;
	var payAccount=data.payAccount;
	var contactName=data.contactName;
	var relation=data.relation;
	var contactMobile=data.contactMobile;
	var address=data.address;
	$(".btn").click(function(){
		$("#idNo").html("<input type='text' placeholder='必填项，实名' value='"+idNo+"' name='idNo'>");
		$("#qqNo").html("<input type='text' placeholder='必填项' value='"+qqNo+"' name='qqNo'> ");
		$("#payAccount").html("<input type='text' placeholder='必填项' value='"+payAccount+"' name='payAccount'> ");
		$("#contactName").html("<input type='text' placeholder='必填项' value='"+contactName+"' name='contactName'> ");
		$("#relation").html("<input type='text' placeholder='必填项' value='"+relation+"' name='relation'> ");
		$("#contactMobile").html("<input type='text' placeholder='必填项' value='"+contactMobile+"' name='contactMobile'> ");
		$("#address").html("<input type='text' placeholder='必填项' value='"+address+"' name='address'> ");
		$("#btn").html("<input class='btn' type='button' value='保存信息' id='save'>");
		$("#save").click(function(){
			var idNo=$.trim($("[name='idNo']").val());
			var qqNo=$.trim($("[name='qqNo']").val());
			var payAccount=$.trim($("[name='payAccount']").val());
			var contactName=$.trim($("[name='contactName']").val());
			var relation=$.trim($("[name='relation']").val());
			var contactMobile=$.trim($("[name='contactMobile']").val());
			var address=$.trim($("[name='address']").val());
		
			var reg = /(^\d{15}$)|(^\d{17}(\d|X)$)/; 
			var regTel=/^0[\d]{2,3}-[\d]{7,8}$/;
			var regMobile = /^0?1[3|4|5|8|7][0-9]\d{8}$/;
			if((idNo=="") || (!reg.test(idNo))){ 
				$("#info").html("身份证号输入不合法");
				return false;
			}
			reg = /^[1-9]\d{4,9}$/;
			if((qqNo=="") || (!reg.test(qqNo))){ 
				$("#info").html("常用qq号码输入不合法");
				return false;
			}
			reg = /^0?\d{9,11}$/;
	        regemail = /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+(com|cn)$/;
	        var tflag = reg.test(payAccount);
	        var mflag = regemail.test(payAccount);
			if ((payAccount=="") ||(!(tflag||mflag))){
				$("#info").html("支付宝账号输入不合法");
				return false;
			}
			reg = /[\u4e00-\u9fa5]+/;
			if((contactName=="") || (!reg.test(contactName))){ 
				$("#info").html("家庭联系人输入不合法");
				return false;
			}
			if((relation=="") || (!reg.test(relation))){ 
				$("#info").html("与家庭联系人关系输入不合法");
				return false;
			}	
			tflag = regTel.test(contactMobile);
			mflag = regMobile.test(contactMobile);
			if ((contactMobile=="") ||(!(tflag||mflag))){
				$("#info").html("家庭联系人手机输入不合法");
				return false;
			}
			if (address == ""){
				$("#info").html("本人收件地址输入不合法");
				return false;
			}
			$.ajaxSetup({async: false});
			$.post("${pageContext.request.contextPath}/userinfo/updateUserInfo.action",{"uid":$("#uid").val(),"idNo":idNo,
				"qqNo":qqNo,"payAccount":payAccount,"contactName":contactName,"relation":relation,"contactMobile":contactMobile,
				"address":address},function(data){
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index);
			});
		});
	});

}
</script>
</head>
<body>
<div class="main">
<input type="hidden" id="uid" value="${param.uid}">
	<h1>${param.name}的信用信息</h1>
		<table class="table table-hover">
		</table>
        <div class="controls" id="btn">  
                <input class="btn" type="button" value="编辑信息">
            </div>  
		<div id="info" class="controls"></div>
</div>
</body>
</html>