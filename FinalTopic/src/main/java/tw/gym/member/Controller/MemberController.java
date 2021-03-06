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
import java.util.Optional;
import java.util.Random;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MultipartFile;

import tw.gym.coach.model.ClassBean;
import tw.gym.coach.model.ClassMemberBean;
import tw.gym.coach.model.CoachBean;
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
@SessionAttributes(names = { "totalPages", "totalElements" })
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

	// ??????????????????
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
//		6??????????????????
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
//		??????
		String name = memberBean.getName();
		String pswd = memberBean.getPassword();
		String toEmail = memberBean.getEmail();
		String subject = "????????????????????? ";
		String body = "Dear " + name + " ??????/??????????????????\n???????????????SpringFitness????????? " + "?????????????????????SpringFitness??????????????????\n"
				+ "????????????????????????????????????\n" + "????????????????????????" + pswd + "\n" + "http://localhost:8080/" + "(??????????????????????????????????????????????????????????????????)";
//		????????????
		String encodePwd = new BCryptPasswordEncoder().encode(memberBean.getPassword());

//		????????????
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
		memberBean.setStatus(-1);
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
//		// bindingResult.rejectValue("memberId", "", "?????????????????????????????????");
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
	@GetMapping("/memberByPage/{pageNo}")
	@ResponseBody
	public List<MemberBean> MemberByPage(@PathVariable("pageNo") int pageNo, Model m) {
		int pageSize = 2;
		Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
		Page<MemberBean> page = memberService.findAllByPage(pageable);
		m.addAttribute("totalPages", page.getTotalPages());
		m.addAttribute("totalElements", page.getTotalElements());
		return page.getContent();
	}

	@GetMapping("/allmember")
	public String AllMember() {
		return "administrator/allMember";
	}

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
		if (!memberBean.getmPhoto().isEmpty()) {
			MultipartFile picture = memberBean.getmPhoto();
			byte[] b = picture.getBytes();
			Blob blob = new SerialBlob(b);

			String fileName = picture.getOriginalFilename();

			String mineType = picture.getContentType();
			memberBean.setMemberPhoto(blob);
			memberBean.setFileName(fileName);
			memberBean.setMemberPhotoMineType(mineType);
		} else {
			MemberBean member = memberService.findByNumber(memberBean.getNumber());
			Blob blob = member.getMemberPhoto();
			String fileName = member.getFileName();
			String mineType = member.getMemberPhotoMineType();
			memberBean.setMemberPhoto(blob);
			memberBean.setFileName(fileName);
			memberBean.setMemberPhotoMineType(mineType);
		}
		memberBean.setStatus(0);
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
		if (!memberBean.getmPhoto().isEmpty()) {
			MultipartFile picture = memberBean.getmPhoto();
			byte[] b = picture.getBytes();
			Blob blob = new SerialBlob(b);

			String fileName = picture.getOriginalFilename();

			String mineType = picture.getContentType();
			memberBean.setMemberPhoto(blob);
			memberBean.setFileName(fileName);
			memberBean.setMemberPhotoMineType(mineType);
		} else {
			MemberBean member = memberService.findByNumber(memberBean.getNumber());
			Blob blob = member.getMemberPhoto();
			String fileName = member.getFileName();
			String mineType = member.getMemberPhotoMineType();
			memberBean.setMemberPhoto(blob);
			memberBean.setFileName(fileName);
			memberBean.setMemberPhotoMineType(mineType);
		}

		if (bindingResult.hasErrors()) {
			return "member/MemberUpdateProfile";
		}
		memberService.update(memberBean);
		return "redirect:/MemberProfile";
	}

	@GetMapping("/forgetPwd")
	public String forgetPwd(Model model, MemberBean memberBean) {
		model.addAttribute("memberBean", memberBean);
		return "member/forgetPwd";
	}

	@PostMapping("/forgetPwd")
	public String forgetPwdData(@ModelAttribute("memberBean") MemberBean member, BindingResult bindingResult)
			throws UsernameNotFoundException {
		String email = member.getEmail();
		String phone = member.getPhone();
		try {
			Optional<MemberBean> opmember = memberService.findEmail(email);

			if (opmember.isEmpty()) {
				bindingResult.rejectValue("email", "", "???????????????");
				return "member/forgetPwd";
			}

			MemberBean memberBean = memberService.findByEmail(email);
			if (!phone.equals(memberBean.getPhone())) {
				System.out.print(phone);
				System.out.print(memberBean.getPhone());

				bindingResult.rejectValue("phone", "", "????????????????????????");
				return "member/forgetPwd";
			} else {
				String[] alphabet = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P",
						"Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" };
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
//			??????
				String name = memberBean.getName();
				String pswd = memberBean.getPassword();
				String toEmail = memberBean.getEmail();
				String subject = "????????????????????? ";
				String body = "Dear " + name + " ??????/??????????????????\n??????????????????????????? " + "?????????????????????SpringFitness??????????????????\n"
						+ "????????????????????????????????????\n" + "???????????????????????????" + pswd + "\n" + "http://localhost:8080/" + "\n"
						+ "(??????????????????????????????????????????????????????????????????)";
//			????????????
				String encodePwd = new BCryptPasswordEncoder().encode(memberBean.getPassword());
				memberBean.setPassword(encodePwd);
				memberBean.setStatus(-1);
				emailSerive.sendEmail(toEmail, subject, body);
				memberService.update(memberBean);
				return "redirect:/login/Member";
			}
		} catch (Exception e) {
			return "member/forgetPwd";
		}
	}

	@GetMapping("/deleteMember/{number}")
	public String deleteMemberData(@PathVariable("number") Integer number) throws SQLException {
		memberService.deleteById(number);
		return "redirect:/findAllMember";
	}

	@GetMapping("/updatePassword/{number}")
	public String updatePassword(Model model, @PathVariable("number") Integer number) {
		MemberBean memberBean = memberService.findByNumber(number);
		model.addAttribute("memberBean", memberBean);
		return "member/MemberUpdatePassword";
	}

	@PostMapping("/updatePassword/{number}")
	public String updatePasswordData(MemberBean memberBean, BindingResult bindingResult,
			@PathVariable("number") Integer number) throws ParseException, IOException, SerialException, SQLException {
		PasswordValidator passwordValidator = new PasswordValidator();
		passwordValidator.validate(memberBean, bindingResult);
		MemberBean member = memberService.findByNumber(number);
		BCryptPasswordEncoder encode = new BCryptPasswordEncoder();
		if (!encode.matches(memberBean.getOldpwd(), member.getPassword())) {
			bindingResult.rejectValue("oldpwd", "", "???????????????");
			return "member/MemberUpdatePassword";
		}
		if (memberBean.getPassword1().length() < 8 || memberBean.getPassword1().length() > 15) {
			bindingResult.rejectValue("password1", "", "?????????8-15?????????????????????");
			System.out.println("??????");
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
				if (flag1 && flag2 && flag3 == true) {
					break;
				}
			}
			if (flag1 && flag2 && flag3 == true) {
				System.out.println("??????");
			} else {
				System.out.println("??????");
				bindingResult.rejectValue("password1", "", "???????????????????????????????????????");
				return "member/MemberUpdatePassword";
			}
		}
		if (bindingResult.hasErrors()) {

			System.out.println(bindingResult.getAllErrors());

			return "member/MemberUpdatePassword";
		}
		String newPwd = new BCryptPasswordEncoder().encode(memberBean.getPassword1());
		member.setPassword(newPwd);
		member.setStatus(0);
		memberService.update(member);
		return "redirect:/login/Member";
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
	// System.out.println("????????????");
	// } else {
	// System.out.println("????????????");
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
		// memberService.insertReservation(cmBean, 1, classId);

        CoachBean cBeann = claService.findCoachByClassId(classId);

		String email = mBean.getEmail();
		String subject = "????????????????????????????????????";
        String body = mBean.getName() + " ??????/??????,?????????" + "\n\n\n" + "???????????????????????????" + "\n\n" + "???????????????" + cBean.getClassName()
                + "\n" + "???????????????" + cBeann.getCoachName() + "\n" + "???????????????" + cBean.getClassDate() + "\n" + "???????????????"
                + cBean.getClassStartTime() + "~"
				+ cBean.getClassEndTime() + "\n\n\n" + "?????????????????????";

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
		String subject = "??????????????????????????????????????????";
		String body = mBean.getName() + ",?????????" + "\n\n\n" + "????????????????????????????????????????????????" + "\n\n" + "???????????????" + cBean.getClassName()
				+ "\n" + "???????????????" + cBean.getClassDate() + "\n" + "???????????????" + cBean.getClassStartTime() + "~"
				+ cBean.getClassEndTime() + "\n\n\n" + "????????????????????????";

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
		String subject = "??????????????????????????????????????????";
		String body = mBean.getName() + ",?????????" + "\n\n\n" + "????????????????????????????????????????????????" + "\n\n" + "???????????????" + cBean.getClassName()
				+ "\n" + "???????????????" + cBean.getClassDate() + "\n" + "???????????????" + cBean.getClassStartTime() + "~"
				+ cBean.getClassEndTime() + "\n" + "\n\n\n" + "????????????????????????";

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
	public String classReservationCheck(@RequestParam(required = false, name = "classConfirm") String classConfirm,
			@RequestParam(required = false, name = "classId") String classId,
			@SessionAttribute("loginUser") MemberBean mBean) {

		Integer classIdd = Integer.parseInt(classId);
		ClassBean cBean = claService.getClassById(classIdd);
		MemberBean memBean = memberService.getById(mBean.getNumber());

		List<ClassBean> cBeans = cmService.findClassesByMemberId(mBean.getNumber());
		for (int i = 0; i < cBeans.size(); i++) {
			if (cBeans.get(i).getClassDate().equals(cBean.getClassDate())) {
				if (cBeans.get(i).getClassStartTime().after(cBean.getClassStartTime())) {
					if (cBeans.get(i).getClassStartTime().equals(cBean.getClassEndTime())
							|| !(cBeans.get(i).getClassStartTime().before(cBean.getClassEndTime())
									&& cBeans.get(i).getClassEndTime().after(cBean.getClassEndTime()))) {
						System.out.println("?????????");

					} else {
						System.out.println("?????????");
					}
				} else {
					if (!cBeans.get(i).getClassStartTime().equals(cBean.getClassStartTime())
							&& !(cBeans.get(i).getClassStartTime().before(cBean.getClassStartTime())
									&& cBeans.get(i).getClassEndTime().after(cBean.getClassStartTime()))) {
						System.out.println("?????????");
					} else {
						System.out.println("?????????");
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
		// memberService.insertReservation(cmBean, 1, classIdd);
		String email = mBean.getEmail();
		String subject = "????????????????????????????????????";
		String body = mBean.getName() + ",?????????" + "\n\n\n" + "???????????????????????????" + "\n\n" + "???????????????" + cBean.getClassName() + "\n"
				+ "???????????????" + cBean.getClassDate() + "\n" + "???????????????" + cBean.getClassStartTime() + "~"
				+ cBean.getClassEndTime() + "\n\n\n" + "?????????????????????";

		emailSerive.sendEmail(email, subject, body);

		if (cBean.getClassAvaliable() == 1) {

			return "true";
		} else {
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
		if (className.isEmpty() && coachName.equals("?????????") && skillName.equals("?????????") && startDate.isEmpty()
				&& endDate.isEmpty() && classStatus.equals("?????????")) {
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
		if (className.isEmpty() && coachName.equals("?????????") && skillName.equals("?????????") && startDate.isEmpty()
				&& endDate.isEmpty() && classStatus.equals("?????????")) {
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
