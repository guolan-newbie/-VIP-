package tools;

import java.io.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.text.SimpleDateFormat;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;

import entity.Admin;
import entity.Clue;
import entity.User;

/**
 * 利用开源组件POI3.0.2动态导出EXCEL文档
 * 转载时请保留以下信息，注明出处！
 * @author leno
 * @version v1.0
 * @param <T> 应用泛型，代表任意一个符合javabean风格的类
 * 注意这里为了简单起见，boolean型的属性xxx的get器方式为getXxx(),而不是isXxx()
 * byte[]表jpg格式的图片数据
 */
public class ExportFileExcel {
 
   public void exportExcel(String title, String[] headers,
         List<User>list,String path) {
	   	  OutputStream out = null;
	try {
		out = new FileOutputStream(path);
	} catch (FileNotFoundException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
      // 声明一个工作薄
      HSSFWorkbook workbook = new HSSFWorkbook();
      // 生成一个表格
      HSSFSheet sheet = workbook.createSheet(title);
      // 设置表格默认列宽度为15个字节
      sheet.setDefaultColumnWidth((short) 15);
      // 生成一个样式
      HSSFCellStyle style = workbook.createCellStyle();
      // 设置这些样式
      style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);
      style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
      style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
      style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
      style.setBorderRight(HSSFCellStyle.BORDER_THIN);
      style.setBorderTop(HSSFCellStyle.BORDER_THIN);
      style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
      // 生成一个字体
      HSSFFont font = workbook.createFont();
      font.setColor(HSSFColor.VIOLET.index);
      font.setFontHeightInPoints((short) 12);
      font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
      // 把字体应用到当前的样式
      style.setFont(font);
      // 生成并设置另一个样式
      HSSFCellStyle style2 = workbook.createCellStyle();
      style2.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
      style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
      style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
      style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
      style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
      style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
      style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
      style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
      // 生成另一个字体
      HSSFFont font2 = workbook.createFont();
      font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
      // 把字体应用到当前的样式
      style2.setFont(font2);
     
      // 声明一个画图的顶级管理器
      HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
      // 定义注释的大小和位置,详见文档
      HSSFComment comment = patriarch.createComment(new HSSFClientAnchor(0, 0, 0, 0, (short) 4, 2, (short) 6, 5));
      // 设置注释内容
      comment.setString(new HSSFRichTextString("可以在POI中添加注释！"));
      // 设置注释作者，当鼠标移动到单元格上是可以在状态栏中看到该内容.
      comment.setAuthor("leno");
 
      //产生表格标题行
      HSSFRow row = sheet.createRow(0);
      for (short i = 0; i < headers.length; i++) {
         HSSFCell cell = row.createCell(i);
         cell.setCellStyle(style);
         HSSFRichTextString text = new HSSFRichTextString(headers[i]);
         cell.setCellValue(text);
      }
 
      //遍历集合数据，产生数据行
      Iterator<User> u=list.iterator();
      int index=0;
      while(u.hasNext()){
    	  index++;
          row = sheet.createRow(index);
          User user=u.next();
              //利用反射，根据javabean属性的先后顺序，动态调用getXxx()方法得到属性值
              //flag判断是否跳出循环
              boolean flag=false;
              short k=0;
              for (k = 0; k < headers.length; k++) {
                 HSSFCell cell = row.createCell(k);
                 cell.setCellStyle(style2);
                 Object value=null;
                 try {
                	 if(k==0){value = index;}
                	 if(k==1){value = user.getName();}
                	 if(k==2){value = user.getMember().getName();}
                	 if(k==3){value = user.getMember().getSchool();}
                	 if(k==4){value = user.getMember().getMobile();}
                	 if(k==5){value = user.getMember().getCompany();}
                	 if(k==6){value = user.getMember().getGraduateDate();}
                	 if(k==7){value = user.getMember().isAbnormal();}
                	 if(k==8){value = user.getMember().getStudent();}
                     //判断值的类型后进行强制类型转换
                     String textValue = null;
                     if (value instanceof Boolean) {
                        boolean bValue = (Boolean) value;
                        textValue = "是";
                        if (!bValue) {
                           textValue ="否";
                        }
                     } else if (value instanceof Date) {
                        Date date = (Date) value;
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                         textValue = sdf.format(date);
                     }  else{
                        //其它数据类型都当作字符串简单处理
                        textValue = value.toString();
                     }
                     //如果不是图片数据，就利用正则表达式判断textValue是否全部由数字组成
                     if(textValue!=null){
                        Pattern p = Pattern.compile("^//d+(//.//d+)?$");  
                        Matcher matcher = p.matcher(textValue);
                        if(matcher.matches()){
                           //是数字当作double处理
                           cell.setCellValue(Double.parseDouble(textValue));
                        }else{
                           HSSFRichTextString richString = new HSSFRichTextString(textValue);
                           HSSFFont font3 = workbook.createFont();
                           font3.setColor(HSSFColor.BLUE.index);
                           richString.applyFont(font3);
                           cell.setCellValue(richString);
                        }
                     }
                 } catch (SecurityException e) {
                     // TODO Auto-generated catch block
                     e.printStackTrace();
                 } catch (IllegalArgumentException e) {
                     // TODO Auto-generated catch block
                     e.printStackTrace();
                 } finally {
                     //清理资源
                 }
              }
      
              try {
                  workbook.write(out);
               } catch (IOException e) {
                  // TODO Auto-generated catch block
                  e.printStackTrace();
               }
           }
      }      
}