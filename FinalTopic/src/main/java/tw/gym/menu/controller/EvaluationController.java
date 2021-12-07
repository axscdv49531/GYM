package tw.gym.menu.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import tw.gym.member.Model.MemberBean;
import tw.gym.menu.model.Evaluation;
import tw.gym.menu.model.EvaluationService;
import tw.gym.menu.model.Menu;
import tw.gym.menu.model.MenuService;



@Controller
public class EvaluationController {
	
	private MenuService Mservice;
	private EvaluationService Eservice;
	
	


	@Autowired
	public EvaluationController(MenuService mservice,EvaluationService eService) {
		Eservice=eService;
		Mservice = mservice;
	}





	@GetMapping("/ToEvaluationMainPage")
	public String toMainPage(Model m) {
		
		List<Menu>list=Mservice.findAll();
		m.addAttribute("menuList",list);
		
		return "menu/Evaluation";
	}
	
	@PostMapping("/insertEvaluation.controller")
	@ResponseBody
	public Evaluation insertEvaluation(@RequestBody Evaluation evaluation) {
		System.out.println(evaluation.getEvaluationid());
		Evaluation e= new Evaluation(evaluation.getScore(),evaluation.getSuggestion(),evaluation.getMenuname());
		return Eservice.insert(e);
		
	}
	
	@GetMapping("/showEvaluationByName.controller")
	@ResponseBody
	public List<Evaluation> showEvaluationByName(){
		return Eservice.findByMenuName(null);
	}
	
	
	@GetMapping("/showEvaluationById.controller")
	@ResponseBody
	public List<Evaluation> showEvaluationById(){
		return Eservice.findAllByMemberId(null);
	}
	
	
	
	
	@PostMapping("/findAll.controller")
	@ResponseBody
	public List<Evaluation> findAll(){
		return Eservice.findAll();
	}
	

}
