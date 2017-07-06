<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
#sortable {
    border: 1px solid #eee;
    width: 300px;
    height:350px;
    overflow:auto;
    min-height: 20px;
    list-style-type: none;
    margin: 0;
    padding: 5px 0 0 0;
    margin-top:10px;
    margin-left: 30px;
    margin-right: 10px;
  }
  #sortable li {
    margin: 0 5px 5px 5px;
    padding: 5px;
    font-size: 1.2em;
    width: 285px;
    border:1px solid #DBDBDB;
    background-color:#FFFFE0;
  }
</style>
<title>课程排序</title>
<script>
$( function() {
    $( "#sortable" ).sortable({
      placeholder: "ui-state-highlight"
    });
    $( "#sortable" ).disableSelection();
  } );
$(function(){
	//设置章节
	$.post("${pageContext.request.contextPath}/course/getChapters.action",function(data){
		showdata(data);
	//	id=$("[name='chid']").val();
	});
	//获取课程
	$("#choose").click(function(){
			$.ajaxSetup({async:false});
			$.post("${pageContext.request.contextPath}/course/getLessons.action",{chid:$("[name='chid']").val()},function(data){
				var line="";
				for(i=0;i<data.length;i++){
					line = line + "<li lang='"+data[i].id+"' class='order'>";
					line = line + data[i].title;
					line = line + "</li>";	
				}
				$("#sortable").html(line);


			});
		})
	//确认点击事件
		$("#ensure").click(function(){			
			var arr = new Array();//定义一个数组,储存顺序
			var i=0;
			$(".order").each(function(){
			    arr[i]=this.lang;
			    i++;
			  });
			//alert(arr);
			
			$.ajaxSetup({async:false});
			$.post("${pageContext.request.contextPath}/course/sortLessons.action",{"order":arr},function(data){
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index);	
			});
		})


	function showdata(data){
		var line="";
		for(i=0;i<data.length;i++){
			if ($("[name='chid']").val() == data[i].id){
				line = line + "<option value="+data[i].id+" selected='selected'>";			
			}
			else{
				line = line + "<option value="+data[i].id+">";
			}
			line = line + data[i].title;
			line = line + "</option>";	
		}
		$("[name='chid']").html(line);
	}
});
		
	</script>
</head>
<body>
	<div class="container">
	<div class="panel panel-default">
		<div class="panel-body">
			<table class="table table-hover">
				<tr>
					<th>所属章节</th>
					<td>
						<select name="chid" class="form-control" style="width: 200px"></select>					
					</td>
					<td>
						<button type="button" class="btn btn-default" id="choose">选择</button>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<div style="text-align:center;">
							<ul id="sortable">

							</ul>
						</div>
					</td>
				</tr>			
				<tr>
					<td colspan="3">
						<div style="margin-left: 150px">
							<button type="button" class="btn btn-default" id="ensure">确定</button>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>

</div>
	
	


</body>
</html>