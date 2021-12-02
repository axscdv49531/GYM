package tw.gym.menu.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import tw.gym.menu.model.Menu;
import tw.gym.menu.model.MenuService;

@Controller
public class upLoadController {

	private Menu menu;
	private MenuService menuService;

	@Autowired
	public upLoadController(Menu menu, MenuService menuService) {
		this.menuService = menuService;
		this.menu = menu;
	}

	@GetMapping("/uploadfilemainpage.controller")
	public String processMainPageAction() {
		return "menu/uploadFile";
	}

	@PostMapping("/upload.controller")
	@ResponseBody // 預設json格式字串
	public String processUploadFileAction(@RequestParam("myFiles") MultipartFile mf, HttpServletRequest request,
			@RequestParam("menuName") String menuName, @RequestParam("menuPrice") Integer menuPrice,
			@RequestParam("menuQty") Integer menuQty) throws IllegalStateException, IOException {
		String fileName = mf.getOriginalFilename();// 檔案名子
		// MultipartRequest 支援上傳多個檔案
		// String saveDirPath = "D:\\MenuPic\\"; //暫存資料夾
		String saveDirPath = request.getSession().getServletContext().getRealPath(".") + "\\images\\";

		// String saveDirPath
		// ="D:\\work\\java\\workspace\\TestMenuMvc\\src\\main\\webapp\\WEB-INF\\resources\\images\\";

		File saveDirPathFile = new File(saveDirPath);
		saveDirPathFile.mkdirs();// mkdirs()沒有路徑也會建立 ,通常用這個 ,可以不用寫

		String savePath = saveDirPath + fileName;
		File savePathFile = new File(savePath);
		mf.transferTo(savePathFile);// 檔案上傳

//		if(fileName!=null && fileName.length()!=0) {
//			saveFile(fileName,savePath,menuName,menuPrice,menuQty);
//		
//			
//			
//		}
		return "savePath:" + saveDirPath;

		// return "savePath:" + savePath;
	}

//	private void saveFile(String fileName, String savePath,String menuName,Integer menuPrice,Integer menuQty ) {
//		menu.setMenuName(menuName);
//		menu.setMenuQty(menuQty);
//		menu.setPrice(menuPrice);
//
//		
//		
//		try {
//			InputStream is = new FileInputStream(savePath);
//			byte[] b = new byte[is.available()];//is.available()可以知道有多大
//			is.read(b);
//			is.close();
//			
//			menu.setMenuPicture(b);
//			menuService.insert(menu);			
//			
//		} catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//	}

}
