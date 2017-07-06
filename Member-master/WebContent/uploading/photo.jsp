<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
 body{background-color:#ffdead}
 #delete {margin-left:700px;margin-top:100px;}
 #share{margin-left:800px;margin-top:-20px;}
 #modify{margin-left:870px;margin-top:-20px;}
	#sidebar a:link,
	#sidebar a:visited {
	color:#666;
	text-decoration:none;
	}
	#sidebar a:hover,
	#sidebar a:active {
	color:#000000;
	text-decoration:underline;
	} 
 
 
</style>
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/uploading/css/imageflow.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/uploading/css/jquery.classyleaves.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/uploading/css/default.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/uploading/css/normalize.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery.rotate.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery.classyleaves.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户相册</title>
<script type="text/javascript">
$(function(){
	$.ajaxSetup({
		  async: false
	});
	var uid=${myuser.id};
	layer.config({
	    extend: 'extend/layer.ext.js'
	}); 
	var tree = new ClassyLeaves({
		leaves: 50,
		maxY: -10,
		multiplyOnClick: true,
		multiply: 2,
		infinite: true,
		speed: 4000
	}); 
	 $('body').on('click', '.addLeaf', function() {
                console.log('8');
                tree.add(8);
                return false;
     });
	
	$.post("${pageContext.request.contextPath}/picture/getUserPicture.action",{uid:uid,pageno:$("#page").val()},function(data){
		for(i=0;i<data.length;i++)
		{	
			var flag=(data[i].flag)
			var id=data[i].id
			var line="";
			line=line + "<img class='pict' title='"+(data[i]).title+"' lang='"+id +"'  src='data: image/jpeg;base64,"+ (data[i]).photo+"'  width='250' height='200' alt='${pageContext.request.contextPath}/' />";		
			$("#starsIF").append(line)	
		}
 },"json");
	
});
</script>
</head>
<body> 
<div id="LoopDiv">
<input id="S_Num" type="hidden" value="8" />
<div id="starsIF" class="imageflow">

</div>
</div>
<c:choose>
	<c:when test="${param.pageno==''}">
		<input type="hidden" id="page" value="1"> 
	</c:when>
	<c:when test="${param.pageno==null}">
		<input type="hidden" id="page" value="1"> 
	</c:when>
	<c:when test="${param.pageno!=null}">
		<input type="hidden" id="page" value="${param.pageno+1}"> 
	</c:when>
</c:choose>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/imageflow.js"></script>
</body>
<div align="center" id="sidebar" ><a href="../personal/navbar.jsp#">返回主页面</a></div>
</html>