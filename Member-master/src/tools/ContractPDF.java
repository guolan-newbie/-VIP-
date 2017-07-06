package tools;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.hwpf.usermodel.Range;
import org.springframework.stereotype.Component;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfWriter;

import dao.PeriodDAO;
import entity.User;
import entity.UserInfo;
@Component
public class ContractPDF {
	@Resource
	PeriodDAO periodDAO;
	//让整个类变得可操作,user来获取需要修改的内容，templetPath是模板文档路径，docPath是替换内容后的文档路径，pdfPath是在线预览的pdf文件路径。
//	public void createContractPDF(User user,String templetPath,String docPath,String pdfPath,UserInfo userinfo,HttpServletRequest request){
//		try {
//			String docpath=testWrite(user,templetPath, docPath, userinfo);
//			PDFReport(docpath, pdfPath,request);
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}

   public String testWrite(User user,String templetPath,String docPath,UserInfo userInfo,int sum,int first,int monthly) throws Exception {
	  InputStream is = new FileInputStream(templetPath);
      HWPFDocument doc = new HWPFDocument(is);
      Range range = doc.getRange();
      //把range范围内的变量进行替换 
      range.replaceText("contractNo", user.getName());
      range.replaceText("member.userinfo.idNo", userInfo.getIdNo());
      range.replaceText("member.Name", user.getMember().getName());
      range.replaceText("member.graduateDate", (new SimpleDateFormat("yyyy年MM月dd日").format(user.getMember().getGraduateDate())).toString());
      range.replaceText("member.school", user.getMember().getSchool());
      range.replaceText("member.phone", user.getMember().getMobile());
      range.replaceText("member.userinfo.qqNo", userInfo.getQqNo());
      range.replaceText("member.userinfo.payAccount", userInfo.getPayAccount());
      range.replaceText("member.userinfo.contactName", userInfo.getContactName());
      range.replaceText("member.userinfo.contactMobile", userInfo.getContactMobile());
      range.replaceText("member.userinfo.relation", userInfo.getRelation());
      range.replaceText("member.userinfo.address", userInfo.getAddress());
      range.replaceText("signDate", (new SimpleDateFormat("yyyy年MM月dd日").format(user.getMember().getTime())).toString());
      //费用信息
      range.replaceText("Amount", String.valueOf(sum));
      range.replaceText("First", String.valueOf(first));
      range.replaceText("Monthly", String.valueOf(monthly));
      range.replaceText("ACapital", digit(sum));
      range.replaceText("FCapital", digit(first));
      range.replaceText("MCapital", digit(monthly));
      File file=new File(docPath);
      if(file.exists()){
    	  file.delete();
      }
      OutputStream os = new FileOutputStream(docPath);
      //把doc输出到输出流中
      System.out.println(doc.toString());
      doc.write(os);
      this.closeStream(os);
      this.closeStream(is);
      return docPath;
   }
  
   /**
    * 关闭输入流
    * @param is
    */
   private void closeStream(InputStream is) {
      if (is != null) {
         try {
            is.close();
         } catch (IOException e) {
            e.printStackTrace();
         }
      }
   }
 
   /**
    * 关闭输出流
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
   public void PDFReport(String docPath,String pdfPath,HttpServletRequest request){
	   File file=new File(pdfPath);
	   if(file.exists()){
		   file.delete();
	   }
	   //Step 1—Create a Document.
	   Document doc = new Document();
	   try {
	   OutputStream out = new FileOutputStream(pdfPath);
	   //Step 2—Get a PdfWriter instance.
	   PdfWriter.getInstance(doc, out);
	   //Step 3—Open the Document.
	   doc.open();
	   //Step 4—Add content.
	   doc.add(new Paragraph(ISToString(docPath),setChineseFont(request)));
	   //Step 5—Close the Document.
	   doc.close();
	   out.close();
	} catch (DocumentException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (FileNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
   }
// 产生PDF字体
   public static Font setChineseFont(HttpServletRequest request) {
       BaseFont bf = null;
       Font fontChinese = null;
       try {
           String fontPath=request.getServletContext().getRealPath("") +"font" + java.io.File.separator + "1.TTF";
           bf = BaseFont.createFont(fontPath,
                   BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
           fontChinese = new Font(bf, 12, Font.NORMAL);
       } catch (DocumentException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
       } catch (IOException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
       }
       return fontChinese;
   }
   //
   public String ISToString(String docPath){
	   // 创建输入流读取DOC文件
	     FileInputStream in;
	     WordExtractor extractor = null;
	     String text = null;
		try {
			in = new FileInputStream(new File(docPath));
		    // 创建WordExtractor
		    extractor = new WordExtractor(in);
		    // 对DOC文件进行提取
		    text = extractor.getText();
		    in.close();
		    extractor.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return text;
   }
   public String digit(double n){
       String fraction[] = {"角", "分"};
       String digit[] = { "零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖" };
       String unit[][] = {{"元", "万", "亿"},
                    {"", "拾", "佰", "仟"}};

       String head = n < 0? "负": "";
       n = Math.abs(n);
        
       String s = "";
       for (int i = 0; i < fraction.length; i++) {
           s += (digit[(int)(Math.floor(n * 10 * Math.pow(10, i)) % 10)] + fraction[i]).replaceAll("(零.)+", "");
       }
       if(s.length()<1){
           s = "整";    
       }
       int integerPart = (int)Math.floor(n);

       for (int i = 0; i < unit[0].length && integerPart > 0; i++) {
           String p ="";
           for (int j = 0; j < unit[1].length && n > 0; j++) {
               p = digit[integerPart%10]+unit[1][j] + p;
               integerPart = integerPart/10;
           }
           s = p.replaceAll("(零.)*零$", "").replaceAll("^$", "零") + unit[0][i] + s;
       }
       return head + s.replaceAll("(零.)*零元", "元").replaceFirst("(零.)+", "").replaceAll("(零.)+", "零").replaceAll("^整$", "零元整");
   }   
}