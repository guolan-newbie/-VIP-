<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">		
$(function(){
    /** 
     * 时间对象的格式化; 
     */  
    Date.prototype.format = function(format) {  
        /* 
         * eg:format="yyyy-MM-dd hh:mm:ss"; 
         */  
        var o = {  
            "M+" : this.getMonth() + 1, // month  
            "d+" : this.getDate(), // day  
            "h+" : this.getHours(), // hour  
            "m+" : this.getMinutes(), // minute  
            "s+" : this.getSeconds(), // second  
            "q+" : Math.floor((this.getMonth() + 3) / 3), // quarter  
            "S" : this.getMilliseconds()  
            // millisecond  
        }  
      
        if (/(y+)/.test(format)) {  
            format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4  
                            - RegExp.$1.length));  
        }  
      
        for (var k in o) {  
            if (new RegExp("(" + k + ")").test(format)) {  
                format = format.replace(RegExp.$1, RegExp.$1.length == 1  
                                ? o[k]  
                                : ("00" + o[k]).substr(("" + o[k]).length));  
            }  
        }  
        return format;  
    }  
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
	//获取数据并初始化表单
	var id=$("[name='id']").val();
	$.post("${pageContext.request.contextPath}/experience/getExperienceById.action",{id:id},function(data){
		$("[name='num']").val(data.num);
		$("[name='sex']").val(data.sex);
		if(data.sex=="男"){
			$("input[name='sex']:eq(0)").attr("checked",'checked');
		}else{
			$("input[name='sex']:eq(1)").attr("checked",'checked');
		}
		$("[name='name']").val(data.name);
		$("[name='school']").val(data.school);
		$("[name='company']").val(data.company);
		$("[name='phone']").val(data.phone);
		$("[name='province']").val(data.province);
		$("[name='student']").val(data.student);
		if(data.student==false){
			$("input[name='student']:eq(0)").attr("checked",'checked');
		}else{
			$("input[name='student']:eq(1)").attr("checked",'checked');
		}
		var date=new Date(data.graduateDate)
		$("[name='graduateDate']").val(date.format("yyyy-MM-dd"));		
	})
	
	
	
	
	
	
	
	var flag=false;
	var msg="";
	//验证用户名
	$("[name='num']").blur(function(){
		var num=$.trim($("[name='num']").val());
		if(num=="")
		{
			$("#msg").html("用户名不能为空!");
			msg="用户名不能为空!";	
			return false;
		}
		else
		{
			$.post("${pageContext.request.contextPath}/experience/checkExists.action",{"num":$(this).val()},function(data){
				//用户名已经存在返回:1,不存在返回:0
				if(data=="1")
				{
					$("#msg").html("用户名已注册,请重新输入!");
					msg="用户名已注册,请重新输入!";
					return false;							 
				}
				$("#msg").html("");
				msg="";
				flag=true;
			});					
		}
	});	
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
		var reg=/[\u4e00-\u9fa5]+/;
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
		var school=$.trim($("[name='school']").val());
		if (school==""){
			$("#msg").html("所在/毕业学校不能为空!");
			msg="所在/毕业学校不能为空!";
			return false;
		}
		$("#msg").html("");
		msg="";
		flag=true;
		
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
	$("#modify").click(function(){		
		if(flag==false){			
			$("#msg").html(msg);
			return false;
		}
		//将毕业时间转成Date类型
		var graduateDate = new Date($("[name='graduateDate']").val().replace("-", "/").replace("-", "/"));
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/experience/modify.action",{id:$("[name='id']").val(),num:$("[name='num']").val(),sex:$("[name='sex']").val(),name:$("[name='name']").val(),school:$("[name='school']").val(),company:$("[name='company']").val(),phone:$("[name='phone']").val(),province:$("[name='province']").val(),student:$("[name='student']").val(),graduateDate:graduateDate},function(data){
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.layer.close(index);	
		})
	})
});
</script>
</head>
<body>
<div class="container">
	<div class="well well-sm text-center">体验者信息</div>
	<div class="panel panel-default">
		<div class="panel-body">
			<form name="add">
			<input type="hidden" name="id" value="${param.id }">
			<table class="table table-hover">
				<tr>
					<th>用户名</th>
					<td>
						<input name="num" type="text" placeholder="必填项" style="width: 200px" class="form-control" required /> 
					</td>
				</tr>
				<tr>
					<th>性别</th>
					<td>
						<input type="radio" value="男" name="sex">男 
						<input type="radio" value="女" name="sex" style="margin-left: 20px">女
					</td>
				</tr>
				<tr>
					<th>真实姓名</th>
					<td>
						<input name="name" type="text" placeholder="必填项" style="width: 200px" class="form-control" required /> 
					</td>
				</tr>
				<tr>
					<th>所在/毕业学校</th>
					<td>
						<input name="school" type="text" placeholder="必填项" style="width: 200px" class="form-control" required />
					</td>
				</tr>
				<tr>
					<th>工作单位</th>
					<td>
						<input name="company" type="text" placeholder="非必填项" style="width: 200px" class="form-control" />
					</td>
				</tr>
				<tr>
					<th>联系电话</th>
					<td>
						<input name="phone" type="text" placeholder="必填项" style="width: 200px" class="form-control" required />
					</td>
				</tr>
				<tr>
					<th>所在省份</th>
					<td>
						<select name="province" class="form-control" style="width: 200px"></select>
					</td>
				</tr>
				<tr>
					<th>是否毕业</th>
					<td>
						<input type="radio" value="false" name="student">已毕业 
						<input type="radio" value="true" name="student" onClick="stu">未毕业
					</td>
				</tr>
				<tr>
					<th>毕业时间</th>
					<td>
						<input type="date" name="graduateDate" value="2000-07-15" placeholder="必填项" class="form-control" style="width: 200px" /> 
                    </td>
				</tr>
				<tr>
					<td colspan="2">
						<div id="msg" style="color: red; font-weight: bold; font-size: 15px; " align="center"></div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div style="margin-left: 110px">
							<button type="button" class="btn btn-default" id="modify">提交</button>
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