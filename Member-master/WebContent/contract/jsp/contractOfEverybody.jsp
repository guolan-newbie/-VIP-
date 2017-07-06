<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="/WEB-INF/NumTag.tld" prefix="num" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
body{color: #222;
    font-family: "Helvetica Neue","Hiragino Sans GB","Microsoft YaHei","黑体",Arial,sans-serif !important;
    }
#a{
	line-height: 28px;
	font-size:22px;
	}
td{
	line-height: 28px;
	font-size:22px;
}
ol{
	list-style-type:demical;
	padding-left: 25px;
}
</style>

</head>
<body>
<div id="a">
<br/>
<h1 align="center">技术培训与服务协议</h1>
<p align="right">合同编号:${myuser.name }&nbsp;&nbsp;&nbsp;&nbsp;<br /></p>
<p>甲方(学员)：${myuser.member.name }</p>
<p>乙方(老师)：张中强 </p>
<p style="text-indent:2em;">感谢你对强哥团队（即乙方：张中强先生）的信任，选择接受强哥团队为你提供的终身技术培训与技术支持服务，并恭喜你已经顺利通过基础测试，加入到这个快乐的大家庭中来。为了确保大家在未来的合作过程中能够愉快相处，现将有关事项约定如下，以兹共同遵守。 </p>
<br/>
<p style="height: 35px;"><strong>一、前提条件： </strong></p>
<p style="text-indent:2em;">加入强哥这个学习团队，代表你完全理解、认同、接受并能认真执行强哥的培训理念，强哥的培训理念包括以下几个方面： </p>
<ol style="list-style-type:upper-roman">
  <li>IT技术学习的前提条件是：兴趣+毅力+正常的逻辑思维能力。请确认你已经具备了以上进入深入技术学习的首要条件。 </li>
  <li>人脉永远比技术更重要。加入强哥的学习团队，要求你有一颗开放的心，能够积极主动地和强哥学习团队的成员进行友好的交流。请确认你已经具备了一定的交流和沟通能力，在未来的学习和工作中，本着合作共赢的原则，加强与强哥学习团队成员之间的交流互动。 </li>
  <li>团结互助的原则。帮助别人，成就自己，强哥学习团队的每一个成员，都必须发扬团结互助的精神，利用自己已经掌握的知识，力所能及地为团队其他成员解决技术问题。请确认你有一颗互助友爱的心。 </li>
  <li>认可强哥终身师徒的人才培养模式，认可强哥的技术能力和讲课风格，愿意积极宣传和推广强哥独创的这种学习成长模式。请发自内心的确认你在未来相当长的一段时间内，愿意将帮助强哥和帮助自己结合起来，愿意和强哥一起把事业做大做强。 </li>
</ol>
<p style="height: 30px; padding-top: 15px; padding-bottom: 10px;"><strong>二、双方身份确认 </strong></p>
<p style="padding-bottom: 10px;"><strong>甲方  (VIP会员方)</strong></p>
<table>
  <tr>
    <td style="width: 180px">姓名:</td>
    <td>${myuser.member.name }</td>
  </tr>
  <tr>
    <td>身份证号码:</td>
    <td>${myuser.userInfo.idNo }</td>
  </tr>
  <tr>
    <td>常用联系电话:</td>
    <td>${myuser.member.mobile }</td>
  </tr>
  <tr>
    <td>常用联系QQ:</td>
    <td>${myuser.userInfo.qqNo }</td>
  </tr>
  <tr>
    <td>学校名称:</td>
    <td>${myuser.member.school }</td>
  </tr>
  <tr>
    <td>具体毕业时间:</td>
    <td><fmt:formatDate value="${myuser.member.graduateDate}" pattern="yyyy年MM月dd日" /></td>
  </tr>
  <tr>
    <td>支付宝账号:</td>
    <td>${myuser.userInfo.payAccount }</td>
  </tr>
</table>
<br/>
<p style="padding-bottom: 10px;"><strong>乙方(强哥)</strong></p>
<table>
  <tr>
    <td style="width: 180px">姓名:</td>
    <td>张中强</td>
  </tr>
  <tr>
    <td>身份证号码:</td>
    <td>230103197207296814</td>
  </tr>
  <tr>
    <td>常用联系电话:</td>
    <td>18610940288</td>
  </tr>
  <tr>
    <td>常用联系QQ:</td>
    <td>7213043</td>
  </tr>
  <tr>
    <td>支付宝账号:</td>
    <td>wizeman@126.com</td>
  </tr>
</table>
<br/>
<p style="height: 35px;"><strong>三、学习形式 </strong></p>
<ol style="list-style-type:upper-roman">
  <li>加入强哥的学习团队，首先需要通过基础能力测试。 </li>
  <li>基础能力测试通过后，缴纳第一部分学费，签订技术培训与服务合同，开始进入正式的学习阶段。 </li>
  <li>根据自己的情况安排时间，通过看强哥视频教程的方式进行学习。遇到不懂的问题，随时和强哥联系，或者在VIP群交流，解决问题。解决问题的方式包括QQ文字交流、QQ图片标注、QQ语音交流、QQ远程协助、QQ远程桌面共享讲解指导、电话交流、面对面直接指导等多种方式，以确保甲方的每一个技术问题，都能在最短时间内得到最完美的解决。 </li>
  <li>课程学习和技术支持服务不限于学习期间，甲方工作后仍然可以继续学习强哥不断更新的课程，遇到工作中不会的问题，强哥会第一时间安排人员协调解决。 </li>
  <li>每周必须要投入一定的时间学习，遇有特殊情况，需要提前向强哥请假。 </li>
  <li>每周周日24点之前必须提交前一周的学习情况汇报，报告自己一周的学习内容、交流自己在学习中遇到的问题、解决的办法，学习中的体会和心得、对生活和工作中遇到的问题的看法。 </li>
  <li>根据个人实际情况，所有基础课程学完以后，可以到北京参加为期一个月的线下实训，与强哥面对面交流。在北京学习期间，个人一切费用自理。 </li>
  <li>强哥提供面试技巧培训，简历修改服务，对每一次面试进行全程跟踪，协助联系实习和工作单位。 </li>
</ol>
<p style="height: 35px;padding-top: 15px; padding-bottom: 10px;"><strong>四、培训费用及缴纳方式 </strong></p>

<c:if test="${status == '0'}">
<p style="text-indent:2em;" >Java Web开发课程的全部费用合计为<strong><fmt:formatNumber value="${myuser.sum }" pattern="#0.00"/></strong>(<strong><num:NumTag num="${myuser.sum }"/></strong>)元人民币，不收取其他任何费用。费用分期缴纳，第一个月至少需缴纳<strong><fmt:formatNumber value="${myuser.first }" pattern="#0.00"/></strong>(<strong><num:NumTag num="${myuser.first }"/></strong>)元人民币，之后每月至少缴纳<strong><fmt:formatNumber value="${myuser.monthly }" pattern="#0.00"/></strong>(<strong><num:NumTag num="${myuser.monthly }"/></strong>)元人民币，直到交完为止。</p>
</c:if>

<c:if test="${status == '1'}">
<p style="text-indent:2em;" >Java Web开发课程的全部费用合计为<strong><fmt:formatNumber value="${myuser.sum }" pattern="#0.00"/></strong>(<strong><num:NumTag num="${myuser.sum }"/></strong>)元人民币，不收取其他任何费用。费用分期缴纳，第一个月至少需缴纳<strong><fmt:formatNumber value="${myuser.first }" pattern="#0.00"/></strong>(<strong><num:NumTag num="${myuser.first }"/></strong>)元人民币，之后至毕业日之前的每个月，至少缴纳<strong><fmt:formatNumber value="${myuser.monthly }" pattern="#0.00"/></strong>(<strong><num:NumTag num="${myuser.monthly }"/></strong>)元人民币，剩余部分自毕业之日起一年之内缴纳完毕，毕业之日起的四个月之内，考虑到甲方要安顿工作和生活，可以暂停缴纳培训费用，从第四个月开始，于每月规定缴费日期之前，每月至少要缴纳剩余学费的八分之一，即<strong><fmt:formatNumber value="${myuser.last }" pattern="#0.00"/></strong>(<strong><num:NumTag num="${myuser.last }"/></strong>)元人民币，直至交完为止。</p>
</c:if>

<c:if test="${status == '2'}">
<p style="text-indent:2em;" >Java Web开发课程的全部费用为<strong><fmt:formatNumber value="${myuser.sum }" pattern="#0.00"/></strong>(<strong><num:NumTag num="${myuser.sum }"/></strong>)元人民币，首付<strong><fmt:formatNumber value="${myuser.first }" pattern="#0.00"/></strong>(<strong><num:NumTag num="${myuser.first }"/></strong>)元人民币，月供<strong><fmt:formatNumber value="${myuser.monthly }" pattern="#0.00"/></strong>(<strong><num:NumTag num="${myuser.monthly }"/></strong>)元人民币，交<strong>${myuser.allMonth }</strong>期，最后一期不足月供，按实际金额<strong><fmt:formatNumber value="${myuser.last }" pattern="#0.00"/></strong>(<strong><num:NumTag num="${myuser.last}"/></strong>)元缴纳。</p>
</c:if>

<c:if test="${status == '3'}">
<p style="text-indent:2em;" >Java Web开发课程的全部费用为<strong><fmt:formatNumber value="${myuser.sum }" pattern="#0.00"/></strong>(<strong><num:NumTag num="${myuser.sum }"/></strong>)元人民币，费用一次性缴纳。</p>
</c:if>
<c:if test="${status == '4'}">
<p style="text-indent:2em;" >Java Web开发课程的全部费用为<strong><fmt:formatNumber value="${myuser.sum }" pattern="#0.00"/></strong>(<strong><num:NumTag num="${myuser.sum }"/></strong>)元人民币，<c:if test="${myuser.delayMonth != '0'}">考虑到甲方经济压力，前<strong>${myuser.delayMonth }</strong>个月可以延缓交费，之后</c:if>每月缴费<strong><fmt:formatNumber value="${myuser.monthly }" pattern="#0.00"/></strong>(<strong><num:NumTag num="${myuser.monthly }"/></strong>)元人民币，最后一期不足月供，按实际金额<strong><fmt:formatNumber value="${myuser.last }" pattern="#0.00"/></strong>(<strong><num:NumTag num="${myuser.last}"/></strong>)元缴纳。</p>
</c:if>

<p style="text-indent:2em;" >强哥的课程是一套整体性的课程，不设置分阶段收费。合同一旦签订，即认为甲方已经完全理解并接受完整的培训计划，认可缴纳全部培训费用。</p>
<p style="height: 35px;padding-top: 15px; padding-bottom: 10px;"><strong>五、服务品质保障 </strong></p>
<p style="text-indent:2em;" >甲方在学习过程中遇到的所有技术问题，乙方必须在五分钟内响应，解决甲方提出的所有技术问题，让甲方清楚明白问题产生的原因及修改的办法。服务时间为工作日早晨8:30 – 晚上：23:30。在以上正常的服务时间之外和国家法定节假日，乙方仍然会提供服务，并努力达到工作日的服务标准。 </p>
<p style="height: 35px;padding-top: 15px; padding-bottom: 10px;"><strong>六、奖励及惩罚 </strong></p>
<ol style="list-style-type:upper-roman">
  <li>培训费用必须按约定数额和约定时间提前或按期缴纳。延迟缴纳需按应缴纳金额每月2%的比例收取滞纳金。 </li>
  <li>甲方不按约定缴纳应缴费用，恶意违约，导致合同无法履行，非正常终止，且拒绝履行剩余培训费用和应缴利息清偿义务的，乙方将向甲方追偿所欠费用。追偿期间由于甲方不积极配合，产生的滞纳金、通讯费、交通费、误工费、律师费、调查费、差旅住宿费、材料费、诉讼费等一切费用，全部由甲方承担。培训费用追偿期间，乙方有权通过网络、报刊等公共媒体公布甲方个人信息及所欠债务信息，由此产生的一切额外费用由甲方承担。 </li>
  <li>推荐学员成功加入强哥学习团队的，对推荐者和新加入者，都有适当的奖励，各奖现金人民币200元，从应缴培训费中扣除。对强哥学习模式推广具有较大贡献者，年底进行嘉奖。 </li>
  <li>为了督促大家积极努力学习，形成一个良好的学习氛围，也便于强哥跟踪每一个学员的学习进度，了解大家在学习过程中遇到的问题，规定每周周日24点之前必须提交前一周的学习情况汇报。违反此规定者每次罚款10元。 </li>
  <li>所有费用和利息必须在工作一年之内结清。 </li>
 </ol>

<p style="height: 35px;padding-top: 15px; padding-bottom: 10px;"><strong>七、其他事项 </strong></p>

<p style="text-indent:2em;" >为了更好地为甲方提供终身服务，帮助甲方在工作中提高，甲方正常就业后，需要提交工作单位信息，录用信息。不愿提交工作单位信息者，视为主动放弃终身服务，乙方将不再为甲方提供任何技术支持服务，乙方可以立即开始追偿甲方所欠的所有费用。 </p>
<p style="text-indent:2em;" > 本合同在执行过程中产生的任何有关法律方面的纠纷，由武军社律师全权代理。任何与法律相关的问题，请咨询武军社，联系电话：13693101282。</p>
<p style="height: 35px;padding-top: 15px; padding-bottom: 10px;"><strong>八、附件资料 </strong></p>
<ol style="list-style-type:upper-roman">
  <li>甲方： </li>
<p style="text-indent:2em;" >甲方的户口本复印件、身份证复印件、联系电话、近期全身照片一张(电子版)。甲方需提供一名家庭联系人信息。家庭联系人必须为甲方直系亲属。甲方需要提供其家庭联系人身份证复印件和联系电话，乙方需要和甲方家庭联系人联系，确保其知悉甲方在接受乙方提供的技术培训和服务，并愿意在甲方不能正常履行合同义务时代为履行。 </p>
<table>
  <tr>
    <td style="width: 250px">家庭联系人姓名:</td>
    <td>${myuser.userInfo.contactName }</td>
  </tr>
  <tr>
    <td>家庭联系人电话:</td>
    <td>${myuser.userInfo.contactMobile}</td>
  </tr>
  <tr>
    <td>与家庭联系人关系:</td>
    <td>${myuser.userInfo.relation }</td>
  </tr>
  <tr>
    <td>本人收件地址:</td>
    <td>${myuser.userInfo.address }</td>
  </tr>
</table>
<li>乙方： </li>
<p style="text-indent:2em;" >公司营业执照复印件(北京趋势前程科技有限公司)、毕业证复印件、学位证复印件、MCP、MCSE、MCDBA证书复印件，联系电话，近期全身免冠照片。 </p>
<p style="text-indent:2em;" >乙方收件地址:北京市通州区万达广场A座917室  张中强 <nobr>联系电话:010-57120799</nobr></p>
</ol>
<p style="height: 35px; padding-top: 15px; padding-bottom: 10px;"><strong>九、其他事项</strong></p>
<p style="text-indent:2em;" >甲乙双方应保证所提供信息的真实性，提供虚假信息视为单方面违约。甲方提供虚假资料信息需立即支付乙方所有剩余学费。乙方提供虚假资料信息需立即偿还甲方所交学费，并按合同总标的赔偿给甲方带来的损失。</p>
<table>
 <tr>
    <td style="width: 250px">甲方(签字):</td>
    <td>${myuser.member.name }</td>
 </tr>
  <tr>
    <td>签字日期：</td>
    <td><fmt:formatDate value="${myuser.member.time}" pattern="yyyy年MM月dd日" /></td>
  </tr>
  <tr>
    <td>乙方(签字):</td>
    <td>张中强</td>
  </tr>
  <tr>
    <td>签字日期：</td>
    <td><fmt:formatDate value="${myuser.member.time}" pattern="yyyy年MM月dd日" /></td>
   </tr>
  </table>
</div>
</body>
</html>