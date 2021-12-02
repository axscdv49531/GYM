package tw.gym.coach.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.coach.model.CoachBean;
import tw.gym.coach.repository.CoachRepository;
import tw.gym.coach.service.CoachService;

@Transactional
@Service
public class CoachServiceImpl implements CoachService {

    @Autowired
    CoachRepository coaRepo;

    @Override
    public Object save(CoachBean cBean) {
        return coaRepo.save(cBean);
    }

    @Override
    public List<CoachBean> listAllCoach() {
        return coaRepo.findAll();
    }

    @Override
    public void updateCoach(CoachBean cBean) {
        coaRepo.save(cBean);

    }

    @Override
    public CoachBean getCoachByAccount(String account) {
        return coaRepo.getCoachByAccount(account);
    }

    @Override
    public void deleteById(Integer coachId) {
        coaRepo.deleteById(coachId);
    }

    @Override
    public CoachBean findByAccountAndPassword(String coachAccount, String coachPassword) {
        return coaRepo.findByAccountAndPassword(coachAccount, coachPassword);
    }

	@Override
	public CoachBean findByEmail(String email) {
		Optional<CoachBean> cBean= coaRepo.findByEmail(email);
		return cBean.get();
	}

}
