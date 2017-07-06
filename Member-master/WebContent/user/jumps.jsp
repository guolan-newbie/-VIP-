<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/signin.css" rel="stylesheet">
<title>跳转页面</title>     
  <script type="text/javascript"> 
  var i = 4;
  function out(){
    if (i>0){
      i--;
    }else
    	{
            location.href="${pageContext.request.contextPath}/user/login.jsp";   
        }
    
    document.getElementById('num').innerHTML=i;
  }
  setInterval('out()',1000);
</script> 
  </head>        
  <body>  
  <div style="text-align:center; margin-top:30px">
    <span style="color:green;font-size:20px" >亲，欢迎再次回来！！！</span>
    <br/>
    <p>
    <br/>页面  还剩  <span id="num">3</span> 秒  跳转...
    <br/>
    </p>
     <p>如果没有跳转，
     请点这里：<a href="${pageContext.request.contextPath}/user/login.jsp">点击跳转</a></p>
  </div>    
  </body>    
</html>   
</html>