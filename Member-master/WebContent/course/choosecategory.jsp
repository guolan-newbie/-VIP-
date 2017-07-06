<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<!-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/zzsc.css"> -->
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

<title>查看进度</title>
<script>
$(function(){
	var id=$("#id").val();
	var identityType=$("#identityType").val();
	getstudentcategory(id,identityType);
	function getstudentcategory(id,identityType){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/courseandpro/getStudentCategory.action",{meid:id,identityType:identityType},function(data){								
			showdata(data);		
		});
		radiusdbclick();
	}
	function radiusdbclick(){
		$(".radius").dblclick(function(){
			var arr=this.lang.split(",");
			var caid=arr[0];
			var title=arr[1];
			var flag=arr[2];
			if(flag=="true"){
				layer.confirm('该学员有【'+title+'】这个专业的进度记录，设为未学会删除此记录，您确定这么做吗？',{btn:['是','否']},//按钮一的回调函数
						function(){
							$.ajaxSetup({async:false});
							$.post("${pageContext.request.contextPath}/courseandpro/setStudentCategory.action",{meid:id,identityType:identityType,caid:caid,flag:'false'},function(data){									
								getstudentcategory(id,identityType);
								layer.closeAll('dialog');
							});
				});
			}else{
				$.post("${pageContext.request.contextPath}/courseandpro/setStudentCategory.action",{meid:id,identityType:identityType,caid:caid,flag:'true'},function(data){									
				});
			}
			getstudentcategory(id,identityType);
		})
	}
	function ensureclick(){
		$("#ensure").click(function(){
			var chooseStr="";
			$("input[name='category']").each(function(){
				//alert($(this).attr('checked'));
		          if ($(this).attr('checked') == "checked") {
		        	  if(chooseStr==""){
		        		  chooseStr+=$(this).val();
		        	  }else{
		        		  chooseStr+=",";
		        		  chooseStr+=$(this).val();
		        	  }
		          }
		     })
			$.ajaxSetup({async:false});
			$.post("${pageContext.request.contextPath}/courseandpro/setStudentCategory.action",{meid:id,identityType:identityType,chooseStr:chooseStr},function(data){								
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index);	
			});
		})
	}
	function showdata(data){
		var line="";
		line+="<tr><td colspan='2' style='color:red'>双击图标更改选择状态</td></tr>";
		for(i=0;i<data.length;i++){
			line+="<tr>";
			line+="<td>"+data[i].title+"</td>";
			line+="<td>";
			if(data[i].capid==""){
				line+="<span class='label label-success radius' lang='"+data[i].caid+","+data[i].title+",false"+"'>未学</span>";
			}else{
				line+="<span class='label label-danger radius' lang='"+data[i].caid+","+data[i].title+",true"+"'>已学</span>";
			}
			
			line+="</td>";
			line+="</tr>";			
		}
		$(".table-hover").html(line);
	}
});
		
</script>
<style type="text/css">

</style>
</head>
<body>
<input type="hidden" value="${param.id }" id="id">
<input type="hidden" value="${param.identityType }" id="identityType">
<div class="container">
	<div class="panel panel-default">
		<div class="panel-body">
			<table class="table table-hover">

					
			</table>
		</div>
	</div>

</div>
</body>
</html>