package tw.gym.courses.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import tw.gym.coach.model.CoachBean;
import tw.gym.coach.service.CoachService;
import tw.gym.courses.model.Course;
import tw.gym.courses.model.CourseService;
import tw.gym.courses.model.CourseSpec;
import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.MemberService;

@Controller
@RequestMapping(path = "/course")
@SessionAttributes(names = { "totalPages", "totalElements" })
public class CourseController {

	@Autowired
	private CourseService cService;

	@Autowired
	private CoachService coaService;

	@Autowired
	private MemberService mService;

	// 管理者：新增課程，轉到表單
	@GetMapping(path = "/courseform.controller") // http://localhost:8081/course/courseform.controller
	public String showMemberForm(Model m) {
		List<CoachBean> coachList = coaService.listAllCoach();

		Course course = new Course();
		m.addAttribute("courseBean", course);
		m.addAttribute("coachList", coachList);
		return "course/courseform";
	}

	// 管理者：轉到顯示課程的頁面
	@GetMapping(path = "/showcourseQuery.controller") // http://localhost:8081/course/showcourseQuery.controller
	public String showCourseQuery(Model m) {
//		Course course =new Course();
//		m.addAttribute("courseBean",course);
		List<CoachBean> coachList = coaService.listAllCoach();
		m.addAttribute("coachList", coachList);

		List<Date> dateList = cService.findAllDate();
		m.addAttribute("dateList", dateList);

		return "course/courseQuery";
		// return cService.findAllDate();
	}

	// 更新一筆課程
	// 管理者：轉到更新的表單
	@GetMapping("/showUpdateForm.controller")
	public String showUpdateForm(@RequestParam("courseId") Integer courseId, Model m, RedirectAttributes ra) {
		System.out.println("success:" + courseId);

		List<CoachBean> coachList = coaService.listAllCoach();
		m.addAttribute("coachList", coachList);

		List<Date> dateList = cService.findAllDate();
		m.addAttribute("dateList", dateList);

		Course course = cService.findById(courseId);
		m.addAttribute("onecourse", course);
		return "course/updateform";
	}

	// 管理者：轉到查詢課程學生的頁面
	@GetMapping("/showStudentQuery.controller")
	public String showStudentQuery(@RequestParam("courseId") Integer courseId, Model m) {
		Integer tempcourseId = courseId;

		m.addAttribute("courseId", tempcourseId);
		return "course/studentQuery";
	}
	
	

//////////////////////////////////////////////////////	

	// 查詢全部課程
	@GetMapping(path = "/findallcoures.controller") // http://localhost:8081/course/findallcoures.controller
	@ResponseBody
	public List<Course> processFindAllCourses() {
		return cService.findAllCourse();
	}
	
	// 查詢單筆課程
	@GetMapping(path = "/findcoursebyid.controller/{cousreId}") 
	@ResponseBody
	public Course processFindCourseById(@PathVariable("cousreId") Integer cousreId) {
		return cService.findById(cousreId);
	}

	// 查詢課程by會員，已加選課程 (我的課表)
	@GetMapping("/findbymember.controller/{pageNo}") // http://localhost:8081/course/findbymember.controller
	@ResponseBody
	public Map<String, Object> processFindByMember(@PathVariable("pageNo") int pageNo,HttpSession session) {
		MemberBean member =(MemberBean)session.getAttribute("loginUser");
//		Integer memberNumber = 1001;
		Integer memberNumber= member.getNumber();
		 
		List<Course> courses = cService.findAllByMember(memberNumber);
		//System.out.println(courses.toString());
		
		int pageSize = 10;// 每頁顯示的筆數
		Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
		
		//List轉Page
        int start = (int) pageable.getOffset();
        int end = (start + pageable.getPageSize()) > courses.size() ? courses.size() : (start + pageable.getPageSize());
        Page<Course> page = new PageImpl<Course>(courses.subList(start, end), pageable, courses.size());
        
        Map<String, Object> pagemap = new HashMap<>();

		pagemap.put("pageContent", page.getContent());
		pagemap.put("totalPages", page.getTotalPages());
		pagemap.put("totalElements", page.getTotalElements());

		return pagemap;
		
	}
	
	// 查詢課程by會員，已經結束的課程 (上課紀錄)
	@GetMapping("/findpastbymember.controller/{pageNo}")
	@ResponseBody
	public Map<String, Object> processFindPastByMember(@PathVariable("pageNo") int pageNo,HttpSession session) {
		MemberBean member =(MemberBean)session.getAttribute("loginUser");
		//Integer memberNumber = 1001;
		Integer memberNumber= member.getNumber();
		
		List<Course> courses = cService.findPastByMember(memberNumber);
		
		int pageSize = 10;// 每頁顯示的筆數
		Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
		
		//List轉Page
        int start = (int) pageable.getOffset();
        int end = (start + pageable.getPageSize()) > courses.size() ? courses.size() : (start + pageable.getPageSize());
        Page<Course> page = new PageImpl<Course>(courses.subList(start, end), pageable, courses.size());
        
        Map<String, Object> pagemap = new HashMap<>();

		pagemap.put("pageContent", page.getContent());
		pagemap.put("totalPages", page.getTotalPages());
		pagemap.put("totalElements", page.getTotalElements());

		return pagemap;

	}

	// 多條件查詢+分頁 (用於：表單查詢課程、當日課程、全部課程)
	@PostMapping("/sendqueryform.controller/{pageNo}") // http://localhost:8081/course/sendqueryform.controller
	@ResponseBody
	public Map<String, Object> processQuery(@RequestBody Course course, @PathVariable("pageNo") int pageNo, Model m) {
		String category = course.getCategory();
		String classroom = course.getClassroom();
		Date date = course.getDate();
		Integer coachId = course.getCoachId();
		System.out.println(coachId);
		CourseSpec courseSpec = new CourseSpec(category, classroom, date, coachId);

		int pageSize = 10;
		Pageable pageable = PageRequest.of(pageNo - 1, pageSize, Sort.by(Direction.ASC, "date").and(Sort.by(Direction.ASC, "period")));
		
		
		Page<Course> page = cService.findAll(courseSpec, pageable);

		Map<String, Object> pagemap = new HashMap<>();

		pagemap.put("pageContent", page.getContent());
		pagemap.put("totalPages", page.getTotalPages());
		pagemap.put("totalElements", page.getTotalElements());

		return pagemap;
		// return page.getContent();
	}
/*
	// 分頁查詢：全部課程
	@PostMapping("/queryByPage/{pageNo}") // http://localhost:8081/course/queryByPage/1
	@ResponseBody
	public List<Course> processQueryByPage(@PathVariable("pageNo") int pageNo, Model m, SessionStatus status,
			HttpSession session) {
		int pageSize = 10;// 每頁顯示的筆數
		Pageable pageable = PageRequest.of(pageNo - 1, pageSize);// 設定顯示頁碼與每頁筆數
		Page<Course> page = cService.findAllByPage(pageable);
		// System.out.println("分頁查詢TEST!!!!!!");
//
//		session.removeAttribute("totalPages");
//		session.removeAttribute("totalElements");
		// status.setComplete();

		m.addAttribute("totalPages", page.getTotalPages());// 取得資料總頁數
		m.addAttribute("totalElements", page.getTotalElements());// 取得全部資料筆數
		// System.out.println("分頁查詢success");
		return page.getContent();// 取得所取得的該頁資料內容
	}
*/
	
	//查詢當周課程(分教室)
	@GetMapping("/querythisweekcourse.controller/{classroom}") // http://localhost:8081/course/querythisweekcourse.controller
	@ResponseBody
	public List<Course> querythisweekcourse(@PathVariable("classroom") String classroom) {

		Date date= new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		// 獲得當前日期是一個星期的第幾天
		int dayWeek = cal.get(Calendar.DAY_OF_WEEK);
		if (1 == dayWeek) {
			cal.add(Calendar.DAY_OF_MONTH, -1);
		}
		// 設定一個星期的第一天，按中國的習慣一個星期的第一天是星期一
		cal.setFirstDayOfWeek(Calendar.MONDAY);
		// 獲得當前日期是一個星期的第幾天
		int day = cal.get(Calendar.DAY_OF_WEEK);
		// 根據日曆的規則，給當前日期減去星期幾與一個星期第一天的差值
		cal.add(Calendar.DATE, cal.getFirstDayOfWeek() - day);
		Date thisWeekMonday = cal.getTime();
		//當周周一，加七天，得到下周周一
		cal.setTime(thisWeekMonday);
		cal.add(Calendar.DATE, 7);
		Date nextWeekMonday = cal.getTime();
		
		System.out.println(thisWeekMonday);
		
		return cService.findOneWeekCourse(thisWeekMonday, nextWeekMonday,classroom);
	
	}
	
	// 查詢課程簡介
	@GetMapping("/queryinformation.controller/{courseId}") // http://localhost:8081/course/queryinformation.controller/178
	@ResponseBody
	public String queryInformation(@PathVariable("courseId") Integer courseId) {
		String str = cService.findInfoById(courseId);
		return str;
	}
	//課程簡介下方秀出教練
    @GetMapping("/showonecoach/{coachId}") // course/
    @ResponseBody
    public CoachBean listAllCoach(@PathVariable("coachId") Integer coachId) {
        CoachBean coach = coaService.getById(coachId);
        return coach;
    }
	
	
	

	// 查詢課程學生
	@GetMapping("/querystudent.controller/{courseId}") // http://localhost:8081/course/querystudent.controller
	@ResponseBody
	public List<MemberBean> querystudent(@PathVariable("courseId") Integer Id) {
		return mService.findByCourse(Id);
	}

	// 新增一筆課程，JSON進JSON出
	@PostMapping("/insertcourse.controller") // http://localhost:8081/course//insertcourse.controller
	@ResponseBody
	public Course processInsertCourse(@RequestBody Course course) { // @RequestParam(name="coachId")
		return cService.insertCourse(course);
	}

	// 刪除一筆課程
	@DeleteMapping("/deletecourse.controller/{courseId}") // http://localhost:8081/course/deletecourse.controller
	@ResponseBody
	public Course processDeleteCourse(@PathVariable("courseId") int courseId) {
		System.out.println("delete!!!");
		cService.deleteById(courseId);
		return null;
	}
	
	
	//批量刪除
	@DeleteMapping("/deleteinbatch.controller")
	@ResponseBody
	public void batch_del_stu(@RequestParam("ids") String ids){
		
		System.out.println("hhhhhhhhhhh");
	 // 接收包含stuId的字符串，並將它分割成字符串數組
	 String[] str_ids = ids.split(",");
	 // 將字符串數組轉為List<Intger> 類型
	 List<Integer> int_ids = new ArrayList<Integer>();
	 for(String id : str_ids){
		 int_ids.add(Integer.parseInt(id));
	 }
	 // 調用service層的批量刪除函數
	 cService.deleteBatch(int_ids);
	
	}
	

	// 更新一筆課程，JSON進JSON出
	@PostMapping("/updatcourse.controller") // http://localhost:8081/course/updatcourse.controller
	@ResponseBody
	public Course processUpdateCourse(@RequestBody Course course) { // @RequestParam(name="coachId")
		System.out.println("success:");
		return cService.updateCourse(course);
	}
}
