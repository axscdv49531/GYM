package tw.gym.menu.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
@Service
@Transactional
public class EvaluationServiceImp implements EvaluationService {
	public EvaluationDao Edao;
	
	@Autowired
	public EvaluationServiceImp(EvaluationDao edao) {
		this.Edao = edao;
	}

	@Override
	public Evaluation insert(Evaluation evaluation) {
		// TODO Auto-generated method stub
		return Edao.save(evaluation);
	}

	@Override
	public List<Evaluation> findByMenuName(String menuName) {
		// TODO Auto-generated method stub
		return Edao.findByMenuName( menuName);
	}

	@Override
	public List<Evaluation> findAllByMemberId(Integer id) {
		// TODO Auto-generated method stub
		return Edao.findAllByMemberId( id);
	}

	@Override
	public List<Evaluation> findAll() {
	
		return Edao.findAll() ;
	}

}
