package tw.fp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.fp.model.ClassBean;
import tw.fp.model.ClassMemberBean;
import tw.fp.model.MemberBean;
import tw.fp.repository.ClassMemberRepository;
import tw.fp.repository.ClassRepository;
import tw.fp.repository.MemberRepository;
import tw.fp.service.MemberService;

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
