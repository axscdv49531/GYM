package tw.gym.membercourse.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import tw.gym.courses.model.CourseService;
import tw.gym.courses.utils.EmailSenderService;
import tw.gym.member.Service.MemberService;
import tw.gym.membercourse.model.Member_Course;
import tw.gym.membercourse.model.Member_CourseService;
import tw.gym.service.CoachService;

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

//		List<CoachBean> coachList = coaService.findAllCoachBean();
//		m.addAttribute("coachList", coachList);
//		
//		List<Date> dateList = cService.findAllDate();
//		m.addAttribute("dateList", dateList);
		return "membercourse/courseSelectSytem";
	}

	// 前往我的課程頁面
	@GetMapping("/mycourseschedulemain.controller")
	public String mycourseschedulemain(Model m) {
		Integer memberNumber = 1;
		return "membercourse/myCourseSchedule";
	}

	// 前往選課紀錄頁面
	@GetMapping("/selectcourserecordmain.controller")
	public String selectcourserecordmain(Model m) {
		Integer memberNumber = 1;
		return "membercourse/selectCourseRecord";
	}

/////////////////////////////////////	

	// 加選一堂課程/
	@GetMapping("/selectcourse.controller/{courseId}") // http://localhost:8081/membercourse/selectcourse.controller/100
	@ResponseBody
	public Member_Course selectcourse(@PathVariable("courseId") Integer courseId) {

		Integer memberNumber = 1;
		
		//加選成功信件的內容設定
		String courseName = cService.findById(courseId).getCourseName();
		Date date = cService.findById(courseId).getDate();
		String period = cService.findById(courseId).getPeriod();
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		String courseTime = dateFormat.format(date) +"  " +period;
		
		//String toEmail = mService.findByNumber(memberNumber).getEmail();
		String toEmail = "habypunk@gmail.com";
		String subject = "加選成功： "+ courseName;
		String body = "您已加選成功：" +courseTime +" 的 " +courseName + "。\n請準時到課。祝您上課愉快！" ;
		

		Member_Course mc = new Member_Course();
		mc.setFk_course_id(courseId);
		mc.setFk_member_num(memberNumber);
		mc.setSelecttime(new Date());
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
					return null;
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
	public Member_Course dropcourse(@PathVariable("courseId") Integer courseId) {

		System.out.println("hello");
		Integer memberNumber = 1;

		List<Member_Course> mcList = mcService.findByFkid(memberNumber, courseId);
		for (Member_Course mc : mcList) {
			if (mc.getState().equals("已加選")) {
				mc.setFk_course_id(courseId);
				mc.setFk_member_num(memberNumber);
				mc.setSelecttime(new Date());
				mc.setState("已退選");

				cService.stuNumMinus(courseId); // 更新Course 人數
				return mcService.updateMC(mc);
			}
		}
		return null;
	}

	// 全部選課紀錄
	@GetMapping("/selectcourserecord.controller") // http://localhost:8081/membercourse/selectcourserecord.controller
	@ResponseBody
	public List<Member_Course> findselectrecord() {
		Integer membernumber = 1;

		return mcService.findByMember(membernumber);
	}

	// 顯示未來的課程/查詢

	// 顯示過去的選課紀錄

}
