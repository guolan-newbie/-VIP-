<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>计算器</title>
<style type="text/css">
body {
	
    width: 600px;
    margin: 40px auto;
    font-family: 'trebuchet MS', 'Lucida sans', Arial;
    font-size: 14px;
    color: #444;
    text-algin:center
}

table {
    *border-collapse: collapse; /* IE7 and lower */
    border-spacing: 0;
    width: 100%;    
   
}

.bordered {
    border: solid #ccc 1px;
    -moz-border-radius: 6px;
    -webkit-border-radius: 6px;
    border-radius: 6px;
    -webkit-box-shadow: 0 1px 1px #ccc; 
    -moz-box-shadow: 0 1px 1px #ccc; 
    box-shadow: 0 1px 1px #ccc;  
           
}

.bordered tr:hover {
    background: #fbf8e9;
    -o-transition: all 0.1s ease-in-out;
    -webkit-transition: all 0.1s ease-in-out;
    -moz-transition: all 0.1s ease-in-out;
    -ms-transition: all 0.1s ease-in-out;
    transition: all 0.1s ease-in-out;
      
}    
    
.bordered td, .bordered th {
    border-left: 1px solid #ccc;
    border-top: 1px solid #ccc;
    padding: 10px;
    text-align: left;    
}

.bordered th {
    background-color: #dce9f9;
    background-image: -webkit-gradient(linear, left top, left bottom, from(#ebf3fc), to(#dce9f9));
    background-image: -webkit-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:    -moz-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:     -ms-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:      -o-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:         linear-gradient(top, #ebf3fc, #dce9f9);
    -webkit-box-shadow: 0 1px 0 rgba(255,255,255,.8) inset; 
    -moz-box-shadow:0 1px 0 rgba(255,255,255,.8) inset;  
    box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;        
    border-top: none;
    text-shadow: 0 1px 0 rgba(255,255,255,.5); 
}

/* .bordered td:first-child, .bordered th:first-child {
    border-left: none;
}
 */
.bordered th:first-child {
    -moz-border-radius: 6px 0 0 0;
    -webkit-border-radius: 6px 0 0 0;
    border-radius: 6px 0 0 0;
}

.bordered th:last-child {
    -moz-border-radius: 0 6px 0 0;
    -webkit-border-radius: 0 6px 0 0;
    border-radius: 0 6px 0 0;
}

.bordered th:only-child{
    -moz-border-radius: 6px 6px 0 0;
    -webkit-border-radius: 6px 6px 0 0;
    border-radius: 6px 6px 0 0;
}

.bordered tr:last-child td:first-child {
    -moz-border-radius: 0 0 0 6px;
    -webkit-border-radius: 0 0 0 6px;
    border-radius: 0 0 0 6px;
}

.bordered tr:last-child td:last-child {
    -moz-border-radius: 0 0 6px 0;
    -webkit-border-radius: 0 0 6px 0;
    border-radius: 0 0 6px 0;
}


</style>
<script type="text/javascript" src="${pageContext.request.contextPath }/jslib/jquery-1.11.1.js"></script>
</head>
<body>
<form>
<table class="bordered">
<tr>
<td>总费用：</td>
<td><input type="text" id="feiyong" value="8000" /></td>
</tr>
<tr>
<td>月利率是：</td>
<td><input type="text" id="lilv" value="1.5" /></td>
</tr>
<tr>
<td>每月交</td>
<td><input type="text" id="money" value="500元" /></td>
</tr>
<tr>
<td>一共要交： </td>
<td><input type="text" id="total"/></td>
</tr>
<tr>
<td><input type="button" id="btn1" value="计算详单"/></td>
<td></td>
<tr>
<td>首付金额：</td>
<td><input type="text" id="shoufu"/></td>
</tr>

<tr>
<td>几个月后提前还款：</td>
<td><input type="text" id="huankuan" /></td>
</tr>
<tr>
<td></td>
 <td><input type="button" id="btn2" value="提前还款" /></td>
<td><input type="button" id="btn3" value="打印提前还款清单" /></td>
</tr>
</table>
</form>
<div id="info">

</div>
<script type="text/javascript">
$(function(){
		$("#btn1").click(function(){
		var sf=$("#shoufu").val();
		var month=1;
		var y=1.015;
		//首付后剩余金额
		var x=8000-sf;
		var total=8000-sf;
		var lixi=0;
		var benjin=0;
		 $("#info").append("<div>首付款：" + sf + "元</div>");
		$("#info").append("<table class='bordered'>");
		$("#info").append("<tr class='bordered'><td>月份</td><td>利息</td><td>本金</td><td>每月总费用</td></tr>");
		for(month;month<26;month++){
			if(x>500){
				x=(x*y-500);
				//x=(x-500)*y
				//x=x*y;
				total=total+500;

				lixi=x*0.015;
				benjin=500-lixi;
				$("#info").append("<tr class='bordered'><td>" + month + "</td><td>" + Math.round(lixi) + "</td><td>" + Math.round(benjin) + "</td><td>" +Math.round(lixi+benjin) + "</td></tr>");
			}else{
				total=total+x;
				total=total+"";
				lixi=x*0.015;
				benjin=x-lixi;
				$("#info").append("<tr class='bordered'><td>" + month + "</td><td>" + Math.round(lixi) + "</td><td>" + Math.round(benjin) + "</td><td>" +Math.round(lixi+benjin)+ "(四舍五入)"+"</td></tr>");
				/* $("#sign").html("总共需要还：" + month + "月！");
				$("#sign").html("总共需要还：" + Math.round(total-8000) + "元钱！"); */
				break;
			}
		};
		$("#info").append("</table>");
		$("#total").val(Math.round(total-8000));
	});
	 $("#btn2").click(function(){ 
		var sf=$("#shoufu").val();
		var month=$("#huankuan").val();
		var y=1.015;
		var x=8000-sf;
		var total=0;
		var flag=0;
		
		for(var i=0;i<month;i++){
			//剩余本息
			x=x*y;
			//本月需要还的利息本金总额
			if(x>500){
				total=x;
				x=x-500;
				continue;

			}
			if(0<x && x<=500){
				total=x;
				x=x-500;
				flag=1;
				continue;
			}
			if(x<0){
				flag=2;
				break;
			}
		};
		if(flag==0){
			total = total +"";
			$("#sign").html("如果需要在第" + month + "月后提前还款，本月需要还款: " +Math.round(total)  + "元！");
			
		}
		if(flag==1){
			total = total +"";
			$("#sign").html("如果需要在第" + month + "月后提前还款，本月需要还款: " +Math.round(total) + "元！");
		
		}
		if(flag==2){
			$("#sign").html("已经还完了！");
		
		}
		
	});
	$("#btn3").click(function(){ 
		var month=$("#huankuan").val();
		 var sf=$("#shoufu").val();
		if(month>23){
			alert("超出还款月限!");
			return;
		};
		
		var y=1.015;
		var x=8000-sf;
		$("#info").append("<table  class='bordered'>");
		$("#info").append("<tr class='bordered'><td>月份</td><td>还款金额</td><td>还款金额中的利息</td><td>还款金额中的本金</td></td><td>剩余本息合计</td></tr>");
		for(var i=1;i<=month;i++){
			//还款金额中的利息
			lixi=x*0.015;
			//本息合计
			x=x*y;
			//还款金额中的本金
			benjin=x-lixi;
			
			//还款
			if(month!=i){
				$("#info").append("<tr class='bordered'><td>" + i + "</td><td>500</td><td>"+ Math.round(lixi) +"</td><td>" + Math.round(500-lixi) + "</td><td>" + Math.round(x-500) + "</td></tr>");
				x=x-500;
				continue;

			}
			if(month==i){
				$("#info").append("<tr class='bordered'><td>" + i + "</td><td>" + Math.round(x) + "</td><td>"+ Math.round(lixi) +"</td><td>" + Math.round(benjin) + "</td><td>" +Math.round(x) + "</td></tr>");
				x=x-500;
				break;
			}
		};
		$("#info").append("</table>");
	}); 
});
</script>
<div id="sign"></div>
</body>
</html>