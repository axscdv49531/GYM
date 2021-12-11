package tw.gym.coach.controller;

import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import tw.gym.coach.model.ClassBean;
import tw.gym.coach.model.CoachBean;
import tw.gym.coach.model.SkillBean;
import tw.gym.coach.service.ClassMemberService;
import tw.gym.coach.service.ClassService;
import tw.gym.coach.service.CoachService;
import tw.gym.coach.service.SkillService;

@Controller
@RequestMapping("/coach")
// @SessionAttributes({ "LoginOK" })
public class CoachAddFormController {

    @Autowired
    CoachService service;

    @Autowired
    ClassService classService;

    @Autowired
    SkillService skiService;

    @Autowired
    ClassMemberService cmService;

    // // 可山
    // @GetMapping("coachAdd")
    // public String showCoachAddForm(Model model) {
    // List<String> radioData = new ArrayList<String>();
    // radioData.add("男");
    // radioData.add("女");
    // model.addAttribute("radioData", radioData);
    // CoachBean cbean = new CoachBean();
    // cbean.setCoachPassword("P@ssw0rd");
    // String encodePwd = new BCryptPasswordEncoder().encode(cbean.getCoachPassword());
    // cbean.setCoachPassword(encodePwd);
    // model.addAttribute("coachBean", cbean);
    // return "/coach/coachAdd";
    //
    // }
    //
    // // 可刪
    // @PostMapping("coachAdd")
    // public String insertCoachData(CoachBean cbean) throws ParseException, IOException, SerialException, SQLException
    // {
    //
    // Long datetime = System.currentTimeMillis();
    // Timestamp timestamp = new Timestamp(datetime);
    //
    // MultipartFile picture = cbean.getcPhoto();
    // byte[] b = picture.getBytes();
    // Blob blob = new SerialBlob(b);
    // cbean.setCoachStatus(0);
    // String fileName = picture.getOriginalFilename();
    //
    // String mineType = picture.getContentType();
    // cbean.setCoachRegisterdate(timestamp);
    // cbean.setCoachPhoto(blob);
    // cbean.setFileName(fileName);
    // cbean.setCoachPhotoMineType(mineType);
    // service.save(cbean);
    // return "redirect:/";
    //
    // }

//    @GetMapping("coachLogin")
//    public String coachLogin(Model model) {
//        LoginBean lBean = new LoginBean();
//        model.addAttribute("loginBean", lBean);
//        return "coach/coachLogin";
//    }
//
//    @PostMapping("coachLogin")
//    public String coachLoginCheck(LoginBean lBean, Model model, HttpSession session) {
//        CoachBean cBean = null;
//        cBean = service.findByAccountAndPassword(lBean.getUserAccount(), lBean.getUserPassword());
//        if (cBean != null) {
//            session.setAttribute("loginUser", cBean);
//            System.out.println("登入成功");
//        } else {
//            System.out.println("登入失敗");
//        }
//
//        return "/coach/LoginSuccess";
//    }
//    @GetMapping("coachLogin")
//    public String coachLogin(Model model) {
//    	 return "/coach/LoginSuccess";
//    }

@GetMapping("coachClassAdd")
public String coachClassAdd(Model model) {
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
        // ClassBean cbean = new ClassBean();
        // model.addAttribute("classBean", cbean);
        // if (!model.containsAttribute("classBean")) {
        // ClassBean cbean = new ClassBean();
        // System.out.println("aaa");
        // model.addAttribute("classBean", cbean);
        // } else {
        // System.out.println(model.getAttribute("classBean"));
        // }
        ClassBean cbean = new ClassBean();
        model.addAttribute("classBean", cbean);


        return "/coach/coachClassAdd";
    }

    @PostMapping("coachClassAdd")
    public String coachClassAddCheck(ClassBean cBean,
            @SessionAttribute("loginUser") CoachBean cBeann, Model model)
            throws ParseException, SerialException, SQLException, IOException {
        System.out.println("check-----------------------------");
        // new ClassValidator().validate(cBean, bindingResult);
        // if (bindingResult.hasErrors()) {
        // List<String> skList = skiService.listAllSkill();
        // model.addAttribute("checkBoxList", skList);
        // List<String> selectData = new ArrayList<String>();
        // selectData.add("09:00");
        // selectData.add("10:00");
        // selectData.add("11:00");
        // selectData.add("12:00");
        // selectData.add("13:00");
        // selectData.add("14:00");
        // selectData.add("15:00");
        // selectData.add("16:00");
        // selectData.add("17:00");
        // selectData.add("18:00");
        // selectData.add("19:00");
        // selectData.add("20:00");
        // model.addAttribute("selectData", selectData);
        // return "/coach/coachClassAdd";
        // }


        Long datetime = System.currentTimeMillis();
        Timestamp timestamp = new Timestamp(datetime);
        cBean.setClassCreatedate(timestamp);
        DateFormat formatter = new SimpleDateFormat("HH:mm");
        Time startTime = new Time(formatter.parse(cBean.getClassStartTimeTemp()).getTime());
        cBean.setClassStartTime(startTime);
        Time endTime = new Time(formatter.parse(cBean.getClassEndTimeTemp()).getTime());
        cBean.setClassEndTime(endTime);
        cBean.setcBean(cBeann);
        // String[] skill = cBean.getClassLabel().split(",");
        Set<SkillBean> sBean = new HashSet<SkillBean>();
        for (int i = 0; i < cBean.getClassLabel().length; i++) {
            SkillBean sBeann = skiService.findBySkillName(cBean.getClassLabel()[i]);
            // sBeann.setSkillName(skill[i]);
            sBean.add(sBeann);
        }

        MultipartFile picture = cBean.getClaPhoto();
        byte[] b = picture.getBytes();
        Blob blob = new SerialBlob(b);

        String fileName = picture.getOriginalFilename();

        String mineType = picture.getContentType();
        cBean.setClassPhoto(blob);
        cBean.setClassFileName(fileName);
        cBean.setClassPhotoMineType(mineType);

        cBean.setsBean(sBean);
        classService.save(cBean);
        return "redirect:/coach/coachClassList";
    }

    @GetMapping("coachClassList")
    public String coachClassList(Model model, @SessionAttribute("loginUser") CoachBean cBeann) {
        List<ClassBean> cBean = classService.findClassesByCoachId(cBeann.getCoachId());
        model.addAttribute(cBean);
        return "/coach/coachClassList";
    }

    @GetMapping("/updateClass")
    // public String updateClass(Model model, @PathVariable("id") Integer id) {
    public String updateClass(Model model, @RequestParam("Id") Integer id) {
        // List<String> checkBoxData = new ArrayList<String>();
        // checkBoxData.add("胸");
        // checkBoxData.add("肩");
        // checkBoxData.add("背");
        // checkBoxData.add("腿");
        // checkBoxData.add("跑步");
        // checkBoxData.add("飛輪");
        // checkBoxData.add("瑜珈");
        // model.addAttribute("checkBoxData", checkBoxData);
        List<String> skList = skiService.listAllSkill();
        // System.out.println(skList);s
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
        ClassBean cBean = classService.getClassById(id);
        String startTemp = cBean.getClassStartTime().toString();
        String start = startTemp.substring(0, 5);
        String endTemp = cBean.getClassEndTime().toString();
        String end = endTemp.substring(0, 5);
        cBean.setClassStartTimeTemp(start);
        cBean.setClassEndTimeTemp(end);
        model.addAttribute("classBean", cBean);
        // System.out.println(cBean.getClassName());
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


        return "/coach/coachClassDetail";
    }

    @PostMapping(value = "/updateClass", params = "edit")
    public String updateClassCheck(ClassBean cBean, @RequestParam("Id") Integer id)
            throws ParseException, IOException, SerialException, SQLException {
        DateFormat formatter = new SimpleDateFormat("HH:mm");
        Time startTime = new Time(formatter.parse(cBean.getClassStartTimeTemp()).getTime());
        cBean.setClassStartTime(startTime);
        Time endTime = new Time(formatter.parse(cBean.getClassEndTimeTemp()).getTime());
        cBean.setClassEndTime(endTime);
        // String[] skill = cBean.getClassLabel().split(",");
        Set<SkillBean> sBean = new HashSet<SkillBean>();
        for (int i = 0; i < cBean.getClassLabel().length; i++) {
            SkillBean sBeann = skiService.findBySkillName(cBean.getClassLabel()[i]);
            // sBeann.setSkillName(skill[i]);
            sBean.add(sBeann);
        }
        cBean.setsBean(sBean);

        MultipartFile picture = cBean.getClaPhoto();
        byte[] b = picture.getBytes();
        Blob blob = new SerialBlob(b);

        String fileName = picture.getOriginalFilename();

        String mineType = picture.getContentType();
        cBean.setClassPhoto(blob);
        cBean.setClassFileName(fileName);
        cBean.setClassPhotoMineType(mineType);
        classService.updateClass(cBean);
        return "redirect:/coach/coachClassList";

    }

    @PostMapping(value = "/updateClass/{id}", params = "delete")
    public String deleteClassData(ClassBean cBean) {
        classService.deleteById(cBean.getClassId());
        return "redirect:/coach/coachClassList";
    }

    // @PostMapping("listAllCoach")
    // @ResponseBody
    // public List<CoachBean> listAllCoach() {
    // List<CoachBean> cBean = service.listAllCoach();
    //
    // return cBean;
    // }

    @PostMapping("listAllClass")
    @ResponseBody
    public List<ClassBean> listAllClass(@SessionAttribute("loginUser") CoachBean cBean) {
        List<ClassBean> claBean = classService.findClassesByCoachId(cBean.getCoachId());
        // Optional<MemberBean> mBean = cmService.findMemberByClassId(66);
        // System.out.println(mBean.get().getName());

        return claBean;
    }

    // @InitBinder
    // public void initBinder(WebDataBinder binder, WebRequest request) {
    // // java.util.Date
    // DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    // dateFormat.setLenient(false);
    // CustomDateEditor ce = new CustomDateEditor(dateFormat, true);
    // binder.registerCustomEditor(Date.class, ce);
    // // java.sql.Date
    // DateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
    // dateFormat2.setLenient(false);
    // CustomDateEditor ce2 = new CustomDateEditor(dateFormat2, true);
    // binder.registerCustomEditor(java.sql.Date.class, ce2);
    // }
}
