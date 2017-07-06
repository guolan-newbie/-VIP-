<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" /> 
		<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>		
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/commensum.css" />
<script type="text/javascript">
$(function(){
		var page2=1;
		getComs(page2);
		//获取沟通信息
	    function getComs(page2){
	    	$.ajaxSetup({async:false});
	 		$.post("${pageContext.request.contextPath}/communication/getCommunicationInfoByPage.action",{page2:page2},function(data){
				var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;		
			var list=dataObj.returnMap.list;
			$(".page-nav").html(navbar);				
				if(data.length > 0){
				drawTable(list);
			}
			else{
				alert("暂无沟通信息！");
			}
			btnclick();
			textOn();
			lookCommunicationclick();
		});
			
		//分页按钮点击事件
		function btnclick(){
			$(".nav-btn").click(function(){
				page2=this.lang;
				getComs(page2);
			})
		}
	 		 		
	 	//沟通信息表格化处理
	    function drawTable(data){  
	
	 		var line="";
			line=line + "<thead class='text-c'>"
			line=line + "<tr>";
			line=line + "<th width='40'>序号</th>";
			line=line + "<th width='100'>会员姓名</th>";			
			line=line + "<th width='200'>沟通时间</th>";
			line=line + "<th width='100'>沟通老师</th>";
			line=line + "<th width='400'>沟通内容</th>";
			line=line + "</tr>";
			line=line + "</thead>"
			for(i=0;i<data.length;i++){
					line=line + "<tr>"
					line=line + "<td class='text-c'>" + (i+1)+ "</td>";
					if(data[i].member.id!=0){
						line=line + "<td class='text-c'>" + "<a class='lookCommunication' lang='"+data[i].member.id+","+data[i].member.name+","+1+"'>" + data[i].member.name + "</a>" + "</td>";
					}else{
						line=line + "<td class='text-c'>" + "<a class='lookCommunication' lang='"+data[i].experience.id+","+data[i].experience.name+","+0+"'>" + data[i].experience.name + "</a>" + "</td>";
					}					
					line=line + "<td class='text-c'>" + data[i].formatTime + "</td>";
					line=line + "<td class='text-c'>" + data[i].admin.realname + "</td>";
					line=line + "<td class='text' id='text"+i+"' lang='"+$(data[i].content).text()+"'></td>";
					line=line + "</tr>"
				}
			$("#communication").html(line);
			var maxwidth = 30;
			for(i=0;i<data.length;i++){
				if ($(data[i].content).text().length > maxwidth) {
					$("#text"+i).text($(data[i].content).text().substring(0, maxwidth) + "...");
				}
				else{
					$("#text"+i).text($(data[i].content).text());
				}				
				//$("#text"+i).text($(data[i].content).text());
			}
	    }	    
	}
	//查看沟通信息点击事件
	function lookCommunicationclick(){
		$(".lookCommunication").click(function(){
			var data=this.lang.split(",");
			var id=data[0];
			var name=data[1];
			var identityType=data[2];
			layer.open({
				  type: 2,
				  title: '查看沟通信息',
				  area: ['780px', '550px'],
				  shift: 1,
				  shade: 0.5, //开启遮罩关闭
				  content: '${pageContext.request.contextPath}/admin/lookcommunication.jsp?id='+id+'&name='+name+'&identityType='+identityType,
				  end: function(){
					  getComs(page2);
				    }
			});
		})
	}
	//备注鼠标悬停事件
	function textOn(){
		$(".text").dblclick(function(){
			var id="#"+this.id;			
			layer.tips(this.lang, id,{time:100000,closeBtn: 2});
			});
	}
	//删除沟通信息
    function delComment(){
		$(".icon-delete-small").click(function(){
			alert("功能暂时未完成");
			return false;
			
			var id=this.lang;
			if(!confirm('您真的要删除此沟通信息吗？'))
			{
				return;
			}
			else
			{
			$.post("${pageContext.request.contextPath}/summary/delComment.action",{id:id},function(){
				getComs(sumId);
			});
			}
		});
	}
});
</script>
</head>
<body  style="background-color:#EEEEEE;">
	<br>
 	<h1 style="text-align:center">会员沟通信息</h1>
	<div class="mt-20">
		<table class="table table-border table-bg table-bordered radius" id="communication">
		</table>	
	</div>
	<br>
	
<div class='page-nav' style="padding-right:120px"></div>
</body>
</html>