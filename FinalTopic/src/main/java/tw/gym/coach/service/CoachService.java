package tw.gym.coach.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.coach.model.CoachBean;

@Service
@Transactional
public interface CoachService {
    
    Object save(CoachBean bean);

    List<CoachBean> listAllCoach();

    void updateCoach(CoachBean cBean);

    CoachBean getCoachByAccount(String account);

    void deleteById(Integer coachId);

    CoachBean findByAccountAndPassword(String coachAccount, String coachPassword);
    
    Optional<CoachBean> findByEmail(String email);
    
    //Dean
    public CoachBean getById(Integer coachId);

}
