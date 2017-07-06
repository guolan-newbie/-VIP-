<%@ page language="java" contentType="text/html; UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; UTF-8">
<title>注册用户-Java互助学习VIP群业务运行系统</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"
	rel="stylesheet">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script
	src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bootstrap/js/bootstrap-datetimepicker.js"
	charset="UTF-8"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bootstrap/js/locales/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<script type="text/javascript">
//提交信息
//function submitFrom(path){		
//		$('#form1')[0].action=path;
//		$('#form1')[0].submit();
//	}
		
$(function(){



//验证输入信息：：
//验证用户名
var userName=0;
var passWord=0;
$("[name='user.name']").blur(function(){
				var name=$.trim($("[name='user.name']").val());
				if(name=="")
				{
					$("#msg1").html("用户名不能为空!");
					 userName=0;
					 return;
				}
				else
				{
					$("#msg1").html("");
					 userName=2;
					
				}
				var regemail=/^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*(;\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*$/;
				if (!regemail.test(name)){
					var patrn=/^\d+$/;
					if (!patrn.test(name)){
						$("[name='accountInfo']").val(1);
						$("#msg1").html("用户名必须是会员号!");
						 userName=0;
						 return;
					}
					else
					{
						$("#msg1").html("");
						 userName=2;
						
					}
				}
				$.post("${pageContext.request.contextPath}/user/checkExists.action",
						{"name":$(this).val()},function(data){
					//用户名已经存在返回:1,不存在返回:0
					$("[name='accountInfo']").val(data);
					if(data=="1")
					{
						$("#msg1").html("用户名已注册,请重新输入!");
						 userName=0;
						 return;
						 
					}
					else
					{
						$("#msg1").html("");
						 userName=2;
						 	 
					}
				});
			});	
//验证密码
$("[name='pwd']").blur(function(){
				var pwd=$.trim($("[name='pwd']").val());
				if(pwd==""){
					$("#msg1").html("密码不能为空!");
					 passWord=0;
					 return;
				}
				else
				{
					 passWord=2;
					 
				}
				$("[name='pwd1']").blur(function(){
					var pwd1=$.trim($("[name='pwd1']").val());
					if(pwd!=pwd1){
						$("[name='accountInfo']").val(1);
						$("#msg1").html("两次输入的密码不一致!");
						 passWord=0;
						 return;
					}
					else
					{
						$("#msg1").html("");
						passWord=2;
						
					}
				})
			});
			//检查用户名并提交用户名和密码的信息。
	 $("#addForm").click(function(){
		 if(userName==2 && passWord==2){
		 		
				$.post("${pageContext.request.contextPath}/member/addUser.action",{"name":$("[name='user.name']").val(),"pwd":$("[name='pwd']").val()},function(data){
						if(data=="1")
						{
							 $("#msg1").html("此页信息已提交,请勿重复操作！"); 
							return;
						}
					});
					$('#myTab li:eq(1) a').tab('show');
		 }
		 else
		 {
			 if(userName==0)
			 {
				 $("#msg1").html("用户名输入有误，请重新输入");
				 return;
				 } 
			 if(passWord==0)
			 {
				 $("#msg1").html("密码输入有误，请重新输入");
				 return;
			 } 
			 	 }
		 });
//验证真实姓名
var realName=0;
var mmobile=0;
var mgraduateDate=2;
			$("[name='member.name']").blur(function(){
				var name=$.trim($("[name='member.name']").val());
				var reg=/[\u4e00-\u9fa5]+/;
				if (name==""){
					$("#msg2").html("真实姓名不能为空!");
					 realName=0;
				}
				else{ realName=2;}
				if (!reg.test(name)){
					$("[name='personalInfo']").val(1);
					$("#msg2").html("真实姓名输入不合法!");
					 realName=0;
				}
				else
				{
					realName=2;
					$("#msg2").html("");
				}
			});
//验证电话号码
				$("[name='mobile']").blur(function(){
				var mobile=$.trim($("[name='mobile']").val());
				var regTel=/^0[\d]{2,3}-[\d]{7,8}$/;
				var regMobile = /^0?1[3|4|5|8|7][0-9]\d{8}$/;
				if (mobile==""){
					$("#msg2").html("移动电话不能为空!");
					 mmobile=0;
				}
				var tflag = regTel.test(mobile);
				var mflag = regMobile.test(mobile);
				if (!(tflag||mflag)){
					$("[name='personalInfo']").val(1);
					$("#msg2").html("移动电话输入不合法");
					 mmobile=0;
				}
				else
				{
					mmobile=2;
					$("#msg2").html("");				 
				}
			});
			//设置省份
			$.post("${pageContext.request.contextPath}/member/getProvinces.action",function(data){
				showdata(data);
			});
			function showdata(data){
				var line="";
				for(i=0;i<data.length;i++){
					if ($("#provid").val() == data[i].id){
						line = line + "<option value="+data[i].id+" selected='selected'>";
					}
					else{
						line = line + "<option value="+data[i].id+">";
					}
					line = line + data[i].name;
					line = line + "</option>";
				}
				$("#province").append(line);
			}
			//设置出生地
			$.post("${pageContext.request.contextPath}/member/getProvinces.action",function(data){
				showseatdata(data);
			});
			function showseatdata(data){
				var line="";
				for(i=0;i<data.length;i++){
					if ($("#seat_provid").val() == data[i].id){
						line = line + "<option value="+data[i].id+" selected='selected'>";
					}
					else{
						line = line + "<option value="+data[i].id+">";
					}
					line = line + data[i].name;
					line = line + "</option>";
				}
				$("#seat_province").append(line);
			}
						//设置性别
			if($("#sex").val()=="男"){
				$('input:radio[name=sex]:nth(0)').attr('checked',true);
				$('input:radio[name=sex]:nth(1)').attr('checked',false);
			}
			else if ($("#sex").val()=="女"){
				$('input:radio[name=sex]:nth(1)').attr('checked',true);
				$('input:radio[name=sex]:nth(0)').attr('checked',false);
			}
			//设置是否学生
		//	if($("#student").val()=="true"){
		//		$('input:radio[name=student]:nth(1)').attr('checked',true);
		//		$('input:radio[name=student]:nth(0)').attr('checked',false);
		//	}
		//	else if($("#student").val()=="false"){
		//		$('input:radio[name=student]:nth(0)').attr('checked',true);
		//		$('input:radio[name=student]:nth(1)').attr('checked',false);
		//	}
			//id没值则将其设置为0
			if($("[name='id']").val()==""){
				$("[name='id']").val("0");
			}
			//给毕业时间设个初始值
			if($("[name='graduateDate']").val()==""){
				
				$("[name='graduateDate']").val("2000-07-15");
			}
		$("input:radio[name='student']").click(function(){
			mgraduateDate=0;
			var pdate = document.getElementById ("graduateDate");
			var d = new Date;
			var today = new Date(d.getFullYear (), d.getMonth (), d.getDate ());
			var reg = /\d+/g;
			var temp = pdate.value.match (reg);
			var foday = new Date (temp[0], parseInt (temp[1]) - 1, temp[2]);
			var chgraduateDates= $("input:radio[name='student']:checked").val()	
			if(chgraduateDates == "true")
			{
				
				if (foday < today)
				{
					
					$("#msg2").html("未毕业,毕业时间必须大于等于当前时间!!");
					 mgraduateDate=0;
					 return;
					//时间小于现在的时间，已经毕业。等于false
				}
				else
				{
					 mgraduateDate=2;
					 $("#msg2").html("");
				}
			}
			if(chgraduateDates=="false")
			{
				
				if (foday > today)
				{
					
					$("#msg2").html("已毕业,毕业时间必小于当前时间!!");
					 mgraduateDate=0;
					 return;
					//时间大于现在的时间，已经毕业。等于false
				}
				else
				{
					 mgraduateDate=2;
					 $("#msg2").html("");
				}
			}
	
		})

				
			$("[name='graduateDate']").blur(function(){
	
			mgraduateDate=0;
				var regDate=/^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/; 
				if(!regDate.test($("[name='graduateDate']").val()))
				{
					$("[name='personalInfo']").val(1);
					$("#msg2").html("日期输入不合法,例: 2000-07-15");
					 mgraduateDate=0;
					 return;
				}
				else
				{
					mgraduateDate=2;
					$("#msg2").html("");
				}
				mgraduateDate=0;
				var pdate = document.getElementById ("graduateDate");
				var d = new Date;
				var today = new Date(d.getFullYear (), d.getMonth (), d.getDate ());
				var reg = /\d+/g;
				var temp = pdate.value.match (reg);
				var foday = new Date (temp[0], parseInt (temp[1]) - 1, temp[2]);	
				var chgraduateDates= $("input:radio[name='student']:checked").val()
			if(chgraduateDates == "true"){	
				 if (foday < today)
					{
						
						$("#msg2").html("未毕业,毕业时间必须大于等于当前时间!");
						 mgraduateDate=0;
						 return;
						
						//时间小于现在的时间，已经毕业。等于false
					}
				else
					{
						mgraduateDate=2;
						$("#msg2").html("");
						return;
					}
			}
			
			if(chgraduateDates=="false")
			{

				if (foday > today)
				{
					
					$("#msg2").html("已毕业,毕业时间必须小于当前时间!!");
					 mgraduateDate=0;
					 return;
					//时间大于现在的时间，已经毕业。等于false
				}
				else
				{
					 mgraduateDate=2;
					 $("#msg2").html("");
				}
			}
			
			});
			

		//检查用户个人信息并与导航条一致
		$("#addMember").click(function(){	
			//判读session是否过期。
			$.post("${pageContext.request.contextPath}/user/checkUserSession.action",function(datas){
				var returnMap = eval("(" + datas + ")").returnMap;
				var statusCode = returnMap.statusCode;
				if (statusCode.errNum != 100) {
					layer.msg("<strong style='color:red;'>" + statusCode.errMsg + "</strong>", {icon : 2});
					$("#msg2").html("由于网络原因或在此页面注册时间过长，信息已失效，请您重新填写");
					return ;
				}
				//正式开始处理数据
					if(mgraduateDate==2 && realName==2 && mmobile==2 ){
				$.post("${pageContext.request.contextPath}/member/addMember.action",{"name":$("[name='user.name']").val(),"pwd":$("[name='pwd']").val(),"name":$("[name='member.name']").val(),"sex":$("input:radio[name='sex']:checked").val(),"school":$("[name='school']").val(),"company":$("[name='company']").val(),"mobile":$("[name='mobile']").val(),"student":$("input:radio[name='student']:checked").val(),"graduateDate":$("[name='graduateDate']").val(),"provid":$("[name='provid']").val(),"seat_provid":$("[name='seat_provid']").val()},function(data){
					});
					 $('#myTab li:eq(2) a').tab('show');
					 }
					 else
					 {
						 if(mgraduateDate==0)
						 {
							 $("#msg2").html("毕业时间填写有误，请重新输入");
							 return;
							 
						 }
						 if(realName==0)
						 {
							 
							$("#msg2").html("真实姓名填写有误，请重新输入"); 
							return;
						 }
						 if(mmobile==0)
						 {
							 $("#msg2").html("电话号码填写有误，请重新输入");
							 return;
							 }
						else{
						 $("#msg2").html("由于网络问题，需要您请重新填写此页面的信息"); 
						 return;
						 }
					}
			});
		});	
		$("#next1").click(function(){
			$('#myTab li:eq(1) a').tab('show');
		})
		$("#next2").click(function(){
			$('#myTab li:eq(2) a').tab('show');
		})
});
$(function(){	 
			//验证身份证号码
			$("[name='idNo']").blur(function(){
				var idNo=$.trim($("[name='idNo']").val());			
				var reg = /(^\d{15}$)|(^\d{17}(\d|X)$)/; 
				if((idNo=="") || (!reg.test(idNo))){ 
					$("[name='creditInfo']").val(1);
					$("#msg3").html("身份证号输入不合法!");
					return false;
				}
				else
				{
					$("#msg3").html("");
					return true;
				}
			});
			//验证qq信息
			$("[name='qqNo']").blur(function(){
				var qqNo=$.trim($("[name='qqNo']").val());
			    var reg = /^[1-9]\d{4,9}$/;
				if((qqNo=="") || (!reg.test(qqNo))){ 
					$("[name='creditInfo']").val(1);
					$("#msg3").html("常用qq号码输入不合法!");
					return false;
				}
				else
				{
					$("#msg3").html("");
					return true;
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
					$("#msg3").html("支付宝账号输入不合法!");
					return false;
				}
				else
				{
					$("#msg3").html("");
					return true;
				}
			});	
		  //
		 			$("[name='contactName']").blur(function(){
				var contactName=$.trim($("[name='contactName']").val());
				var reg = /[\u4e00-\u9fa5]+/;
				if((contactName=="") || (!reg.test(contactName))){ 
					$("[name='creditInfo']").val(1);
					$("#msg3").html("家庭联系人输入不合法!");
					return false;
				}
				else
				{
					$("#msg3").html("");
					return true;
				}
			});
			//验证与家庭联系人的关系
			$("[name='relation']").blur(function(){
				var relation=$.trim($("[name='relation']").val());
				var reg = /[\u4e00-\u9fa5]+/;
				if((relation=="") || (!reg.test(relation))){ 
					$("[name='creditInfo']").val(1);
					$("#msg3").html("与家庭联系人关系输入不合法!");
					return false;
				}	
				else
				{
					$("#msg3").html("");
					return true;
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
					$("#msg3").html("家庭联系人手机输入不合法!");
					return false;
				}
				else
				{
					$("#msg3").html("");
					return true;
				}
			});
			//验证本人收件地址	
			$("[name='address']").blur(function(){
				var address=$.trim($("[name='address']").val());
				if (address == ""){
					$("[name='creditInfo']").val(1);
					$("#msg3").html("本人收件地址不能为空!");
					return false;
				}
				else
				{
					$("#msg3").html("");
					
				}
			});
			//加载日历包
			$('.form_date').datetimepicker({
				language: 'zh-CN',/*加载日历语言包，可自定义*/
				weekStart: 1,
				todayBtn: 1,
				autoclose: 1,
				todayHighlight: 1,
				startView: 2,
				minView: 2,
				forceParse: 0
			});
			
})		

	
	//	$(function(){
			
	//		$("[type='submit']").click(function(){	
				
				//$.ajaxSetup({
				//	  async: false
				//});
												
				//如果测试的时候嫌麻烦，就把注释去掉
				//if(false){
		//		if(($("[name='accountInfo']").val()=="0" && $("[name='personalInfo']").val()=="0" && $("[name='creditInfo']").val()=="0" ))
	//			{
	//				return true;
	//			}

	//		});
	//	},"json");

//}
function onJump(){
	if(confirm("当您的账号信息通过审核，才有权限浏览全部信息，如果信息填写不全,将不会通过审核，影响您的体验，请谨慎选择是否要跳过"))
	 {
			window.location.href="${pageContext.request.contextPath}/member/navbar1.jsp"; 
	 }

	
	}

		$(function(){ $("[data-toggle='tooltip']").tooltip(); });

		</script>
</head>
<body style="background-color: #CCF">
	<div class="center-block"
		style="width: 550px; margin-top: 50px; background-color: #FFF;">
		<div class="panel panel-success">
			<div class="panel-heading">
				<h1 class="panel-title">
					<ul id="myTab" class="nav nav-tabs">
						<li class="active"><a href="#steps1" data-toggle="tab">
								注册账号 </a></li>
						<li><a href="#steps2" data-toggle="tab">个人信息</a></li>
						<li><a href="#steps3" data-toggle="tab">信用信息</a></li>
						<li class="dropdown"><a href="#" id="myTabDrop1"
							class="dropdown-toggle" data-toggle="dropdown">返回 <b
								class="caret"></b>
						</a>
							<ul class="dropdown-menu" role="menu"
								aria-labelledby="myTabDrop1">
								<li><a href="${pageContext.request.contextPath}/index.jsp">首页</a></li>
								<li><a href="${pageContext.request.contextPath}/user/login.jsp">登录</a></li>
							</ul></li>
					</ul>
				</h1>
			</div>
		</div>
		<form id="form1" name="form1" action="${pageContext.request.contextPath}/member/add.action" method="post">
			<div id="myTabContent" class="tab-content">
				<div class="tab-pane fade in active" id="steps1"
					style="margin-top: 0px">
					<div class="well well-lg,
   text-center">注册信息</div>

					<div class="panel panel-default">
						<div class="panel-body">
						<c:if test="${sessionScope.myuser==null}">
								<table class="table table-hover">
									<tr>
										<th>用户名</th>
										<td><input id="user.name" name="user.name"
											placeholder="填写会员号" style="width: 200px" type="text"
											class="form-control" value="${myuser.name}" /></td>
									</tr>
									<tr>
										<th>密码</th>
										<td><input id="pwd" name="pwd" type="password"
											class="form-control" style="width: 200px" AUTOCOMPLETE=OFF
											placeholder="必填" value="${myuser.pwd}" /></td>
									</tr>
									<tr>
										<th>重复密码</th>
										<td><input name="pwd1" type="password" AUTOCOMPLETE=OFF
											style="width: 200px"  class="form-control" placeholder="必填" value="${myuser.pwd}" /></td>
									</tr>
									<tr>
								</table>
								<input type="hidden" name="accountInfo" value="0" />
								<hr />
								<div id="msg1"
									style="color: red; font-weight: bold; font-size: 15px;" align="center"></div>
								<div align="center">
								<button type="button" class="btn btn-default" id="addForm">
									<a href="#steps2" data-toggle="tab"  >下一页</a>
									</button>
								</div>
							</c:if>
							<c:if test="${sessionScope.myuser!=null}">
							<table class="table table-hover">
							<tr>
								<td>用户名:</td>
								<td>${myuser.name}</td>
							</tr>
							<tr>
								<td>密码:</td>
								<td>******</td>
							</tr>
							<tr>
								<td style="color:#F00;">此页信息已注册</td>
								<td>请填写下一页个人信息：<button type="button" class="btn btn-default" id="next1">
								<a href="#" data-toggle="tab">下一页</a>
								</button>
						    	</td>
							</tr>
							</table>
							</c:if>
						</div>
					</div>
				</div>



				<div class="tab-pane fade" id="steps2">
					<span class="label label-info">温馨提醒：个人信息可以跳过，但跳过将不会通过审核，部分功能会不能使用哦！</span>
					<p>
					<div class="well well-lg,
   text-center">个人信息</div>
					</p>

					<div class="panel panel-default">
						<div class="panel-body">
						<c:if test="${sessionScope.myuser.member.mobile==null}">
							<table class="table table-hover">
								<tr>
									<th>性别</th>
									<td><input type="radio" value="男" name="sex"
										checked="checked">男 <input type="radio" value="女"
										name="sex" style="margin-left: 20px">女</td>
								</tr>
								<tr>
									<th>真实姓名</th>
									<td><input id="member.name" name="member.name" type="text"
										placeholder="必填项" style="width: 200px" class="form-control"
										required /> </td>
								</tr>
								<tr>
									<th>所在/毕业学校</th>
									<td><input id="school" name="school" type="text"
										placeholder="必填项" style="width: 200px" class="form-control"
										required /></td>
								</tr>
								<tr>
									<th>工作单位</th>
									<td><input id="company" name="company" type="text"
										placeholder="非必填项" style="width: 200px" class="form-control" /></td>
								</tr>
								<tr>
									<th>移动电话</th>
									<td><input id="mobile" name="mobile" placeholder="必填项"
										type="text" class="form-control" required style="width: 200px" />
									<td>
								</tr>
								<tr>
									<th>所在省份</th>
									<td><select id="province" name="provid"
										class="form-control" style="width: 200px"></select></td>
								</tr>
								<tr>
									<th>出生地</th>
									<td><select id="seat_province" name="seat_provid"
										class="form-control" style="width: 200px"></select></td>
								</tr>
								<tr>
									<th>是否毕业</th>
									<td><input type="radio" value="false" name="student" 
										checked="checked" >已毕业 <input type="radio" value="true" 
										name="student" onClick="stu">未毕业</td>
								</tr>
								<tr>
									<th>毕业时间</th>
									<td><input type="date" id="graduateDate" name="graduateDate"
        value="2000-07-15" onchange="chkDate()" placeholder="必填项" class="form-control" style="width: 200px" /> 
                                </td>
								</tr>
								<tr>
									<td colspan="2"> 
										<div id="msg2"
											style="color: red; font-weight: bold; font-size: 15px;"  align="center"></div></td>
								</tr>
								<tr>
									<td>
									<div style="margin-left: 225px">
											<button type="button" class="btn btn-default" id="addMember">
												<a href="#" data-toggle="tab">下一页</a>
											</button>
											</div>
									</td>
									<td>
										<div style="margin-left: 160px">
										      <a style="color:#F00" href="javascript:;" onclick="onJump()" >跳过</a>
										</div>
									</td>
								</tr>
							</table>
							</c:if>
							<c:if test="${sessionScope.myuser.member.mobile!=null}">
						<table class="table table-hover">
							<tr>
								<td>用户名:</td>
								<td>${myuser.name}</td>
							</tr>
							<tr>
								<td>真实姓名:</td>
								<td>${myuser.member.name}</td>
							</tr>
							<tr>
								<td>性别:</td>
								<td>${myuser.member.sex}</td>
							</tr>
							<tr>
								<td>学校:</td>
								<td>${myuser.member.school}</td>
							</tr>
							<tr>
								<td>公司:</td>
								<td>${myuser.member.company}</td>
							</tr>
							<tr>
								<td>移动电话:</td>
								<td>${myuser.member.mobile}</td>
							</tr>
							<tr>
								<td>是否毕业:</td>
								<td><c:if test="${myuser.member.student=='true'}">未毕业</c:if>
									<c:if test="${myuser.member.student=='false'}">已毕业</c:if></td>
							</tr>
							<tr>
								<td>毕业时间:</td>
								<td><fmt:formatDate value="${myuser.member.graduateDate}"
										pattern="yyyy年MM月" /></td>
							</tr>
							<tr>
								<td style="color:#F00;">此页信息已注册</td>
								<td>请填写下一页个人信息：<button type="button" class="btn btn-default" id="next2">
								<a href="#" data-toggle="tab">下一页</a>
								</button>
						    	</td>
							</tr>
						</table>
							</c:if>
						</div>
					</div>

				</div>

				<div class="tab-pane fade" id="steps3">
					<span class="label label-info">温馨提醒：信用信息可以跳过，但跳过将不会通过审核，部分功能会不能使用哦！</span>
					<p></p>
					<div class="well well-lg,
   text-center">信用信息</div>
					<div class="panel panel-default">
						<div class="panel-body">
					<c:if test="${sessionScope.myuser.userInfo.idNo!=null}">
					
						<div  align="left" style="background-color:#FFF" >
						   <div class="jumbotron" align="left" style="background-color:#CCF" >
						      <h1 align="center" style="color:#F00" >恭喜您</h1>
						      <p align="center" >您的个人信息已经填写完整，请耐心等待审核</p>
						      <p align="center"><a class="btn btn-primary btn-lg" role="button" href="${pageContext.request.contextPath}/member/navbar1.jsp">
 
						         返回登录</a>
						      </p>
						   </div>
						</div>
						
					</c:if>
	<c:if test="${sessionScope.myuser.userInfo.idNo==null}">
							<table class="table table-hover">
								<tr>
									<th>身份证号</th>
									<td><input id="idNo" name="idNo" type="text"
										placeholder="必填项,实名" class="form-control" required
										style="width: 200px" /></td>
								</tr>
								<tr>
									<th>常用QQ号码</th>
									<td><input id="qqNo" name="qqNo" type="text"
										placeholder="必填项" class="form-control" required
										style="width: 200px" /></td>
								</tr>
								<tr>
									<th>支付宝账号</th>
									<td><input id="payAccount" name="payAccount" type="text"
										placeholder="必填项" class="form-control" required
										style="width: 200px" /></td>
								</tr>
								<tr>
									<th>家庭联系人</th>
									<td><input id="contactNamw" name="contactName" type="text"
										placeholder="必填项" class="form-control" required
										style="width: 200px" /></td>
								</tr>
								<tr>
									<th>与家庭联系人关系</th>
									<td><input id="relation" name="relation" type="text"
										placeholder="必填项" class="form-control" required
										style="width: 200px" />
									<td>
								</tr>
								<tr>
									<th>家庭联系人手机</th>
									<td><input id="contactMobile" name="contactMobile"
										type="text" placeholder="必填项" class="form-control" required
										style="width: 200px" /></td>
								</tr>
								<tr>
									<th>本人收件地址</th>
									<td><input id="address" name="address" type="text"
										placeholder="必填项" class="form-control" required
										style="width: 200px" /></td>
								</tr>

								<tr>
									<td colspan="2"><input type="hidden" name="pensonalInfo" value="0" />
										<div id="msg3"
											style="color: red; font-weight: bold; font-size: 15px; " align="center"></div></td>
								</tr>
                                <tr>
                                <td>	
                                	<div style="margin-left:225px">
								<input type="submit" class="btn btn-default" value="完成" />
							</div></td><td>		<div style="margin-left:160px">	
                            <a style="color:#F00" href="javascript:;" onclick="onJump()" >跳过</a>
							</div></td>
                                </tr>
							</table>
							</c:if>

			</div>
			</div>
			</div>
		</form>
	</div>


</body>
</html>
