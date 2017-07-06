<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看周报</title>
<link href="${pageContext.request.contextPath}/css/looksummary.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" /> 
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/extend/layer.ext.js"></script>
<style type="text/css">

</style>
<script type="text/javascript">
$(function(){
	//第一次点击进来的默认值
	var checkType="all";
	var weekType="all";
	var title;
	var page2=1;
	var assistant=0;
	var assistantLength;
	var cmid=$("#mid").val();
	var sumcount=$("#sumcount").val();
	setWeekTypeCheck(weekType);
	getData(checkType,weekType,title,page2,assistant,cmid);
	$("#search-summary").click(function(){
		checkType=$("[name='checkType']").val();
		weekType=$("[name='weekType']").val();
		title=$("[name='title']").val();
		page2=1;
		assistant=$("[name='assistant']").val();
		//设置weekType
		if($("#weekType-2").is(":checked"))
		{
			//alert($("#weekType-2").val());
			weekType=$("#weekType-2").val();
		}
		if($("#weekType-3").is(":checked"))
		{
			//alert($("#weekType-3").val());
			weekType=$("#weekType-3").val();
		}
		if($("#weekType-4").is(":checked"))
		{
			//alert($("#weekType-4").val());
			weekType=$("#weekType-4").val();
		}		
		getData(checkType,weekType,title,page2,assistant,cmid);
		//设置assistant,保留之前被选中的状态
		for(i=0;i<=assistantLength;i++){
			if(assistant==$("#assistant"+i).val())
			{	
				
				$("#assistant"+i).attr("selected",true);
			}
		}
	})	
	function setWeekTypeCheck(weekType)
	{
		if(weekType=="all"){
			$("#weekType-1").attr("checked",true);
		}
		if(weekType=="previous"){
			$("#weekType-2").attr("checked",true);
		}
		if(weekType=="current"){
			$("#weekType-3").attr("checked",true);
		}
		if(weekType=="next"){
			$("#weekType-4").attr("checked",true);
		}
	}
	function getData(checkType,weekType,title,page2,assistant,cmid){
		$.ajaxSetup({async:false});
		getAssistant();
		$.post("${pageContext.request.contextPath}/summary/getSumByMid.action",{checkType:checkType,weekType:weekType,title:title,page2:page2,assistant:assistant,cmid:cmid},function(data){
			if(data=="0")
				$("#period").html("该用户没有这一期的周报！");
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var tatolCount=dataObj.returnMap.totalCount;
			var list=dataObj.returnMap.list;
			var title=dataObj.returnMap.title;
			var titleTip=dataObj.returnMap.titleTip;
			//alert(title)
			$("#titleTip").html(titleTip);
			$(".page-nav").html(navbar);
			btnclick();
			$("#TATOLCOUNT").html(tatolCount);
			$("[name='title']").val(title);
			drawTable(list);
			titclick();
			trclick();
			modifySum();
			delSum();
			select();
			batchDelSum();
		})
			
		
	}
	function btnclick(){
		$(".nav-btn").click(function(){
			page2=this.lang;
			getData(checkType,weekType,title,page2,assistant,cmid);
		})
	}	
	function getAssistant(){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/admin/getAll.action",function(data){
			assistantLength=data.length;
			var line="";
			line=line + "<option value='0' id='assistant0'>不限</option>";
			for(i=0;i<data.length;i++){
				line=line + "<option value='" + data[i].id + "' id='assistant"+(i+1)+"'>" + data[i].realname + "</option>";
			}
			$("[name='assistant']").html(line);
		})
		
	}
	//查看周报	
	function showSum(id){
			//location.href="${pageContext.request.contextPath}/summary/membersumcomment1.jsp?page2="+page2+"&checkType="+checkType+"&weekType="+weekType+"&title="+title+"&id="+id;
			//window.open("${pageContext.request.contextPath}/summary/membersumcomment1.jsp?id="+id);
		layer.open({
			  type: 2,
			  title: '查看周报',
			  area: ['800px', '500px'],
			 // closeBtn: 0, //不显示关闭按钮
			  shift: 1,
			  maxmin: true,
			  shade: 0.5, //开启遮罩关闭
			  content: '${pageContext.request.contextPath}/summary/membersumcomment1.jsp?id='+id,
			  end: function(){
				  	getData(checkType,weekType,title,page2,assistant,cmid);
			    }
		});
	
	}
	function titclick(){
		$(".tit").click(function(){
			var id=this.lang;
			showSum(id);
		})
	}
	function trclick(){
		//火狐对last不支持，在不该被点的td里面机上noclick的class
		//$("tr td:not(':first,:last')").click(function(){
		$("tr td:not(.noclick)").click(function(){
			var id=this.parentNode.lang;
			showSum(id);
		})

	}
	//修改周报信息,暂时只有修改title的功能
	function modifySum(){
		$(".mod").click(function(){
			if(weekType!="all"){
				weekType="now"; 
			}
			var id=this.lang;
		 	$.post("${pageContext.request.contextPath}/summary/getSumById.action",{"id":id},function(data){
		 		var title=data.title;
		 		layer.open({
						  type: 2,
						  title: '修改',
						  area: ['600px', '361px'],
						 // closeBtn: 0, //不显示关闭按钮
						  shift: 1,
						  shade: 0.5, //开启遮罩关闭
						  content: '${pageContext.request.contextPath}/admin/modifysum.jsp?title='+title+'&id='+id,
						  end: function(){
							  	getData(checkType,weekType,title,page2,assistant,cmid);
						    }
						});
				})		
			})
	}
	//如果第一个被选中，下面的所有都要被选中，如果第一个没有被选中，下面的所有都不要被选中。
	function select()
	{
		$("input[type='checkbox']:first").click(function(){
			$("input[type='checkbox']").not(":first").prop("checked",$(this).prop("checked"));
		});
	}
	function delSum(){
		$(".icon-delete-middle").click(function(){
			var id=this.lang;			
			//alert(id)
			if(!confirm('您确定要删除此条记录吗？'))
			{
				return;
			}
			else
			{
			$.ajaxSetup({async:false});
			$.post("${pageContext.request.contextPath}/summary/delSummary.action",{id:id},function(){
				getData(checkType,weekType,title,page2,assistant,cmid);
			});
			}
		});
	}
	//批量删除周报
	function batchDelSum(){
		$("#batchDel").click(function(){
			var ids=""; //存储所有ID用的，哪些被选中就存起来
			var i=0; //ID的数量
			$("input[type='checkbox']").each(function(index, element) {
	            if(index>0)
				{
					if($(this).prop("checked"))
					{
						var id=$(this).parent().parent().children().eq(1)
			            .children().eq(0).val();
						ids+=id;
						i++;
						ids+=",";
					}
				}		
			});	
			if(ids.length>1)
			{
				ids=ids.substring(0,ids.length-1);
				//alert(ids)
				if(!confirm("你确定要删除这" + i +"条记录吗"))
				{
					return;
				}
				else
				{
					$.ajaxSetup({async:false});
					$.post("${pageContext.request.contextPath}/summary/batchDelSummary.action",{ids:ids},function(){
						getData(checkType,weekType,title,page2,assistant,cmid);
					});
				}
			}		
			
		});
	}
	function drawTable(data){
		var line="";
		line=line + "<thead>";
		line=line + "<tr class='text-c'>";
		line=line + "<th class='ck'><input type='checkbox' name='' value=''></th>";
		line=line + "<th class='xh'>序号</th>";
		line=line + "<th class='yhm'>用户名</th>";
		line=line + "<th class='xm'>姓名</th>";
		line=line + "<th style='min-width:200px;'>周报标题</th>";	
		line=line + "<th style='min-width:180px;'>提交时间</th>";
		line=line + "<th class='xzs'>小助手</th>";
		line=line + "<th class='zt'>状态</th>";
		line=line + "<th class='cz'>操作</th>";
		line=line + "</tr>";
		line=line + "</thead>";
		line=line + "<tbody>";
		for(i=0;i<data.length;i++){
			var title="";
			var time="";
			var assistant="";
			var operation="";
			var  status="";
			if(data[i].sid==0){
				title=$("[name='title']").val();
				status="<span class='label label-warning radius'>未提交</span>";
				if(data[i].arealname!=null){
					assistant=data[i].arealname;
				}								
			}else{
				title=data[i].title;
				time=data[i].time;
				if(data[i].arealname!=null){
					assistant=data[i].arealname;
				}			
				if(data[i].ischeckval == '0')
				{
					status="<span class='label label-danger radius'>未审核</span>";
				}else{
					status="<span class='label label-success radius'>已审核</span>";
				}
				operation="<a href='javascript:void(0)' class='tit' lang='"+data[i].sid+"'>查看&nbsp;|</a>";	
				operation+="<a class='icon-delete-middle' href='javascript:;' lang='"+data[i].sid+"'title='删除'>";
				operation+="<i class='Hui-iconfont'>&#xe6e2;</i>";
				operation+="</a>";
				operation+="<a href='javascript:void(0)' class='mod' lang='"+data[i].sid+"'>|&nbsp;修改</a>";			
			}
			line=line + "<tr class='text-c tr' lang='"+data[i].sid+"'>";
			line=line + "<td class='noclick'>" + "<input type='checkbox' name='' value=''>" + "</td>";
			line=line + "<td>" + (i+1) +"<input type='hidden' value="+data[i].sid +"> "+ "</td>";
			line=line + "<td>" + data[i].num + "</td>";
			line=line + "<td>" + data[i].name + "</td>";
			line=line + "<td>" + title + "</td>";
			line=line + "<td>" + time + "</td>";
			line=line + "<td>" + assistant + "</td>";
			line=line +"<td class='td-status'>";
			line=line+status;
			line=line +"</td>";	
			line=line +"<td class='noclick'>";
			line=line + operation;
			line=line+"</td>"
			line=line + "</tr>";
			
		}
		line=line + "</tbody>";
		$("#period").html(line);
	}
           
});	

</script>
</head>
<body>

	<div class="text-c" style="padding-left:0;padding-right:60px;"> 
	<form id="">
		审核状态：
		<span class="select-box inline">
			<select name="checkType" class="select">
				<option value="all">不限</option>
				<option value="checked">已审核</option>
				<option value="nonchecked">未审核</option>
			</select>
		</span>
		<input type="radio" id="weekType-1" name="weekType" value="all">
		<span class="select-box inline">
		<label for="weekType-1">全部</label>&nbsp;
		</span>
		<input type="radio" id="weekType-2" name="weekType" value="previous">
		<span class="select-box inline">
		<label for="weekType-2">向前一周</label>&nbsp;
		</span>
		<input type="radio" id="weekType-3" name="weekType" value="current" checked>
		<span class="select-box inline">
		<label for="weekType-3">本周</label>&nbsp;
		</span>
		<input type="radio" id="weekType-4" name="weekType" value="next">
		<span class="select-box inline">
		<label for="weekType-4">向后一周</label>&nbsp;
		</span>
		<span class="select-box inline">
		<input type="hidden" name="title" value="">
		<button name="" id="search-summary" class="btn btn-success" type="button"><i class="Hui-iconfont">&#xe665;</i> 搜周报</button>
		</span>
	</form>
	</div>
	<div class="cl pd-5 bg-1 bk-gray mt-20" id="title" style="text-align:left;">
		<span id="titleTip" style="padding-left:35%;"></span>
		 <span class="r">共有数据：<strong id="TATOLCOUNT"></strong> 条</span>
		  <span class="l"><a href="javascript:;" class="btn btn-danger radius" id="batchDel"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a></span> 
	 </div>
	<div class="mt-20" style="padding-left:0;padding-right:60px;">
		<table class="table table-border table-bg table-bordered radius" id="period">
		</table>	
	</div>
	<br>
<div class='page-nav' style="padding-right:120px"><input type="hidden" id="mid" value="${myuser.member.uid}"></div>

</body>
</html>