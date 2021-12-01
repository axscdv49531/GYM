package tw.gym.commodity.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import tw.gym.commodity.model.CommodityBean;
import tw.gym.commodity.model.CommodityImgBean;
import tw.gym.commodity.repository.CommodityImgRepository;
import tw.gym.commodity.repository.CommodityRepository;

@Service
@Transactional
public class CommodityImgService {
	
	@Autowired
	CommodityRepository cdRepo;
	
	@Autowired
	CommodityImgRepository ciRepo;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CommodityImgService.class);
	
	public List<CommodityImgBean> insert(MultipartFile[] parts, String dirPath, String date, CommodityBean comm) throws IOException {
		LOGGER.info("----------insert photos------------");
		
		File dirFile = new File(dirPath);
		if(!dirFile.exists()) {
				dirFile.mkdirs();
		}
		
		List<CommodityImgBean> imgList = new ArrayList<>();
		
		//儲存圖片
		for (int i = 0; i < parts.length ; i++) {
			LOGGER.info("uploadFile size: "+ parts[i].getSize());
			if (parts[i].getSize() != 0) {
				String tmp = date + i + parts[i].getOriginalFilename().substring(parts[i].getOriginalFilename().lastIndexOf("."));
				String filepath = dirPath + tmp;
				File imgfile = new File(filepath);
				
				CommodityImgBean bean = new CommodityImgBean(); 
				bean.setImgSrc(tmp);
				bean.setItemId(comm.getItemId());
				bean.setItem(comm);
				
				LOGGER.info("file path: " + dirPath);
				parts[i].transferTo(imgfile);
				imgList.add(ciRepo.save(bean));
			}
		}
		return imgList;
	}
	
	public boolean deleteImg(Integer cid, String imgSrc) {
		List<CommodityImgBean> list = ciRepo.findAllByItemId(cid);
		System.out.println(cid +", " + imgSrc);
		if (list.size() >1) {
			for (CommodityImgBean ele:list) {
				System.out.println(ele.getImgSrc() +", " +ele.getItemId());
				if (ele.getImgSrc().equals(imgSrc)) {
					ciRepo.deleteById(ele.getItemImgId());
					return true;
				}
			}
		}
		return false;
	}

}
