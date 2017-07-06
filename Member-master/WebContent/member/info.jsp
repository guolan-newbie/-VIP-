<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>修改信息-Java互助学习VIP群业务运行系统</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico">
    <script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
	<script type="text/javascript">
	$(function(){
		if ($("#uid").val() == ""){
			uid = 0;
		}
		else{
			uid = $("#uid").val();
		}
		$.post("${pageContext.request.contextPath}/member/getFlag.action",{uid:uid},function(data){
			//设置省份
			$.post("${pageContext.request.contextPath}/member/getProvinces.action",function(data){
				showdata(data);
			});
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
			if($("#student").val()=="true"){
				$('input:radio[name=student]:nth(1)').attr('checked',true);
				$('input:radio[name=student]:nth(0)').attr('checked',false);
			}
			else if($("#student").val()=="false"){
				$('input:radio[name=student]:nth(0)').attr('checked',true);
				$('input:radio[name=student]:nth(1)').attr('checked',false);
			}
			//设置个graduateDate
			if($("#date").val()==""){
				$("[name='graduateDate']").val("2000-07-15");
			}
			if (data == "1"){
				$("[name='name']").attr("readonly",true);
				$("[name='school']").attr("readonly",true);
				$("[name='graduateDate']").attr("readonly",true);
				
				$(":radio").each(function(){
					if (!$(this).attr('checked')){
							$(this).attr("disabled",true);		
					}
				});
			}
			$("[type='submit']").click(function(){	
			
				$.ajaxSetup({
					  async: false
				});			
				var name=$.trim($("[name='member.name']").val());
				var mobile=$.trim($("[name='mobile']").val());
				var reg=/[\u4e00-\u9fa5]+/;
				var regTel=/^0[\d]{2,3}-[\d]{7,8}$/;
				var regMobile = /^0?1[3|4|5|8|7][0-9]\d{8}$/;
				if (name=="" || mobile==""){
					$("#info").html("真实姓名和移动电话不能为空");
					return false;
				}
				if (!reg.test(name)){
					$("#info").html("真实姓名输入不合法");
					return false;
				}
				var tflag = regTel.test(mobile);
				var mflag = regMobile.test(mobile);
				if (!(tflag||mflag)){
					$("#info").html("移动电话输入不合法");
					return false;
				}
				var val=$('input:radio[name="student"]:checked').val();
				if(val == "true"){
					var dt = new Date($("[name='graduateDate']").val());
					var d = new Date();
					d = new Date(d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate());
					var n = d.getTime() - dt.getTime();
					if (n>0){
						$("#info").html("未毕业，毕业时间必须大于等于当前时间");
						return false;
					}	
				}
				var tflag = regTel.test(mobile);
				var mflag = regMobile.test(mobile);
				if (!(tflag||mflag)){
					$("#info").html("移动电话输入不合法");
					return false;
				}
				
				var idNo=$.trim($("[name='idNo']").val());
				var qqNo=$.trim($("[name='qqNo']").val());
				var payAccount=$.trim($("[name='payAccount']").val());
				var contactName=$.trim($("[name='contactName']").val());
				var relation=$.trim($("[name='relation']").val());
				var contactMobile=$.trim($("[name='contactMobile']").val());
				var address=$.trim($("[name='address']").val());
			
				var reg = /(^\d{15}$)|(^\d{17}(\d|X)$)/; 
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
			});
		},"json");
		
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
	</script>
	
</head>
<body>


    	<input type="hidden" id="sex" value="${myuser.member.sex}">
		<input type="hidden" id="student" value="${myuser.member.student}">
		<input type="hidden" id="date" value="${myuser.member.graduateDate}">
		<input type="hidden" id="provid" value="${myuser.member.provid}">
        
<form class="main form-horizontal" method="post" action="${pageContext.request.contextPath}/member/add.action">
       	<input type="hidden" name="id" value="${myuser.member.id}">
		<input type="hidden" id="uid" value="${myuser.id}">
		
       	<legend class="controls">会员基本信息</legend>
        <div class="control-group">
            <label class="control-label">性别</label>
            <div class="controls">
                <label class="radio">
                    <input type="radio" value="男" name="sex" checked="checked">男
                </label>
                <label class="radio">
                    <input type="radio" value="女" name="sex">女
                </label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">真实姓名</label>
            <div class="controls">
                <input name="member.name" type="text" placeholder="必填项" class="input-xlarge" value="${myuser.member.name}" required>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">所在/毕业学校</label>
            <div class="controls">
                <input name="school" type="text" placeholder="必填项" class="input-xlarge" value="${myuser.member.school}" required>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">工作单位</label>
            <div class="controls">
                <input name="company" type="text" placeholder="非必填项" class="input-xlarge" value="${myuser.member.company}">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">移动电话</label>
            <div class="controls">
                <input name="mobile" type="text" placeholder="必填项" class="input-xlarge" value="${myuser.member.mobile}" required>
            </div>
        </div>
         <div class="control-group">
            <label class="control-label">所在省份</label>
            <div class="controls">
                <select class="input-xlarge" id="province" name="provid"></select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">是否毕业</label>
            <div class="controls">
                <label class="radio">
                    <input type="radio" value="false" name="student" checked="checked">已毕业
                </label>
                <label class="radio">
                    <input type="radio" value="true" name="student">未毕业
                </label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">毕业时间</label>
            <div class="controls">
                <input name="graduateDate" type="text" placeholder="必填项" class="input-xlarge" value="<fmt:formatDate value='${myuser.member.graduateDate}' type='date' pattern='yyyy-MM-dd'/>" required>
            </div>
        </div>
       	<c:if test="${!myuser.member.flag}"> 
	        <legend class="controls">会员信用信息</legend>
	        <div class="control-group">
	            <label class="control-label">身份证号</label>
	            <div class="controls">
	                <input name="idNo" type="text" placeholder="必填项，实名" class="input-xlarge" value="${myuser.userInfo.idNo}" required>
	            </div>
	        </div>
	        <div class="control-group">
	            <label class="control-label">常用QQ号码</label>
	            <div class="controls">
	                <input name="qqNo" type="text" placeholder="必填项" class="input-xlarge" value="${myuser.userInfo.qqNo}" required>
	            </div>
	        </div>
	        <div class="control-group">
	            <label class="control-label">支付宝账号</label>
	            <div class="controls">
	                <input name="payAccount" type="text" placeholder="必填项" class="input-xlarge" value="${myuser.userInfo.payAccount}" required>
	            </div>
	        </div>
	        <div class="control-group">
	            <label class="control-label">家庭联系人</label>
	            <div class="controls">
	                <input name="contactName" type="text" placeholder="必填项" class="input-xlarge" value="${myuser.userInfo.contactName}" required>
	            </div>
	        </div>
	        <div class="control-group">
	            <label class="control-label">与家庭联系人关系</label>
	            <div class="controls">
	                <input name="relation" type="text" placeholder="必填项" class="input-xlarge" value="${myuser.userInfo.relation}" required>
	            </div>
	        </div>
	        <div class="control-group">
	            <label class="control-label">家庭联系人手机</label>
	            <div class="controls">
	                <input name="contactMobile" type="text" placeholder="必填项" class="input-xlarge" value="${myuser.userInfo.contactMobile}" required>
	            </div>
	        </div>
	        <div class="control-group">
	            <label class="control-label">本人收件地址</label>
	            <div class="controls">
	                <input name="address" type="text" placeholder="必填项" class="input-xlarge" value="${myuser.userInfo.address}" required>
	            </div>
	        </div>
        </c:if>
        <div id="info" class="controls"></div>
        <div class="control-group">  
            <label class="control-label">  
            </label>  
            <div class="controls">  
                <button class="btn" type="submit" id="ok">确定</button>  
            </div>  
        </div>   
    </form>

</body>
</html>
