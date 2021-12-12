package tw.gym.commodity.service;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.commodity.model.CommodityBean;
import tw.gym.commodity.repository.CommodityRepository;

@Service
@Transactional
public class CommodityService {
	
	@Autowired
	CommodityRepository cdRepo;
	
	public CommodityBean insert(CommodityBean bean, boolean flag) {
		if (!flag) {
			return cdRepo.save(bean);
		}
		bean.setLastUpdated(new Date(System.currentTimeMillis()));
		bean.setOnSale(true);
		return cdRepo.saveAndFlush(bean);
	}
	
	public boolean deleteById(Integer id) {
		if(cdRepo.isComsumed(id)!= null) {
			return false;
		}		
		cdRepo.deleteById(id);
		return true;
	}
	
	public CommodityBean findById(Integer id) {
		Optional<CommodityBean> op = cdRepo.findById(id);
		if (op.isEmpty()) {
			return null;
		}
		return op.get();
	}
	
	public List<CommodityBean> findAll() {
		return cdRepo.findAll();
	}
	
	public Page<CommodityBean> findAllByPages(Example<CommodityBean> example, Pageable page) {
		return cdRepo.findAll(example, page);
	}
	
	public List<CommodityBean> findByOnSaleAndKeywords(String keyword){
		return cdRepo.findByOnSaleAndKeywords(keyword);
	}
	
	public List<String> findAllVendors(){
		return cdRepo.findAllVendors();
	}
	
	public List<CommodityBean> findAllWithoutDiscountRules(){
		return cdRepo.findAllWithoutDiscountRules();
	}
	
}
