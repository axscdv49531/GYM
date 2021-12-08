package tw.gym.member.Controller;

import java.io.IOException;
import java.sql.Blob;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MultipartFile;

import tw.gym.coach.model.ClassBean;
import tw.gym.coach.model.ClassMemberBean;
import tw.gym.coach.model.SkillBean;
import tw.gym.coach.service.ClassMemberService;
import tw.gym.coach.service.ClassService;
import tw.gym.coach.service.CoachService;
import tw.gym.coach.service.SkillService;
import tw.gym.courses.utils.EmailSenderService;
import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.MemberService;
import tw.gym.member.validator.MemberValidator;
import tw.gym.member.validator.PasswordValidator;

@Controller
//@RequestMapping(path = "/GymProject")
//@SessionAttributes(names = { "totalPages", "totalElements" })
public class MemberController {

	private MemberService memberService;

	// Mark
	@Autowired
	ClassService claService;
	// Mark
	@Autowired
	CoachService coaService;
	// Mark
	@Autowired
	SkillService skiService;

	@Autowired
	EmailSenderService emailSerive;

	@Autowired
	ClassMemberService cmService;

	@Autowired
	public MemberController(MemberService memberService) {
		this.memberService = memberService;
	}

	// @GetMapping(path ="/login/Coach")
	// public String CoachLogin(){
	// return "LoginCoach";
	// }
	//
	// @PostMapping(path ="/login/Coach")
	// public String CoachIndex(){
	// return "coach/CoachIndex";
	// }

	// 輸入會員資料
	@GetMapping(path = "/insertMember")
	public String insertMember(Model m) {
		MemberBean memberBean = new MemberBean();
		m.addAttribute("memberBean", memberBean);
		return "administrator/MemberForm";
	}

	@PostMapping(path = "/insertMember")
	public String insert(Model m, @ModelAttribute("memberBean") MemberBean memberBean, BindingResult bindingResult)
			throws ParseException, IOException, SerialException, SQLException {
		MemberValidator memberValidator = new MemberValidator();
		memberValidator.validate(memberBean, bindingResult);

		if (bindingResult.hasErrors()) {
			System.out.println(bindingResult.getAllErrors());
			return "administrator/MemberForm";
		}
//		6位數密碼亂數
		String[] alphabet = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R",
				"S", "T", "U", "V", "W", "X", "Y", "Z" };
		StringBuffer code = new StringBuffer();
		Random random = new Random();
		int temp;
		for (int i = 0; i < 6; i++) {
			if (random.nextInt(2) == 0) {
				temp = random.nextInt(10);
				code.append(temp);
			} else {
				temp = random.nextInt(26);
				code.append(alphabet[temp]);
			}
		}
		memberBean.setPassword(code.toString());
//		寄信
		String name = memberBean.getName();
		String pswd = memberBean.getPassword();
		String toEmail = memberBean.getEmail();
		String subject = "歡迎加入會員： ";
		String body = "Dear " + name + " 小姐/先生，您好：\n歡迎您加入SpringFitness會員。 " + "您可以立即啟用SpringFitness網路會員服務\n"
				+ "請點擊下面連結進入網頁：\n" + "以下是您的密碼：" + pswd + "\n" + "http://localhost:8080/" + "(本信件由系統自動發出，請勿直接回覆，謝謝配合)";
//		密碼加密
		String encodePwd = new BCryptPasswordEncoder().encode(memberBean.getPassword());

//		檔案上傳
		MultipartFile picture = memberBean.getmPhoto();
		byte[] b = picture.getBytes();
		Blob blob = new SerialBlob(b);

		String fileName = picture.getOriginalFilename();

		String mineType = picture.getContentType();
		memberBean.setMemberPhoto(blob);
		memberBean.setFileName(fileName);
		memberBean.setMemberPhotoMineType(mineType);
		memberBean.setPassword(encodePwd);
		memberBean.setDeposite(0);
		emailSerive.sendEmail(toEmail, subject, body);
		memberService.insert(memberBean);
		return "redirect:/findAllMember";
	}
//	@PostMapping(path = "/insertMember")
//	@ResponseBody
//	public String insert(Model m, @RequestBody @ModelAttribute("memberBean") MemberBean memberBean,
//			BindingResult bindingResult) throws ParseException, IOException, SerialException, SQLException {
//		MemberValidator memberValidator = new MemberValidator();
//		memberValidator.validate(memberBean, bindingResult);
//		
//		if (bindingResult.hasErrors()) {
//			System.out.println(bindingResult.getAllErrors());
//			return "administrator/MemberForm";
//		}
//		// if (memberBean != null) {
//		// if(memberBean.getId().equals(memberService. == true);
//		// bindingResult.rejectValue("memberId", "", "帳號已存在，請重新輸入");
//		// return "MemberForm";
//		// }
//		memberBean.setPassword("123456");
//		String encodePwd = new BCryptPasswordEncoder().encode(memberBean.getPassword());
//		
//		MultipartFile picture = memberBean.getmPhoto();
//		byte[] b = picture.getBytes();
//		Blob blob = new SerialBlob(b);
//		
//		String fileName = picture.getOriginalFilename();
//		
//		String mineType = picture.getContentType();
//		memberBean.setMemberPhoto(blob);
//		memberBean.setFileName(fileName);
//		memberBean.setMemberPhotoMineType(mineType);
//		memberBean.setPassword(encodePwd);
//		memberBean.setDeposite(0);
//		
//		memberService.insert(memberBean);
//		return "";
//	}

	@GetMapping("/findAllMember")
	public String selectAll(Model model) {
		List<MemberBean> memberBean = memberService.findAll();
		model.addAttribute(memberBean);
		return "administrator/ShowMember";
	}

//	@GetMapping("/membermain.controller")
//	public String processMemberMainAction() {
//		return "administrator/allMember";
//	}
//	@PostMapping("/memberbyid/{number}")
//	@ResponseBody
//	public MemberBean processFindByIdAction(@PathVariable("number") Integer number) {
//		return memberService.findBymNum(number);
//	}
//
//	@PostMapping("/memberByPage/{pageNo}")
//	@ResponseBody
//	public List<MemberBean> MemberByPage(@PathVariable("pageNo") int pageNo, Model m) {
//		int pageSize = 2;
//		Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
//		Page<MemberBean> page = memberService.findAllByPage(pageable);
//		m.addAttribute("totalPages", page.getTotalPages());
//		m.addAttribute("totalElements", page.getTotalElements());
//		return page.getContent();
//	}

	@GetMapping("/selectMember/{number}")
	public String findById(Model model, @PathVariable Integer number) {
		MemberBean memberBean = memberService.findByNumber(number);
		model.addAttribute("memberBean", memberBean);
		return "administrator/ShowMemberDetail";
	}

	@GetMapping("/modifyMember/{number}")
	public String updateMember(Model model, @PathVariable Integer number) {
		MemberBean memberBean = memberService.findByNumber(number);
		// memberbean.setPassword(memberbean.getPassword());
		model.addAttribute("memberBean", memberBean);
		return "administrator/EditMemberForm";
	}

	@PostMapping("/modifyMember/{number}")
	public String updateMemberdata(@ModelAttribute("memberBean") MemberBean memberBean, BindingResult bindingResult)
			throws ParseException, IOException, SerialException, SQLException {
		new MemberValidator().validate(memberBean, bindingResult);

		MultipartFile picture = memberBean.getmPhoto();
		byte[] b = picture.getBytes();
		Blob blob = new SerialBlob(b);

		String fileName = picture.getOriginalFilename();

		String mineType = picture.getContentType();
		memberBean.setMemberPhoto(blob);
		memberBean.setFileName(fileName);
		memberBean.setMemberPhotoMineType(mineType);
		if (memberBean.getDeposite() == null) {
			memberBean.setDeposite(0);
		}
		if (bindingResult.hasErrors()) {
			return "administrator/EditMemberForm";
		}
		memberService.update(memberBean);
		return "redirect:/findAllMember";
	}

	@GetMapping("/updateMember")
	public String updateMemberProfile(Model model, HttpSession session) {
		MemberBean memberBean = (MemberBean) session.getAttribute("loginUser");
		model.addAttribute("memberBean", memberBean);
		return "member/MemberUpdateProfile";
	}

	@PostMapping("/updateMember")
	public String updateMemberProfileData(@ModelAttribute("memberBean") MemberBean memberBean,
			BindingResult bindingResult) throws ParseException, IOException, SerialException, SQLException {
		new MemberValidator().validate(memberBean, bindingResult);

		MultipartFile picture = memberBean.getmPhoto();
		byte[] b = picture.getBytes();
		Blob blob = new SerialBlob(b);

		String fileName = picture.getOriginalFilename();

		String mineType = picture.getContentType();
		memberBean.setMemberPhoto(blob);
		memberBean.setFileName(fileName);
		memberBean.setMemberPhotoMineType(mineType);
		if (memberBean.getDeposite() == null) {
			memberBean.setDeposite(0);
		}
		if (bindingResult.hasErrors()) {
			return "member/MemberUpdateProfile";
		}
		memberService.update(memberBean);
		return "redirect:/MemberProfile";
	}

	@GetMapping("/deleteMember/{number}")
	public String deleteMemberData(@PathVariable("number") Integer number) throws SQLException {
		memberService.deleteById(number);
		return "redirect:/findAllMember";
	}

	@GetMapping("/updatePassword/{number}")
	public String updatePassword(Model model, HttpSession session) {
		MemberBean memberBean = (MemberBean) session.getAttribute("loginUser");
		model.addAttribute("memberBean", memberBean);
		return "member/MemberUpdatePassword";
	}

	@PostMapping("/updatePassword/{number}")
	public String updatePasswordData(@ModelAttribute("memberBean") MemberBean memberBean, BindingResult bindingResult,
			@PathVariable("number") Integer number) throws ParseException, IOException, SerialException, SQLException {
		PasswordValidator passwordValidator = new PasswordValidator();
		passwordValidator.validate(memberBean, bindingResult);
		MemberBean member = memberService.findByNumber(number);
		BCryptPasswordEncoder encode = new BCryptPasswordEncoder();
		if (!encode.matches(memberBean.getOldpwd(), member.getPassword())) {
			bindingResult.rejectValue("oldpwd", "", "原密碼錯誤");
			return "member/MemberUpdatePassword";
		}
		if (memberBean.getPassword1().length() < 8 || memberBean.getPassword1().length() > 15) {
			bindingResult.rejectValue("password1", "", "請輸入8-15位英文數字組合");
			System.out.println("錯誤");
			return "member/MemberUpdatePassword";
		} else {
			boolean flag1 = false, flag2 = false, flag3 = false;

			for (int i = 0; i < memberBean.getPassword1().length(); i++) {
				String pwd = memberBean.getPassword1();
				char ch = pwd.charAt(i);

				if (ch >= 48 && ch <= 57) {
					flag1 = true;
				} else if (ch >= 65 && ch <= 90) {
					flag2 = true;
				} else if (ch >= 97 && ch <= 122) {
					flag3 = true;
				}
				if (flag1 && flag2 && flag3== true) {
					break;
				}
			}
			if (flag1 && flag2 && flag3== true) {
				System.out.println("正確");
			} else {
				System.out.println("錯誤");
				bindingResult.rejectValue("password1", "", "密碼需包含大小寫英文及數字");
				return "member/MemberUpdatePassword";
			}
		}
		if (bindingResult.hasErrors()) {

			System.out.println(bindingResult.getAllErrors());

			return "member/MemberUpdatePassword";
		}
		String newPwd = new BCryptPasswordEncoder().encode(memberBean.getPassword1());
		member.setPassword(newPwd);
		memberService.update(member);
		return "redirect:/login/MemberSuccess";
	}

	@InitBinder
	public void initBinder(WebDataBinder binder, WebRequest request) {
		// java.util.Date
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		dateFormat.setLenient(false);
		CustomDateEditor ce = new CustomDateEditor(dateFormat, true);
		binder.registerCustomEditor(Date.class, ce);
		// java.sql.Date
		DateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat2.setLenient(false);
		CustomDateEditor ce2 = new CustomDateEditor(dateFormat2, true);
		binder.registerCustomEditor(java.sql.Date.class, ce2);
	}

	@GetMapping("/getMemberPicture")
	public ResponseEntity<byte[]> getMemberPicture(@RequestParam("email") String email) throws SQLException {

		System.out.println(email);
		MemberBean memberBean = memberService.getMemberByEmail(email);
		System.out.println(memberBean.getEmail());
		ResponseEntity<byte[]> re = null;
		Blob blob = memberBean.getMemberPhoto();
		byte[] b = blob.getBytes(1, (int) blob.length());
		HttpHeaders headers = new HttpHeaders();
		MediaType mediaType = MediaType.valueOf(memberBean.getMemberPhotoMineType());
		headers.setContentType(mediaType);
		re = new ResponseEntity<byte[]>(b, headers, HttpStatus.OK);
		return re;
	}

	// //Mark
	// @GetMapping("memberLogin")
	// public String memberlogin(Model model) {
	// LoginBean lBean = new LoginBean();
	// model.addAttribute("loginBean", lBean);
	// return "/coach/coachLogin";
	// }

	// //Mark
	// @PostMapping("memberLogin")
	// public String memberlogincheck(Model model, HttpSession session, LoginBean
	// lBean) {
	// MemberBean mBean = null;
	// System.out.println(lBean.getUserAccount() + "1");
	// mBean = memService.findByAccountAndPassword(lBean.getUserAccount(),
	// lBean.getUserPassword());
	// System.out.println(lBean.getUserAccount());
	// if (mBean != null) {
	// session.setAttribute("loginUser", mBean);
	// // model.addAttribute("LoginOK", cBean);
	// System.out.println("登入成功");
	// } else {
	// System.out.println("登入失敗");
	// }
	//
	// return "/member/memberLoginSuccess";
	// }
	// Mark
	@GetMapping("classRes")
	public String classReservation() {

		return "/member/memberLoginSuccess";
	}

	// Mark
	@GetMapping("classReservation")
	public String memberViewClassList(Model model) {
		List<ClassBean> allClass = claService.listAllClass();
		List<SkillBean> sBean = skiService.findAll();
		List<String> name = claService.findClassCoach();
		model.addAttribute("coachList", name);
		model.addAttribute("skillList", sBean);
		model.addAttribute(allClass);
		return "/member/classList";
	}

	// Mark
	@GetMapping("/viewClass/{id}")
	public String memberViewClass(@PathVariable("id") Integer classId, Model model) {
		List<String> skList = skiService.listAllSkill();
		model.addAttribute("checkBoxList", skList);
		List<String> selectData = new ArrayList<String>();
		selectData.add("09:00");
		selectData.add("10:00");
		selectData.add("11:00");
		selectData.add("12:00");
		selectData.add("13:00");
		selectData.add("14:00");
		selectData.add("15:00");
		selectData.add("16:00");
		selectData.add("17:00");
		selectData.add("18:00");
		selectData.add("19:00");
		selectData.add("20:00");
		model.addAttribute("selectData", selectData);
		ClassBean cBean = claService.getClassById(classId);
		String startTemp = cBean.getClassStartTime().toString();
		String start = startTemp.substring(0, 5);
		String endTemp = cBean.getClassEndTime().toString();
		String end = endTemp.substring(0, 5);
		cBean.setClassStartTimeTemp(start);
		cBean.setClassEndTimeTemp(end);

		Set<SkillBean> a = cBean.getsBean();
		Iterator<SkillBean> aa = a.iterator();
		String[] st = new String[cBean.getsBean().size()];
		int i = 0;
		while (aa.hasNext()) {
			// System.out.println(aa.next().getSkillName());
			st[i] = aa.next().getSkillName();
			i++;
		}
		cBean.setClassLabel(st);
		model.addAttribute("classBean", cBean);

		return "/member/viewClass";
	}

	// Mark
	@PostMapping("/viewClass/{id}")
	public String reservationSuccess(@PathVariable("id") Integer classId,
			@SessionAttribute("loginUser") MemberBean mBean) {
		// ClassBean cBean = claService.getClassById(classId);
		// MemberBean memBean = memService.getById(mBean.getMemberId());
		// memBean.setcBean(cBean);
		ClassBean cBean = claService.getClassById(classId);
		MemberBean memBean = memberService.getById(mBean.getNumber());
		ClassMemberBean cmBean = new ClassMemberBean();
		cmBean.setcBean(cBean);
		cmBean.setmBean(memBean);
		Long datetime = System.currentTimeMillis();
		Timestamp timestamp = new Timestamp(datetime);
		cmBean.setRegisterDate(timestamp);
		memberService.insertReservation(cmBean, 1, classId);

		String email = mBean.getEmail();
		String subject = "一對一課程預約成功通知信";
		String body = mBean.getName() + ",您好：" + "\n\n\n" + "您的預約資訊如下：" + "\n\n" + "課程名稱：" + cBean.getClassName() + "\n"
				+ "上課日期：" + cBean.getClassDate() + "\n" + "上課時間：" + cBean.getClassStartTime() + "~"
				+ cBean.getClassEndTime() + "\n\n\n" + "感謝您的預約！";

		emailSerive.sendEmail(email, subject, body);
		return "redirect:/classReservation";
	}

	// Mark
	@GetMapping("viewReservationClass")
	public String viewReservationClass(Model model, @SessionAttribute("loginUser") MemberBean mBean) {

		List<ClassBean> cBean = memberService.findByMemberId(mBean.getNumber());
		model.addAttribute(cBean);

		return "/member/viewReservationClass";
	}

	// Mark
	@GetMapping("/member/viewClass/{id}")
	public String memberViewClassDetail(@PathVariable("id") Integer classId, Model model) {
		List<String> skList = skiService.listAllSkill();
		model.addAttribute("checkBoxList", skList);
		List<String> selectData = new ArrayList<String>();
		selectData.add("09:00");
		selectData.add("10:00");
		selectData.add("11:00");
		selectData.add("12:00");
		selectData.add("13:00");
		selectData.add("14:00");
		selectData.add("15:00");
		selectData.add("16:00");
		selectData.add("17:00");
		selectData.add("18:00");
		selectData.add("19:00");
		selectData.add("20:00");
		model.addAttribute("selectData", selectData);
		ClassBean cBean = claService.getClassById(classId);
		String startTemp = cBean.getClassStartTime().toString();
		String start = startTemp.substring(0, 5);
		String endTemp = cBean.getClassEndTime().toString();
		String end = endTemp.substring(0, 5);
		cBean.setClassStartTimeTemp(start);
		cBean.setClassEndTimeTemp(end);

		Set<SkillBean> a = cBean.getsBean();
		Iterator<SkillBean> aa = a.iterator();
		String[] st = new String[cBean.getsBean().size()];
		int i = 0;
		while (aa.hasNext()) {
			// System.out.println(aa.next().getSkillName());
			st[i] = aa.next().getSkillName();
			i++;
		}
		cBean.setClassLabel(st);
		model.addAttribute("classBean", cBean);

		return "/member/viewClassDetail";
	}

	// Mark
	@PostMapping("/member/viewClass/{id}")
	public String memberViewClassDetailDelete(@PathVariable("id") Integer classId,
			@SessionAttribute("loginUser") MemberBean mBean) {

		memberService.deleteByClassId(classId, 0);
		ClassBean cBean = claService.getClassById(classId);
		String email = mBean.getEmail();
		String subject = "一對一課程取消預約成功通知信";
		String body = mBean.getName() + ",您好：" + "\n\n\n" + "您已成功取消預約課程，資訊如下：" + "\n\n" + "課程名稱：" + cBean.getClassName()
				+ "\n" + "上課日期：" + cBean.getClassDate() + "\n" + "上課時間：" + cBean.getClassStartTime() + "~"
				+ cBean.getClassEndTime() + "\n\n\n" + "期待您再次光臨！";

		emailSerive.sendEmail(email, subject, body);

		return "redirect:/viewReservationClass";
	}

	// Mark
	@PostMapping("cancelClass")
	@ResponseBody
	public String cencelClass(@RequestParam(required = false, name = "classId") String classId,
			@SessionAttribute("loginUser") MemberBean mBean) {
		Integer classIdd = Integer.parseInt(classId);
		memberService.deleteByClassId(classIdd, 0);
		ClassBean cBean = claService.getClassById(classIdd);
		String email = mBean.getEmail();
		String subject = "一對一課程取消預約成功通知信";
		String body = mBean.getName() + ",您好：" + "\n\n\n" + "您已成功取消預約課程，資訊如下：" + "\n\n" + "課程名稱：" + cBean.getClassName()
				+ "\n" + "上課日期：" + cBean.getClassDate() + "\n" + "上課時間：" + cBean.getClassStartTime() + "~"
				+ cBean.getClassEndTime() + "\n" + "\n\n\n" + "期待您再次光臨！";

		emailSerive.sendEmail(email, subject, body);
		System.out.println("123");

		if (cBean.getClassAvaliable() == 0) {

			return "true";
		} else {
			return "false";
		}
	}

	// Mark
	@PostMapping("listAllClass")
	@ResponseBody
	public List<ClassBean> listAllClass() {
		List<ClassBean> cBean = claService.listAllClass();

		return cBean;
	}

	// Mark
	@GetMapping("memberViewClassLists")
	public String memberViewClassLists(Model model) {
		List<ClassBean> allClass = claService.listAllClass();
		List<SkillBean> sBean = skiService.findAll();
		List<String> name = claService.findClassCoach();
		model.addAttribute("coachList", name);
		model.addAttribute("skillList", sBean);
		model.addAttribute(allClass);

		return "/member/viewReservationClass";
	}

	// Mark
	@PostMapping("memberListAllClass")
	@ResponseBody
	public List<ClassBean> memberListAllClass(@SessionAttribute("loginUser") MemberBean mBean) {
		List<ClassBean> cBean = memberService.findByMemberId(mBean.getNumber());

		return cBean;
	}

    // Mark
    @PostMapping("classReservationCheck")
    @ResponseBody
    public String classReservationCheck(@RequestParam(required = false, name = "classId") String classId,
            @SessionAttribute("loginUser") MemberBean mBean) {

        Integer classIdd = Integer.parseInt(classId);
        ClassBean cBean = claService.getClassById(classIdd);
        MemberBean memBean = memberService.getById(mBean.getNumber());

        List<ClassBean> cBeans = cmService.findClassesByMemberId(mBean.getNumber());
        if (cBeans.size() > 0) {
            for (int i = 0; i < cBeans.size(); i++) {
                if (cBeans.get(i).getClassDate().equals(cBean.getClassDate())) {
                    if (cBeans.get(i).getClassStartTime().after(cBean.getClassStartTime())) {
                        if (cBeans.get(i).getClassStartTime().equals(cBean.getClassEndTime())
                                || !(cBeans.get(i).getClassStartTime().before(cBean.getClassEndTime())
                                        && cBeans.get(i).getClassEndTime().after(cBean.getClassEndTime()))) {

                        } else {
                            return "dup";
                        }
                    } else {
                        if (!cBeans.get(i).getClassStartTime().equals(cBean.getClassStartTime())
                                && !(cBeans.get(i).getClassStartTime().before(cBean.getClassStartTime())
                                        && cBeans.get(i).getClassEndTime().after(cBean.getClassStartTime()))) {

                        } else {
                            return "dup";
                        }
                    }
                }
            }
        }

        ClassMemberBean cmBean = new ClassMemberBean();
        cmBean.setcBean(cBean);
        cmBean.setmBean(memBean);
        Long datetime = System.currentTimeMillis();
        Timestamp timestamp = new Timestamp(datetime);
        cmBean.setRegisterDate(timestamp);
        System.out.println(cBean.getClassAvaliable());
        memberService.insertReservation(cmBean, 1, classIdd);
        System.out.println(cBean.getClassAvaliable());
        System.out.println("======================================================");
        String email = mBean.getEmail();
        String subject = "一對一課程預約成功通知信";
        String body = mBean.getName() + ",您好：" + "\n\n\n" + "您的預約資訊如下：" + "\n\n" + "課程名稱：" + cBean.getClassName() + "\n"
                + cBean.getClassEndTime() + "\n\n\n" + "感謝您的預約！";

        emailSerive.sendEmail(email, subject, body);
        System.out.println(cBean.getClassAvaliable());

        if (cBean.getClassAvaliable() == 1) {
            System.out.println("成功");
            return "true";
        } else {
            System.out.println("失敗");
            return "false";
        }

    }

	// Mark
	@PostMapping("searchClass")
	@ResponseBody
	public List<ClassBean> searchClass(@RequestParam(required = false, name = "cName") String className,
			@RequestParam(required = false, name = "coaName") String coachName,
			@RequestParam(required = false, name = "sName") String skillName,
			@RequestParam(required = false, name = "sDate") String startDate,
			@RequestParam(required = false, name = "eDate") String endDate,
			@RequestParam(required = false, name = "cStatus") String classStatus) {
		// System.out.println(className);
		// System.out.println(skillName);
		// System.out.println(startDate);
		// System.out.println(endDate);
		// System.out.println(classStatus);
		if (className.isEmpty() && coachName.equals("請選擇") && skillName.equals("請選擇") && startDate.isEmpty()
				&& endDate.isEmpty() && classStatus.equals("請選擇")) {
			List<ClassBean> cBean = claService.listAllClass();
			return cBean;
		} else {
			List<ClassBean> cBean = claService.dynamicQuery(className, coachName, skillName, startDate, endDate,
					classStatus);
			System.out.println("123");
			return cBean;
		}

	}

	// Mark
	@PostMapping("memberSearchClass")
	@ResponseBody
	public List<ClassBean> memberSearchClass(@RequestParam(required = false, name = "cName") String className,
			@RequestParam(required = false, name = "coaName") String coachName,
			@RequestParam(required = false, name = "sName") String skillName,
			@RequestParam(required = false, name = "sDate") String startDate,
			@RequestParam(required = false, name = "eDate") String endDate,
			@RequestParam(required = false, name = "cStatus") String classStatus,
			@SessionAttribute("loginUser") MemberBean mBean) {
		// System.out.println(className);
		// System.out.println(skillName);
		// System.out.println(startDate);
		// System.out.println(endDate);
		// System.out.println(classStatus);
		List<ClassBean> mcBean = memberService.findByMemberId(mBean.getNumber());
		if (className.isEmpty() && coachName.equals("請選擇") && skillName.equals("請選擇") && startDate.isEmpty()
				&& endDate.isEmpty() && classStatus.equals("請選擇")) {
			return mcBean;
		} else {
			List<ClassBean> cBean = claService.memberDynamicQuery(className, coachName, skillName, startDate, endDate,
					classStatus, mcBean);
			System.out.println("123");
			return cBean;
		}

	}

	@GetMapping("testcoach")
	public String testCoachList() {

		return "/Temp/coachTest";

	}

	@GetMapping("showCoachList")
	public String showCoachList() {

		return "/coach/coachList";

	}

	@GetMapping("/getClassPicture")
	public ResponseEntity<byte[]> getCoachPicture(@RequestParam("classId") String classId) throws SQLException {
		System.out.println(classId);
		Integer classIdd = Integer.parseInt(classId);
		ClassBean cBean = claService.getClassById(classIdd);
		// System.out.println(cBean.getCoachName());
		ResponseEntity<byte[]> re = null;
		Blob blob = cBean.getClassPhoto();
		byte[] b = blob.getBytes(1, (int) blob.length());
		HttpHeaders headers = new HttpHeaders();
		MediaType mediaType = MediaType.valueOf(cBean.getClassPhotoMineType());
		headers.setContentType(mediaType);
		re = new ResponseEntity<byte[]>(b, headers, HttpStatus.OK);
		return re;
	}

	@GetMapping("classIntroduction")
	public String classIntroduction() {
		return "/member/classIntroduction";
	}

}
