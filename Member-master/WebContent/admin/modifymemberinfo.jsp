<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"  rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>		
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<style type="text/css">
.main{margin-left:5%;margin-right:5%;}
.controls{float:left;}
#info{margin-left:60px;color:red;font-size:16px;}
</style>
<script type="text/javascript">
$(function(){
	getData();
	//获取数据
	function getData(){	
		$.post("${pageContext.request.contextPath}/member/getMemberById.action",{id:$("#id").val()},function(data){
			var line="";
			line+="<tr>";
			line+="<td>用户名:</td>";
			line+="<td>"+data.user.name+"</td>";
			line+="</tr>";
			line+="<tr>";
			line+="<td>真实姓名:</td>";
			line+="<td id='name'>"+data.name+"</td>";
			line+="</tr>";
			line+="<tr>";
			line+="<td>性别:</td>";
			line+="<td id='sex'>"+data.sex+"</td>";
			line+="</tr>";
			line+="<tr>";
			line+="<td>学校:</td>";
			line+="<td id='school'>"+data.school+"</td>";
			line+="</tr>";
			line+="<tr>";
			line+="<td>工作单位:</td>";
			line+="<td id='company'>"+data.company+"</td>";
			line+="</tr>";
			line+="<tr>";
			line+="<td>移动电话:</td>";
			line+="<td id='mobile'>"+data.mobile+"</td>";
			line+="</tr>";
			line+="<tr>";
			line+="<td>是否毕业:</td>";
			var student;
			if(data.student==true){
				student="未毕业";
			}else{
				student="已毕业";
			}			
			line+="<td id='student'>"+student+"</td>";
			line+="</tr>";
			line+="<tr>";
			line+="<td>毕业时间:</td>";
			line+="<td id='graduateDate'>"+data.formatGraduateDate+"</td>";
			line+="</tr>";
			line+="<tr>";
			line+="<td>注册时间:</td>";
			line+="<td id=''>"+data.formatTime+"</td>";
			line+="</tr>";
			$(".table-hover").html(line);
			btnclick(data);
		});		
	}
	//编辑资料
	function btnclick(data){
		//再把data传进去，值获取不到 都是undefined
		var name=data.name;
		var school=data.school;
		var company=data.company;
		var mobile=data.mobile;
		var graduateDate=data.formatGraduateDate;
		var sexradio="";
		if(data.sex=="男"){
			sexradio="<input type='radio' value='男' name='sex' checked='checked'>男<input type='radio' value='女' name='sex' style='margin-left: 20px'>女";
		}else{
			sexradio="<input type='radio' value='男' name='sex'>男<input type='radio' value='女' name='sex' style='margin-left: 20px' checked='checked'>女";
		}
		var studentradio="";
		if(data.student==true){
			studentradio="<input type='radio' value='false' name='student'>已毕业 <input type='radio' value='true' name='student' checked='checked'>未毕业";
		}else{
			studentradio="<input type='radio' value='false' name='student' checked='checked'>已毕业 <input type='radio' value='true' name='student'>未毕业";
		}
		$(".btn").click(function(){
			$("#name").html("<input type='text' placeholder='必填项' value='"+name+"' name='name' >");
			$("#sex").html(sexradio);
			$("#school").html("<input type='text' placeholder='必填项' value='"+school+"' name='school' >");
			$("#company").html("<input type='text' placeholder='必填项' value='"+company+"' name='company'> ");
			$("#mobile").html("<input type='text' placeholder='必填项' value='"+mobile+"' name='mobile'> ");
			$("#student").html(studentradio);
			$("#graduateDate").html("<input type='text' placeholder='必填项' value='"+graduateDate+"' name='graduateDate'> ");
			$("#btn").html("<input class='btn' type='button' value='保存信息' id='save'>");
			$("#save").click(function(){
				var name=$.trim($("[name='name']").val());
				var mobile=$.trim($("[name='mobile']").val());
				var school=$.trim($("[name='school']").val());
				var reg=/[\u4e00-\u9fa5]+/;
				var regTel=/^0[\d]{2,3}-[\d]{7,8}$/;
				var regMobile = /^0?1[3|4|5|8|7][0-9]\d{8}$/;				
				var regDate=/^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/; 
				if (name==""){
					$("#info").html("真实姓名不能为空");
					return false;
				}
				if (mobile==""){
					$("#info").html("移动电话不能为空");
					return false;
				}
				if (school==""){
					$("#info").html("学校不能为空");
					return false;
				}
				var tflag = regTel.test(mobile);
				var mflag = regMobile.test(mobile);
				if (!(tflag||mflag)){
					$("#info").html("移动电话输入不合法");
					return false;
				}							
				$("[name='sex']").val($('input:radio[name="sex"]:checked').val());
				if(!regDate.test($("[name='graduateDate']").val()))
				{
					$("#info").html("日期输入不合法,例: 2000-07-15");
					return false;
				}
				//判断毕业时间与是否毕业的正确性
				var graduateDate=$("[name='graduateDate']").val();
				var arr = graduateDate.split(/[- :]/);
				var foday = new Date(arr[0], arr[1]-1, arr[2]); 
				var d = new Date;
				var today = new Date(d.getFullYear (), d.getMonth (), d.getDate ());
				var chgraduateDates= $("input:radio[name='student']:checked").val()	
				if(chgraduateDates == "true")
				{				
					if (foday < today)
					{					
						$("#info").html("如果未毕业，毕业时间必须大于等于当前时间!!");
						 return false;
					}
				}else
				{					
					if (foday > today)
					{						
						$("#info").html("如果已毕业,毕业时间必须小于当前时间!!");
						 return false;
					}
				}
				$.ajaxSetup({async: false});
				$.post("${pageContext.request.contextPath}/member/updateMemberByadmin.action",{"id":$("#id").val(),"uid":$("#uid").val(),"name":name,
					"company":$("[name='company']").val(),"mobile":mobile,"sex":$("[name='sex']").val(),"school":school,
					student:chgraduateDates,
					"graduateDate":$("[name='graduateDate']").val()},function(data){
						var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
						parent.layer.close(index);
				});
			});
		});
	}
});
</script>
</head>
<body>
<div class="main">
<input type="hidden" id="id" value="${param.id}">
<input type="hidden" id="uid" value="${param.uid}">
	<h1>${param.name}的会员信息</h1>
	<table class="table table-hover">	
	</table>	
    <div class="controls" id="btn">  
        <input class="btn" type="button" value="编辑信息">
    </div>
	<div id="info" class="controls"></div>
</div>
</body>
</html>