package tw.gym.commodity.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tw.gym.commodity.model.ItemTypeBean;
import tw.gym.commodity.repository.ItemTypeRepository;

@Service
@Transactional
public class ItemTypeService {
	
	@Autowired
	ItemTypeRepository typeRepo;
	
	public ItemTypeBean save(ItemTypeBean bean) {
		return typeRepo.save(bean);
	}
	
	public boolean deleteById(Integer id) {
		if (typeRepo.isUsed(id) == null) {
			typeRepo.deleteById(id);
			return true;
		}
		return false;
	}
	
	public List<ItemTypeBean> findAll(){
		return typeRepo.findAll();
	}
	
	public Map<String, ArrayList<ItemTypeBean>> findAllByGroups(){		
		Map<String, ArrayList<ItemTypeBean>> result = new LinkedHashMap<String, ArrayList<ItemTypeBean>>();
		
		for (ItemTypeBean bean : typeRepo.findAll()) {
			
			String groups = bean.getGroups();
			ArrayList<ItemTypeBean> values;
			if (result.containsKey(groups)) {
				values = result.get(groups);
			}else {
				values = new ArrayList<ItemTypeBean>();
			}
			values.add(bean);
			result.put(bean.getGroups(), values);
		}
		
		return result;
	}
	
	public List<ItemTypeBean> findAllByOrderingCategory(){
		return typeRepo.findAllByOrderByGroups();
	}
	
	public List<Map<String, Object>> getPctOfEachType(Integer year, Integer month){
		return typeRepo.getPctOfEachType(year, month);
	}
	
	public List<String> getChartMonth(){
		return typeRepo.getChartMonth();
	}
	
}
