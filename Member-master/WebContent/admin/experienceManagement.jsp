<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>用户审核-Java互助学习VIP群业务运行系统</title>
	
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" /> 
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<style type="text/css">
	.joinline{background-color:#99FFCC}
	.leftline{background-color:#FF9797}
	.preline{background-color:#FFD700}
	.mt-20{margin-top:40px}
</style>
<script type="text/javascript">
$(function(){
	/* 页面一加载获取的全部信息*/
	var page2=1;
	var flag =0;
	getData("全部信息",page2);
	
	/* 点击对应的人获取数据  */
	$(".butname").click(function() {
		var name = this.innerText;
		$(".btn").removeClass("active");
		$(this).addClass("active");
		//$("#name").html(name);
		getData(name,1);
	});
	
	/*用于显示全部人的数据*/
	function getData(name,page2){
		if(name=="全部信息"){
			getAll(page2);
		}else if(name=="已经加入"){
			flag=1;
			getDate1(page2,flag);
		}else if(name=="已经退出"){
			flag=0;
			getDate1(page2,flag);
		}else if(name=="正在体验"){
			getDate2(page2);
		}else if(name=="预科计划"){
			flag=2;
			getDate1(page2,flag);
		}
		
		
	}
	/*用于显示加入、预科、退出的数据*/
	function getDate1(page2,flag){
		getOthoers(page2,flag);
		btnclick();
		lookCommunicationclick();
		addCommunicationclick();
		joinclick();
		previpclick();
		leftclick();
		resetclick();
		addclick();
		einfoOn();
	}
	/*用于显示正在体验的数据*/
	function getDate2(page2){
		getIng(page2);
		lookCommunicationclick();
		addCommunicationclick();
		joinclick();
		previpclick();
		leftclick();
		resetclick();
		addclick();
		einfoOn();
	}
	
	
	/*获取所有人的信息 */
	function getAll(page2){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/experience/getExperienceByPage.action",{page2:page2},function(data){
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var list=dataObj.returnMap.list;
			$(".page-nav").html(navbar);
			$("#msgnull").html("");
			btnclick();
			drawTable(list);
			lookCommunicationclick();
			addCommunicationclick();
			joinclick();
			previpclick();
			leftclick();
			resetclick();
			addclick();
			einfoOn();
		})
	}
	/*用于显示加入、预科、退出的数据*/
	function getOthoers(page2,flag){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/experience/getExperienceInByPage.action",{page2:page2,flag:flag},function(data){
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var list=dataObj.returnMap.list;
			$(".page-nav").html(navbar);
			btnclick();
			drawTable(list);
		})
	}
	/*用于显示正在体验的数据*/
	function getIng(page2){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/experience/getExperienceIngByPage.action",{page2:page2},function(data){
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var list=dataObj.returnMap.list;
			$(".page-nav").html(navbar);
			$("#msgnull").html("");
			btnclick();
			drawTable(list);
		})
	}
	
	
	//分页按钮点击事件
	function btnclick(){
		$(".nav-btn").click(function(){
			page2=this.lang;			
			getData($(".active").html(),page2);
		})
	}
	//添加点击事件
	function addclick(){
		$("#add").unbind("click").click(function(){
			$(this).unbind();
			layer.open({
				  type: 2,
				  title: '添加体验者',
				  area: ['380px', '500px'],
				  shift: 1,
				  shade: 0.5, //开启遮罩关闭
				  content: '${pageContext.request.contextPath}/experience/add.jsp',
				  end: function(){
					  getData($(".active").html(),page2);
				  }
			});
		})
	}
	//备注鼠标悬停事件
	function memoOn(){
		$(".memo").mouseover(function(){
			var id="#"+this.id;			
			layer.tips('只想提示地精准些', id,{time: 1000});
			});
	}	
	//查看沟通信息点击事件
	function lookCommunicationclick(){
		$(".lookCommunication").click(function(){
			var data=this.lang.split(",");
			var id=data[0];
			var name=data[1];
			layer.open({
				  type: 2,
				  title: '查看沟通信息',
				  area: ['780px', '550px'],
				  shift: 1,
				  shade: 0.5, //开启遮罩关闭
				  content: '${pageContext.request.contextPath}/experience/lookcommunication.jsp?id='+id+'&name='+name,
				  end: function(){
					  getData($(".active").html(),page2);
				    }
			});
		})
	}
	//添加沟通信息点击事件
	function addCommunicationclick(){
		$(".addCommunication").click(function(){
			var data=this.lang.split(",");
			var id=data[0];
			var name=data[1];
			layer.open({
				  type: 2,
				  title: '添加沟通信息',
				  area: ['810px', '550px'],
				  shift: 1,
				  shade: 0.5, //开启遮罩关闭
				  content: '${pageContext.request.contextPath}/experience/addcommunication.jsp?id='+id+'&name='+name,
				  end: function(){
					  getData($(".active").html(),page2);
				    }
			});
		})
	}
	//加入VIP点击事件
	//*未修复：1.重复添加会员
	//	    2.添加会员后，不能重置取消会员资格，否则会员编号，会和提示框中的编号不同
	function joinclick(){
		$(".join").click(function(){
			//alert("功能暂未完善！");
			//return false;
			var data=this.lang.split(",");
			if('true' == data[3]) {
				layer.msg("该体验者已经添加过了!", {icon: 1});
				return ;
			}
			var id=data[0];
			var name=data[1];
			var tempNum=(""+data[2]).split("0");
			var num=tempNum[3];
			if(!confirm("确认添加【" + name + "】" + "为会员吗？"))
			{
				return;
			}
			$.post("${pageContext.request.contextPath}/experience/joinVIP.action",{id:id},function(data){
				getData($(".active").html(),page2);
			});			
		})
	}
	//加入VIP点击事件
	//*未修复：1.重复添加会员
	//	    2.添加会员后，不能重置取消会员资格，否则会员编号，会和提示框中的编号不同
	function previpclick(){
		$(".preVIP").click(function(){
			//alert("功能暂未完善！");
			//return false;
			var data=this.lang.split(",");
			if('true' == data[3]) {
				layer.msg("该体验者已经添加过了!", {icon: 1});
				return ;
			}
			var id=data[0];
			var name=data[1];
			var tempNum=(""+data[2]).split("0");
			var num=tempNum[3];
			if(!confirm("确认添加【" + name + "】" + "为预科计划吗？"))
			{
				return;
			}
			$.post("${pageContext.request.contextPath}/experience/joinPreVIP.action",{id:id},function(data){
				getData($(".active").html(),page2);
			});			
		})
	}
	//退出点击事件
	function leftclick(){
		$(".left").click(function(){
			var str = this.lang.split(",");
			var id=str[0];
			//alert(str[1]);
			if('' != str[1]) {
				layer.msg("<b style='color:red;'>该体验者已经退出或者变成会员了！</b>", {icon: 2});
				return ;
			}
			$.post("${pageContext.request.contextPath}/experience/leftVIP.action",{id:id},function(data){
				getData($(".active").html(),page2);
				});
		})
	}
	//重置点击事件
	function resetclick(){
		$(".reset").click(function(){
			var id=this.lang;
			$.post("${pageContext.request.contextPath}/experience/resetVIPFlag.action",{id:id},function(data){
				getData($(".active").html(),page2);
				});
		})
	}
	//删除点击事件
	function deleteclick(){
		$(".delete").click(function(){
			var id = this.lang;
			layer.confirm('您确定要删除该用户吗?删除该用户时，同时也会删除该用户的基本信息和信用信息，请谨慎操作！',{btn:['是','否']},//按钮一的回调函数
					function(){
						$.post("${pageContext.request.contextPath}/user/deleteById.action?id=" + id,function(data){
						layer.closeAll('dialog');
						getData($(".active").html(),page2);
						});
			});
		});
	}
	//点击姓名显示信息事件
	function einfoOn(){
		$(".einfo").click(function(){
			$.ajaxSetup({async:false});
			$.post("${pageContext.request.contextPath}/experience/getExperienceById.action",{id:this.lang},function(data){
				var info=data.name+"<br/>";
				info+="手机号码：" + data.phone+"<br/>";
				info+="QQ号码："+data.qq;
				layer.alert(info);
			});
		});
	}
	
	//详细信息点击事件
	function msgclick(){
		$(".msg").click(function(){
			var x=$(this);
			$.post("${pageContext.request.contextPath}/user/getinfo.action?id=" + this.lang,function(data){
				var info="";
				if(data==""){
					info="没有信息，该会员还没有填写";
				}else{
					info="<table class='table table-border table-bg table-bordered radius'>";
					info+="<tr>";
					info+="<td>身份证号码</td><td>"+ data.idNo + "</td>";
					info+="</tr><tr>";
					info+="<td>QQ号码</td><td>" + data.qqNo + "</td>"; 
					info+="</tr><tr>";
					info+="<td>支付宝</td><td>" + data.payAccount + "</td>"; 
					info+="</tr><tr>";
					info+="<td>家庭联系人</td><td>" + data.contactName + "</td>"; 
					info+="</tr><tr>";
					info+="<td>家庭联系人手机</td><td>" + data.contactMobile + "</td>"; 
					info+="</tr><tr>";
					info+="<td>与家庭联系人关系</td><td>" + data.relation + "</td>"; 
					info+="</tr><tr>";
					info+="<td>收件地址</td><td>" + data.address + "</td>"; 
					info+="</tr><tr>";
					info+="</table>";
				}						
				layer.alert(info);
			});
		});
	}
	function drawTable(data){
		var line="";
		line=line + "<thead class='text-c'>";
		line=line + "<tr style='white-space: nowrap'>";
		line=line + "<th>序号</th>";
		line=line + "<th>用户名</th>";
		line=line + "<th>真实姓名</th>";
		line=line + "<th>类型</th>";	
		line=line + "<th style='text-align:left;'>毕业学校</th>";
		line=line + "<th>开始时间</th>";
		line=line + "<th>结束时间</th>";
		line=line + "<th>会员编号</th>";
		line=line + "<th>助教</th>";
		line=line + "<th>沟通信息</th>";
		line=line + "<th>操作</th>";	
		line=line + "</tr>";
		line=line + "</thead>"
		
		for(i=0;i<data.length;i++){
			var student="在学"
			if(data[i].student==false){
				student="在职";
			}
			var aname="";
			if(data[i].admin!=null){
				aname=data[i].admin.realname;
			}
			var membernum="";
			if(data[i].user!=null){
				membernum=data[i].user.name;
			}
			line=line + "<tbody class='text-c'>"
			var endtime="";
			if(data[i].endtime!=null){
				endtime=data[i].formatEndtime;
				if(data[i].flag==1){
					//加入vip，用绿色
					line=line+"<tr class='joinline'>";
				}else if(data[i].flag==2){
					//加入pre-vip，用红色
					line=line+"<tr class='preline'>";
				}else{
					//退出vip
					line=line+"<tr class='leftline'>";
				}			
			}
			else{
				line=line + "<tr class=''>"
			}
			line=line + "<td>" + (i+1) + "</td>";
			line=line + "<td>" + data[i].num + "</td>";
			line=line + "<td class='einfo' lang='" + data[i].id + "'>" + data[i].name + "</td>";
			line=line + "<td>" + student +  "</td>";	
			line=line + "<td style='text-align:left;'>" + data[i].school + "</td>";	
			line=line + "<td>" + data[i].formatBegintime + "</td>";
			line=line + "<td>" + endtime + "</td>";
			line=line + "<td>" + membernum + "</td>";
			line=line + "<td>" + aname + "</td>";
			line=line + "<td class='memo' id='memo"+(i+1)+"'>";
			line=line + "<a href='javascript:void(0)' title='添加' style='text-decoration:none' class='addCommunication' lang='" + data[i].id + "," + data[i].name +"'>添加"+"</a>&nbsp;|&nbsp;";
			line=line + "<a href='javascript:void(0)' title='查看' style='text-decoration:none' class='lookCommunication' lang='" + data[i].id + "," + data[i].name +"'>查看"+"</a>";
			line=line + "</td>";
			line=line + "<td>";
			line=line + "<a href='javascript:void(0)' title='加入' style='text-decoration:none' class='join' lang='"+ data[i].id + "," + data[i].name + "," + data[i].num + "," + data[i].flag +"'>加入"+"</a>&nbsp;|&nbsp;";
			line=line + "<a href='javascript:void(0)' title='预科' style='text-decoration:none' class='preVIP' lang='"+ data[i].id + "," + data[i].name + "," + data[i].num + "," + data[i].flag +"'>预科"+"</a>&nbsp;|&nbsp;";
			line=line + "<a href='javascript:void(0)' title='退出' style='text-decoration:none' class='left' lang='"+ data[i].id + "," + endtime +"'>退出"+"</a>&nbsp;|&nbsp;";
			line=line + "<a href='javascript:void(0)' title='重置' style='text-decoration:none' class='reset' lang='"+data[i].id+"'><i class='Hui-iconfont'>&#xe66b;</i></a>&nbsp;|&nbsp;";
			line=line + "<a href='javascript:void(0)' title='修改' style='text-decoration:none' class='modify' lang='"+data[i].id+"'><i class='Hui-iconfont'>&#xe6df;</i></a>&nbsp;|&nbsp;";
			line=line + "<a href='javascript:void(0)' title='删除' style='text-decoration:none' class='delete' lang='"+data[i].id+"'><i class='Hui-iconfont'>&#xe609;</i></a>";
			line=line + "</td>";
			line=line + "</tr>";
			line=line + "</tbody>"
		}
		$("#experience").html(line);
	
	}
});
</script>

</head>
<body>
	<c:if test="${admin==null}">
	<jsp:forward page="/user/login.jsp"></jsp:forward>
	</c:if>		
	<h1 style="text-align:center">体验用户管理</h1>
	<!-- class="cl pd-5 bg-1 bk-gray mt-20" -->
	<div   class="btn-group" style="float:left" id="title"> 
		<span class="l">
			<span class="btn btn-primary radius active butname">全部信息</span>
			<span class="btn btn-primary radius butname">正在体验</span>
			<span class="btn btn-primary radius butname">已经加入</span>
			<span class="btn btn-primary radius butname">已经退出</span>
			<span class="btn btn-primary radius butname">预科计划</span>
			<a class="btn btn-primary radius" href="javascript:;" id="add"><i class="Hui-iconfont">&#xe600;</i> 添加体验者</a>
		</span>  
		
	</div>
	
	
	<div class="mt-20 ">
		
		<table id="experience" class="table table-border table-bg table-bordered radius" style='white-space: nowrap'></table>
	</div>
	<div id="msgnull" align="center"  style="font-size:20px;color:#F00" ></div>
 	<br>
	<div class='page-nav' style="padding-right:120px"></div>
</body>
</html>