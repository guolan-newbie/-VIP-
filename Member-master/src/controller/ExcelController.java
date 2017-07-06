package controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import entity.ExcelEntity;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import tools.DateFormatUtils;
import tools.ExcelUtils;
import tools.JsonUtils;
import tools.RandomNumberUtils;

@Controller
public class ExcelController {
	
	private List<ExcelEntity> list = new ArrayList<>();
	
	@RequestMapping("/transferValue.action")
	@ResponseBody
	public String transferTValue(String tableJson) {
		list = JsonUtils.jsonToList(tableJson, ExcelEntity.class);
		return null;
	}

	@RequestMapping("download.action")
	public String download(HttpServletResponse response){
		
		//借助工具类生成时间+随机四位数字的xls文件名	
		String string4 = RandomNumberUtils.getFourDigitsRandomNumberString();
		String time = DateFormatUtils.dateFormatNoSpacing(new Date());
		String random = time + string4 ;
		
		response.setContentType("aplication/vnd.ms-excel");
	    //有中文必须转码 (利用String类中的字节转码方式)
		response.setHeader("Content-Disposition", "attachment; filename="+random+".xls");	
		WritableWorkbook writableWorkbook;
		try {
			writableWorkbook = ExcelUtils.createExcelByList(response.getOutputStream(), list );
			writableWorkbook.write();
			writableWorkbook.close();
		} catch (WriteException | IOException | ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
}
