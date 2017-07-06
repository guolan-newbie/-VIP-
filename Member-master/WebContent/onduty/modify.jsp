<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

  	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
 
<script type="text/javascript">

$(function(){
	var ue = UE.getEditor('editor');
	ue.ready(function(){
		ue.setContent($("#solutionReport").val());
	});		
	$("#oid").val($("[name='ooid']").val());
  
    $("#ondutylog").submit(function(){
    	if($("#oid").val()==0)
		{
    		alert("请选择值班开始时间");
			return false;
		}
    	if($("[name='beHelpedName']").val().length==0)
    	{
    		alert("被帮助者姓名不能为空");
			return false;
    	}
    	if($("[name='beHelpedQQ']").val().length==0)
    	{
    		alert("被帮助者QQ不能为空");
			return false;
    	}
    	if($("[name='beHelpedInfo']").val().length==0)
    	{
    		alert("被帮助者个人情况不能为空");
			return false;
    	}
    	if($("[name='qustionDescription']").val().length==0)
    	{
    		alert("问题描述不能为空");
			return false;
    	}   	
		var contents=UE.getEditor('editor').getContent();
		if(contents == "" ){
			alert("解决情况不能为空");
			return false;
		}
		$("#solutionReport").val(contents);
    });
});

</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.textarea{
height:100px;
width:700px;
}
input[type="text"]{
color: #141414;
}
</style>
</head>
<body>
${LOG }
<form:form action="${pageContext.request.contextPath}/ondutylog/modify.action" id="ondutylog">
	<table>
		<caption>值班日志</caption>
		 <tr>  
    		<td>值班开始时间：</td>
    		<td>   
        		<form:select path="oid">
        		<form:option value="0" label="　　 --请选择--"></form:option>  
            	<form:options items="${APPLY}" itemLabel="time" itemValue="oid"></form:options>          
        		</form:select>   
    		</td>    
    	</tr>
		<tr>
			<td>被帮助者的姓名：</td><td><input type="text" name="beHelpedName" value="${LOG.beHelpedName }"></input></td>
		</tr>
		<tr>
			<td>被帮助者的QQ：</td><td><input type="text" name="beHelpedQQ" value="${LOG.beHelpedQQ }"></input></td>
		</tr>
		<tr>
			<td colspan="2">
				被帮助者的个人情况：<br>
				<input type="textarea" class="textarea" name="beHelpedInfo" value="${LOG.beHelpedInfo }"></input>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			问题描述：<br>
			<input type="textarea" class="textarea" name="qustionDescription" value="${LOG.qustionDescription }">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				解决情况：<br>
				<script id="editor" type="text/plain" style="height: 300px;">
		    	</script>
		    </td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="hidden" name="id"  value="${LOG.id }">
				<input type="hidden" name="ooid"  value="${LOG.oid }">
				<input type="hidden" name="solutionReport" id="solutionReport"  value="${LOG.solutionReport }">
				<input type="submit" value="提交" style="margin-left: 650px;"/>
			</td>
		</tr>
	</table>
</form:form>  
</body>
</html>