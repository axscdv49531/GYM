package tw.gym.courses.utils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;

import tw.gym.courses.model.Course;
import tw.gym.courses.model.CourseService;

@RestController
@RequestMapping("course")
public class PdfController {

	@Resource
    private CourseService cSerivce;

    @Resource
    PdfTableService pdfTableService;

    //把資料儲存到pdf檔案
    @GetMapping("/savepdf")
    public String savepdf() {
        List<Course> courseList = cSerivce.findAllCourse();
        String savePath = "/data/springboot2/goodslist.pdf";
        pdfTableService.createPDF(new Document(PageSize.A4), courseList,savePath);
        return "pdf saveed";
    }

    //從瀏覽器直接顯示pdf
    //顯示全部課程PDF
    @GetMapping("/viewpdf/allcourses") //http://localhost:8081/course/viewpdf/allcourses
    public ModelAndView allcoursesviewpdf() {
        List<Course> courseList = cSerivce.findAllCourse();
        Map<String, Object> model = new HashMap<>();
        model.put("sheet", courseList);
        ViewPdfUtil viewPdf = new ViewPdfUtil();
        viewPdf.setFileName("總課成列表.pdf");
        viewPdf.setPdfType("goods");
        return new ModelAndView(viewPdf, model);
    }
    
    //從瀏覽器直接顯示pdf
    //顯示我的課程PDF
    @GetMapping("/viewpdf/mycourses") //http://localhost:8081/course/viewpdf/mycourses
    public ModelAndView mycoursesviewpdf() {
    	Integer memberNumber = 1001;
    	
        List<Course> courseList = cSerivce.findAllByMember(memberNumber);
        Map<String, Object> model = new HashMap<>();
        model.put("sheet", courseList);
        ViewPdfUtil viewPdf = new ViewPdfUtil();
        viewPdf.setFileName("我的課表.pdf");
        viewPdf.setPdfType("goods");
        return new ModelAndView(viewPdf, model);
    }

//    //下載pdf檔案
//    @GetMapping("/downpdf")
//    public void downpdf() {
//          String filepath = "/data/springboot2/goodslist.pdf";
//          PdfUtil.downPdfFile(filepath);
//     }
//	
	
}
