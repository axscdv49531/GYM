package tw.gym.member.Controller;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

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

@Controller
@RequestMapping("/member")
public class MembersController {
    @Autowired
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

    // Mark
    @PostMapping("classReservationCheck")
    @ResponseBody
    public ClassBean classReservationCheck(@RequestParam(required = false, name = "classConfirm") String classConfirm,
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
                        return null;
                    }
                } else {
                    if (!cBeans.get(i).getClassStartTime().equals(cBean.getClassStartTime())
                            && !(cBeans.get(i).getClassStartTime().before(cBean.getClassStartTime())
                                    && cBeans.get(i).getClassEndTime().after(cBean.getClassStartTime()))) {
                        System.out.println("?????????");
                    } else {
                        System.out.println("?????????");
                        return null;
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
        claService.setAvaliable(1, classIdd);
        memberService.insertReservation(cmBean);
        System.out.println(cBean.getClassAvaliable());
        CoachBean cBeann = claService.findCoachByClassId(classIdd);

        String email = mBean.getEmail();
        String subject = "????????????????????????????????????";
        String body = mBean.getName() + " ??????/??????,?????????" + "\n\n\n" + "???????????????????????????" + "\n\n" + "???????????????" + cBean.getClassName()
                + "\n" + "???????????????" + cBeann.getCoachName() + "\n" + "???????????????" + cBean.getClassDate() + "\n" + "???????????????"
                + cBean.getClassStartTime() + "~"
                + cBean.getClassEndTime() + "\n\n\n" + "?????????????????????";


        emailSerive.sendEmail(email, subject, body);

        // if (cBean.getClassAvaliable() == 1) {
        //
        // return "true";
        // } else {
        // return "false";
        // }
        return cBean;
    }

    @GetMapping("memberViewClassDetail")
    public String memberViewClassDetail(Model model, @RequestParam("Id") Integer id) {

        CoachBean cBean = claService.findCoachByClassId(id);
        ClassBean claBean = claService.getClassById(id);

        String coachAccount = cBean.getCoachAccount();
        model.addAttribute("coachAccount", coachAccount);
        model.addAttribute("claBean", claBean);
        return "/member/memberViewClassDetail";
    }

    @GetMapping("memberViewClassDetailPerson")
    public String memberViewClassDetailPerson(Model model, @RequestParam("Id") Integer id) {

        CoachBean cBean = claService.findCoachByClassId(id);
        ClassBean claBean = claService.getClassById(id);

        String coachAccount = cBean.getCoachAccount();
        model.addAttribute("coachAccount", coachAccount);
        model.addAttribute("claBean", claBean);
        return "/member/memberViewClassDetailPerson";
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
    @PostMapping("cancelClass")
    @ResponseBody
    public String cencelClass(@RequestParam(required = false, name = "classId") String classId,
            @SessionAttribute("loginUser") MemberBean mBean) {
        Integer classIdd = Integer.parseInt(classId);
        memberService.deleteByClassId(classIdd, 0);
        ClassBean cBean = claService.getClassById(classIdd);

        CoachBean cBeann = claService.findCoachByClassId(classIdd);
        String email = mBean.getEmail();
        String subject = "??????????????????????????????????????????";
        String body = mBean.getName() + " ??????/??????,?????????" + "\n\n\n" + "????????????????????????????????????????????????" + "\n\n" + "???????????????"
                + cBean.getClassName()
                + "\n" + "???????????????" + cBeann.getCoachName() + "\n" + "???????????????" + cBean.getClassDate() + "\n" + "???????????????"
                + cBean.getClassStartTime() + "~"
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
    @PostMapping("memberListAllClass")
    @ResponseBody
    public List<ClassBean> memberListAllClass(@SessionAttribute("loginUser") MemberBean mBean) {
        List<ClassBean> cBean = memberService.findByMemberId(mBean.getNumber());

        return cBean;
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

    @GetMapping("showCoachList")
    public String showCoachList() {

        return "/coach/coachList";

    }

    @GetMapping("memberClassListHistory")
    public String memberClassListHistory() {

        return "/member/memberClassListHistory";
    }

    @PostMapping("listRecentClass")
    @ResponseBody
    public List<ClassBean> listRecentClass(@SessionAttribute("loginUser") MemberBean mBean) {
        List<ClassBean> cBean = memberService.findByMemberId(mBean.getNumber());

        return cBean;
    }

    // Mark
    @GetMapping("classReservation")
    public String memberViewClassList(Model model, @RequestParam(required = false, name = "Id") String coachIdd) {

        System.out.println(coachIdd);
        List<ClassBean> allClass = claService.listAllClass();
        List<SkillBean> sBean = skiService.findAll();
        List<String> name = claService.findClassCoach();
        model.addAttribute("coachList", name);
        model.addAttribute("skillList", sBean);
        model.addAttribute(allClass);
        model.addAttribute("coachId", coachIdd);
        return "/member/classList";
    }

    // @GetMapping("classListByCoach")
    // public String classListByCoach(Model model, ) {
    // List<ClassBean> allClass = claService.listAllClass();
    // List<SkillBean> sBean = skiService.findAll();
    // List<String> name = claService.findClassCoach();
    // model.addAttribute("coachList", name);
    // model.addAttribute("skillList", sBean);
    // model.addAttribute(allClass);
    //
    //
    //
    //
    // return "/member/classList";
    // }

}
