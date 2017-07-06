package tools;
//自定义标签类：将阿拉伯数字转化为大写数字，如将1转化为壹
import javax.servlet.jsp.tagext.TagSupport;
import java.io.*;
import javax.servlet.jsp.JspWriter;
public class NumTag extends TagSupport {
 public String num ;

 public void setnum(String num){
  this.num=num;
 }

 public String getnum(){
  return num;
 }

 public int doEndTag() {
	 double number=Double.parseDouble(num);
	 StringBuffer chineseNumber = new StringBuffer();
     String [] num={"零","壹","贰","叁","肆","伍","陆","柒","捌","玖"};
     String [] unit = {"分","角","元","拾","佰","仟","万","拾","佰","仟","亿","拾","佰","仟","万"};
     String tempNumber = String.valueOf(Math.round((number * 100)));
     int tempNumberLength = tempNumber.length();
     if ("0".equals(tempNumber))
     {
	   	  try {
	          JspWriter JSPWriterOutput = pageContext.getOut();
	          JSPWriterOutput.print("零元整");
	   	  } catch (IOException ioEx) {
	      System.out.println("IOException in HelloTag " + ioEx);
	   	  }
	   	  return (SKIP_BODY);	

     }
     if (tempNumberLength > 15)
     {
         try {
			throw new Exception("超出转化范围.");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
     }
     boolean preReadZero = true;    //前面的字符是否读零
     for (int i=tempNumberLength; i>0; i--)
     {
         if ((tempNumberLength - i + 2) % 4 == 0)
         {
             //如果在（圆，万，亿，万）位上的四个数都为零,如果标志为未读零，则只读零，如果标志为已读零，则略过这四位
             if (i - 4 >= 0 && "0000".equals(tempNumber.substring(i - 4, i)))
             {
                 if (!preReadZero)
                 {
                     chineseNumber.insert(0, "零");
                     preReadZero = true;
                 }
                 i -= 3;    //下面还有一个i--
                 continue;
             }
             //如果当前位在（圆，万，亿，万）位上，则设置标志为已读零（即重置读零标志）
             preReadZero = true;
         }
         Integer digit = Integer.parseInt(tempNumber.substring(i - 1, i));
         if (digit == 0)
         {
             //如果当前位是零并且标志为未读零，则读零，并设置标志为已读零
             if (!preReadZero)
             {
                 chineseNumber.insert(0, "零");
                 preReadZero = true;
             }
             //如果当前位是零并且在（圆，万，亿，万）位上，则读出（圆，万，亿，万）
             if ((tempNumberLength - i + 2) % 4 == 0)
             {
                 chineseNumber.insert(0, unit[tempNumberLength - i]);
             }
         }
         //如果当前位不为零，则读出此位，并且设置标志为未读零
         else
         {
             chineseNumber.insert(0, num[digit] + unit[tempNumberLength - i]);
             preReadZero = false;
         }
     }
     //如果分角两位上的值都为零，则添加一个“整”字
     if (tempNumberLength - 2 >= 0 && "00".equals(tempNumber.substring(tempNumberLength - 2, tempNumberLength)))
     {
         chineseNumber.append("整");
     }
	  try {
          JspWriter JSPWriterOutput = pageContext.getOut();
          JSPWriterOutput.print(chineseNumber.toString());
	  } catch (IOException ioEx) {
      System.out.println("IOException in HelloTag " + ioEx);
	  }
        return (SKIP_BODY);
    }

}
