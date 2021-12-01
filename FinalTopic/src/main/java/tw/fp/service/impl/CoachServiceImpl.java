package tw.fp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.fp.model.CoachBean;
import tw.fp.repository.CoachRepository;
import tw.fp.service.CoachService;

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

}
