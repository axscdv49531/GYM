package tw.gym.member.Service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.member.Dao.InbodyRepository;
import tw.gym.member.Model.InbodyBean;
import tw.gym.member.Service.InbodyService;

@Service
@Transactional
public class InbodyServiceImpl implements InbodyService {

	private InbodyRepository inbodyRepository;

	@Autowired
	public InbodyServiceImpl(InbodyRepository inbodyRepository) {
		this.inbodyRepository = inbodyRepository;
	}

	@Override
	public List<InbodyBean> findAllByMember(Integer number) {
		return inbodyRepository.findAllByMember(number);
	}

	@Override
	public InbodyBean insertByMember(InbodyBean inbodyBean, Integer number) {
		return inbodyRepository.insertByMember(inbodyBean, number);
	}

	@Override
	public InbodyBean update(InbodyBean inbodyBean) {
		return inbodyRepository.save(inbodyBean);
	}

	@Override
	public void deleteById(Integer no) {
		inbodyRepository.deleteById(no);
	}

}
