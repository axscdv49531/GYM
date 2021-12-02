package tw.gym.menu.model;

import java.util.List;

public interface EvaluationService {
	public Evaluation insert(Evaluation evaluation);
	
	public List<Evaluation> findByMenuName(String menuName);
	
	public List<Evaluation> findAllByMemberId(Integer id);
	
	public List<Evaluation> findAll();
}
