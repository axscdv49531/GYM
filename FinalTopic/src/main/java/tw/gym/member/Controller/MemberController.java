package tw.gym.member.Controller;

import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
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

import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.MemberService;
import tw.gym.member.validator.MemberValidator;
import tw.gym.model.ClassBean;
import tw.gym.model.ClassMemberBean;
import tw.gym.model.SkillBean;
import tw.gym.service.ClassService;
import tw.gym.service.CoachService;
import tw.gym.service.SkillService;

@Controller
//@RequestMapping(path = "/GymProject")
// @SessionAttributes(names = { "totalPages", "totalElements" })
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
	public MemberController(MemberService memberService) {
		this.memberService = memberService;
	}

	// 輸入會員資料
	@GetMapping(path = "/insertMember")
	public String insertMember(Model m) {
		MemberBean memberBean = new MemberBean();
		m.addAttribute("memberBean", memberBean);
		return "member/MemberForm";
	}

	@PostMapping(path = "/insertMember")
	public String insert(Model m, @ModelAttribute("memberBean") MemberBean memberBean, BindingResult bindingResult) {
		MemberValidator memberValidator = new MemberValidator();
		memberValidator.validate(memberBean, bindingResult);


		if (bindingResult.hasErrors()) {
			System.out.println(bindingResult.getAllErrors());
			return "member/MemberForm";
		}
//		if (memberBean != null) {
//			if(memberBean.getId().equals(memberService. == true);
//			bindingResult.rejectValue("memberId", "", "帳號已存在，請重新輸入");
//			return "MemberForm"; 
//		}
		String encodePwd = new BCryptPasswordEncoder().encode(memberBean.getPassword());
		memberBean.setPassword(encodePwd);
        memberBean.setDeposite(0);
		memberService.insert(memberBean);
		return "redirect:/member/findAllMember";
	}
//	@PostMapping("/insertMember")
//	@ResponseBody
//	public MemberBean processInsertMember( @RequestBody MemberBean memberBean) { 
//		 return memberService.insert(memberBean);
//	}

	@GetMapping("/findAllMember")
	public String selectAll(Model model) {
		List<MemberBean> memberBean = memberService.findAll();
		model.addAttribute(memberBean);
		return "member/ShowMember";
	}

	@GetMapping("/selectMember/{number}")
	public String findById(Model model, @PathVariable Integer number) {
		MemberBean memberBean = memberService.findByNumber(number);
		model.addAttribute("memberBean", memberBean);
		return "member/ShowMemberDetail";
	}

	@GetMapping("/modifyMember/{number}")
	public String updateMember(Model model, @PathVariable Integer number) {
		MemberBean memberBean = memberService.findByNumber(number);
//		memberbean.setPassword(memberbean.getPassword());
		model.addAttribute("memberBean", memberBean);
		return "member/EditMemberForm";
	}

	@PostMapping("/modifyMember/{number}")
	public String updateMemberdata(@ModelAttribute("memberBean") MemberBean memberBean, BindingResult bindingResult) {
		new MemberValidator().validate(memberBean, bindingResult);

		if (bindingResult.hasErrors()) {
			return "member/EditMemberForm";
		}
		memberService.update(memberBean);
		return "redirect:/member/findAllMember";
	}

	@GetMapping("/deleteMember/{number}")
	public String deleteMemberData(@PathVariable("number") Integer number) throws SQLException {
		memberService.deleteById(number);
		return "redirect:/member/findAllMember";
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

    // //Mark
    // @GetMapping("memberLogin")
    // public String memberlogin(Model model) {
    // LoginBean lBean = new LoginBean();
    // model.addAttribute("loginBean", lBean);
    // return "/coach/coachLogin";
    // }

    // //Mark
    // @PostMapping("memberLogin")
    // public String memberlogincheck(Model model, HttpSession session, LoginBean lBean) {
    // MemberBean mBean = null;
    // System.out.println(lBean.getUserAccount() + "1");
    // mBean = memService.findByAccountAndPassword(lBean.getUserAccount(), lBean.getUserPassword());
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

        return "redirect:/member/classReservation";
    }

    // Mark
    @GetMapping("viewReservationClass")
    public String viewReservationClass(Model model, @SessionAttribute("loginUser") MemberBean mBean) {

        List<ClassBean> cBean = memberService.findByMemberId(mBean.getNumber());
        model.addAttribute(cBean);

        return "/member/viewReservationClass";
    }

    // Mark
    @GetMapping("/cancelClass/{classId}")
    public String cencelClass(@PathVariable Integer classId, Integer a) {

        memberService.deleteByClassId(classId, 0);

        return "redirect:/member/viewReservationClass";
    }

    // Mark
    @PostMapping("listAllClass")
    @ResponseBody
    public List<ClassBean> listAllClass() {
        List<ClassBean> cBean = claService.listAllClass();

        return cBean;
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

}
