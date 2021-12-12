package tw.gym.commodity.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import tw.gym.commodity.service.CommodityImgService;

@RestController
public class CommodityImgController {
	
	@Autowired
	ServletContext context;	
	
	@Autowired
	CommodityImgService ciService;
	
	@GetMapping("/imgs/{cid}/{imgSrc}")
	public ResponseEntity<byte[]> getCommodityImg(@PathVariable("cid") String cid, @PathVariable("imgSrc") String imgSrc) {
		String path = "/uploadFile/"+cid +"/"+imgSrc;
		ResponseEntity<byte[]> re = null;
		
		try {
			InputStream is = context.getResourceAsStream(path);
			if (is == null) {
				path = "/uploadFile/no_image.png";
				is = context.getResourceAsStream(path);
			}
			
			ByteArrayOutputStream baos= new ByteArrayOutputStream();
			int len = 0;
			byte[] b = new byte[12800];
			while((len = is.read(b))!= -1) {
				baos.write(b, 0, len);
			}
			
			b = baos.toByteArray();
			MediaType mediaType = MediaType.valueOf(context.getMimeType(path));
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(mediaType);
			re = new ResponseEntity<byte[]>(b, headers, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return re;
	}
	
	@DeleteMapping("/admin/delCommImg/{cid}/{imgSrc}")
	public ResponseEntity<String> delCommodityImg(@PathVariable("cid") Integer cid, @PathVariable("imgSrc") String imgSrc) {
		System.out.println(cid+" "+imgSrc);
		if (ciService.deleteImg(cid, imgSrc)) {
			String path = context.getRealPath("/")+ "\\uploadFile\\"+cid+"\\"+imgSrc;
			File file = new File(path);
			if(file.delete()) {
				return new ResponseEntity<String>("Deletion successed.", HttpStatus.OK);
			}
		}
		return new ResponseEntity<>("Not allowed.", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	

}
