<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
  <title></title>
  <style>
  .contain{
  	width:500px;
  	height:580px;
  	text-align:center;
  }

  #sortable1, #sortable2 {
    border: 1px solid #eee;
    width: 200px;
    height:450px;
    overflow:auto;
    min-height: 20px;
    list-style-type: none;
    margin: 0;
    padding: 5px 0 0 0;
    float: left;
    margin-top:10px;
    margin-left: 30px;
    margin-right: 10px;
  }
  #sortable1 li, #sortable2 li {
    margin: 0 5px 5px 5px;
    padding: 5px;
    font-size: 1.2em;
    width: 185px;
    border:1px solid #DBDBDB;
  }
  #sortable1 li{
  background-color:#FFFFE0;
  }
  .clear{
  clear:both;
  }
  </style>

  <script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-ui.min.js"></script>
  <script>
  $( function() {
    $( "#sortable1, #sortable2" ).sortable({
      connectWith: ".connectedSortable"
    }).disableSelection();
  } );
  $(function(){
	  var caid=$("#caid").val();
	  var title=$("#title").val();
	  $("[name='title']").val(title);
		//获取左边的章节
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/course/getcachapter.action",{caid:caid},function(data){								
			showdata(data);		
		});
		//获取右边的章节
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/course/getChaptersNotInThisCategory.action",{caid:caid},function(data){								
			showdata2(data);		
		});
		var flag=false;
		var msg="";
		$("[name='title']").focus();
		//判断类别名
		$("[name='title']").blur(function(){
			title=$.trim($("[name='title']").val());
			if(title==""){
				$("#msg").html("类别名称不能为空!");
				return false;
			}
			$("#msg").html("");
			msg="";
			flag=true;
		});
		//确认点击事件
			$("#ensure").click(function(){	
				if(flag==false){			
					$("#msg").html(msg);
					return false;
				}
				var arr = new Array();//定义一个数组,储存顺序
				var i=0;
				$("#sortable1 li").each(function(){
				    arr[i]=this.lang;
				    i++;
				  });
				if(arr.length==0){
					$("#msg").html("请从右边拖动章节到左边!");
					return false;
				}
				//alert(arr);
				$.ajaxSetup({async:false});
				$.post("${pageContext.request.contextPath}/course/modifyCategory.action",{id:caid,title:title,"order":arr},function(data){
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index);	
				});
			})


		function showdata(data){
			var line="";
			for(i=0;i<data.length;i++){
				line = line + "<li lang='"+data[i].id+"'>";
				line = line + data[i].title;
				line = line + "</li>";
			}
			$("#sortable1").html(line);
		}
		function showdata2(data){
			var line="";
			for(i=0;i<data.length;i++){
				line = line + "<li lang='"+data[i].id+"'>";
				line = line + data[i].title;
				line = line + "</li>";
			}
			$("#sortable2").html(line);
		}
	});
  </script>
</head>
<body>
<input type="hidden" value="${param.caid }" id="caid">
<input type="hidden" value="${param.title }" id="title">
 <div class="contain">
	 <div style="margin-top: 20px">
	 	类别名：<input type="text" name="title" >
	 </div>
	 <div>
		<ul id="sortable1" class="connectedSortable">
		</ul>		 
		<ul id="sortable2" class="connectedSortable">
		</ul>
	</div>
	<div class="clear"></div><!-- 必须要加一个光光用来清除浮动的div，不然margin-top不好用 -->
	<div id="msg" style="color: red; font-weight: bold; font-size: 15px; " align="center"></div>
	<div style="margin-top: 20px"><input type="button" value="确定" class="btn btn-default" id="ensure"></div>	
</div>
 
</body>
</html>