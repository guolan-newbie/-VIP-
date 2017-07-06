<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>信息展示-Java互助学习VIP群业务运行系统</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
	
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript">
$(function(){
	$.post("${pageContext.request.contextPath}/notice/notice.action",function(data){
		if(data=="1"){
			$(".notice").attr("src","${pageContext.request.contextPath}/images/notice.gif");
			$(".nodata").html("<marquee behavior='scroll'   scrollamount='4' width='300' onmouseover='this.stop();' onmouseout='this.start();' style='overflow:hidden'><a class='notice' href='javascript:;'> <b>有新公告了，快去看看吧！</b></marquee>");
		}else{
			$(".notice").attr("src","${pageContext.request.contextPath}/images/notice.png");
		}
	});
	//layer层打开系统公告
	$(".notice").click(function(){
			var index=layer.open({
				type:2,
			    title:'系统公告',
			    area: ['810px', '563px'],
			    shift:5,
			    maxmin: true,
			    content: '${pageContext.request.contextPath }/notice/mynotice.jsp',
			    end: function(){
				       location.href="${pageContext.request.contextPath}/member/navbar1.jsp";
				}
			});	
	});	
	
	//获取同期加入学员
	$.post("${pageContext.request.contextPath}/course/getTheSamePeriodMember.action",function(data){
		var line="";
		for(var i=0;i<data.length;i++){
			line+="<a class='lookprogress' lang='"+data[i].id+","+1+"'>"+data[i].name+"</a>";
			line+="&nbsp;&nbsp;&nbsp;";
		}
		$("#theSamePeriod").html(line);
	});
	
	//获取学过的类别
	$.post("${pageContext.request.contextPath}/course/getMyCategory.action",function(data){
		var line="";
		for(var i=0;i<data.length;i++){
			var caid=data[i].id;
			line+=data[i].title+":&nbsp;&nbsp;&nbsp;";
			//获取进度相似学员
			$.post("${pageContext.request.contextPath}/course/getTheSameProgressStudent.action",{caid:caid},function(data){
				for(var i=0;i<data.length;i++){
					line+="<a class='lookprogress' lang='"+data[i].id+","+data[i].identityType+","+caid+"'>"+data[i].name+"</a>";
					line+="&nbsp;&nbsp;&nbsp;";
				}
				line+="<br>";				
			});
		}
		$("#theSameProgress").html(line);
	});
	
	
	$(".lookprogress").click(function(){
		var arr=this.lang.split(",");
		var id=arr[0];
		var identityType=arr[1];
		var caid=arr[2];
		var url='${pageContext.request.contextPath}/course/lookprogress.jsp?id='+id+'&identityType='+identityType;
		if(caid!=null){
			url='${pageContext.request.contextPath}/course/lookprogress.jsp?id='+id+'&identityType='+identityType+'&caid='+caid;
		}
		layer.open({
		    type: 2,
		    title:'查看进度',
		    area: ['800px', '500px'],
		    shift:1,
		    shade: 0.5, //开启遮罩关闭
		    content: url,
		    end: function() {    	
		    }
		});				
	})
});
</script>

</head>
<body>
<div class="pd-20" style="padding-top:20px;">
  <p class="f-20 text-success">欢迎登录VIP会员系统！  <img src="${pageContext.request.contextPath}/images/notice.png" class="notice" ></p>
  <p class="nodata" style="width:110px; height:18px;font-size:17px;" >  

  </p>
  <table class="table table-border table-bordered table-bg mt-20">
    <thead>
      <tr>
        <th colspan="2" scope="col">学员进度查看</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td width="80">同期加入 </td>
        <td id="theSamePeriod"></td>
      </tr>
      <tr>
        <td width="80">进度相近</td>
        <td id="theSameProgress"></td>
      </tr>
    </tbody>
  </table>
</div>
</body>
</html>