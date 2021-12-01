package tw.gym.controller;

import java.sql.Blob;
import java.sql.SQLException;
import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import tw.gym.model.ClassBean;
import tw.gym.model.CoachBean;
import tw.gym.service.ClassService;
import tw.gym.service.CoachService;

@Controller
@RequestMapping("/administrator")
public class AdministratorController {

    @Autowired
    CoachService service;

    @Autowired
    ClassService classService;

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

    @GetMapping("/updateCoach/{account}")
    public String updateCoach(Model model, @PathVariable("account") String account) {
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

    @PostMapping(value = "/updateCoach/{name}", params = "edit")
    public String updateCoachData(CoachBean cBean) {
        service.updateCoach(cBean);
        return "redirect:/";
    }

    @PostMapping(value = "/updateCoach/{name}", params = "delete")
    public String deleteCoachData(CoachBean cBean) {
        service.deleteById(cBean.getCoachId());
        return "redirect:/";
    }

    @GetMapping("allCoachClasses")
    public String allClassList(Model model) {
        List<ClassBean> allClass = classService.listAllClass();
        model.addAttribute(allClass);
        return "/administrator/allCoachClasses";
    }

    @GetMapping("/updateClass/{id}")
    public String updateClass(Model model, @PathVariable("id") Integer id) {
        List<String> checkBoxData = new ArrayList<String>();
        checkBoxData.add("胸");
        checkBoxData.add("肩");
        checkBoxData.add("背");
        checkBoxData.add("腿");
        checkBoxData.add("跑步");
        checkBoxData.add("飛輪");
        checkBoxData.add("瑜珈");
        model.addAttribute("checkBoxData", checkBoxData);
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
        return "/coach/coachClassDetail";
    }

    @PostMapping(value = "/updateClass/{id}", params = "edit")
    public String updateClassCheck(ClassBean cBean) throws ParseException {
        DateFormat formatter = new SimpleDateFormat("HH:mm");
        Time startTime = new Time(formatter.parse(cBean.getClassStartTimeTemp()).getTime());
        cBean.setClassStartTime(startTime);
        Time endTime = new Time(formatter.parse(cBean.getClassEndTimeTemp()).getTime());
        cBean.setClassEndTime(endTime);
        classService.updateClass(cBean);
        return "redirect:/administrator/allCoachClasses";

    }

    @PostMapping(value = "/updateClass/{id}", params = "delete")
    public String deleteClassData(ClassBean cBean) {
        classService.deleteById(cBean.getClassId());
        return "redirect:/administrator/allCoachClasses";
    }

    @GetMapping("/getCoachPicture")
    public ResponseEntity<byte[]> getCoachPicture(@RequestParam("coachAccount") String coachAccount)
            throws SQLException {
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

}
