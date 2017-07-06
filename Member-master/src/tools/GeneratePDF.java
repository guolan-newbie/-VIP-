package tools;

import java.awt.Insets;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.text.SimpleDateFormat;
import javax.annotation.Resource;
import org.springframework.stereotype.Component;
import org.zefer.pd4ml.PD4Constants;
import org.zefer.pd4ml.PD4ML;

import dao.PeriodDAO;
import entity.User;
import entity.UserInfo;

/**
 * 作者：农大辉，时间：2015.12.5 html生成pdf的工具了类，
 * outputPDFFile为pdf文件生成的地址，inputHTMLFileName为html的来自的地址
 * 用到了pd4ml的技术，pd4ml的依赖包：pd4ml_demo.jar，ss_css2.jar
 * 解决中文的乱码问题，建立一个fonts包，pd4ml.useTTF("java:fonts",true);设置字体。解决乱码
 */

@Component
public class GeneratePDF {
	@Resource
	PeriodDAO periodDAO;

	protected int topValue = 10;
	protected int leftValue = 20;
	protected int rightValue = 10;
	protected int bottomValue = 10;

	// 测试
	// public static void main(String[] args) throws Exception {
	// GeneratePDF converter = new GeneratePDF();
	// User user=new User();
	// user.setName("13");
	// UserInfo userInfo=new UserInfo();
	// String path="C:/contractForStudent.html";
	// String htmlpath=converter.texttestWrite(user, path,
	// "C:/dema.html","C:/demd.html", userInfo);
	// //htmlPath是替换内容后的文件路径
	// System.out.println("这是路径"+new File(htmlpath));
	// converter.generatePDF_2(htmlpath,new File("C:/demd1.pdf"));
	// }
	// 这是把html转换为Pdf的方法，File outputPDFFile为输出pdf的地址，String htmlPath为HTML的地址
	public void generatePDF(String htmlPath, File outputPDFFile) throws Exception {
		FileOutputStream fos = new FileOutputStream(outputPDFFile);
		PD4ML pd4ml = new PD4ML();
		// pd4ml.setPageInsets(new Insets(20, 10, 10, 10));
		pd4ml.setPageInsetsMM(new Insets(topValue, leftValue, bottomValue, rightValue));
		pd4ml.setHtmlWidth(1300);
		//pd4ml.setPageSize(pd4ml.changePageOrientation(PD4Constants.A4));
		pd4ml.setPageSize(PD4Constants.A4);
		pd4ml.useTTF("java:fonts", true);
		pd4ml.setDefaultTTFs("SongTi_GB2312", "SongTi_GB2312", "SongTi_GB2312");
		pd4ml.enableDebugInfo();
		pd4ml.render("file:" + htmlPath, fos);
	}

	// 读取html的内容，然后替换关键字,htmlPath是替换内容后的文件路径
	public String replaceKeyWords(User user, String inputHTMLFileName, String htmlPath, String pdfPath,
			UserInfo userInfo) throws IOException {
		String data = "";
		// 替换关键字
		data = GeneratePDF.getFileData(inputHTMLFileName);// 返回读取的数据的内容
		data = data.replace("contractNo", "<font face=\"KaiTi_GB2312\">" + user.getName() + "</font>");
		data = data.replace("member.userinfo.idNo", userInfo.getIdNo());
		data = data.replace("member.userinfo.qqNo", userInfo.getQqNo());
		data = data.replace("member.Name", user.getMember().getName());
		data = data.replace("member.graduateDate",
				(new SimpleDateFormat("yyyy年MM月dd日").format(user.getMember().getGraduateDate())).toString());
		data = data.replace("member.school", "<font face=\"KaiTi_GB2312\">" + user.getMember().getSchool() + "</font>");
		data = data.replace("member.phone", user.getMember().getMobile());
		data = data.replace("member.userinfo.payAccount", userInfo.getPayAccount());
		data = data.replace("member.userinfo.contactName", userInfo.getContactName());
		data = data.replace("member.userinfo.contactMobile", userInfo.getContactMobile());
		data = data.replace("member.userinfo.relation", userInfo.getRelation());
		data = data.replace("member.userinfo.address", userInfo.getAddress());
		data = data.replace("signDate",
				(new SimpleDateFormat("yyyy年MM月dd日").format(user.getMember().getTime())).toString());
		String newPeriodInfo = "";

		int mid = user.getMember().getId();
		int delayMonth = periodDAO.getDelayMonthyByMid(mid);

		// 判断是新分期还是全费还是旧分期
		if (user.getMember().getPeriodStatus() == 1) {
			newPeriodInfo = "Java Web开发课程的全部费用为<strong>Amount</strong>(<strong>ACapital</strong>)元人民币，首付<strong>First</strong>(<strong>FCapital</strong>)元人民币，月供<strong>Monthly</strong>(<strong>MCapital</strong>)元人民币，交<strong>AllMonth</strong>期，最后一期不足月供，按实际金额<strong>Last</strong>(<strong>LCapital</strong>)元缴纳。";
		} else if (user.getMember().getPeriodStatus() == 2) {
			newPeriodInfo = "Java Web开发课程的全部费用为<strong>Amount</strong>(<strong>ACapital</strong>)元人民币，费用一次性缴纳。";
		} else if (user.getMember().getPeriodStatus() == 0 && true == user.getMember().getStudent()) {
			newPeriodInfo = "Java Web开发课程的全部费用合计为<strong>Amount</strong>(<strong>ACapital</strong>)元人民币，不收取其他任何费用。费用分期缴纳，第一个月至少需缴纳<strong>First</strong>(<strong>FCapital</strong>)元人民币，之后至毕业日之前的每个月，至少缴纳<strong>Monthly</strong>(<strong>MCapital</strong>)元人民币，剩余部分自毕业之日起一年之内缴纳完毕，毕业之日起的四个月之内，考虑到甲方要安顿工作和生活，可以暂停缴纳培训费用，从第四个月开始，于每月规定缴费日期之前，每月至少要缴纳剩余学费的八分之一，即<strong>Last</strong>(<strong>LCapital</strong>)元人民币，直至交完为止。";
		} else if (user.getMember().getPeriodStatus() == 3) {
			if (delayMonth != 0) {
				newPeriodInfo = "Java Web开发课程的全部费用合计为<strong>Amount</strong>(<strong>ACapital</strong>)元人民币，考虑到甲方经济压力，前<strong>DelayMonth</strong>个月可以延缓交费，之后每月缴费<strong>Monthly</strong>(<strong>MCapital</strong>)元人民币，最后一期不足月供，按实际金额<strong>Last</strong>(<strong>LCapital</strong>)元缴纳。";
			} else {
				newPeriodInfo = "Java Web开发课程的全部费用合计为<strong>Amount</strong>(<strong>ACapital</strong>)元人民币，每月缴费<strong>Monthly</strong>(<strong>MCapital</strong>)元人民币，最后一期不足月供，按实际金额<strong>Last</strong>(<strong>LCapital</strong>)元缴纳。";
			}
		} else {
			newPeriodInfo = "Java Web开发课程的全部费用合计为<strong>Amount</strong>(<strong>ACapital</strong>)元人民币，不收取其他任何费用。费用分期缴纳，第一个月至少需缴纳<strong>First</strong>(<strong>FCapital</strong>)元人民币，之后每月至少缴纳<strong>Monthly</strong>(<strong>MCapital</strong>)元人民币，直到交完为止。";
		}
		data = data.replace("CONTENT", newPeriodInfo);

		// 替换费用信息
		// int mid=user.getMember().getId();
		double sum = periodDAO.getSum(mid);
		double first = periodDAO.getFirst(mid);
		double monthly = periodDAO.getMonthly(mid);
		int allMonth = periodDAO.getAllMonthByMid(mid) - 2;
		// int delayMonth=periodDAO.getDelayMonthyByMid(mid);
		double last = periodDAO.getLast(mid);
		data = data.replace("Amount", String.valueOf(sum));
		data = data.replace("First", String.valueOf(first));
		data = data.replace("Monthly", String.valueOf(monthly));
		data = data.replace("AllMonth", String.valueOf(allMonth));
		data = data.replace("Last", String.valueOf(last));
		data = data.replace("DelayMonth", String.valueOf(delayMonth));
		data = data.replace("ACapital", digit(sum));
		data = data.replace("FCapital", digit(first));
		data = data.replace("MCapital", digit(monthly));
		data = data.replace("LCapital", digit(last));
		File file = new File(htmlPath);
		if (file.exists()) {
			file.delete();
		}
		// 往文件中写入字符串
		OutputStream os = new FileOutputStream(file);
		os.write(data.getBytes());
		// 把html输出到输出流中
		this.closeStream(os);
		// 返回替换后的内容的文件的路径
		return htmlPath;
	}

	/**
	 * 关闭输出流
	 * 
	 * @param os
	 */
	private void closeStream(OutputStream os) {
		if (os != null) {
			try {
				os.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	// 读取文件中的内容到string
	public static String getFileData(String inputHTMLFileName) {
		StringBuffer document = new StringBuffer();
		try {
			File file = new File(inputHTMLFileName);
			// InputStream读取文件流，对文件进行读取,就是字节流的输入
			InputStream is = new FileInputStream(file);
			// BufferedReader,从文件中读入字符数据并置入缓冲区,提高读取的速度，以gbk的编码方式读取
			InputStreamReader ips = new InputStreamReader(is, "utf-8");
			BufferedReader reader = new BufferedReader(ips);
			String line = null;
			while ((line = reader.readLine()) != null)
				document.append(line + " ");
			reader.close();
			is.close();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 返回读取的数据的内容
		return document.toString();
	}

	// 把费用的数字类型改为繁体字
	public String digit(double n) {
		String fraction[] = { "角", "分" };
		String digit[] = { "零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖" };
		String unit[][] = { { "元", "万", "亿" }, { "", "拾", "佰", "仟" } };

		String head = n < 0 ? "负" : "";
		n = Math.abs(n);

		String s = "";
		for (int i = 0; i < fraction.length; i++) {
			s += (digit[(int) (Math.floor(n * 10 * Math.pow(10, i)) % 10)] + fraction[i]).replaceAll("(零.)+", "");
		}
		if (s.length() < 1) {
			s = "整";
		}
		int integerPart = (int) Math.floor(n);

		for (int i = 0; i < unit[0].length && integerPart > 0; i++) {
			String p = "";
			for (int j = 0; j < unit[1].length && n > 0; j++) {
				p = digit[integerPart % 10] + unit[1][j] + p;
				integerPart = integerPart / 10;
			}
			s = p.replaceAll("(零.)*零$", "").replaceAll("^$", "零") + unit[0][i] + s;
		}
		return head + s.replaceAll("(零.)*零元", "元").replaceFirst("(零.)+", "").replaceAll("(零.)+", "零").replaceAll("^整$",
				"零元整");
	}
}
