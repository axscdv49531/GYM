package tw.fp.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.fp.model.CoachBean;

@Service
@Transactional
public interface CoachService {
    
    Object save(CoachBean bean);

    List<CoachBean> listAllCoach();

    void updateCoach(CoachBean cBean);

    CoachBean getCoachByAccount(String account);

    void deleteById(Integer coachId);

    CoachBean findByAccountAndPassword(String coachAccount, String coachPassword);

}
