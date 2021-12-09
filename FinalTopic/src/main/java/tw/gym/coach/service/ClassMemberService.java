package tw.gym.coach.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.coach.model.ClassBean;
import tw.gym.member.Model.MemberBean;

@Service
@Transactional
public interface ClassMemberService {
    List<ClassBean> findClassesByMemberId(Integer memberId);

    Optional<MemberBean> findMemberByClassId(Integer classId);

}
