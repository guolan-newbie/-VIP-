<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="utf-8">
	<title>课程管理-Java互助学习VIP群业务运行系统</title>
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>

<script type="text/javascript">
$(function() {
	var page2=1;
	getData(page2);
	function getData(page2) {
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/course/getCourseByPage.action",{page2:page2},function(data){
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var tatolCount = dataObj.returnMap.totalCount;
			var list=dataObj.returnMap.list;
			$(".page-nav").html(navbar);
			btnclick();
			$("#num").html(tatolCount);
			drawTable(list);	
			modifyclick();
			deleteclick();
		});
	}
	
	//分页按钮点击事件
	function btnclick(){
		$(".nav-btn").click(function(){
			page2=this.lang;
			getData(page2);
		})
	}
	//添加章节点击事件
	$("#addchapter").click(function() {
		layer.open({
		    type: 2,
		    title:'添加章节',
		    area: ['380px', '380px'],
		    shift:1,
		    shade: 0.5, //开启遮罩关闭
		    content: '${pageContext.request.contextPath}/course/addchapter.jsp',
		    end: function() {    	
		    getData(page2);
		    //	query(1);
		    }
		});				
	});
	//添加课程点击事件
	$("#addlession").click(function() {
		layer.open({
		    type: 2,
		    title:'添加课程',
		    area: ['380px', '380px'],
		    shift:1,
		    shade: 0.5, //开启遮罩关闭
		    content: '${pageContext.request.contextPath}/course/addlesson.jsp',
		    end: function() {    	
		    getData(page2);
		    //	query(1);
		    }
		});				
	});
	
	$("#sortlessions").click(function() {
		layer.open({
		    type: 2,
		    title:'课程排序',
		    area: ['450px', '600px'],
		    shift:1,
		    shade: 0.5, //开启遮罩关闭
		    content: '${pageContext.request.contextPath}/course/sortlessons.jsp',
		    end: function() {    	
		    getData(page2);
		    //	query(1);
		    }
		});				
	});
	$("#setcategory").click(function() {
		layer.open({
		    type: 2,
		    title:'类别设定',
		    area: ['505px', '600px'],
		    shift:1,
		    shade: 0.5, //开启遮罩关闭
		    content: '${pageContext.request.contextPath}/course/setcategory.jsp',
		    end: function() {    	
		    getData(page2);
		    //	query(1);
		    }
		});				
	});
	$("#lookcategory").click(function() {
		layer.open({
		    type: 2,
		    title:'查看类别',
		    area: ['800px', '600px'],
		    shift:1,
		    shade: 0.5, //开启遮罩关闭
		    content: '${pageContext.request.contextPath}/course/lookcategory.jsp',
		    end: function() {    	
		    getData(page2);
		    //	query(1);
		    }
		});				
	});
	function modifyclick(){
		$(".modify").click(function(){
			var arr = this.lang.split(",");
			var id=arr[0];
			var chid=arr[1];
			var url="${pageContext.request.contextPath}/course/modifylesson.jsp?id="+id;
			if(chid==0){
				url="${pageContext.request.contextPath}/course/modifychapter.jsp?id="+id;
			}
			layer.open({
			    type: 2,
			    title:'修改',
			    area: ['380px', '380px'],
			    shift:1,
			    content: url,
			    end: function() {    	
				    getData(page2);
					//query($("b").text());
			    }
			});				
		})
	}
	
	function deleteclick(){
		$(".icon-delete-middle").click(function(){
			var arr = this.lang.split(",");
			var id=arr[0];
			var chid=arr[1];
			var img="您确定要删除此条课程记录吗？";
			if(chid==0){
				img="您确定要删除此条章节记录吗？此操作会将该章节下的所有课程删除，请谨慎操作！";
			}
			layer.confirm(img,{btn:['是','否']},//按钮一的回调函数
					function(){
						$.post("${pageContext.request.contextPath}/course/delete.action",{id:id,chid:chid},function(data) {
						layer.closeAll('dialog');
						getData(page2);
						});
			});
		})
	}
	

});



function drawTable(data) {	
	var table="";
	table=table + "<thead><tr class='text-c'>";
	table=table + "<th width='40'>序号</th>";
	table=table + "<th width='80'>名称</th>";
	table=table + "<th width='40'>所属章节</th>";
	table=table + "<th width='40'>所属类别</th>";
	table=table + "<th width='80'>是否选修</th>";
	table=table + "<th width='40'>操作 </th>";
	table=table + "</tr></thead>";
	table=table + "<tbody>"

	for(i = 0;i < data.length;i++) {
		var line="";
		var catitle="";
		var chtitle="";
		var optional_flag="";		
		if(data[i].chid==0){
			if(data[i].optional_flag==true){
				optional_flag="<span class='label label-danger radius'>是</span>";
			}else{
				optional_flag="<span class='label label-success radius'>否</span>";
			}
			for(j = 0;j < data[i].categoryTitles.length;j++) {
				if(j==0){
					catitle+=data[i].categoryTitles[j];
				}else{
					catitle= catitle+","+data[i].categoryTitles[j];
				}
				
			}
		}else{
			chtitle=data[i].chtitle;
		}
		var operation="<a style='text-decoration:none' class='modify' href='javascript:;' lang='"+data[i].id+","+data[i].chid+"' title='修改'>";
		operation+="<i class='Hui-iconfont'>&#xe6df;</i>";
		operation+="</a>";
		operation+="&nbsp;&nbsp;";
		operation+="<a class='icon-delete-middle' href='javascript:;' lang='"+data[i].id+","+data[i].chid+"'title='删除'>";
		operation+="<i class='Hui-iconfont'>&#xe6e2;</i>";
		operation+="</a>";

			line=line + "<tr class='text-c'>"
			line=line + "<td>" + (i+1)+ "</td>";
			line=line + "<td>" + data[i].title+ "</td>";
			line=line + "<td>" + chtitle + "</td>";
			line=line + "<td>" + catitle + "</td>";	
			line=line + "<td>" + optional_flag + "</td>";	
			line=line + "<td>";
			line=line + operation;	
			//课程管理表被其他表多次引用，所以不能被删除，可以被修改
			//line=line + "<a style='text-decoration:none' class='delete' lang='"+data[i].id+"' href='javascript:;' title='删除'><i class='Hui-iconfont'>&#xe6e2;</i></a>";		
			line=line + "</td>";
			line = line + "</tr>";	
			table+=line;
	}
	table=table + "</tbody>";
	$("#courses").html(table);
}

</script>
</head>
<body>
	<h1 style="text-align:center">课程管理</h1>
	<div class="pd-20">
		<div class="text-c"> 	
        	<input type="text" name="title" id="" placeholder="课程名称" style="width:250px" class="input-text">		
			<button name="" id="query" class="btn btn-success" type="submit"><i class="Hui-iconfont">&#xe665;</i>课程查询</button>
		</div>
		<div class="cl pd-5 bg-1 bk-gray mt-20"> 
			<span class="l">
			<a class="btn btn-primary radius" href="javascript:;" id="addchapter"><i class="Hui-iconfont">&#xe600;</i> 添加章节</a>
            <a class="btn btn-primary radius" href="javascript:;" id="addlession"><i class="Hui-iconfont">&#xe600;</i> 添加课程</a>
            <a class="btn btn-default radius" href="javascript:;" id="sortlessions"><i class="Hui-iconfont">&#xe647;</i> 课程排序</a>
            <a class="btn btn-default radius" href="javascript:;" id="setcategory"><i class="Hui-iconfont">&#xe647;</i> 类别设定</a>
			<a class="btn btn-default radius" href="javascript:;" id="lookcategory"><i class="Hui-iconfont">&#xe647;</i> 查看类别</a>
			
			</span> 
			<span class="r">共有数据：<strong id="num"></strong> 条</span> 
		</div>
		<div class="mt-20">
			<table id="courses" class="table table-border table-bg table-bordered radius"></table>
		</div>
	</div>
	<div class='page-nav' style="padding-right:120px"></div>
	
</body>
</html>