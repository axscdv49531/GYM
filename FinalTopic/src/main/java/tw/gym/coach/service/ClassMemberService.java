package tw.gym.coach.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.coach.model.ClassBean;

@Service
@Transactional
public interface ClassMemberService {
    List<ClassBean> findClassesByMemberId(Integer memberId);

}
