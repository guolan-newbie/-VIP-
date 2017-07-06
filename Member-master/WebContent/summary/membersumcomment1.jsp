<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>我的周报-专注建立IT精英圈子</title>
	<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" /> 
		<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
    	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.all.js"></script>
    	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/lang/zh-cn/zh-cn.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>	
		<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">	
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/commensum.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/summary/bootstrap3.3.5.min.css">
		<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>  
<style type="text/css">
	.commcontendivcodd
	{
		padding-left:35px;
		padding-right:35px;
	}
	/*
	 * 修改：添加imgdiv,img;删除left,left span的样式以适应更新的周报界面
	 * 作者：王德斌
	 * 日期：2016-10-13
	*/	
	div#imgdiv {
		width: 50px;
		height: 50px;
		float: right;
		margin-top: 10px;
		margin-right: 15px;
	}
	
	.img {
		border-radius: 50%;
		width:50px;
		height:50px;
	} 
	/* 
	 * 修改：添加username,commentcdivseatprovince,commentcdivprovince样式;
	 *		修改commentcdivname,commentcdivtime,commentcdivassistant样式使其与新界面匹配
	 * 作者：王德斌
	 * 日期：2016-10-13 
	 */
	.username{
		font-weight: 600;
		position: relative;
		top: 19px;
		left: 20px;
	}
	.commentcdivname{
		position: relative;
		font-weight: 600;
		top: 19px;
		left: 30px;
	}
	.commentcdivtime{
		position: relative;
		font-weight: 600;
		top: 19px;
		left: 40px;
	}
	.commentcdivseatprovince{
		position: relative;
		font-weight: 600;
		top: 19px;
		left: 50px;
	}
	.commentcdivprovince{
		position: relative;
		font-weight: 600;
		top: 19px;
		left: 60px;
	}
	.commentcdivassistant{
		position: relative;
		top: 50px;
		left:-170px;
		font-size:13px;
		color:#1C86EE;
	}
</style> 
<script type="text/javascript">

$(function(){

	//获取url中的参数,以便返回
    (function ($) {
        $.getUrlParam = function (name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
    })(jQuery);
    var userType=null;
	var userID=null;
    var id = $.getUrlParam('id');
    var page2 = $.getUrlParam('page2');
    var ownerType = $.getUrlParam('ownerType');	
    var checkType = $.getUrlParam('checkType');
    var weekType = $.getUrlParam('weekType');
    var title = $.getUrlParam('title');

    var aa=0;
    var sumId;
    getSum(id);
    getComs(sumId);
	var ue = UE.getEditor('editor',{
		initialFrameWidth:600,
		initialContent:'请在此输入评论内容',
		autoClearinitialContent:true,
		enableAutoSave: false
	});
	ue.ready(function(){
		aa= UE.getEditor('editor').getContent();
	});	
	//在这里如果是看自己的最后一篇周报   就删除remind记录
	$.post("${pageContext.request.contextPath}/summary/remind.action",{pid:sumId});	
	//审核
	$("#icon").click(function(){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/summary/approveSumarry.action",{id:sumId},function(){
			$("#icon").attr({style:"color:red"});
		});					
		//设置审核隐藏域的值
		parent.$("#look").val('1');
	});
	//会员评论				
	$("#comment").click(function(){	
		var ue = UE.getEditor('editor');
		$.ajaxSetup({async:false});
		var contents=ue.getContent();
		//评论不能为空
		if(contents == "" || contents == aa){
			alert("评论内容不能为空");
			return;
		}
		$.post("${pageContext.request.contextPath}/summary/addComment.action",{content:contents,pid:sumId},function(data){
			if(data=="1"){
				//改变summary表中remind字段
				$.post("${pageContext.request.contextPath}/summary/remind.action",{pid:sumId});
				ue.ready(function(){
					ue.setContent("");
				});	
			}
			else{
				layer.open({
 					  type: 2,
 					  title: '登录',
 					  area: ['600px', '361px'],
 					  closeBtn: 0, //不显示关闭按钮
 					  shift: 1,
 					  shade: 0.5, //开启遮罩关闭
 					  content: '${pageContext.request.contextPath}/summary/login.jsp?state=3&id=0&contents='+contents,
 					  end: function(){
  	     					parent.layer.msg('登录成功', {
	    					    icon: 1,
	    					    time: 1000
	    					});
	     					var time=null;
	  		 					time=setInterval(function(){
	    	     				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	    						parent.layer.close(index);
	    					},1000);
 					    }
 					});
			}	
			getComs(sumId);	
		});
	});
	//管理员评论
	$("#commentadmin").click(function(){
		var contents=UE.getEditor('editor').getContent();
		
		//评论不能为空
		if(contents == "" || contents == aa){
			alert("评论内容不能为空");
			return;
		}
		$.post("${pageContext.request.contextPath}/summary/addComment.action",{content:contents,pid:sumId},function(data){
			if(data=="1"){
				//改变summary表中remind字段
				$.post("${pageContext.request.contextPath}/summary/remind.action",{pid:sumId});
				ue.ready(function(){
					ue.setContent("");
				});	
			}
			else{
				layer.open({
					  type: 2,
					  title: '登录',
					  area: ['600px', '361px'],
					  closeBtn: 0, //不显示关闭按钮
					  shift: 1,
					  shade: 0.5, //开启遮罩关闭
					  content: '${pageContext.request.contextPath}/summary/login.jsp?state=3&id=0&contents='+contents,
					  end: function(){
	     					parent.layer.msg('登录成功', {
	    					    icon: 1,
	    					    time: 1000
	    					});
	     					var time=null;
	  		 					time=setInterval(function(){
	    	     				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	    						parent.layer.close(index);
	    					},1000);
					    }
					});
			}	
			getComs(sumId);					
		});
	});	
	/*
	//管理员返回
	$("#adminreturn").click(function(){
		//location.href="${pageContext.request.contextPath}/admin/looksummarys.jsp?page2="+page2+"&checkType="+checkType+"&weekType="+weekType+"&title="+title;
		history.go(-1);
	});	
	//会员返回
	$("#memberreturn").click(function(){
			//location.href="${pageContext.request.contextPath}/member/looksummarys.jsp?page2="+page2+"&ownerType="+ownerType+"&checkType="+checkType+"&weekType="+weekType+"&title="+title;
		history.go(-1);
	})	*/
	
	//获取周报
	/*
	 * 修改：添加获取用户头像、出生地和所在地的代码
	 * 作者：王德斌
	 * 日期：2016-10-13
	 
	 * 修改：添加sex参数，修复默认头像显示问题
	 * 作者：王德斌
	 * 日期：2016-10-16
	*/	
    function getSum(id){
		$.ajaxSetup({async:false});
		var uid = "";
		var provid = "";
		var seat_provid = "";
    	$.post("${pageContext.request.contextPath}/summary/getSumById.action",{id:id},function(data){
    		var id=0;
    		var name="";
    		var adminname="";
    		var num="";
    		var sex;
			if(data.mid!=0){
				userID=id=data.member.id;
				//修改此处 name=data.member.id;
				userType="member";
				if(data.member.admin!=null){
					adminname="学习小助手："+data.member.admin.realname;
				}				
				//num=data.member.user.name;
				num=data.member.user.name+"&nbsp;&nbsp;"+data.member.name;
				uid = data.member.uid;
				provid = data.member.provid;
				seat_provid = data.member.seat_provid;
				sex=data.member.sex;
			}else{
				userID=id=data.experience.id;
				//修改此处 name=data.experience.id;
				userType="experience";
				if(data.experience.admin!=null){
					adminname="学习小助手："+data.experience.admin.realname;
				}			
				num=data.experience.num;
				provid = data.experience.province;
				seat_provid = data.experience.seat_provid;
				sex=data.experience.sex;
				//解决体验者序号显示不全的问题
				$(".username").css("font-size",1+"em");
			}
			$("#memid").val(id);
			$(".commentcdivname").html(name);
			$(".commentcdivtime").html(data.time);
			$(".commentcdivassistant").html(adminname);			
			$(".username").html(num);
			$("#sex").val(sex);
			/* $("#cont").html($(data.content).text()); */
			$("#cont").html(data.content);
			sumId=data.id;
			//alert(sumId);
			if(data.ischeck==1)
				{
					$("#icon2").attr({style:"color:red"});
					$("#icon").attr({style:"color:red"});
				}
    	})
    	getCover(uid);
		getSeatProvince(seat_provid);
		getProvince(provid);
    }
	//获取评论和浏览记录
    function getComs(id){
    	$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/summary/getComments.action",{id:id},function(data){
			if(data.summaries !="")
			{
				var commentsString="";
				$.each(data.summaries,function(i) {
					var memberid=0;
					var experienceid=0;
					var contentname;
					var contenttime=data.summaries[i].time;
					var content=data.summaries[i].content;
					if(data.summaries[i].member!=null)
					{
						memberid=data.summaries[i].member.id;
						contentname=data.summaries[i].member.name;
					}
					if(data.summaries[i].experience!=null)
					{
						experienceid=data.summaries[i].experience.id;
						contentname=data.summaries[i].experience.name;
					}
					if(data.summaries[i].admin !=null)
					{
						contentname="<font color='red'><b>"+data.summaries[i].admin.realname+"</b></font>";					
					}
					var commentString="<div class='commcontendivcod'>";
					commentString+="<span class='commcontendivcods'>"+contentname+"&nbsp;&nbsp;"+"</span>";
					commentString+="<span class='commcontendivcodsins'>"+contenttime+"</span>";
					if($("#isAdmin").val()=="admin"||memberid==$("#memberId").val()||experienceid==$("#experienceId").val()){
						commentString+="<span><a class='icon-delete-small' href='javascript:;' lang="+data.summaries[i].id+"><i class='Hui-iconfont'>&#xe6e2;</i></a></span>";
					}	
					if(($("#isAdmin").val()=="admin"&&memberid==0&&experienceid==0)||memberid==$("#memberId").val()||experienceid==$("#experienceId").val()){
						commentString+="<span><a class='icon-update-small' href='javascript:;' lang="+data.summaries[i].id+"><i class='Hui-iconfont'>&#xe60c;</i></a></span>";
					}
					commentString+="<div class='commcontendivcodd'>";
					commentString+="<br>";
					commentString+="<div>"+content+"</div>";
					commentString+="<br>";
					commentString+="</div>";	
					commentString+="</div>";						
					commentsString+=commentString;	
				});	
				$("#comments").html(commentsString);
			}
			else{
				var commentString="<div class='commcontendivcod'>";
				commentString+="<div class='commcontendivcodd2'>";
				commentString+="<div class='nocondiv'>";
				commentString+="<br>";
				commentString+="<span class='nocontent'>"+"暂无评论......"+"</span>";
				commentString+="<br>";	
				commentString+="</div>";	
				commentString+="</div>";
				commentString+="</div>";
				$("#comments").html(commentString);
			};
			if(data.summaryVisits !="") {
				var visitString = "";
				var visitAdmin = "";
				var visitUser = "";
				var visitExperience = "";
				$.each(data.summaryVisits,function(i) {
					if(data.summaryVisits[i].flag == 1) {
						visitAdmin += "<span class='label label-warning'>" + data.summaryVisits[i].name + "</span>\t";
					} else if(data.summaryVisits[i].flag == 2) {
						visitUser += "<span class='label label-success'>" + data.summaryVisits[i].name + "</span>\t";
					} else {
						visitExperience += "<span class='label label-info'>" + data.summaryVisits[i].name + "</span>\t";
					}
				});
				visitString += "<div class='commcontendivcod'><div class='commcontendivcodd'><br />";
				visitString += visitAdmin;	
				visitString += visitUser;
				visitString += visitExperience;	
				visitString += "<br /><br /></div></div>";
				$("#visit").html(visitString);
			}
			delComment();
			updateComment();
		});
    }
	//删除评论
    function delComment(){
		$(".icon-delete-small").click(function(){
			var id=this.lang;
			if(!confirm('您真的要删除此评论吗？'))
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
	
	//修改评论
	function updateComment(){
		$(".icon-update-small").click(function(){
			var id=this.lang;
			layer.open({
				type: 2,
				title: '修改评论',
				area: ['700px', '361px'],
				closeBtn: 1, //不显示关闭按钮
				shift: 1,
				shade: 0.5, //开启遮罩关闭
				content: '${pageContext.request.contextPath}/summary/modifycomment.jsp?id='+id
			});
		});
	}
	
	// 得到用户头像
	/* 
	 * 修改：添加sex参数，修复默认头像显示问题
	 * 作者：王德斌
	 * 日期：2016-10-16 
	 */
    function getCover(uid) {
		if(uid == ""){
			if($("#sex").val()=='男'){
				$("#imgdiv").html("<img src='${pageContext.request.contextPath}/images/user_male.png' alt='用户头像' class='img'>");
			}
			else{
				$("#imgdiv").html("<img src='${pageContext.request.contextPath}/images/user_female.png' alt='用户头像' class='img'>");
			}
		} else {
			$.ajaxSetup({
				async : false
			});
			$.post("${pageContext.request.contextPath}/picture/getCover.action", {
				id : uid
			}, function(data) {
				if (data != "") {
					$("#imgdiv").html("<img src='data: image/jpeg;base64," + data.photo + "' alt='用户头像' class='img'>");
				}
				else if($("#sex").val()=='男'){
					$("#imgdiv").html("<img src='${pageContext.request.contextPath}/images/user_male.png' alt='用户头像' class='img'>");
				}
				else{
					$("#imgdiv").html("<img src='${pageContext.request.contextPath}/images/user_female.png' alt='用户头像' class='img'>");
				}
			});
		}
	}

	// 得到用户出生地
	function getSeatProvince(seat_provid) {
		$.post("${pageContext.request.contextPath}/member/getProvByProvId.action", {
			provid : seat_provid
		}, function(data) {
			var seat_province = data.name;
			if (typeof (seat_province) == "undefined") {
				seat_province = "未设置";
			}
			var info = "出生地:" + seat_province;
			$(".commentcdivseatprovince").html(info);
		});
	}

	// 得到用户所在地
	function getProvince(provid) {
		$.post("${pageContext.request.contextPath}/member/getProvByProvId.action", {
			provid : provid
		}, function(data) {
			var province = data.name;
			if (typeof (province) == "undefined") {
				province = "未设置";
			}
			var info = "所在地:" + province;
			$(".commentcdivprovince").html(info);
		});
	}
	
	//管理员点击用户头像，跳出其个人信息和所有沟通信息
	/* 
	 * 作者：巨李岗
	 * 日期：2016-10-21 
	 */
	$("#imgdiv").click(function(){
		//location.href="${pageContext.request.contextPath}/admin/PersonalInfoAndCommunication.jsp";
		//alert($("#memid").val());
		if($("#isAdmin").val()=="admin")    //添加管理员权限
		{
			layer.open({
				  type: 2,
				  title: '会员信息和沟通信息',
				  area: ['700px', '450px'],
				 // closeBtn: 0, //不显示关闭按钮
				  shift: 1,
				  //maxmin: true,
				  shade: 0.5, //开启遮罩关闭
				  content: '${pageContext.request.contextPath}/admin/PersonalInfoAndCommunication.jsp?userID='+userID+"&userType="+userType,
				  end: function(){}
					//getData(checkType,weekType,title,page2,assistant);
				});
		}
	});	
 });
</script>

</head>
<body  style="background-color:#EEEEEE;">
	<c:if test="${myuser.member==null&&admin==null&&experience==null}">
	<c:redirect url="/user/login.jsp" />
	</c:if>
            <!-- 正文 -->
			<!-- <div class="content-wrap"> -->
	  <div id="contas">
		 <!-- 
		 * 修改：添加用户头像imgdiv、出生地commentcdivseatprovince及所在地commentcdivprovince
		 * 作者：王德斌
		 * 日期：2016-10-13
		 
		 * 修改：添加sex参数，修复默认头像显示问题
		 * 作者：王德斌
		 * 日期：2016-10-16 
		 -->
		<div class="commentcdiv">
			<div style="height: 50px;">
				<input type="hidden" id="sex" />
				<span class="username"></span>
				<span class="commentcdivname"></span>	
				<span class="commentcdivtime"></span>
				<span class="commentcdivseatprovince"></span>
				<span class="commentcdivprovince"></span>
				<span class="commentcdivassistant"></span>
				<div id="imgdiv"></div>
				<input type="hidden" id="memid">
			</div>
			<hr color="#00CCFF" style="height: 3px;" />
			<div class="commtent">
				<div id="cont">

				</div>
			</div>
			<br><br>
		</div>
		<!--
        	作者：615893265@qq.com
        	时间：2015-11-23
        	描述：这是审阅标记
        -->
		<div class="approvedi">
			<div class="approvedidiv">
			<c:choose>
				<c:when test="${admin!=null}">				
					<a href="javascript:;" id="icon" >
						<span class="glyphicon glyphicon-eye-open" style="font-size: 24px;" ></span>
					</a>
				</c:when>
				<c:when test="${admin==null}">		
					<div id="icon2" >
						<span class="glyphicon glyphicon-eye-open" style="font-size: 24px;" ></span>
					</div>
				</c:when>
			</c:choose>
			</div><br><br>
		</div>
		<!--
        	作者：615893265@qq.com
        	时间：2015-11-23
        	描述：这是评论内容列表
        -->
		<div class="commcontendiv" id="commcontendiv">
			<div  class="commcontendivtd">
				<span class="commcontendivtdspan">评论</span>
			</div>
			<div id="comments"></div>
		</div>
		<div class="commcontendiv" id="commcontendiv">
			<div  class="commcontendivtd">
				<span class="commcontendivtdspan">谁看过我</span>
			</div>
			<div id="visit"></div>
		</div>
		<!--
        	作者：615893265@qq.com
        	时间：2015-11-23
        	描述：这是写评论的编辑器
        -->
        <br><br>
		<div style="margin-left: 95px;width: 200px;">
			<script id="editor" type="text/plain" style="width: 120px;height: 100px;">
		    </script>
		</div>
		<div style="margin-left:95px ;float:left;">
		<c:choose>
			<c:when test="${admin==null&&(myuser.member!=null||experience!=null)}">
				<button class="btn" id="comment"><span style="color: #0000FF;">发表评论</span></button>
			</c:when>
			<c:when test="${admin!=null}">
				<button class="btn" id="commentadmin"><span style="color: #0000FF;">发表评论</span></button>
			</c:when>
		</c:choose>
			&nbsp;&nbsp;&nbsp;
			<!-- 去除返回功能
		<c:choose>
			<c:when test="${admin!=null}">
				<button class="btn" id="adminreturn"><span style="color:red ;">返回</span></button>
			</c:when>
			<c:when test="${admin==null&&myuser.member!=null}">
				<button class="btn" id="memberreturn"><span style="color:red ;">返回</span></button>
			</c:when>
		</c:choose>	
		 -->	
		 <c:choose>
			<c:when test="${admin==null&&(myuser.member!=null||experience!=null)}">
				<input type="hidden" value="notadmin" id="isAdmin">
				<input type="hidden" value="${myuser.member.id}" id="memberId">
				<input type="hidden" value="${myuser.member.id}" id="experienceId">				
			</c:when>
			<c:when test="${admin!=null}">
				<input type="hidden" value="admin" id="isAdmin">
			</c:when>
		</c:choose>			
		<div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div>
	  </div>
	 <div>	

	 </div>
			</div>




</body>
</html>