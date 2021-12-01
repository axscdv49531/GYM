package tw.gym.member.Service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.member.Dao.DepositeRepository;
import tw.gym.member.Model.DepositeBean;
import tw.gym.member.Service.DepositeService;

@Service
@Transactional
public class DepositeServiceImpl implements DepositeService {

	private DepositeRepository depositeRepository;
	
	@Autowired
	public DepositeServiceImpl(DepositeRepository depositeRepository) {
		this.depositeRepository = depositeRepository;
	}

	@Override
	public DepositeBean update(DepositeBean depositeBean) {
		return depositeRepository.save(depositeBean);
	}

	@Override
	public List<DepositeBean> findAll() {
		return depositeRepository.findAll();
	}

	@Override
	public DepositeBean insertMemberNumber(DepositeBean depositeBean, Integer number) {
		return depositeRepository.insertMemberNumber(depositeBean, number);
	}

	@Override
	public List<DepositeBean> findAllByMember(Integer number) {
	
		return depositeRepository.findAllByMember(number);
	}

}
