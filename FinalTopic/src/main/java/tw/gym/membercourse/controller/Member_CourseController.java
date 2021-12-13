package tw.gym.membercourse.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import tw.gym.coach.model.CoachBean;
import tw.gym.coach.service.CoachService;
import tw.gym.courses.model.CourseService;
import tw.gym.courses.utils.EmailSenderService;
import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.MemberService;
import tw.gym.membercourse.model.Member_Course;
import tw.gym.membercourse.model.Member_CourseService;
import tw.gym.membercourse.model.Member_CourseSpec;


@Controller
@RequestMapping(path = "/membercourse")
@SessionAttributes(names = { "totalPages", "totalElements" })
public class Member_CourseController {

	@Autowired
	private MemberService mService;

	@Autowired
	private CourseService cService;

	@Autowired
	private CoachService coaService;

	@Autowired
	private Member_CourseService mcService;

	@Autowired
	private EmailSenderService emailSerive;

	// 前往會員選課系統頁面
	@GetMapping("/courseselectionmain.controller")
	public String courseselectionmain(Model m) {

		List<CoachBean> coachList = coaService.listAllCoach();
		m.addAttribute("coachList", coachList);
		
		List<Date> dateList = cService.findAllDate();
		m.addAttribute("dateList", dateList);
		return "membercourse/courseSelectSytem";
	}
	// 前往沒登入的選課系統頁面
	@GetMapping("/nologin_courseSelectSystem.controller")
	public String nologincourseselectionmain(Model m) {

		List<CoachBean> coachList = coaService.listAllCoach();
		m.addAttribute("coachList", coachList);
		
		List<Date> dateList = cService.findAllDate();
		m.addAttribute("dateList", dateList);
		return "membercourse/courseSelectSytem";
	}
	

	// 前往我的課程頁面
	@GetMapping("/mycourseschedulemain.controller")
	public String mycourseschedulemain(Model m) {
		return "membercourse/myCourseSchedule";
	}

	// 前往上課紀錄頁面
	@GetMapping("/pastCourseRecord.controller")
	public String pastCourseRecord(Model m) {
		return "membercourse/pastCourseRecord";
	}
	
	// 前往選課紀錄頁面
	@GetMapping("/selectcourserecordmain.controller")
	public String selectcourserecordmain(Model m) {
		return "membercourse/selectCourseRecord";
	}

/////////////////////////////////////	

	// 加選一堂課程/
	@GetMapping("/selectcourse.controller/{courseId}") // http://localhost:8081/membercourse/selectcourse.controller/1
	@ResponseBody
	public Member_Course selectcourse(@PathVariable("courseId") Integer courseId,HttpSession session) {
System.out.println("success");

	Date selecttime =new Date(); //加選時間

		MemberBean member =(MemberBean)session.getAttribute("loginUser");
		//Integer memberNumber = 1001;
		Integer memberNumber= member.getNumber();
		
		//加選成功信件的內容設定
		
		String username = member.getName();
		String courseName = cService.findById(courseId).getCourseName();
		String coachName = cService.findById(courseId).getCoach().getCoachName();
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		String date =dateFormat.format(cService.findById(courseId).getDate());
		String period = cService.findById(courseId).getPeriod();
		
		String classroom = cService.findById(courseId).getClassroom();
		
		//String toEmail = mService.findByNumber(memberNumber).getEmail();
		//String toEmail = "habypunk@gmail.com";
		String toEmail = member.getEmail();
		String subject = "課程預約確認： "+ courseName;
		String body = 
				"Dear " + username + " 小姐/先生，您好：\n您已成功加選課程。 " +
				      "課程名稱： " + courseName + "\n" + 
				      "授課老師： " + coachName + "\n" + 
				      "上課日期： " + date + "\n" + 
				      "上課時間： " + period + "\n" + 
				      "上課教室： " + classroom + " 教室\n\n" + 
				      "請您至少提早五分鐘到教室報到，若您未準時到課，請您提前取消預約課程。\n"+
				      "Spring Fitness預祝您上課愉快！\n\n"+
				      "(本信件由系統自動發出，請勿直接回覆，謝謝配合)";
		

		Member_Course mc = new Member_Course();
		mc.setFk_course_id(courseId);
		mc.setFk_member_num(memberNumber);
		mc.setSelecttime(selecttime);
		mc.setState("已加選");

//		//檢查是否衝堂
//		Date coursetime =cService.findById(courseId).getDate();
//		String courseperiod = cService.findById(courseId).getPeriod();

		// 檢查是否已加選、檢查是否衝堂、前端檢查選課人數上限
		List<Member_Course> mcList = mcService.findByFkid(memberNumber, courseId);
		if (null != mcList && !mcList.isEmpty()) {
			// 不為空，表示已有選課紀錄
			for (Member_Course onemc : mcList) {
				// 若有一筆紀錄為已加選，表示有選上該課程
				if (onemc.getState().equals("已加選"))
					System.out.println("重複");
					return null ;
			}
			// 有選課紀錄，但沒有已加選：加選！
			cService.stuNumPlus(courseId); // 更新Course 人數
			emailSerive.sendEmail(toEmail,subject, body);
			return mcService.insertMC(mc);

		} else {
			// 為空，沒有選課紀錄：加選！
			cService.stuNumPlus(courseId); // 更新Course 人數
			emailSerive.sendEmail(toEmail,subject, body);
			return mcService.insertMC(mc);
		}

	}

	// 退選課程/更新state欄位
		@GetMapping("/dropcourse.controller/{courseId}") // http://localhost:8081/membercourse/selectcourse.controller/100
		@ResponseBody
		public Member_Course dropcourse(@PathVariable("courseId") Integer courseId,HttpSession session) {
			
			Date selecttime =new Date(); //退選時間
			
			MemberBean member =(MemberBean)session.getAttribute("loginUser");
			//Integer memberNumber = 1001;
			Integer memberNumber= member.getNumber();
			
			//退選成功信件的內容設定
			String username = member.getName();
			String courseName = cService.findById(courseId).getCourseName();
			String coachName = cService.findById(courseId).getCoach().getCoachName();
			
			DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
			String date =dateFormat.format(cService.findById(courseId).getDate());
			String period = cService.findById(courseId).getPeriod();
			
			String classroom = cService.findById(courseId).getClassroom();
			
			//String toEmail = mService.findByNumber(memberNumber).getEmail();
			//String toEmail = "habypunk@gmail.com";
			String toEmail = member.getEmail();
			String subject = "課程取消通知： "+ courseName;
			String body = 
					"Dear " + username + " 小姐/先生，您好：\n" +
							"您已於 " + selecttime + "取消您原本預約的課程：\n"+
					      "課程名稱： " + courseName + "\n" + 
					      "授課老師： " + coachName + "\n" + 
					      "上課日期： " + date + "\n" + 
					      "上課時間： " + period + "\n" + 
					      "上課教室： " + classroom + " 教室\n\n" + 
					        "Spring Fitness歡迎您再次預約其他課程。祝您順心！\n\n"+
					      "(本信件由系統自動發出，請勿直接回覆，謝謝配合)";

			List<Member_Course> mcList = mcService.findByFkid(memberNumber, courseId);
			for (Member_Course mc : mcList) {
				if (mc.getState().equals("已加選")) {
					mc.setFk_course_id(courseId);
					mc.setFk_member_num(memberNumber);
					mc.setSelecttime(selecttime);
					mc.setState("已退選");

					//退選課程
					cService.stuNumMinus(courseId); // 更新Course 人數
					emailSerive.sendEmail(toEmail,subject, body);
					return mcService.updateMC(mc);
				}
			}
			return null;
		}

		// 全部選課紀錄
		@GetMapping("/selectcourserecord.controller/{pageNo}") // http://localhost:8081/membercourse/selectcourserecord.controller/1
		@ResponseBody
		public Map<String, Object> findselectrecord(@PathVariable("pageNo") int pageNo) {
			Integer memberNumber = 1;
			
			int pageSize = 10;
			Member_CourseSpec mcSpec = new Member_CourseSpec(memberNumber);
			
			Pageable pageable = PageRequest.of(pageNo - 1, pageSize, Sort.by(Direction.DESC, "selecttime").and(Sort.by(Direction.ASC, "state")));
			
			Page<Member_Course> page = mcService.findByMemberNumber(mcSpec, pageable);
			
			Map<String, Object> pagemap = new HashMap<>();

			pagemap.put("pageContent", page.getContent());
			pagemap.put("totalPages", page.getTotalPages());
			pagemap.put("totalElements", page.getTotalElements());

			return pagemap;
		}

	// 顯示未來的課程/查詢

	// 顯示過去的選課紀錄

}
