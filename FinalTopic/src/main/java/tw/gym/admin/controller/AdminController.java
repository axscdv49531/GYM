package tw.gym.admin.controller;

import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;
import java.text.ParseException;

import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import tw.gym.member.Model.Admin;
import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.AdminService;
import tw.gym.member.validator.MemberValidator;

@Controller
public class AdminController {

	private AdminService adminService;

	@Autowired
	public AdminController(AdminService adminService) {
		this.adminService = adminService;
	}

	@GetMapping(path = "/insertAdmin")
	public String insertAdmin(Model m) {
		Admin admin = new Admin();
		m.addAttribute("admin", admin);
		return "admin/adminForm";
	}

	@PostMapping(path = "/insertAdmin")
	public String insert(Model m, @ModelAttribute("admin") Admin admin) {
		String encodePwd = new BCryptPasswordEncoder().encode(admin.getPassword());
		admin.setPassword(encodePwd);
		admin.setStatus(1);
		adminService.insert(admin);
		return "redirect:/";
	}
}
