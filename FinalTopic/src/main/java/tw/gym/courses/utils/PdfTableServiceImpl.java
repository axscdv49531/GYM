package tw.gym.courses.utils;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import tw.gym.courses.model.Course;

@Service
public class PdfTableServiceImpl implements PdfTableService {

	// 建立pdf檔案，
	// savePath是儲存路徑，如果是空字串，則直接輸出到document
	// document:pdf內容
	// goods:寫入到pdf表格中的資料
	@Override
	public void createPDF(Document document, List<Course> courses, String savePath) {
		try {
			if (!savePath.equals("")) {
				PdfWriter.getInstance(document, new FileOutputStream(savePath));
			}
			document.addTitle("課程表");
			document.addAuthor("第四組健身中心");
			document.addSubject("最新刻表");
			document.addKeywords("課程");
			document.open();
			Paragraph para = getParagraphText(
					"整個白酒行業從2012年開始，都迅速下滑，銷量和利潤都是大跌。2014年和2015年，茅臺的股價漲得不錯，但也沒有超過同期的白馬股太多，加上利潤增速一直沒有恢復塑化劑之前的狀態，我就一直沒有再買入");
			document.add(para);
			
			/*插入圖片
			String imagePath = "/data/springboot2/logo.jpg"; // 圖片的絕對路徑
			Image image = Image.getInstance(imagePath); // 取得圖片物件
			// 計算得到目標寬高
			File gifFile = new File(imagePath);
			int origWidth = 0;
			int origHeight = 0;
			try {
				BufferedImage imageBuffer = ImageIO.read(gifFile);
				if (imageBuffer != null) {// 如果image=null 表示上傳的不是圖片格式
					origWidth = imageBuffer.getWidth();
					origHeight = imageBuffer.getHeight();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}

			System.out.println("width:" + document.getPageSize().getWidth());
			System.out.println("margin:" + document.leftMargin());
			// 得到新的高度和新的寬度
			float newwidth = document.getPageSize().getWidth() - document.leftMargin() - document.rightMargin();
			float newHeight = (newwidth * origHeight) / origWidth;

			image.scaleAbsolute(newwidth, newHeight);

			document.add(image);
*/
			
			
			PdfPTable table = createTable(courses);
			document.add(table);

		} catch (IOException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		} finally {
			if (document.isOpen()) {
				document.close();
			}
		}
	}

	// 從text得到可以新增到document的Paragraph
	public static Paragraph getParagraphText(String text) {

		try {
			Font font = new Font(BaseFont.createFont(new ClassPathResource("/font/微軟正黑體.TTF").getPath(),
					BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED));
			font.setColor(BaseColor.GRAY);

			Paragraph para = new Paragraph(text, font);
			return para;
		} catch (IOException | DocumentException e) {
			e.printStackTrace();
			return null;
		}
	}

	// 建立PdfTable
	public static PdfPTable createTable(List<Course> courses) throws IOException, DocumentException {
		PdfPTable table = new PdfPTable(8);// 生成一個4列的表格

		int widths[] = { 5, 15, 15, 15, 15, 5, 10, 10 };// 指定各列的寬度百分比
		table.setWidthPercentage(100);
		table.setSpacingBefore(10);
		table.setWidths(widths);

		PdfPCell cell;
		int size = 20;
		Font font = new Font(BaseFont.createFont(new ClassPathResource("/font/微軟正黑體.TTF").getPath(),
				BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED));
		//Font font = new Font(BaseFont.createFont("STSong-Light",
		//		BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED));
		font.setColor(BaseColor.BLACK);
		font.setSize(10);

		Font font_head = new Font(BaseFont.createFont(new ClassPathResource("/font/微軟正黑體.TTF").getPath(),
				BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED));
		font_head.setColor(BaseColor.BLUE);
		font_head.setSize(10);

		Font font_title = new Font(BaseFont.createFont(new ClassPathResource("/font/微軟正黑體.TTF").getPath(),
				BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED));
		font_title.setColor(BaseColor.BLACK);
		font_title.setSize(16);

		cell = new PdfPCell(new Phrase("課程表", font_title));
		cell.setColspan(8);// 設定所佔列數
		cell.setFixedHeight(25);// 設定高度
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);// 設定水平居中
		table.addCell(cell);
		cell = new PdfPCell(new Phrase("編號", font_head));// 課程編號
		cell.setFixedHeight(size);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell);
		cell = new PdfPCell(new Phrase("名稱", font_head));// 課程名稱
		cell.setFixedHeight(size);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell);
		cell = new PdfPCell(new Phrase("總類", font_head));// 課程總類
		cell.setFixedHeight(size);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell);
		cell = new PdfPCell(new Phrase("日期", font_head));// 日期
		cell.setFixedHeight(size);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell);
		cell = new PdfPCell(new Phrase("時間", font_head));// 課程時間
		cell.setFixedHeight(size);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell);
		cell = new PdfPCell(new Phrase("教室", font_head));// 教室編號
		cell.setFixedHeight(size);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell);
		cell = new PdfPCell(new Phrase("老師", font_head));// 授課老師
		cell.setFixedHeight(size);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell);
		cell = new PdfPCell(new Phrase("人數上限", font_head));// 學生人數上限
		cell.setFixedHeight(size);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell);
		
		
		for (int i = 0; i < courses.size(); i++) {
			cell = new PdfPCell(new Phrase(String.valueOf(courses.get(i).getId()), font));// 課程編號
			cell.setFixedHeight(size);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(cell);
			cell = new PdfPCell(new Phrase(courses.get(i).getCourseName(), font));// 課程名稱
			cell.setFixedHeight(size);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(cell);
			cell = new PdfPCell(new Phrase(courses.get(i).getCategory(), font));// 課程總類
			cell.setFixedHeight(size);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(cell);
			cell = new PdfPCell(new Phrase(String.valueOf(courses.get(i).getDate()), font));// 日期
			cell.setFixedHeight(size);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(cell);
			cell = new PdfPCell(new Phrase(courses.get(i).getPeriod(), font));// 時間
			cell.setFixedHeight(size);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(cell);
			cell = new PdfPCell(new Phrase(courses.get(i).getClassroom(), font));// 教室編號
			cell.setFixedHeight(size);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(cell);
			cell = new PdfPCell(new Phrase(courses.get(i).getCoach().getCoachName(), font));// 授課老師
			cell.setFixedHeight(size);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(cell);
			cell = new PdfPCell(new Phrase(courses.get(i).getMaxStudentNum() + "", font));// 學生人數上限
			cell.setFixedHeight(size);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(cell);
		}
		return table;
	}

}