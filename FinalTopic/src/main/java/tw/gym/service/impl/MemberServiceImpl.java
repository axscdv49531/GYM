package tw.gym.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.model.ClassBean;
import tw.gym.model.ClassMemberBean;
import tw.gym.model.MemberBean;
import tw.gym.repository.ClassMemberRepository;
import tw.gym.repository.ClassRepository;
import tw.gym.repository.MemberRepository;
import tw.gym.service.MemberService;

@Transactional
@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    MemberRepository memRepo;
    @Autowired
    ClassMemberRepository cmRepo;
    @Autowired
    ClassRepository claRepo;

    @Override
    public MemberBean findByAccountAndPassword(String coachAccount, String coachPassword) {
        return memRepo.findByAccountAndPassword(coachAccount, coachPassword);
    }

    @Override
    public MemberBean getById(Integer memberId) {
        return memRepo.getById(memberId);
    }

    @Override
    public void insertReservation(ClassMemberBean cmBean, Integer a, Integer classId) {
        claRepo.setAvaliable(a, classId);
        cmRepo.save(cmBean);
    }

    @Override
    public List<ClassBean> findByMemberId(Integer memberId) {
        return memRepo.findByMemberId(memberId);
    }

    @Override
    public void deleteByClassId(Integer classId, Integer a) {
        claRepo.setAvaliable(a, classId);
        memRepo.deleteByClassId(classId);
    }

    // @Override
    // public List<ClassBean> findByKeyWord(String keyWord) {
    // // return memRepo.findByKeyWord(keyWord);
    // return memRepo.findByClassNameContaining(keyWord);
    // }

}
