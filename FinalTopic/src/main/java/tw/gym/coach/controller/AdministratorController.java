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
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import tw.gym.coach.model.ClassBean;
import tw.gym.coach.model.CoachBean;
import tw.gym.coach.model.SkillBean;
import tw.gym.coach.service.ClassService;
import tw.gym.coach.service.CoachService;
import tw.gym.coach.service.SkillService;

@Controller
@RequestMapping("/administrator")
public class AdministratorController {

    @Autowired
    CoachService service;

    @Autowired
    ClassService classService;

    @Autowired
    SkillService skiService;


    @GetMapping("coachPage")
    public String coachPage() {
        return "/coach/coachPage";
    }


    @GetMapping("coachList")
    public String listAllCoach(Model model) {
        List<CoachBean> cBean = service.listAllCoach();
        model.addAttribute(cBean);
        return "/coach/coachList";

    }

    // @GetMapping("/updateCoach/{account}")
    @GetMapping("updateCoach")
    public String updateCoach(Model model, @RequestParam("ac") String account) {
        System.out.println(account);
        List<String> radioData = new ArrayList<String>();
        radioData.add("男");
        radioData.add("女");
        model.addAttribute("radioData", radioData);
        CoachBean cBean = service.getCoachByAccount(account);
        // DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        // cBean.setCoachBirthTemp(df.format(cBean.getCoachBirth()));

        model.addAttribute("coachBean", cBean);
        return "/coach/coachDetail";

    }

    @PostMapping(value = "updateCoach", params = "edit")
    public String updateCoachData(CoachBean cBean) throws IOException, SerialException, SQLException {
        MultipartFile picture = cBean.getcPhoto();
        byte[] b = picture.getBytes();
        Blob blob = new SerialBlob(b);

        String fileName = picture.getOriginalFilename();

        String mineType = picture.getContentType();
        cBean.setCoachPhoto(blob);
        cBean.setFileName(fileName);
        cBean.setCoachPhotoMineType(mineType);
        service.updateCoach(cBean);
        return "redirect:/administrator/coachAdminPage";
    }

    @PostMapping(value = "updateCoach", params = "delete")
    public String deleteCoachData(CoachBean cBean) {
        service.deleteById(cBean.getCoachId());
        return "redirect:/administrator/coachAdminPage";
    }

    @GetMapping("allCoachClasses")
    public String allClassList(Model model) {
        List<ClassBean> allClass = classService.listAllClass();
        model.addAttribute(allClass);
        return "/administrator/allCoachClasses";
    }

    // @GetMapping("/updateClass/{id}")
    @GetMapping("updateClass")
    public String updateClass(Model model, @RequestParam("id") Integer id) {
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
        return "/administrator/coachClassDetail";
    }

    @PostMapping(value = "updateClass", params = "edit")
    public String updateClassCheck(ClassBean cBean) throws ParseException, IOException, SerialException, SQLException {
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
        return "redirect:/administrator/coachAdminPage";

    }

    @PostMapping(value = "updateClass", params = "delete")
    public String deleteClassData(ClassBean cBean) {
        classService.deleteById(cBean.getClassId());
        return "redirect:/administrator/coachAdminPage";
    }

    @GetMapping("/getCoachPicture")
    public ResponseEntity<byte[]> getCoachPicture(@RequestParam("coachAccount") String coachAccount)
            throws SQLException {

        System.out.println(coachAccount);
        CoachBean cBean = service.getCoachByAccount(coachAccount);
        System.out.println(cBean.getCoachName());
        ResponseEntity<byte[]> re = null;
        Blob blob = cBean.getCoachPhoto();
        byte[] b = blob.getBytes(1, (int) blob.length());
        HttpHeaders headers = new HttpHeaders();
        MediaType mediaType = MediaType.valueOf(cBean.getCoachPhotoMineType());
        headers.setContentType(mediaType);
        re = new ResponseEntity<byte[]>(b, headers, HttpStatus.OK);
        return re;
    }

    @PostMapping("listAllCoach")
    @ResponseBody
    public List<CoachBean> listAllCoach() {
        List<CoachBean> cBean = service.listAllCoach();

        return cBean;
    }

    @PostMapping("listAllClass")
    @ResponseBody
    public List<ClassBean> listAllClass() {
        List<ClassBean> allClass = classService.listAllClass();
        return allClass;
    }

    @GetMapping("coachAdminPage")
    public String coachAdmin() {
        return "/coach/coachAdmin";
    }

    // @PostMapping("/coachAdd")
    // @ResponseBody
    // public CoachBean processInsertCourse(@RequestBody CoachBean cBean) { // @RequestParam(name="coachId")
    // // @RequestBody
    // // CoachBean cBean
    //
    // // System.out.println("aaaaaaaaaaaaaaaaaaa");
    // // System.out.println(cBean);
    // // return cService.insertCourse(course);
    //
    // return null;
    // }

    @GetMapping("coachAdd")
    public String showCoachAddForm(Model model) {
        List<String> radioData = new ArrayList<String>();
        radioData.add("男");
        radioData.add("女");
        model.addAttribute("radioData", radioData);
        CoachBean cbean = new CoachBean();
        cbean.setCoachPassword("P@ssw0rd");
        String encodePwd = new BCryptPasswordEncoder().encode(cbean.getCoachPassword());
        cbean.setCoachPassword(encodePwd);
        model.addAttribute("coachBean", cbean);
        return "/coach/coachAdd";

    }
    //
    @PostMapping("coachAdd")
    public String insertCoachData(CoachBean cbean) throws ParseException, IOException, SerialException, SQLException {

        Long datetime = System.currentTimeMillis();
        Timestamp timestamp = new Timestamp(datetime);

        MultipartFile picture = cbean.getcPhoto();
        byte[] b = picture.getBytes();
        Blob blob = new SerialBlob(b);
        cbean.setCoachStatus(0);
        String fileName = picture.getOriginalFilename();

        String mineType = picture.getContentType();
        cbean.setCoachRegisterdate(timestamp);
        cbean.setCoachPhoto(blob);
        cbean.setFileName(fileName);
        cbean.setCoachPhotoMineType(mineType);
        service.save(cbean);
        return "redirect:/administrator/coachAdminPage";

    }

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
        List<String> name = classService.findClassCoach();
        model.addAttribute("coachList", name);
        ClassBean cbean = new ClassBean();
        model.addAttribute("classBean", cbean);

        return "/administrator/coachClassAdd";
    }

    @PostMapping("coachClassAdd")
    public String coachClassAdd(ClassBean cBean, Model model)
            throws ParseException, SerialException, SQLException, IOException {
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
        String coachName = cBean.getCoach();
        CoachBean cBeann = service.getCoachByName(coachName);
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
        return "redirect:/administrator/coachAdminPage";
    }

}
