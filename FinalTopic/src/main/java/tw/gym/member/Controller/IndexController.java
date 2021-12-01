package tw.gym.member.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
public class IndexController {

	@GetMapping(path = "/")
	public String index() {
		return "index test";
	}
	@GetMapping(path = "/NewFile")
	public String test() {
		return "NewFile";
	}
}
