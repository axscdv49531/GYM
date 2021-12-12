package tw.gym.commodity.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.commodity.model.RuleBase;
import tw.gym.commodity.repository.RuleBaseRepository;

@Service
@Transactional
public class RuleBaseService {
	
	@Autowired
	RuleBaseRepository rbRepo;
	
	public RuleBase insert(RuleBase bean) {
		return rbRepo.save(bean);
	}
	
	public List<RuleBase> findAll() {
		return rbRepo.findAll();
	}
	
	public List<RuleBase> findActiveRules(){
		return rbRepo.findActiveRules();
	}
	
	public List<String> findCommIdWithActiveRule(String time){
		return rbRepo.findCommIdWithActiveRule(time);
	}
	
	public boolean deleteRule(Integer id) {
		if (rbRepo.isRuleConsumed(id)== null) {
			RuleBase bean = rbRepo.findById(id).get();
			bean.getCommodity().clear();
			rbRepo.deleteById(id);
			return true;
		}
		return false;
	}	
	
	public RuleBase findById(Integer id) {
		Optional<RuleBase> opt = rbRepo.findById(id);
		if (opt.isEmpty()) {
			return null;
		}
		return opt.get();
	}
}
