package tw.gym.courses.utils;

import java.util.List;

import com.itextpdf.text.Document;

import tw.gym.courses.model.Course;

public interface PdfTableService {

	//建立pdf檔案，
	// savePath是儲存路徑，如果是空字串，則直接輸出到document
	//document:pdf內容
	//goods:寫入到pdf表格中的資料
	void createPDF(Document document, List<Course> courses, String savePath);

}