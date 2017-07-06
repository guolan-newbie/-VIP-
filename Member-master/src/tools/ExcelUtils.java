package tools;

import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import entity.ExcelEntity;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.DateFormat;
import jxl.write.DateTime;
import jxl.write.Label;
import jxl.write.Number;
import jxl.write.NumberFormat;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
/**
 * 
 * @Title ExcelUtils
 * @Desription 完成table到excel的转换，以及excel样式的一些设计
 * @author 熊杰
 * @date 2017年3月11日
 */
public class ExcelUtils {
    public static WritableWorkbook createExcelByList(OutputStream outputStream , List<ExcelEntity> list  
    		) throws IOException, WriteException, ParseException {
        WritableWorkbook writableWorkbook= Workbook.createWorkbook(outputStream);
        Label nc0 = null;
        Label nc1 = null;
        Label nc2 = null;
        Label nc3 = null;
        Label nc4 = null;     
        Label nc5 = null;
        DateTime time0 = null;
        Number number0 = null;
        Number number1 = null;
        Number number2 = null;
        Number number3 = null;
//------------------------------------------------------------------------------------------------------        
//设置表格信息页面
        WritableSheet sheet = writableWorkbook.createSheet("缴费报表", 0);
        //设置excel样式
        //表头样式
        WritableFont headFont = new WritableFont(WritableFont.ARIAL , 12 );
        headFont.setColour(Colour.BLUE_GREY); // 字体颜色
        headFont.setItalic(true); // 斜体
        
        WritableCellFormat headFormat = new WritableCellFormat(headFont);
        
        // 单元格内容水平居中
        headFormat.setAlignment(Alignment.CENTRE);
          //边框
        headFormat.setBorder(Border.ALL, BorderLineStyle.THIN,jxl.format.Colour.BLACK); 
        //设置底色为冰蓝色
        headFormat.setBackground(jxl.format.Colour.ICE_BLUE);
        
        //表中内容样式
        WritableFont contentfont = new WritableFont(WritableFont.ARIAL , 12 );
        contentfont.setColour(Colour.BLACK); // 字体颜色
        WritableCellFormat contentFormat = new WritableCellFormat(contentfont);
        
        // 单元格内容水平居中
        contentFormat.setAlignment(Alignment.CENTRE);
        contentFormat.setBorder(Border.ALL, BorderLineStyle.THIN,jxl.format.Colour.BLACK); 
        //设置底色为白色
        contentFormat.setBackground(jxl.format.Colour.WHITE);   
        
        //分别设置时间Date和数值Number数据格式
        DateFormat dateFormat = new DateFormat("yyyy年m月d日");
        WritableCellFormat timeCellFormat = new WritableCellFormat(contentfont, dateFormat);
        timeCellFormat.setAlignment(Alignment.CENTRE);
        timeCellFormat.setBorder(Border.ALL, BorderLineStyle.THIN,jxl.format.Colour.BLACK); 
        timeCellFormat.setBackground(jxl.format.Colour.WHITE);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        
        NumberFormat numberFormat = new NumberFormat("0.00");
        WritableCellFormat numberCellFormat = new WritableCellFormat(contentfont,numberFormat);
        numberCellFormat.setAlignment(Alignment.CENTRE);
        numberCellFormat.setBorder(Border.ALL, BorderLineStyle.THIN,jxl.format.Colour.BLACK); 
        numberCellFormat.setBackground(jxl.format.Colour.WHITE);
        sheet.setColumnView(0, 20);
        
        //设置表头单元格高度
        sheet.setRowView(0,600);
        nc0 = new Label(0, 0, list.get(0).getMonth(),headFormat);
        nc1 = new Label(1, 0, list.get(0).getTime(),headFormat);
        nc2 = new Label(2, 0, list.get(0).getMpay(),headFormat);
        nc3 = new Label(3, 0, list.get(0).getInterest(),headFormat);
        nc4 = new Label(4, 0, list.get(0).getCapital(),headFormat);
        nc5 = new Label(5, 0, list.get(0).getNumInterest(),headFormat);
        
        sheet.addCell(nc0);
        sheet.addCell(nc1);
        sheet.addCell(nc2);
        sheet.addCell(nc3);
        sheet.addCell(nc4);
        sheet.addCell(nc5);
        //取出list中的table 展示在excel中
        sheet.setColumnView(0, 20);    
        for(int i =1;i< list.size();i++){
        	//设置第i列单元格宽度
            sheet.setColumnView(i, 20);       		
	        nc0 = new Label(0, i, list.get(i).getMonth(),contentFormat);
	        time0 = new DateTime(1, i, sdf.parse(list.get(i).getTime()),timeCellFormat);
	        number0 = new Number(2, i, Double.parseDouble(list.get(i).getMpay()),numberCellFormat);
	        number1 = new Number(3, i, Double.parseDouble(list.get(i).getInterest()),numberCellFormat);
	        number2 = new Number(4, i, Double.parseDouble(list.get(i).getCapital()),numberCellFormat);
	        number3 = new Number(5, i, Double.parseDouble(list.get(i).getNumInterest()),numberCellFormat);
	        sheet.addCell(nc0);
            sheet.addCell(time0);
            sheet.addCell(number0);
            sheet.addCell(number1);
            sheet.addCell(number2);
            sheet.addCell(number3);
        }
        return writableWorkbook;
	}

}
