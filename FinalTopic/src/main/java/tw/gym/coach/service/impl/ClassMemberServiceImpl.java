package tw.gym.coach.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.coach.model.ClassBean;
import tw.gym.coach.repository.ClassMemberRepository;
import tw.gym.coach.service.ClassMemberService;
import tw.gym.member.Model.MemberBean;

@Service
@Transactional
public class ClassMemberServiceImpl implements ClassMemberService {

    @Autowired
    ClassMemberRepository cmRepo;

    @Override
    public List<ClassBean> findClassesByMemberId(Integer memberId) {
        return cmRepo.findClassesByMemberId(memberId);
    }

    @Override
    public Optional<MemberBean> findMemberByClassId(Integer classId) {
        return cmRepo.findMemberByClassId(classId);
    }

}
