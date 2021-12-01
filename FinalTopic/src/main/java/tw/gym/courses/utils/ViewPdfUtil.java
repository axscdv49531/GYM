package tw.gym.courses.utils;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.Document;
import com.itextpdf.text.pdf.PdfWriter;

import tw.gym.courses.model.Course;

public class ViewPdfUtil extends AbstractITextPdfView {

	 //檔名
    private String fileName;
    public String getFileName() {
        return this.fileName;
    }
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    //指定一個型別，方便知道呼叫哪個類處理
    private String pdfType;
    public String getPdfType() {
        return this.pdfType;
    }
    public void setPdfType(String pdfType) {
        this.pdfType = pdfType;
    }

    //說明：主要是實現buildPdfDocument方法，供ModelAndView呼叫時直接顯示到瀏覽器頁面
    //生成pdf的document並顯示出來
    @Override
    protected void buildPdfDocument(Map<String, Object> model, Document document, PdfWriter writer, HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition","filename=" + URLEncoder.encode(this.fileName, "UTF-8"));
        List<Course> courses = (List<Course>) model.get("sheet");
        if (this.pdfType.equals("goods")) {
            PdfTableService pdfTableService = new PdfTableServiceImpl();
            //不儲存成檔案，直接顯示，所以不指定儲存路徑
            pdfTableService.createPDF(document, courses,"");
        }
    }
}
