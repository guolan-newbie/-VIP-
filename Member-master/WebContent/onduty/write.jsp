<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap3.min.css">
  	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
 
<script type="text/javascript">

$(function(){
	//$.ajax({async:false })
	//$.post("${pageContext.request.contextPath}/ondutylog/getApply.action",function(data){
		//var apply=$("#apply").val();
		//alert(apply);
	//})
	//获取url中的参数Oid,type
    (function ($) {
        $.getUrlParam = function (name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
    })(jQuery);
    var oid = $.getUrlParam('oid');
    var type = $.getUrlParam('type');
    document.getElementById("oid").value =oid;
    var coid=$("#oid").val();

	
    var ue = UE.getEditor('editor');
    $("#ondutylog").submit(function(){
    	if($("#oid").val()==0)
		{
    		$("#info").html("×请选择值班开始时间");
			return false;
		}
    	if($("[name='beHelpedName']").val().length==0)
    	{
    		$("#info").html("×被帮助者姓名不能为空");
			return false;
    	}
    	if($("[name='beHelpedQQ']").val().length==0)
    	{
    		$("#info").html("×被帮助者QQ不能为空");
			return false;
    	}
    	if($("[name='beHelpedInfo']").val().length==0)
    	{
    		$("#info").html("×被帮助者个人情况不能为空");
			return false;
    	}
    	if($("[name='qustionDescription']").val().length==0)
    	{
    		$("#info").html("×问题描述不能为空");
			return false;
    	}   	
		var contents=UE.getEditor('editor').getContent();
		if(contents == "" ){
			$("#info").html("×解决情况不能为空");
			return false;
		}
		$("#solutionReport").val(contents);
    });
});

</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
input[type="text"]{
	color: #141414;
}
#info{
	color:red;
}
</style>
</head>
<body>
<form:form action="${pageContext.request.contextPath}/ondutylog/add.action" commandName="ondutylog" modelAttribute="ondutylog" id="ondutylog"  role="form"  class="form-horizontal">
<div class="container">
	<div class="form-group form-group-md">
                    <label class="sr-only">值班日志</label>
                    <div class="col-md-3 col-md-offset-4">
                        <h1>　　值班日志</h1>
                    </div>
                </div>
                
                <br>
        		<div class="form-group form-group-md">
						<label class="sr-only">被帮助者的姓名</label>
					<div class="col-md-3 col-md-offset-2">
						<input type="text" name="beHelpedName" class="form-control" placeholder="被帮助者的姓名">
					</div>
				</div>
				<br>
				<div class="form-group form-group-md">
					<label class="sr-only">被帮助者的QQ</label>
					<div class="col-md-3 col-md-offset-2">
						<input type="text" name="beHelpedQQ" class="form-control" placeholder="被帮助者的QQ">
					</div>
				</div>
				<br>
				<div class="form-group form-group-md">
					<label class="sr-only">被帮助者的个人情况</label>
					<div class="col-md-6 col-md-offset-2">
						<input type="text" name="beHelpedInfo" class="form-control" placeholder="被帮助者的个人情况">
					</div>
				</div>
				<br>
				<div class="form-group form-group-md">
					<label class="sr-only">问题描述</label>
					<div class="col-md-7 col-md-offset-2">
						<textarea class="form-control" rows="3" name="qustionDescription" placeholder="问题描述"></textarea>
					</div>
				</div>
				<br>
				<!--  
				<div class="form-group form-group-md">
					<label class="sr-only">解决情况</label>
					<div class="col-md-7 col-md-offset-2">
						<script id="editor" type="text/plain" style="height: 300px;"></script>
					</div>
				</div>
				-->
				<br>
				<div class="form-group form-group-md">
					<label class="sr-only">解决情况</label>
					<div class="col-md-7 col-md-offset-2">
						<textarea class="form-control" rows="3" name="solutionReport" placeholder="解决情况"></textarea>
					</div>
				</div>
				<br>
				<div class="form-group form-group-md">
					<div class="col-md-7 col-md-offset-2" id="info"></div>
				</div>
				<div class="form-group form-group-md">
					<input type="hidden" name="solutionReport" id="solutionReport">
					<input type="hidden" name="oid" value="" id="oid">
					<div class="col-md-7 col-md-offset-2">
						<button type="submit" class="form-control">提交</button>
					</div>
				</div>
				<div><input type="hidden" value=${APPLY } id="apply"></div>
      </div>
</form:form>
</body>
</html>