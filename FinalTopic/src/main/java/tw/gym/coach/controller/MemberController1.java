package tw.gym.coach.controller;
//package tw.gym.controller;
//
//import java.sql.Timestamp;
//import java.text.ParseException;
//import java.util.ArrayList;
//import java.util.List;
//
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.bind.annotation.SessionAttribute;
//
//import tw.gym.model.ClassBean;
//import tw.gym.model.ClassMemberBean;
//import tw.gym.model.LoginBean;
//import tw.gym.model.MemberBean1;
//import tw.gym.model.SkillBean;
//import tw.gym.service.ClassService;
//import tw.gym.service.CoachService;
//import tw.gym.service.MemberService1;
//import tw.gym.service.SkillService;
//import tw.gym.service.impl.testaaa;
//
//@Controller
//@RequestMapping("/member")
//public class MemberController1 {
//
//    @Autowired
//    MemberService1 memService;
//    @Autowired
//    ClassService claService;
//    @Autowired
//    CoachService coaService;
//    @Autowired
//    SkillService skiService;
//    @Autowired
//    testaaa t;
//
//    @GetMapping("memberLogin")
//    public String memberlogin(Model model) {
//        LoginBean lBean = new LoginBean();
//        model.addAttribute("loginBean", lBean);
//        return "/coach/coachLogin";
//    }
//
//    @PostMapping("memberLogin")
//    public String memberlogincheck(Model model, HttpSession session, LoginBean lBean) {
//        MemberBean1 mBean = null;
//        System.out.println(lBean.getUserAccount() + "1");
//        mBean = memService.findByAccountAndPassword(lBean.getUserAccount(), lBean.getUserPassword());
//        System.out.println(lBean.getUserAccount());
//        if (mBean != null) {
//            session.setAttribute("loginUser", mBean);
//            // model.addAttribute("LoginOK", cBean);
//            System.out.println("登入成功");
//        } else {
//            System.out.println("登入失敗");
//        }
//
//        return "/member/memberLoginSuccess";
//    }
//
//    @GetMapping("classReservation")
//    public String memberViewClassList(Model model) {
//        List<ClassBean> allClass = claService.listAllClass();
//        List<SkillBean> sBean = skiService.findAll();
//        List<String> name = claService.findClassCoach();
//        model.addAttribute("coachList", name);
//        model.addAttribute("skillList", sBean);
//        model.addAttribute(allClass);
//        return "/member/classList";
//    }
//
//    @GetMapping("/viewClass/{id}")
//    public String memberViewClass(@PathVariable("id") Integer classId, Model model) {
//        List<String> checkBoxData = new ArrayList<String>();
//        checkBoxData.add("胸");
//        checkBoxData.add("肩");
//        checkBoxData.add("背");
//        checkBoxData.add("腿");
//        checkBoxData.add("跑步");
//        checkBoxData.add("飛輪");
//        checkBoxData.add("瑜珈");
//        model.addAttribute("checkBoxData", checkBoxData);
//        List<String> selectData = new ArrayList<String>();
//        selectData.add("09:00");
//        selectData.add("10:00");
//        selectData.add("11:00");
//        selectData.add("12:00");
//        selectData.add("13:00");
//        selectData.add("14:00");
//        selectData.add("15:00");
//        selectData.add("16:00");
//        selectData.add("17:00");
//        selectData.add("18:00");
//        selectData.add("19:00");
//        selectData.add("20:00");
//        model.addAttribute("selectData", selectData);
//        ClassBean cBean = claService.getClassById(classId);
//        String startTemp = cBean.getClassStartTime().toString();
//        String start = startTemp.substring(0, 5);
//        String endTemp = cBean.getClassEndTime().toString();
//        String end = endTemp.substring(0, 5);
//        cBean.setClassStartTimeTemp(start);
//        cBean.setClassEndTimeTemp(end);
//        model.addAttribute("classBean", cBean);
//
//        return "/member/viewClass";
//    }
//
//    @PostMapping("/viewClass/{id}")
//    public String reservationSuccess(@PathVariable("id") Integer classId,
//            @SessionAttribute("loginUser") MemberBean1 mBean) {
//        // ClassBean cBean = claService.getClassById(classId);
//        // MemberBean memBean = memService.getById(mBean.getMemberId());
//        // memBean.setcBean(cBean);
//        ClassBean cBean = claService.getClassById(classId);
//        MemberBean1 memBean = memService.getById(mBean.getMemberId());
//        ClassMemberBean cmBean = new ClassMemberBean();
//        cmBean.setcBean(cBean);
//        cmBean.setmBean(memBean);
//        Long datetime = System.currentTimeMillis();
//        Timestamp timestamp = new Timestamp(datetime);
//        cmBean.setRegisterDate(timestamp);
//        memService.insertReservation(cmBean, 1, classId);
//
//        return "redirect:/member/classReservation";
//    }
//
//    @GetMapping("viewReservationClass")
//    public String viewReservationClass(Model model, @SessionAttribute("loginUser") MemberBean1 mBean) {
//
//        List<ClassBean> cBean = memService.findByMemberId(mBean.getMemberId());
//        model.addAttribute(cBean);
//
//        return "/member/viewReservationClass";
//    }
//
//    @GetMapping("/cancelClass/{classId}")
//    public String cencelClass(@PathVariable Integer classId, Integer a) {
//
//        memService.deleteByClassId(classId, 0);
//
//        return "redirect:/member/viewReservationClass";
//    }
//
//    @PostMapping("listAllClass")
//    @ResponseBody
//    public List<ClassBean> listAllClass() {
//        List<ClassBean> cBean = claService.listAllClass();
//
//        return cBean;
//    }
//
//    @PostMapping("searchClass")
//    @ResponseBody
//    public List<ClassBean> searchClass(@RequestParam(required = false, name = "cName") String className,
//            @RequestParam(required = false, name = "coaName") String coachName,
//            @RequestParam(required = false, name = "sName") String skillName,
//            @RequestParam(required = false, name = "sDate") String startDate,
//            @RequestParam(required = false, name = "eDate") String endDate,
//            @RequestParam(required = false, name = "cStatus") String classStatus) throws ParseException {
//        // @RequestParam(required = false, name = "searchaa")
//        System.out.println(className);
//        System.out.println(skillName);
//        System.out.println(startDate);
//        System.out.println(endDate);
//        System.out.println(classStatus);
//        // List<ClassBean> cBean = null;
//        // if (className.isEmpty() && skillName.equals("請選擇") && startDate.isEmpty() && endDate.isEmpty()) {
//        // List<ClassBean> cBean = claService.listAllClass();
//        // return cBean;
//        // } else {
//        // List<ClassBean> cBean = t.findd(className);
//        // System.out.println("123");
//        // return cBean;
//        // }
//        if (className.isEmpty() && coachName.equals("請選擇") && skillName.equals("請選擇") && startDate.isEmpty()
//                && endDate.isEmpty() && classStatus.equals("請選擇")) {
//            List<ClassBean> cBean = claService.listAllClass();
//            return cBean;
//        } else {
//            List<ClassBean> cBean = claService.dynamicQuery(className, coachName, skillName, startDate, endDate,
//                    classStatus);
//            System.out.println("123");
//            return cBean;
//        }
//
//    }
//
//}
