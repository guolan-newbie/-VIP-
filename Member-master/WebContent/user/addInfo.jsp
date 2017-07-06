<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">	
$(function(){
	var index = parent.layer.getFrameIndex(window.name);
	(function ($) {
	    $.getUrlParam = function (name) {
	        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
	        var r = window.location.search.substr(1).match(reg);
	        if (r != null) return unescape(r[2]); return null;
	    }
	})(jQuery);
	var root = $.getUrlParam('root');
	if(root == 2){
		$("[name='xyxx']").each(function(){
			$(this).hide();
		});
	}
	else{
		$("[name='grxx']").each(function(){
			$(this).hide();
		});
	}
	var flag=false;
	var msg="";
	//设置性别
	$("input:radio[name='sex']").click(function(){
		if($('input:radio[name="sex"]:eq(0)').is(":checked")==true){
			$("[name='sex']").val("男");
		}else{
			$("[name='sex']").val("女");
		}
	})	
	//验证真实姓名
	$("[name='name']").blur(function(){
		var name=$.trim($("[name='name']").val());
		var reg=/^[a-zA-Z\u4e00-\u9fa5\s]{1,20}$/;
		if (name==""){
			$("#msg").html("真实姓名不能为空!");
			msg="真实姓名不能为空!";
			return false;
		}
		else{
			if (!reg.test(name)){
				$("#msg").html("真实姓名输入不合法!");
				msg="真实姓名输入不合法!";
				return false;
			}
			$("#msg").html("");
			msg="";
			flag=true;
		}
	});
	//验证学校名称
	$("[name='school']").blur(function(){
		var reg=/^[a-zA-Z\u4e00-\u9fa5\s]{1,20}$/;
		var school=$.trim($("[name='school']").val());
		if (school==""){
			$("#msg").html("所在/毕业学校不能为空!");
			msg="所在/毕业学校不能为空!";
			return false;
		}
		else{
			if (!reg.test(school)){
				$("#msg").html("所在/毕业学校输入不合法!");
				msg="所在/毕业学校输入不合法!";
				return false;
			}
			$("#msg").html("");
			msg="";
			flag=true;
		}
	});
	//验证电话号码
	$("[name='phone']").blur(function(){
		var phone=$.trim($("[name='phone']").val());
		var regTel=/^0[\d]{2,3}-[\d]{7,8}$/;
		var regMobile = /^0?1[3|4|5|8|7][0-9]\d{8}$/;
		if (phone==""){
			$("#msg").html("移动电话不能为空!");
			msg="移动电话不能为空!";
			return false;
		}else{
			var tflag = regTel.test(phone);
			var mflag = regMobile.test(phone);
			if (!(tflag||mflag)){
				$("#msg").html("移动电话输入不合法!");
				msg="移动电话输入不合法!";
				return false;
			}
			$("#msg").html("");
			msg="";
			flag=true;
		}		
	});
	
	//验证身份证号码
	$("[name='idNo']").blur(function(){
		var idNo=$.trim($("[name='idNo']").val());			
		var reg = /(^\d{15}$)|(^\d{17}(\d|X)$)/; 
		if((idNo=="") || (!reg.test(idNo))){ 
			$("[name='creditInfo']").val(1);
			$("#msg").html("身份证号输入不合法!");
			return false;
		}
		else
		{
			$("#msg").html("");
			flag=true;
			//return true;
		}
	});
	//验证qq信息
	$("[name='qqNo']").blur(function(){
		var qqNo=$.trim($("[name='qqNo']").val());
	    var reg = /^[1-9]\d{4,9}$/;
		if((qqNo=="") || (!reg.test(qqNo))){ 
			$("[name='creditInfo']").val(1);
			$("#msg").html("常用qq号码输入不合法!");
			return false;
		}
		else
		{
			$("#msg").html("");
			flag=true;
			//return true;
		}
	});
	//验证支付宝号码
	$("[name='payAccount']").blur(function(){
		var payAccount=$.trim($("[name='payAccount']").val());
		var reg = /^0?\d{9,11}$/;
        var regemail = /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+(com|cn)$/;
        var tflag = reg.test(payAccount);
        var mflag = regemail.test(payAccount);
		if ((payAccount=="") ||(!(tflag||mflag))){
			$("[name='creditInfo']").val(1);
			$("#msg").html("支付宝账号输入不合法!");
			return false;
		}
		else
		{
			$("#msg").html("");
			flag=true;
			//return true;
		}
	});	
  //
 			$("[name='contactName']").blur(function(){
		var contactName=$.trim($("[name='contactName']").val());
		var reg = /[\u4e00-\u9fa5]+/;
		if((contactName=="") || (!reg.test(contactName))){ 
			$("[name='creditInfo']").val(1);
			$("#msg").html("家庭联系人输入不合法!");
			return false;
		}
		else
		{
			$("#msg").html("");
			flag=true;
			//return true;
		}
	});
	//验证与家庭联系人的关系
	$("[name='relation']").blur(function(){
		var relation=$.trim($("[name='relation']").val());
		var reg = /[\u4e00-\u9fa5]+/;
		if((relation=="") || (!reg.test(relation))){ 
			$("[name='creditInfo']").val(1);
			$("#msg").html("与家庭联系人关系输入不合法!");
			return false;
		}	
		else
		{
			$("#msg").html("");
			flag=true;
			//return true;
		}
	});
	//验证手机号码
	$("[name='contactMobile']").blur(function(){
		var contactMobile=$.trim($("[name='contactMobile']").val());
		var regTel=/^0[\d]{2,3}-[\d]{7,8}$/;
		var regMobile = /^0?1[3|4|5|8|7][0-9]\d{8}$/;
		var tflag = regTel.test(contactMobile);
		var mflag = regMobile.test(contactMobile);
		if ((contactMobile=="") ||(!(tflag||mflag))){
			$("[name='creditInfo']").val(1);
			$("#msg").html("家庭联系人手机输入不合法!");
			return false;
		}
		else
		{
			$("#msg").html("");
			flag=true;
			//return true;
		}
	});
	//验证本人收件地址	
	$("[name='address']").blur(function(){
		var address=$.trim($("[name='address']").val());
		if (address == ""){
			$("[name='creditInfo']").val(1);
			$("#msg").html("本人收件地址不能为空!");
			return false;
		}
		else
		{
			$("#msg").html("");
			flag=true;
		}
	});
	
	
	
	//设置省份
	$.post("${pageContext.request.contextPath}/member/getProvinces.action",function(data){
		showdata(data);
	});
	function showdata(data){
		var line="";
		for(i=0;i<data.length;i++){
			if ($("[name='province']").val() == data[i].id){
				line = line + "<option value="+data[i].id+" selected='selected'>";
			}
			else{
				line = line + "<option value="+data[i].id+">";
			}
			line = line + data[i].name;
			line = line + "</option>";
		}
		$("[name='province']").append(line);
	}
	//设置出生地
	$.post("${pageContext.request.contextPath}/member/getProvinces.action",function(data){
		showseatdata(data);
	});
	function showseatdata(data){
		var line="";
		for(i=0;i<data.length;i++){
			if ($("[name='seat_province']").val() == data[i].id){
				line = line + "<option value="+data[i].id+" selected='selected'>";
			}
			else{
				line = line + "<option value="+data[i].id+">";
			}
			line = line + data[i].name;
			line = line + "</option>";
		}
		$("[name='seat_province']").append(line);
	}
	//设置是否毕业
	$("input:radio[name='student']").click(function(){
		if($('input:radio[name="student"]:eq(0)').is(":checked")==true){
			$("[name='student']").val(false);
		}else{
			$("[name='student']").val(true);
		}
	})
	//给毕业时间设个初始值
	if($("[name='graduateDate']").val()==""){
		
		$("[name='graduateDate']").val("2000-07-15");
	}
	//检验毕业时间
	$("[name='student']").change(function(){
		checkGraduateDate();
	});
	$("[name='graduateDate']").blur(function(){
		checkGraduateDate();
	});
	function checkGraduateDate(){
		var regDate=/^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/; 
		if(!regDate.test($("[name='graduateDate']").val()))
		{
			$("#msg").html("日期输入不合法,例: 2000-07-15");
			msg="日期输入不合法,例: 2000-07-15";
			return false;
		}
		else
		{
			var mydate = new Date();
			var now=mydate.toLocaleDateString(); //获取当前日期
			var graduate = $("[name='graduateDate']").val();
            var graduateDate = new Date(graduate.replace("-", "/").replace("-", "/"));
            var today = new Date(now.replace("-", "/").replace("-", "/"));
            if($("input:radio[name='student']:checked").val()=="false"){//已毕业
            	if (graduateDate > today) {
                    $("#msg").html("已毕业，毕业时间不能大于今天!");
        			msg="已毕业，毕业时间不能大于今天!";
        			return false;
                }
            	$("#msg").html("");
    			msg="";
    			flag=true;
            }else{//未毕业
            	if (graduateDate < today) {
                    $("#msg").html("未毕业，毕业时间不能早于今天!");
        			msg="未毕业，毕业时间不能早于今天!";
        			return false;
                }
            	$("#msg").html("");
    			msg="";
    			flag=true;
            }
            
		}
	}
	$("#add").click(function(){	
		if(flag==false){			
			$("#msg").html("有资料未填写，或填写错误!!!");
			return false;
		}
		if(root == 2) {
			//将毕业时间转成Date类型
			//var graduateDate = new Date($("[name='graduateDate']").val().replace("-", "/").replace("-", "/"));
			$.ajaxSetup({async:false});
			$.post("${pageContext.request.contextPath}/member/addPersonal.action",{sex:$("[name='sex']").val(),name:$("[name='name']").val(),school:$("[name='school']").val(),company:$("[name='company']").val(),mobile:$("[name='phone']").val(),provid:$("[name='province']").val(),seat_provid:$("[name='seat_province']").val(),student:$("[name='student']").val(),graduateDate:$("[name='graduateDate']").val()},function(data){
				parent.location.href = "${pageContext.request.contextPath}/user/login.jsp";
			})
		} else {
			$.ajaxSetup({async:false});
			$.post("${pageContext.request.contextPath}/member/addCredit.action",{idNo:$("[name='idNo']").val(),qqNo:$("[name='qqNo']").val(),payAccount:$("[name='payAccount']").val(),contactName:$("[name='contactName']").val(),relation:$("[name='relation']").val(),contactMobile:$("[name='contactMobile']").val(),address:$("[name='address']").val()},function(){
				parent.location.href = "${pageContext.request.contextPath}/user/login.jsp";
			});
		}
	})
});
</script>
</head>
<body>
<div class="container">
	<div class="panel panel-default">
		<div class="panel-body">
			<form name="add">
			<table class="table table-hover">

				<tr name="grxx">
					<th>性别</th>
					<td>
						<input type="radio" value="男" name="sex" checked="checked">男 
						<input type="radio" value="女" name="sex" style="margin-left: 20px">女
					</td>
				</tr>
				<tr name="grxx">
					<th>真实姓名</th>
					<td>
						<input name="name" type="text" placeholder="必填项" style="width: 200px" class="form-control" required /> 
					</td>
				</tr>
				<tr name="grxx">
					<th>所在学校</th>
					<td>
						<input name="school" type="text" placeholder="必填项" style="width: 200px" class="form-control" required />
					</td>
				</tr>
				<tr name="grxx">
					<th>工作单位</th>
					<td>
						<input name="company" type="text" placeholder="非必填项" style="width: 200px" class="form-control" />
					</td>
				</tr>
				<tr name="grxx">
					<th>联系电话</th>
					<td>
						<input name="phone" type="text" placeholder="必填项" style="width: 200px" class="form-control" required />
					</td>
				</tr>
				<tr name="grxx">
					<th>所在省份</th>
					<td>
						<select name="province" class="form-control" style="width: 200px"></select>
					</td>
				</tr>
				
				<tr name="grxx">
					<th>出生地</th>
					<td>
						<select name="seat_province" class="form-control" style="width: 200px"></select>
					</td>
				</tr>
				
				<tr name="grxx">
					<th>是否毕业</th>
					<td>
						<input type="radio" value="false" name="student" checked="checked" >已毕业 
						<input type="radio" value="true" name="student">未毕业
					</td>
				</tr>
				<tr name="grxx">
					<th>毕业时间</th>
					<td>
						<input type="date" name="graduateDate" value="2000-07-15" placeholder="必填项" class="form-control" style="width: 200px" /> 
                    </td>
				</tr>
				
				<tr name="xyxx">
					<th>身份证号</th>
					<td><input id="idNo" name="idNo" type="text"
							placeholder="必填项,实名" class="form-control" required
							style="width: 200px" /></td>
				</tr>
				<tr name="xyxx">
					<th>常用QQ号码</th>
					<td><input id="qqNo" name="qqNo" type="text"
							placeholder="必填项" class="form-control" required
							style="width: 200px" /></td>
				</tr>
				<tr name="xyxx">
					<th>支付宝账号</th>
					<td><input id="payAccount" name="payAccount" type="text"
						placeholder="必填项" class="form-control" required
						style="width: 200px" /></td>
				</tr>
				<tr name="xyxx">
					<th>家庭联系人</th>
					<td><input id="contactNamw" name="contactName" type="text"
						placeholder="必填项" class="form-control" required
						style="width: 200px" /></td>
				</tr>
				<tr name="xyxx">
					<th>与家庭联系人关系</th>
					<td><input id="relation" name="relation" type="text"
						placeholder="必填项" class="form-control" required
						style="width: 200px" />
					<td>
				</tr>
				<tr name="xyxx">
					<th>家庭联系人手机</th>
					<td><input id="contactMobile" name="contactMobile"
						type="text" placeholder="必填项" class="form-control" required
						style="width: 200px" /></td>
				</tr>
				<tr name="xyxx">
					<th>本人收件地址</th>
					<td><input id="address" name="address" type="text"
						placeholder="必填项" class="form-control" required
						style="width: 200px" /></td>
				</tr>
				
				
				<tr>
					<td colspan="2">
						<div id="msg" style="color: red; font-weight: bold; font-size: 15px; " align="center"></div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div style="margin-left: 110px">
							<button type="button" class="btn btn-default" id="add">提交</button>
						</div>
					</td>
				</tr>
			</table>
			</form>
		</div>
	</div>

</div>
</body>
</html>